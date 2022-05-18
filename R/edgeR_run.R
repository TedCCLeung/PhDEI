#' Perform edgeR differentially expressed gene analysis
#'
#' @param raw_count_matrix Matrix. A numerical matrix with gene identifiers as row names and sample identifiers as column names.
#' @param sample_names Character. Sample identifiers for the analysis.
#' @param grouping Factor. A factor of numbers with the same length as sample_names to describe the grouping.
#'
#' @return Data frame
#'
#' @export

edgeR_run <- function(
  raw_count_matrix,
  sample_names,
  grouping
){

  ## Select the data
  rawCounts <- raw_count_matrix[, sample_names]
  design <- stats::model.matrix(~grouping)

  ## Normalise the reads
  DGEList <- edgeR::DGEList(
    counts = rawCounts,
    genes = rownames(raw_count_matrix),
    remove.zeros = TRUE,
    group = grouping
  )

  keep <- edgeR::filterByExpr(DGEList, design)
  DGEList <- DGEList[keep, , keep.lib.sizes=FALSE]
  DGEList <- edgeR::calcNormFactors(DGEList)

  ## Removes spike-ins
  DGEList <- DGEList[!startsWith(DGEList$genes$genes, "ERCC"), , keep.lib.sizes=TRUE]

  DGEList <- edgeR::estimateDisp(DGEList, design, robust=TRUE)
  fit <- edgeR::glmQLFit(DGEList, design, robust=TRUE, prior.count = 0)
  fit <- edgeR::glmQLFTest(fit, contrast = c(0, 1))
  ## Return all results
  fit_output <- edgeR::topTags(fit, n = "Inf", adjust.method = "BH")$table

  return(fit_output)
}
