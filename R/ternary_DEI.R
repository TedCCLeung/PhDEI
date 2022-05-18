#' Plot ternary plot of gene DEI
#'
#' @importFrom magrittr %>%
#'
#' @param plot_density Logical.
#' @param plot_contour Logical.
#' @param plot_points Logical.
#' @param power Numeric.
#'
#' @return plot

ternary_DEI <- function(
  power = 4,
  plot_density = FALSE,
  plot_contour = TRUE,
  plot_points = TRUE
){

  coordinates <- rDEI_summary[, c("geneID", "EQ_DEI", "LD_DEI", "SD_DEI")] %>%
    dplyr::filter(.data$geneID %in% photoperiodic_genes) %>%
    tibble::column_to_rownames(var = "geneID") %>%
    dplyr::mutate(sum = (.data$EQ_DEI)^power + (.data$LD_DEI)^power + (.data$SD_DEI)^power) %>%
    dplyr::mutate(EQ_ratio = (.data$EQ_DEI)^power/.data$sum) %>%
    dplyr::mutate(LD_ratio = (.data$LD_DEI)^power/.data$sum) %>%
    dplyr::mutate(SD_ratio = (.data$SD_DEI)^power/.data$sum) %>%
    dplyr::select(c("EQ_ratio", "LD_ratio", "SD_ratio")) %>%
    as.matrix()

  Ternary::TernaryPlot(alab = 'EQ-SD', blab = 'EQ-LD', clab = 'SD-LD', grid.lines = 5,
                       atip = "EQ-only", btip = "LD-only", ctip = "SD-only",
                       grid.minor.lines = 0, axis.labels = seq(0, 1, by = 0.2)
                       )
  if (plot_density){Ternary::ColourTernary(Ternary::TernaryDensity(coordinates, resolution = 50L))}
  if (plot_points){Ternary::TernaryPoints(coordinates, col = 'red', pch = '.')}
  if (plot_contour){Ternary::TernaryDensityContour(coordinates, resolution = 50L, drawlabels = FALSE)}
}


# grDevices::pdf("ternary_DEI_.pdf")
# ternary_DEI(power = 4, plot_density = FALSE, plot_points = FALSE, plot_contour = FALSE)
# grDevices::dev.off()
