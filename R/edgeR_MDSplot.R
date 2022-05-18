#' Generate a MDS plot for gene count data
#'
#' @param gene_count_matrix Matrix.
#'
#' @return ggplot2 object

edgeR_MDSplot <- function(
  gene_count_matrix
){

  DGEList <- edgeR::DGEList(counts = gene_count_matrix, genes = base::rownames(gene_count_matrix), remove.zeros = TRUE)

  ## Remove any potential spike-ins
  DGEList <- DGEList[!startsWith(DGEList$genes$genes, "ERCC"), , keep.lib.sizes=TRUE]

  ## Filter low expression genes
  keep <- edgeR::filterByExpr(DGEList, group = substr(colnames(gene_count_matrix), 1, 5))
  DGEList <- DGEList[keep, , keep.lib.sizes=FALSE]

  ## MDS plot
  p_MDS <- limma::plotMDS(DGEList, top = 100000, gene.selection = "common")
  (x_var <- as.character(p_MDS$var.explained[1]))
  (y_var <- as.character(p_MDS$var.explained[2]))

  df_MDS <- data.frame(X = p_MDS$x, Y = p_MDS$y)
  rownames(df_MDS) <- colnames(gene_count_matrix)

  ## Prepare data for ggplot
  labels <- substr(rownames(df_MDS), 4, 5)
  df_MDS$color <- substr(rownames(df_MDS), 1, 2)

  ## ggplot2
  sp <- ggplot2::ggplot(df_MDS, ggplot2::aes_string("X", "Y", label = "labels", color = "color")) +
    ggplot2::geom_text(size = 3) +
    ggplot2::xlim(-1.7, 1.7) +
    ggplot2::ylim(-1.5, 1.5) +
    ggplot2::xlab(x_var) +
    ggplot2::ylab(y_var)

  return(sp)
}


