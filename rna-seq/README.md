hisat2_counts.csv - Read counts for each sample.
design_mat.csv - Design matrix for DESeq2, and mapping of raw sample names to strain names.
RNA Sequencing Stats.xlsx - Statistics of sequencing run.
gene2description.tsv - Description of genes.
DESeq2_run.R - Runs DESeq2 analysis, calculating fold enrichment between gene sets. Must change contrasts and output file names appropriately.
{}_deseq2.csv - DESeq2 output files.
gsea.R - Runs gene set enrichment analysis (GSEA), using output from DESeq2. Must change name of input and output files per analysis.
{}_kegg_gsea.csv - GSEA output files.