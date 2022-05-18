#' Parse an edgeR contrast table into a list of list of contrasts and groupings.
#'
#' @param edgeR_contrasts Dataframe. EdgeR contrasts
#'
#' @return None


edgeR_read_contrasts <- function(
  edgeR_contrasts
){

  contrasts <- unique(edgeR_contrasts[, 1])

  result <- lapply(contrasts, function(contrast){
    res <- list(
      sample_names = edgeR_contrasts[edgeR_contrasts[, 1] == contrast, "sample_name"],
      grouping = as.factor(edgeR_contrasts[edgeR_contrasts[, 1] == contrast, "sample_cond"]),
      contrast_name = contrast
    )
    return(res)
  })

  sample_names <- lapply(result, function(x){return(x[["sample_names"]])})
  grouping <- lapply(result, function(x){return(x[["grouping"]])})
  contrast_names <- sapply(result, function(x){return(unique(x[["contrast_name"]]))})

  return(list(sample_names = sample_names, grouping = grouping, contrast_names = contrast_names))
}
