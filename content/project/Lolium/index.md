---
date: "2022-07-20T00:00:00Z"
external_link: ""
image:
  # caption: Function-based assignment of RBP functionalities.
  focal_point: Smart
# links:
# - icon: twitter
#   icon_pack: fab
#   name: Follow
#   url: https://twitter.com/afraderasola
# slides: example
summary: Main M.Sc project - I developed a scoring function around three R-based RNA-Seq differential expression packages (DESeq2, edgeR, limma+voom). The main goal was to assess ow well packages perform and compare the their results in order to maximize (or restric, depending on your criteria) the number of detected DEGs. 
tags:
- Genomics
title: Scoring function development for RNA-Seq differential expression assessment
url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""
---

# Introduction

My M.Sc project aimed to develop a scoring function for detecting differentially expressed genes (DEGs) using RNA-Seq data. I was motivated by the abundance of existing packages and resources for DEG analysis and wanted to investigate the differences between the most popular methods, compare their results, and determine the optimal approach for identifying DEGs. To achieve this, I utilized a novel dataset focused on drought resistance in the ryegrass species *Lolium perenne* to test the various DEG detection packages and optimize the methodology. Through this project, I was able to contribute to the important field of crop agriculture while improving the accuracy and efficiency of DEG analysis. 

# RNAseq, DEGs and R pacakges for data analysis

RNA sequencing (RNAseq) is a widely used technique to measure gene expression levels in cells or tissues. RNAseq data analysis involves several steps, including quality control, alignment, quantification of gene expression, differential gene expression analysis, and functional enrichment analysis. Each step requires careful consideration to ensure the reliability and reproducibility of the results. There are several tools and packages available for each step, and choosing the appropriate ones is critical to achieving accurate and meaningful results. RNAseq data analysis can provide insights into gene regulation, identify novel transcripts, and discover biomarkers for disease diagnosis and treatment.

I decided to focus on three widely used packages (edgeR, DESeq2 and limma+voom) and a less-cannonical one (baySeq):

- [**edgeR**](https://academic.oup.com/bioinformatics/article/26/1/139/182458?login=true): edgeR (Empirical analysis of Digital Gene Expression in R) is a software package used for the identification of differentially expressed genes in RNAseq datasets. It uses a negative binomial model and empirical Bayes estimation to estimate the dispersion parameters and gene-wise dispersion estimates. This package can be used for single-factor or multi-factor experimental designs.

- [**DESeq2**](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-014-0550-8): DESeq2 is a R package that can be used to analyze differential gene expression in RNAseq experiments. It uses the negative binomial distribution to model count data and provides methods for estimating size factors and dispersion parameters. DESeq2 also provides methods for normalizing data, performing hypothesis testing, and visualizing results.

- [**limma+voom**](https://f1000research.com/articles/5-1408/v3): limma (Linear Models for Microarray Data) is an R package that can be used to analyze differential gene expression in RNAseq datasets. It uses linear models to analyze differential expression and provides a range of functions for data normalization and visualization. The voom (Variance modeling at the Observed Mean) function in limma can be used to transform count data into log2-counts per million (logCPM) values, which can then be used with limma for differential expression analysis.

- [**baySeq**](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-11-422): baySeq is a software package for analyzing RNAseq data using Bayesian methods. It can be used to identify differentially expressed genes, quantify expression levels, and estimate the probability of differential expression. baySeq models count data using a negative binomial distribution and provides a flexible framework for incorporating prior information about gene expression.