## Set global variables for objects defined in data.R
utils::globalVariables(c(
  "rDEI_summary",
  "read_count_matrix",
  "edgeR_contrasts",
  "TMM_mean_matrix",
  "DEI_annotation",
  "photoperiodic_genes"
))

#load("./data/aggcluster_photoperiodic_genes.rda")
