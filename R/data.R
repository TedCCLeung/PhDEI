#' Contrasts used for identifying differentially expressed genes in the RNA-seq data
#'
#' @format A data frame with 108 observations and 7 variables:
#' \describe{
#'   \item{contrast}{Name of the contrast between individual time points}
#'   \item{cond1}{Photoperiod 1 of the contrast}
#'   \item{cond2}{Photoperiod 2 of the contrast}
#'   \item{time}{Time point}
#'   \item{sample_name}{Sample used in the contrast}
#'   \item{sample_cond}{Photoperiod of the sample}
#'   \item{contrast_conds}{Name of the contrast between photoperiods}
#' }
"edgeR_contrasts"

#' Contrasts used for identifying differentially expressed genes in the RNA-seq data
#'
#' @format A data frame with 108 observations and 7 variables:
#' \describe{
#'   \item{EQ_00_A}{Sample}
#'   \item{EQ_00_B}{Sample}
#'   \item{EQ_00_C}{Sample}
#'   \item{EQ_04_A}{Sample}
#'   \item{EQ_04_B}{Sample}
#'   \item{EQ_04_C}{Sample}
#'   \item{EQ_08_A}{Sample}
#'   \item{EQ_08_B}{Sample}
#'   \item{EQ_08_C}{Sample}
#'   \item{EQ_12_A}{Sample}
#'   \item{EQ_12_B}{Sample}
#'   \item{EQ_12_C}{Sample}
#'   \item{EQ_16_A}{Sample}
#'   \item{EQ_16_B}{Sample}
#'   \item{EQ_16_C}{Sample}
#'   \item{EQ_20_A}{Sample}
#'   \item{EQ_20_B}{Sample}
#'   \item{EQ_20_C}{Sample}
#'   \item{LD_00_A}{Sample}
#'   \item{LD_00_B}{Sample}
#'   \item{LD_00_C}{Sample}
#'   \item{LD_04_A}{Sample}
#'   \item{LD_04_B}{Sample}
#'   \item{LD_04_C}{Sample}
#'   \item{LD_08_A}{Sample}
#'   \item{LD_08_B}{Sample}
#'   \item{LD_08_C}{Sample}
#'   \item{LD_12_A}{Sample}
#'   \item{LD_12_B}{Sample}
#'   \item{LD_12_C}{Sample}
#'   \item{LD_16_A}{Sample}
#'   \item{LD_16_B}{Sample}
#'   \item{LD_16_C}{Sample}
#'   \item{LD_20_A}{Sample}
#'   \item{LD_20_B}{Sample}
#'   \item{LD_20_C}{Sample}
#'   \item{SD_00_A}{Sample}
#'   \item{SD_00_B}{Sample}
#'   \item{SD_00_C}{Sample}
#'   \item{SD_04_A}{Sample}
#'   \item{SD_04_B}{Sample}
#'   \item{SD_04_C}{Sample}
#'   \item{SD_08_A}{Sample}
#'   \item{SD_08_B}{Sample}
#'   \item{SD_08_C}{Sample}
#'   \item{SD_12_A}{Sample}
#'   \item{SD_12_B}{Sample}
#'   \item{SD_12_C}{Sample}
#'   \item{SD_16_A}{Sample}
#'   \item{SD_16_B}{Sample}
#'   \item{SD_16_C}{Sample}
#'   \item{SD_20_A}{Sample}
#'   \item{SD_20_B}{Sample}
#'   \item{SD_20_C}{Sample}
#' }
"read_count_matrix"

#' TAIR10 gene models from Arabidopsis_thaliana.TAIR10.47.gtf
#'
#' @format A data frame with 24845 rows and 18 variables:
#' \describe{
#'   \item{EQ_00}{Sample}
#'   \item{EQ_04}{Sample}
#'   \item{EQ_08}{Sample}
#'   \item{EQ_12}{Sample}
#'   \item{EQ_16}{Sample}
#'   \item{EQ_20}{Sample}
#'   \item{LD_00}{Sample}
#'   \item{LD_04}{Sample}
#'   \item{LD_08}{Sample}
#'   \item{LD_12}{Sample}
#'   \item{LD_16}{Sample}
#'   \item{LD_20}{Sample}
#'   \item{SD_00}{Sample}
#'   \item{SD_04}{Sample}
#'   \item{SD_08}{Sample}
#'   \item{SD_12}{Sample}
#'   \item{SD_16}{Sample}
#'   \item{SD_20}{Sample}
#' }
"TMM_mean_matrix"


#' TAIR10 gene models from Arabidopsis_thaliana.TAIR10.47.gtf
#'
#' @format A data frame with 63 rows and 3 variables:
#' \describe{
#'   \item{SampleName}{Sample name}
#'   \item{Time}{Time point}
#'   \item{Treatment}{Photoperiod}
#' }
"DEI_annotation"

#' Photoperiodic genes in this dataset
#'
#' @format A vector of 8302 photoperiodic genes
"photoperiodic_genes"

