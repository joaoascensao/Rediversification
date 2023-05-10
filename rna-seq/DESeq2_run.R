library( "DESeq2" )
library(ggplot2)
library(tidyverse)
library(genefilter)
library(ggrepel)

counts_data <- read.csv('hisat2_counts.csv')
rownames(counts_data) <- counts_data$Locus
counts_data = subset(counts_data, select = -c(Locus) )
head(counts_data)

colData <- read.csv('design_mat.csv')
rownames(colData) <- colData$name
colData = subset(colData, select = -c(name) )

dds <- DESeqDataSetFromMatrix(countData = counts_data,
                              colData = colData,
                              design= ~ condition )
keep <- rowSums(counts(dds) >= 10) >= 4
dds <- dds[keep,]

dds <- DESeq(dds)


res <- results(dds, contrast = c("condition", "L", "S"))
res <- lfcShrink(dds, contrast = c("condition", "L", "S"),type='ashr')
df_res <- as.data.frame(res)
write.csv(df_res,'LS_deseq2.csv')

vsd <- varianceStabilizingTransformation(dds, blind=TRUE)

write.csv(assay(vsd),'vsd2.csv')
rld <- rlog(dds)
write.csv(assay(rld),'rlog.csv')

