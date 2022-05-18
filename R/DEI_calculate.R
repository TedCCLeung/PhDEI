
DEI_calculate <- function(
  DEI_annotation = DEI_annotation,
  expression_matrix = TMM_mean_matrix,
  replicate_no = 3
){

  ## 01. Load data -------------------------
  ## Get the sample names needed
  seasons <- unique(DEI_annotation$Treatment)
  season_time_labels <- base::lapply(seasons, function(season){
    list(sample_names = DEI_annotation[DEI_annotation$Treatment == season, "SampleName"],
         time_stamps = DEI_annotation[DEI_annotation$Treatment == season, "Time"])
  })
  names(season_time_labels) <- seasons

  ## Get the expression data
  genes <- rownames(expression_matrix)


  ## 02. Calculate AUC -------------------------

  res_auc <- lapply(1:length(season_time_labels), function(n){
    k <- season_time_labels[[n]]
    s <- names(season_time_labels)[n]
    df_auc_res <- as.data.frame(t(apply(expression_matrix, 1, function(x){
      auc_ <- PK::auc(
        conc = as.numeric(x[k$sample_names]),
        time = k$time_stamps,
        method = "t",
        design = "ssd"
      )$CIs
      return(c(auc_$est, auc_$stderr))
    })))
    colnames(df_auc_res) <- paste0(s, c("_DEI", "_SEM"))
    df_auc_res$geneID <- rownames(df_auc_res)
    return(df_auc_res)
  })

  names(res_auc) <- seasons
  df_AUC <- Reduce(function(dtf1, dtf2) merge(dtf1, dtf2, by = "geneID"), res_auc)


  ## 03. Comparing AUC
  combinations <- utils::combn(seasons, m = 2)

  rDEI_list <- lapply(1:ncol(combinations), function(k){

    df_ <- cbind(res_auc[[combinations[2, k]]], res_auc[[combinations[1, k]]])

    p_val <- apply(df_, 1, function(x){
      return(t.test2(
        mean1 = as.numeric(x[1]), mean2 = as.numeric(x[4]),
        sd1 = as.numeric(x[2])*sqrt(replicate_no), sd2 = as.numeric(x[5])*sqrt(replicate_no),
        n1 = replicate_no, n2 = replicate_no
        )$p.value)
    })

    rDEI <- apply(df_, 1, function(x){

      val1 <- as.numeric(x[1])
      val2 <- as.numeric(x[4])

      if (val1 == 0 | val2 == 0){
        return(NA)
      } else {
        return(as.numeric(x[1])/as.numeric(x[4]))
      }
    })

    rDEI_log2 <- apply(df_, 1, function(x){
      val <- log2(as.numeric(x[1])/as.numeric(x[4]))
      if (is.na(val) | is.infinite(val)){
        return(NA)
      } else {
        return(val)
      }
    })

    df_rDEI <- data.frame(
      rDEI,
      rDEI_log2,
      p_val
    )

    colnames(df_rDEI) <- c(
      paste0("rDEI_", combinations[2, k], combinations[1, k]),
      paste0("log2_rDEI_", combinations[2, k], combinations[1, k]),
      paste0("p_", combinations[2, k], combinations[1, k])
      )

    df_rDEI$geneID <- rownames(df_rDEI)

    return(df_rDEI)
  })

  df_rDEI <- Reduce(function(dtf1, dtf2) merge(dtf1, dtf2, by = "geneID"), rDEI_list)

  #####
  df_output <- merge(df_AUC, df_rDEI, by = "geneID")
  return(df_output)
}

