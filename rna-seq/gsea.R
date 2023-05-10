library(clusterProfiler)
library(enrichplot)
# we use ggplot2 to add x axis labels (ex: ridgeplot)
library(ggplot2)
library(org.EcK12.eg.db)



df2 = read.csv("SbS_deseq2.csv", header=TRUE)
original_kegg_gene_list <- df2$log2FoldChange

names(original_kegg_gene_list) <- df2$X

kegg_gene_list<-na.omit(original_kegg_gene_list)


kegg_gene_list = sort(kegg_gene_list, decreasing = TRUE)

kegg_organism = "ebr"
kk4 <- gseKEGG(geneList      = kegg_gene_list,
               organism      = kegg_organism,
               minGSSize     = 3,
               maxGSSize     = 800,
               pvalueCutoff  = 1,
               eps           = 1e-20,
               pAdjustMethod = "none",
               keyType       = "kegg",
               nPerm         = 1000000)


cluster_summary <- data.frame(kk4)
write.csv(cluster_summary , file = "SbS_kegg_gsea.csv", row.names=FALSE)

