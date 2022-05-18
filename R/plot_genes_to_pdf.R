plot_genes_to_pdf <- function(
  genes = "AT3G61060",
  tags = "",
  filename = "./genes.pdf"
){

  ggpubr::ggarrange(plotlist = Map(plot_gene, genes, tags), nrow = length(genes)) %>%
    ggplot2::ggsave(
      filename = filename,
      height = length(genes)*2,
      width = 3,
      limitsize = FALSE
    )

}


