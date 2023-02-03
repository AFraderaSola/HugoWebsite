---
date: "2022-08-31T00:00:00Z"
external_link: ""
image:
  caption: Function-based assignment of RBP functionalities.
  focal_point: Smart
# links:
# - icon: twitter
#   icon_pack: fab
#   name: Follow
#   url: https://twitter.com/afraderasola
slides: CSAMARBPyeast
summary: Main PhD project - RNA binding proteins (RBPs) were selected according to their involvement in RNA pathways and immunoprecipitated. This allowed us to create a function-based network that enabled the assignment of new functionalities on novel and known RBPs. This work was recently presented at CSAMA 2022.
tags:
- Proteomics
title: Network-based assignment of RNA-binding protein function
url_code: ""
url_pdf: ""
url_slides: ""
url_video: ""
---

{{< toc >}}

### TL;DR

This project’s goal is to identify RNA-binding proteins (RBPs) functionalities with **proteomics data and network analysis**. I used **mass-spectrometry** data to collect interaction partners for 40 RBPs with known functionalities on the mRNA life cycle. Then I constructed a network to connect all the proteins and use a **guilt-by-association principle** to assign novel functionalities. This resulted in the creation of a **Shiny app** database [https://butterlab.imb-mainz.de/ScRBPinteractome/](https://butterlab.imb-mainz.de/ScRBPinteractome/) where data can be interactively explored. 
If you find the app interesting and you want to learn more about the data analysis behind it, continue to read. 

### Introduction

This project is the backbone of my **PhD thesis** which revolves around mass-spectrometry (MS) data, with a particular focus on RNA binding-proteins (RBPs) and their associated functionalities. In recent years, the number of detected proteins classified as RBPs has been **skyrocketing**; in yeast, for instance, there are 1,273 proteins classified as RBPs. You can check this nice review from [Hentze *et al.*](https://www.nature.com/articles/nrm.2017.130) if you are curious about this phenomenon.  Even so, and despite more and more proteins being classified as RBPs, their **functional** roles remain largely unexplored. 
The main reason behind the lack of functional details is that newly described RBPs mostly come from **high-throughput** techniques such as  [RNA interactome capture (RIC)](https://www.nature.com/articles/s41467-018-06557-8). These techniques usually generate big data sets and **shine at identifying and classifying individuals**, but they do lack deep biological characterization. 
The goal behind this project was to add a **first layer** of functional characterization while keeping a **high-throughput**. Thus, we selected **40 well-characterised yeast RBPs** and identified its interaction partners with immunoprecipitation coupled to MS-based quantitative proteomics. With this data we were able to build **function-based** networks to gather hints on which individuals might be involved on particular **RNA-related** pathways. 

### The Data

#### Candidate RBPs

I wanted to collect the interaction partners for 40 selected RBPs, which would constitute the building blocks of our function-based networks. Before focusing on the interactors data itself let’s first take a step back and look at the candidates data. Why these 40 RBPs in particular? How do they enable function-based networks? Hell, what do I even mean by “function-based networks''?

{{< figure src="Picture1.png" caption="Function-based network concept" >}}

Let’s start by refreshing some basic network terminology. During this post, I am gonna describe the selected RBPs as network **hubs**, their interaction partners as **nodes**, and the connections between them as **edges**.  This way, each square (Target RBP) is a hub, each circle (IP interactor) is a node, and the lines (connections) are edges. These three elements are what I eventually used to create the **RBP interactome network**. When we later take a subset of this larger network, filtering for a particular functionality, we get what we describe as **function-based networks**. For instance, if we would keep only the blue hubs, we would obtain a blue function-based network. 
Now that I have established the network *lingua franca*, we can focus on our 40 RBP candidates. I selected them with the idea that, ultimately, they would become the hubs on the function-based networks. Thus it became paramount to select **well-studied** candidates with **central roles** on their pathways. I relied on the [KEGG](https://www.kegg.jp/) and [Reactome](https://reactome.org/) databases to query RBPs involved in **RNA biology pathways** such as degradation or splicing. Finally, our **candidates** needed to be included on the TAP tagged comercial library so I could capture them with antibodies. 

#### Interactors data

{{< figure src="Picture2.png" caption="Immunoprecipitation experimental design" >}}

I immunoprecipitated each selected RBP and pulled down all their interactor partners, in the **presence** or **absence** of RNA. This allowed to obtain two very distinctive groups of interactors: 
- **Protein-Protein interactors (PPI)**: Due to the RNA digestion, by RNase A, all the nodes in this group interact with our hubs in an **RNA independent** manner. 
- **RNA-dependent interactors (RDI)**: This group contains all the nodes that interact with our hubs in an **RNA dependent** manner. 
For both groups, the interactors were measured and quantified with a label-free quantification (LFQ) MS protocol. Together with the hub candidates, the PPI and RDI nodes are the building blocks which I used to construct the function-based networks.

### Data analysis

I have not included any code on this post but, If you get curious and want to check it, you can find it available at the following github repository [github repository](https://github.com/AFraderaSola/Scerevisiae_RBPs_Interactome). I will reference which subfolders belong to each analysis on their corresponding subsection. 

#### RBP interactors quantification

The code for this analysis can be found in the following [github repository subfolder](https://github.com/AFraderaSola/Scerevisiae_RBPs_Interactome/tree/main/01_IPscreen/YAFXXX/LFQ/01_CoreAnalysis). During this section, I am gonna assume you know some basic MS concepts; otherwise you can check this nice review from [Sinha *et al.*](https://portlandpress.com/biochemist/article/42/5/64/226371/A-beginner-s-guide-to-mass-spectrometry-based) to freshen them up. 

After the immunoprecipitation experiments, I obtained, in quadruplicate, protein elution products for three conditions:
- **Wild type (WT)**
- **TAP-tagged IP RNase treated (RNase)**
- **TAP-tagged IP untreated (IP)**
These are ready for MS measurement; as mentioned before, I choose a LFQ protocol. Long story short, this means we can directly use our digested peptides without adding any chemical or metabolic labelling. This way, for each of our selected 40 candidates I would **quantify** their RNase and IP **interactors** so I could compare them to each other and against a WT. 
The first step in the quantification is to match the MS peptide spectra with protein groups; for this purpose, I use the andromeda search engine as incorporated in [MaxQuant](https://www.maxquant.org/). This allows for protein quantification, based on the peptide intensity. I will not go into further details on how LFQ works, you can chek this review from [Cox *et al.*](https://www.sciencedirect.com/science/article/pii/S1535947620333107?via%3Dihub) if you want to learn more.

{{< figure src="Picture3.png" caption="Protein filtering steps" >}}

With our proteins identified we proceed with a series of quality control filtering steps; mainly we filter out the following protein groups:
- **Known contaminants**, present on any MS experiment (i. e., keratin), as provided by the [Cox lab](http://www.coxdocs.org/doku.php?id=maxquant:start_downloads.htm) 
- **Reverse peptides**
- Filter peptides by **razor** and **unique peptide number**. This way, I only keep protein with a minimum of razor+unique peptide count higher than 2 and a minimum of unique peptide count higher than 1.
- Filter out by **quantification event**. This way, I decide to keep only proteins with a minimum of 2 quantification events along the replicates. Thus, any protein without an intensity value associated (not NA) in, at least, two out of four replicates will be filtered out.

{{< figure src="Picture4.png" caption="LFQ intesities distribution: original vs. imputed values" >}}

Next step is dealing with the **missing values**. A known issue of MS experiments is the **abundance of NA values** along the detected protein groups due to technical limitations. For instance, a protein group could be identified with an average intensity of 25 in three replicates and have an NA value on the fourth. Our approach for these NA values is to assume that the protein was **not detected due to technical limitations** not because it was not present in the protein mixture. This way, we decide to impute an intensity value for all NA values still present **after the filtering steps**. We do so by shifting a **beta distribution** obtained from the LFQ intensity values to the **limit of quantitation**. This way, the resulting imputed values will always be random values constricted to the lowest end of our LFQ intensities. This is just one approach among many; if you are interested in further reading regarding MS data imputation, I would suggest this article from [Wei *et al.*](https://www.nature.com/articles/s41598-017-19120-0). 
With our NA values imputed, we are ready to proceed with a series of quality control and exploratory analysis checks. These are pretty standard on any omics analysis (i. e., clustering by pearson correlation coefficient and dimensionality reduction by PCA) so I will not cover them in this post.

{{< figure src="Picture5.png" caption="Volcano plots: PPI comparison (left) and RDI comparison (right)" >}}

This leads to our final step, where we assess quantified interactors differences among our three conditions. We do so with a standard [t-test](https://en.wikipedia.org/wiki/Student%27s_t-test). The results are **visualised as a volcano plot**, which offers an intuitive way to identify enriched interactors and **benchmark the experiment quality** by observing the RBP-TAP and RNase behaviour. As described before, we are interested in obtaining to groups of interactors, as shown for PAB1 in the example volcano plots:
- **PPI**, resulting from the comparison of a treated TAP-tagged RBP (RNase) to a wildt type (WT). In this comparison, the **RBP-TAP targeted** during the immunoprecipitation gets **clearly enriched** as it is not pulled down on the WT condition. On the other hand, the RNase enzyme falls on the **background** due to its presence in both conditions. All RBP-TAP **RNA independent interactors** get enriched in this comparison. 
- **RDI**, resulting from the comparison of an untreated TAP-tagged RBP (IP) to a treated TAP-tagged RBP (RNase). In this comparison, the **RBP-TAP targeted** during the immunoprecipitation falls on the **background** as it is equally pulled down in both conditions. On the other hand, the RNase enzyme gets **negatively enriched** as it is only present in the treated condition (RNase).  All RBP-TAP **RNA dependent interactors** get enriched in this comparison. 

{{< figure src="Picture6.png" caption="Bar plot: PPI (green), RDI (orange) and ovelap (purple) groups" >}}

This way, we repeated this setup for all our 40 RBPs and we obtained two **clearly different** groups (minimal overlap, **in purple** on the barplot image) corresponding to the **PPI** and **RDI**.

#### Functional Analysis

The code for this analysis can be found in the following [github repository subfolder](https://github.com/AFraderaSola/Scerevisiae_RBPs_Interactome/tree/main/01_IPscreen/YAFXXX/LFQ/02_FunctionalAnalysis). 

{{< figure src="Picture7.png" caption="Functional enrichment heat map" >}}

After the (long) quantification section, I described how our network **hubs** (target tagged RBPs) and **nodes** (**PPI** and **RDI** groups) were obtained. At this point I would be ready to build the interactome network, as the **edges** just connect the nodes to the hubs when they were quantified on their respective experiments. I indeed have all the elements to build a *basic* interactome network, but I am interested in building a *function-based* network. Thus I need to classify the hubs by **function** in order to do so. I already selected them following functional criteria and one could argue this would be already enough. But I want to take it a step further and see if not just the *hubs* have associated functions but also their associated *nodes*. Thus, I choose to perform a functional enrichment analysis for each hub associated nodes. Again, this is a standard analysis included on many omics workflows so I will not cover it deeply. Long story short, I performed an **over-representation analysis** as implemented in the [ClusterProfiler R package](https://yulab-smu.top/biomedical-knowledge-mining-book/enrichment-overview.html) which, in brief, calculates p-values by hypergeometric distribution from a experimentally derived list of enriched IDs (PPI or RDI groups) and its background (Quantified proteins). This way we obtained the PPI and RDI associated [KEGG](https://www.kegg.jp/) pathways for each hub, if any.

#### Network Analysis

Now comes the fun part; I do have all the **elements** to construct a network (hubs, nodes and edges) and a **data-driven functional classification** criteria. Thus I can proceed to build the networks, with the R [igraph](https://igraph.org/r/)  **nicely algorithm** implementation. For the **PPI** and **RDI** data, I decided to create two different kind of networks:
- A **global network**, containing all 40 hubs. In such networks, hubs and their edges would be colour highlighted when they had a **unique associated function**. 

{{< figure src="Picture8.png" caption="Global network: PPI (left) and RDI (right) groups as a network" >}}

- A **function-based subnetwork**, containing all hubs associated with a particular subnetwork. For these networks I also colour highlighted the nodes, so they would show whether they have been reported before or not on the **BioGRID database** and whether they have been **classified as RBPs** or not. 

{{< figure src="Picture9.png" caption="Function-based  subnetwork: PPI (left) and RDI (right) groups as a network" >}}

Additionally I also combined the **PPI** and **RDI** groups into a **global network** and **function-based subnetwork**. For these networks, instead of highlighting the hubs or the nodes I choose **to highlight the edges** to show their group association (PPI, RDI or overlap). 

{{< figure src="Picture10.png" caption="Global and Function-based networks: PPI and RDI groups combined as a network" >}}

### Conclusion

All these data analysis and network building are created with a particular goal in mind: **serve as a resource**. We point out which **nodes are novel** (non reported at BioGRID) and whether they are **classified as RBPs or not**. Additionally we pointed out potential functional associations with our **function-based** networks. Following the **guilt-by-association** principle, if a node is concurrently associated with other nodes and hubs that are participating, for instance, in splicing pathways you are likely involved in splicing. Thus this can be used as a starting point  for **in-depth functional characterization**. To facilitate it, I constructed a user-friendly **shiny app** [https://butterlab.imb-mainz.de/ScRBPinteractome/](https://butterlab.imb-mainz.de/ScRBPinteractome/) were all the networks can be explored. With this, I hope that data becomes **accessible** and **RNA research labs** are able to deepen the RBP research field. 



