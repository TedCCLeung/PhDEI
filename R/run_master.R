run_master <- function(
  read_count_matrix,
  edgeR_contrast_table,
  DEI_annotation_table,
  output_dir = "./"
){

  ## STEP 0: PROCESS INPUTS -----------------------------
  run_input(
    dir = paste0(output_dir, "/0_input/"),
    gene_count_table = read_count_matrix,
    edgeR_contrast_table = edgeR_contrast_table,
    DEI_annotation_table = DEI_annotation_table
  )

  ## STEP 1-3: DEG ANALYSIS BY EDGER, GET DEGS, CLASSIFY INTO SEASONS -----------------------------

  run_edgeR(
    dir = output_dir,
    edgeR_contrast_table = paste0(output_dir, "/0_input/edgeR_contrast_table.tsv"),
    gene_count_table = paste0(output_dir, "/0_input/gene_count_matrix.tsv"),
    sig_cutoff = 0.2,
    FC_cutoff = 1.0
  )

}

## Test run
# run_master(
#   read_count_matrix = read_count_matrix,
#   edgeR_contrast_table = edgeR_contrasts,
#   DEI_annotation_table = DEI_annotation,
#   output_dir = "data-raw/"
# )
