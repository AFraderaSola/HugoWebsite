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

This project’s goal is to identify RNA-binding proteins (RBPs) functionalities with **proteomics data and network analysis**. I used **mass spectrometry** data to collect interaction partners for 40 RBPs with known functionalities on the mRNA life cycle. Then I constructed a network to connect all the proteins and use a **guilt-by-association principle** to assign novel functionalities. This resulted in the creation of a **Shiny app** database [https://butterlab.imb-mainz.de/ScRBPinteractome/](https://butterlab.imb-mainz.de/ScRBPinteractome/) where data can be interactively explored. 
If you find the app interesting and you want to learn more about the data analysis behind it, continue to read. 

### Introduction

This project is the backbone of my **PhD thesis** which revolves around mass spectrometry data, with a particular focus on RNA binding-proteins (RBPs) and their associated functionalities. In recent years, the number of detected proteins classified as RBPs has been **skyrocketing**; in yeast, for instance, there are 1,273 proteins classified as RBPs. You can check this nice review from [Hentze *et al.*]([https://www.nature.com/articles/nrm.2017.130]) if you are curious about this phenomenon.  Even so, and despite more and more proteins being classified as RBPs, their **functional** roles remain largely unexplored. 
The main reason behind the lack of functional details is that newly described RBPs mostly come from **high-throughput** techniques such as  [RNA interactome capture (RIC)]([https://www.nature.com/articles/s41467-018-06557-8]). These techniques usually generate big data sets and **shine at identifying and classifying individuals**, but they do lack deep biological characterization. 
The goal behind this project was to add a **first layer** of functional characterization while keeping a **high-throughput**. Thus, we selected **40 well-characterised yeast RBPs** and identified its interaction partners with immunoprecipitation coupled to mass-spectrometry based quantitative proteomics. With this data we were able to build **function-based** networks to gather hints on which individuals might be involved on particular **RNA-related** pathways. 

### The Data

#### Candidate RBPs

I wanted to collect the interaction partners for 40 selected RBPs, which would constitute the building blocks of our function-based networks. Before focusing on the interactors data itself let’s first take a step back and look at the candidates data. Why these 40 RBPs in particular? How do they enable function-based networks? Hell, what do I even mean by “function-based networks''?

{{< figure src="Picture1.png" caption="Function-based network concept" >}}

Let’s start by refreshing some basic network terminology. During this post, I am gonna describe the selected RBPs as network **hubs**, their interaction partners as **nodes**, and the connections between them as **edges**.  This way, in Figure 1, each square (Target RBP) is a hub, each circle (IP interactor) is a node, and the lines (connections) are edges. These three elements are what I eventually used to create the **RBP interactome network**. When we later take a subset of this larger network, filtering for a particular functionality, we get what we describe as **function-based networks**. For instance, if we would keep only the blue hubs on Figure 1, we would obtain a blue function-based network. 
Now that I have established the network *lingua franca*, we can focus on our 40 RBP candidates. I selected them with the idea that, ultimately, they would become the hubs on the function-based networks. Thus it became paramount to select **well-studied** candidates with **central roles** on their pathways. I relied on the [KEGG](https://www.kegg.jp/) and [Reactome](https://reactome.org/) databases to query RBPs involved in **RNA biology pathways** such as degradation or splicing. Finally, our **candidates** needed to be included on the TAP tagged comercial library so I could capture them with antibodies. 

#### Interactors data

{{< figure src="Picture2.png" caption="Immunoprecipitation experimental design" >}}

I immunoprecipitated each selected RBP and pulled down all their interactor partners, in the **presence** or **absence** of RNA. This allowed to obtain two very distinctive groups of interactors: 
- **Protein-Protein interactors (PPI)**: Due to the RNA digestion, by RNase A, all the nodes in this group interact with our hubs in an **RNA independent** manner. 
- **RNA-dependent interactors (RDI)**: This group contains all the nodes that interact with our hubs in an **RNA dependent** manner. 
For both groups, the interactors were measured and quantified with a label-free quantification mass-spectrometry protocol. Together with the hub candidates, the PPI and RDI nodes are the building blocks which I used to construct the function-based networks.

### Data analysis

I have **not included any code** on this post but, If you get curious and want to check it, you can find it available at the following github repository [github repository](https://github.com/AFraderaSola/Scerevisiae_RBPs_Interactome)

#### RBP interactors quantification

During this section, I am gonna **assume** you know some **basic mass-spectrometry concepts**; otherwise you can check this nice review from [Sinha *et al.*](https://portlandpress.com/biochemist/article/42/5/64/226371/A-beginner-s-guide-to-mass-spectrometry-based) to freshen them up. 
