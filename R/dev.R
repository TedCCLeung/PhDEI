##Set up package -----------------------------------
# usethis::use_git()
# usethis::use_github()
# usethis::create_github_token()
# usethis::use_mit_license()

##Data manipulation -----------------------------------
# usethis::use_package("utils")
# usethis::use_package("ComplexUpset", type = "Suggests")
# usethis::use_package("PK", type = "Suggests")
# usethis::use_package("plotly", type = "Suggests")
# usethis::use_package("dendextend", type = "Suggests")
# usethis::use_package("circlize", type = "Suggests")
# usethis::use_package("ComplexHeatmap")
# usethis::use_package("rlang")
# usethis::use_package("reshape2", type = "Suggests")
# usethis::use_package("Ternary", type = "Suggests")
# usethis::use_package("dynamicTreeCut", type = "Suggests")

##Bioconductor -----------------------------------
# usethis::use_package("edgeR")
# usethis::use_package("limma", type = "Suggests")


##Tidyverse -----------------------------------
# usethis::use_package("roxygen2"); usethis::use_pipe(export = TRUE)
# usethis::use_package("stringr", min_version = "1.4.0")
# usethis::use_package("magrittr", min_version = "2.0.1")
# usethis::use_package("dplyr", min_version = "1.0.7")
# usethis::use_package("tidyr", min_version = "1.1.4")
# usethis::use_package("ggplot2", min_version = "3.3.5")
# usethis::use_package("ggpubr", type = "Suggests")
# usethis::use_package("ggridges")
# usethis::use_package("ggmap", type = "Suggests")
# usethis::use_package("tibble", type = "Suggests")


##Set up NAMESPACE and install -----------------------------------
# devtools::document()
# devtools::load_all()
# devtools::check()
# devtools::install()

# library(extrafont)

#edgeR_contrasts <- read.csv("/Users/TedCCLeung/Documents/Projects/Photoperiod/2_analysis/0_data/B_userData/design_matrices/edgeR_contrasts.csv", stringsAsFactors = FALSE,  colClasses="character")
#usethis::use_data(edgeR_contrasts, overwrite = TRUE)

#read_count_matrix <- as.matrix(read.csv("/Users/TedCCLeung/Documents/Projects/Photoperiod/2_analysis/0_data/B_userData/output_HISAT/gene_count_matrix.csv", row.names = 1))
#read_count_matrix <- read_count_matrix[sort(rownames(read_count_matrix)), ]
#usethis::use_data(read_count_matrix, overwrite = TRUE)

#photoperiodic_eigen_vectors <- read.csv("/Users/TedCCLeung/Documents/Projects/Photoperiod/2_analysis/2_pipeline/1_DEI/030_clustering/photoperiodic/eigen_vec.csv", header = FALSE, row.names = 1)
#usethis::use_data(photoperiodic_eigen_vectors)
