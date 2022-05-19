#' Extract significantly up- and down-reguluted genes from edgeR results
#'
#' @importFrom rlang .data
#'
#' @param dir Character. Directory.
#' @param edgeR_contrast_table Either a dataframe with edgeR contrasts, or full path to a tab-separated file of it
#' @param gene_count_table Either a dataframe with raw gene counts, or full path to a tab-separated file of it
#' @param sig_cutoff Numeric. p-value threshold for determining photoperiodic genes
#' @param FC_cutoff Numeric. Fold change threshold for determining photoperiodic genes
#'
#' @return None

run_edgeR <- function(
  dir,
  edgeR_contrast_table = edgeR_contrasts,
  gene_count_table = read_count_matrix,
  sig_cutoff = 0.2,
  FC_cutoff = 1.0
){

  ## STEP 0: SET UP DIRECTORIES -----------------------------
  if (!dir.exists(paste0(dir, "/1_edgeR_results"))){dir.create(paste0(dir, "/1_edgeR_results"), recursive = TRUE)}
  if (!dir.exists(paste0(dir, "/2_DEGs"))){dir.create(paste0(dir, "/2_DEGs"), recursive = TRUE)}

  ## STEP 1: Read inputs -----------------------------
  ## Read in contrast table
  if (class(edgeR_contrast_table) %in% c("data.frame", "matrix")){
    contrasts <- edgeR_read_contrasts(edgeR_contrast_table)
  } else {
    contrasts <- edgeR_read_contrasts(utils::read.table(edgeR_contrast_table, header = TRUE))
  }

  ## Read in gene count table
  if (class(gene_count_table)[1] %in% c("data.frame", "matrix")){
    gene_count_matrix <- as.matrix(gene_count_table)
  } else {
    gene_count_matrix <- as.matrix(utils::read.table(gene_count_table, header = TRUE, row.names = 1))
  }


  ## STEP 2: PERFORM EDGER ON THE CONTRASTS -----------------------------

  ## Perform edgeR on individual contrasts using Map
  edgeR_results <- base::Map(
    edgeR_run,
    lapply(seq(length(contrasts$sample_names)), function(x){gene_count_matrix}),
    contrasts$sample_names,
    contrasts$grouping
  )

  ## And store the results
  write_edgeR_results <- function(edgeR_result, file_name){utils::write.table(edgeR_result, file = file_name, sep = "\t", quote = FALSE, row.names = FALSE)}
  base::Map(write_edgeR_results, edgeR_results, paste0(dir, "/1_edgeR_results/", contrasts$contrast_names, ".tsv"))


  ## STEP 3: DETERMINE DEGS -----------------------------

  ## Get the DEGs from individual edgeR results table using Map
  DEG_results <- base::Map(
    edgeR_get_DEGs,
    edgeR_results,
    contrasts$grouping,
    rep(sig_cutoff, length(edgeR_results)),
    rep(FC_cutoff, length(edgeR_results))
  )
  df_DEG <- base::Reduce(function(dtf1,dtf2) dplyr::full_join(dtf1, dtf2, by = "geneID"), DEG_results) %>%
    magrittr::set_colnames(c("geneID", contrasts$contrast_names)) %>%
    dplyr::arrange(.data$geneID)

  ## Output as a large data frame
  utils::write.table(df_DEG, file = paste0(dir, "/2_DEGs/DEGs.tsv"), sep = "\t", quote = FALSE, row.names = FALSE)

  ## Output gene lists as .txt files
  write_genes <- function(genes, file){utils::write.table(sort(genes), file = file, row.names = FALSE, col.names = FALSE, quote = FALSE)}
  write_genes(df_DEG$geneID, file = paste0(dir, "/2_DEGs/genelist_photoperiodic.tsv"))


  ## STEP 4: MAKE PLOTS -----------------------------

  ## MDS plot
  edgeR_MDSplot(gene_count_matrix = gene_count_matrix) %>%
    ggplot2::ggsave(filename = paste0(dir, "/1_edgeR_results/MDSplot.pdf"), height = 2, width = 3.5)


  ## Plot upset plot for the time point groups
  df_DEG %>%
    edgeR_get_DEG_list(searches = list("LD", "EQ", "SD")) %>%
    ComplexHeatmap::list_to_matrix() %>%
    magrittr::equals(1) %>%
    as.data.frame() %>%
    edgeR_upset(min_size = 150, reverse_order = TRUE) %>%
    ggplot2::ggsave(filename = paste0(dir, "/1_edgeR_results/upSet_photoperiod.pdf"), height = 2.5, width = 3)


  ## Plot upset plot for the time point groups
  df_DEG %>%
    edgeR_get_DEG_list(searches = list("00", "04", "08", "12", "16", "20")) %>%
    ComplexHeatmap::list_to_matrix() %>%
    magrittr::equals(1) %>%
    as.data.frame() %>%
    edgeR_upset(min_size = 150, reverse_order = TRUE) %>%
    ggplot2::ggsave(filename = paste0(dir, "/1_edgeR_results/upSet_timepoint.pdf"), height = 2.5, width = 3)

}
