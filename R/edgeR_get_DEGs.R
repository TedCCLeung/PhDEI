#' Extract significantly up- and down-reguluted genes from edgeR results
#'
#' @param edgeR_result Data frame. Output from perform_edgeR.
#' @param grouping Factor. Generated from read_edgeR_contrasts
#' @param sig_cutoff Numerical.
#' @param FC_cutoff Numerical.
#' @param PVAL_or_FDR Character. "PVAL" or "FDR".
#'
#' @return None

edgeR_get_DEGs <- function(
  edgeR_result,
  grouping,
  sig_cutoff,
  FC_cutoff,
  PVAL_or_FDR = "PVAL"
){

  ## Defind the up- and down-regulated conditions
  up_cond <- levels(as.factor(grouping))[1]
  down_cond <- levels(as.factor(grouping))[2]

  ## statistical cutoff
  if (PVAL_or_FDR == "FDR"){
    edgeR_result$stat_cutoff <- ifelse((edgeR_result$FDR < sig_cutoff), "DEG", "noDEG")
  } else if (PVAL_or_FDR == "PVAL"){
    edgeR_result$stat_cutoff <- ifelse((edgeR_result$PValue < sig_cutoff), "DEG", "noDEG")
  }

  up_genes <- rownames(edgeR_result[(edgeR_result$logFC > log2(FC_cutoff)) & (edgeR_result$stat_cutoff == "DEG"), ])
  down_genes <- rownames(edgeR_result[(edgeR_result$logFC < (-1*log2(FC_cutoff))) & (edgeR_result$stat_cutoff == "DEG"), ])

  df_updown <- data.frame(
    c(rep(up_cond, length(up_genes)), rep(down_cond, length(down_genes)))
  )
  geneID <- c(up_genes, down_genes)
  df_updown <- cbind(geneID, df_updown)

  return(df_updown)
}
