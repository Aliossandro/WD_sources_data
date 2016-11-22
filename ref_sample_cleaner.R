###load sample previously extracted, clean it, and compute time difference with subsequent edit


setwd('~/Documents/PhD/') # modify according to local path
ref_sample <- read.csv('ref_data_sample.csv', stringsAsFactors = F)

#clean duplicates 
df <-   ref_sample[!duplicated(ref_sample[c("ref_id","timestamp_ref", 'ref_value')]),]

#clean unwanted references and change data type of timestamp
df <- df[which(df$ref_domain != 'www.wikidata.org'),]
df$timestamp_ref <- as.character(df$timestamp_ref)
df$timestamp <- as.POSIXct(df$timestamp_ref)
df <- subset(df, select = - timestamp_ref)
df <- df[grep('[a-z]{1,3}(.wikipedia.org)', df$ref_domain, invert = TRUE),]

#add a dummy row for each ref with timestamp value equal to the last day of the dumps 
df_single_max<- df[!duplicated(df$ref_id),]
df_single_max$timestamp <- as.POSIXct('2016-10-02 13:13:20')
df <- rbind(df, df_single_max)
rm(df_single_max)

#order by group, just to visually check if everything is in order
df <- df[order(df$ref_id, - df$timestamp),]

#compute time diff by group
df$diff <- ave(as.numeric(df$timestamp), factor(df$ref_id), FUN=function(x) c(NA, diff(x)))

#delete dummy rows and useless columns
df <- df[!(df$timestamp == '2016-10-02 13:13:20'),]
df <- subset(df, select = - c(ref_hash, rev_id, ref_type, tdiff, prev_tdiff))
