library(tidyverse)

# function to remove duplicate columns, such as something like, Series_1 and Series_2
reduce_names <- function(df){
  
# make sure this new column in the dataframe is character, not factor
  df$names <- as.character(df$names)

  # separate on the _#. pattern and then the _$ pattern
  df_reduced <- df %>% 
    separate(names, c("names_A","names_B"), sep = "\\_\\d+\\.") %>% 
    separate(names_B, c("names_B","names_C"), sep = "\\_\\d")  %>% 
    separate(names_A, c("names_A","names_D"), sep = "\\_\\d+$") 
  
  # remove duplicate rows
  df_reduced <- distinct(df_reduced)
  
  # merge remaining columns again
  df_reduced <- df_reduced %>% unite("names", names_A:names_C, na.rm = TRUE, remove = TRUE)
  
  # turn underscores into spaces
  df_reduced$names <- gsub('_', ' ', df_reduced$names)
  
  return(df_reduced)
}


# read in the saved searches
full <- read_delim("missing_full.txt", 
                                 "\t", escape_double = FALSE, col_types = cols(ISBN = col_double(), Pub_Year = col_integer()), trim_ws = TRUE)

brief <- read_delim("missing_brief.txt", 
                   "\t", escape_double = FALSE, col_types = cols(ISBN = col_double(), Pub_Year = col_integer()), trim_ws = TRUE)

single <- read_delim("missing_single.txt", 
                   "\t", escape_double = FALSE, col_types = cols(ISBN = col_double(), Pub_Year = col_integer()), trim_ws = TRUE)

# pull out the column headers
names_single <- names(single)
names_brief <- names(brief)
names_full <- names(full)

# find names that are added to brief and full
# names_in_brief_not_in_single <- names_brief[!(names_brief %in% names_single)]
# names_in_full_not_in_brief <- names_full[!(names_full %in% names_brief)]

# turn the names lists into dataframes
names_single_df <- data.frame(names_single)
names_brief_df <- data.frame(names_brief)
names_full_df <- data.frame(names_full)

# find names that are added to brief and full
names_in_brief_not_in_single_df <- data.frame(names_in_brief_not_in_single)
names_in_full_not_in_brief_df <- data.frame(names_in_full_not_in_brief)

#update column names
colnames(names_single_df)[colnames(names_single_df) == 'names_single'] <- 'names'
colnames(names_brief_df)[colnames(names_brief_df) == 'names_brief'] <- 'names'
colnames(names_full_df)[colnames(names_full_df) == 'names_full'] <- 'names'
colnames(names_in_brief_not_in_single_df)[colnames(names_in_brief_not_in_single_df) == 'names_in_brief_not_in_single'] <- 'names'
colnames(names_in_full_not_in_brief_df)[colnames(names_in_full_not_in_brief_df) == 'names_in_full_not_in_brief'] <- 'names'

# remove duplicate columns
names_brief_df_reduced <- reduce_names(names_brief_df)
names_full_df_reduced <- reduce_names(names_full_df)
names_in_brief_not_in_single_reduced <- reduce_names(names_in_brief_not_in_single_df)
names_in_full_not_in_brief_reduced <- reduce_names(names_in_full_not_in_brief_df)

# make csv files with all column names in each level
write.csv(names_single_df, file = "single_columns.txt", row.names = FALSE, quote = FALSE)
write.csv(names_brief_df, file = "brief_columns.txt", row.names = FALSE, quote = FALSE)
write.csv(names_full_df, file = "full_columns.txt", row.names = FALSE, quote = FALSE)

# write csv iles with all unique column names in each level
write.csv(names_brief_df_reduced, file = "brief_columns_no_repeats.txt", row.names = FALSE, quote = FALSE)
write.csv(names_full_df_reduced, file = "full_columns_no_repeats.txt", row.names = FALSE, quote = FALSE)

# write csv files with column names added to brief and full
write.csv(names_in_brief_not_in_single_reduced, file = "brief_not_single.txt", row.names = FALSE, quote = FALSE)
write.csv(names_in_full_not_in_brief_reduced, file = "full_not_brief.txt", row.names = FALSE, quote = FALSE)





