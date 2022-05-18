#' Extract significantly up- and down-reguluted genes from edgeR results
#'
#' @param dir Character. Directory.
#' @param edgeR_contrast_table Either a dataframe with edgeR contrasts, or full path to a tab-separated file of it
#' @param gene_count_table Either a dataframe with raw gene counts, or full path to a tab-separated file of it
#' @param DEI_annotation_table Either a dataframe with DEI annotation, or full path to a tab-separated file of it
#'
#' @return None

run_input <- function(
  dir,
  gene_count_table = read_count_matrix,
  edgeR_contrast_table = edgeR_contrasts,
  DEI_annotation_table = DEI_annotation
){

  ## STEP 0: SET UP DIRECTORIES -----------------------------
  if (!dir.exists(dir)){dir.create(dir, recursive = TRUE)}


  ## STEP 1: Read inputs -----------------------------
  ## Read in contrast table
  if (class(edgeR_contrast_table) %in% c("data.frame", "matrix")){
    contrast_table <- edgeR_contrast_table
    contrasts <- edgeR_read_contrasts(edgeR_contrast_table)
  } else {
    contrast_table <- utils::read.table(edgeR_contrast_table, header = TRUE)
    contrasts <- edgeR_read_contrasts(contrast_table)
  }

  ## Read in gene count table
  if (class(gene_count_table)[1] %in% c("data.frame", "matrix")){
    gene_count_matrix <- as.matrix(gene_count_table)
  } else {
    gene_count_matrix <- as.matrix(utils::read.table(gene_count_table, header = TRUE, row.names = 1))
  }

  ## Read in annotation table for calculating DEI
  if (class(DEI_annotation_table)[1] %in% c("data.frame", "matrix")){
    df_DEI_annotation <- as.matrix(DEI_annotation_table)
  } else {
    df_DEI_annotation <- as.matrix(utils::read.table(DEI_annotation_table, header = TRUE, row.names = 1))
  }

  ## STEP 2: Store inputs as records -----------------------------

  utils::write.table(contrast_table, file = paste0(dir, "/edgeR_contrast_table.tsv"), sep = "\t", quote = FALSE, row.names = FALSE)
  utils::write.table(gene_count_matrix, file = paste0(dir, "/gene_count_matrix.tsv"), sep = "\t", quote = FALSE, row.names = TRUE)
  utils::write.table(df_DEI_annotation, file = paste0(dir, "/DEI_annotation_table.tsv"), sep = "\t", quote = FALSE, row.names = FALSE)
}
