read_genes <- function(x){y <- readLines(file(x)); close(file(x)); return(sort(y))}

std <- function(x) stats::sd(x)/sqrt(length(x))


calculate_z_row <- function(df){
  dfz <- t(scale(t(df)))
  dfz[is.na(dfz)] <- 0
  return(dfz)
}

t.test2 <- function(mean1, sd1, n1, mean2, sd2, n2, direction = "greater") {
  data1 <- scale(1:n1)*sd1 + mean1
  data2 <- scale(1:n2)*sd2 + mean2
  if (mean1 > mean2){
    stats::t.test(data1, data2, alternative = "greater")
  } else if (mean1 < mean2){
    stats::t.test(data1, data2, alternative = "less")
  } else {
    stats::t.test(data1, data2, alternative = "two.sided")
  }
}







sliding_window <- function(
  vec,
  window_width
){
  all_windows <- length(vec)-window_width+1
  return(lapply(1:all_windows, function(k){vec[k:(k+window_width-1)]}))
}



addLeadingZeros <- function(
  num_vec
){
  digit_number <- floor(max(log10(num_vec)+1))
  return(stringr::str_pad(as.character(num_vec), digit_number, pad = "0"))
}


remove_combination_duplicates <- function(
  df,
  columns
){
  return(df[!duplicated(t(apply(df[columns], 1, sort))), ])
}


dataframe_to_list <- function(
  df
){
  list_items <- unique(df[, 1])
  output_list <- lapply(list_items, function(x){return(df[df[, 1] == x, 2])})
  names(output_list) <- list_items
  output_list <- output_list[order(lengths(output_list), decreasing = TRUE)]
  return(output_list)
}

