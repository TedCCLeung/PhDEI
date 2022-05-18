edgeR_get_DEG_list <- function(
  DEG_summary,
  searches
){

  search_list <- lapply(searches, function(x){
    ## get a df with only the columns for the timepoint
    df1 <- DEG_summary[, c(colnames(DEG_summary)[grepl(x, colnames(DEG_summary))])]
    ## return rows that are not all NA
    df2 <- df1[apply(df1, 1, function(y){sum(is.na(y))<ncol(df1)}), ]
    genes <- DEG_summary[rownames(df2), "geneID"]
    return(genes)
  })

  names(search_list) <- searches
  return(search_list)
}
