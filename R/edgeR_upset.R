edgeR_upset <- function(
  mat,
  min_size = FALSE,
  reverse_order = FALSE
){

  if (reverse_order){sets = rev(colnames(mat))
  } else {sets = colnames(mat)}

  ## Set a theme for the sets on top
  top_theme <- ggplot2::theme(
    axis.title.y = ggplot2::element_blank(),
    axis.text.y = ggplot2::element_blank(),
    axis.ticks.y = ggplot2::element_blank(),
    axis.text.x = ggplot2::element_text(angle = 270, vjust = 0.5, hjust=1)
    )

  ## Set a theme for the base annotations
  annotation_theme <- ggplot2::theme(
    axis.title.x = ggplot2::element_blank(),
    axis.text.x = ggplot2::element_blank(),
    axis.ticks.x = ggplot2::element_blank()
    )


  ## Plotting the upset plot
  fig <- ComplexUpset::upset(
    mat,
    sets,
    width_ratio = 0.3,
    height_ratio = 0.5,
    sort_sets = FALSE,
    name = "",
    wrap = TRUE,
    sort_intersections_by = "degree",
    min_size = min_size,

    set_sizes = ComplexUpset::upset_set_size(geom = ggplot2::geom_bar(width=0.4), position = "right") +
      ggplot2::scale_y_continuous(name = "") +
      top_theme,

    base_annotations = list(
      'Intersection size'=(
        ComplexUpset::intersection_size(counts = FALSE) +
          annotation_theme +
          ggplot2::scale_y_continuous(expand = c(0, 0), limits = c(0, NA), name="number of genes") +
          ggplot2::geom_col(width = 0.1)
        )
     ),

    matrix = (
      ComplexUpset::intersection_matrix(
        geom = ggplot2::geom_point(size = 0.7),
        segment = ggplot2::geom_segment(size = 0.3)
        )
      ),
    themes = ComplexUpset::upset_modify_themes(list())
  ) &
    ggplot2::theme(plot.background = ggplot2::element_rect(fill='transparent', color=NA))

  ## Return the figure
  return(fig)
}
