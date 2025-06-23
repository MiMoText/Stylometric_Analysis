# Stylometry and Knowledge Graphs: Authorship Attribution of *L’enfant du bordel* (1800)
​
This repository was created during the work on a paper on stylometric analysis by Julia Röttgermann and Johanna Konstanciak. It contains all data used: the R-script for stylometric analysis, the corpora, results, and the image files.

It focuses on authorship attribution of the novel *L'enfant du bordel* (1800), which was published anonymously. Previously stylometric analysis were part of the project  (2019-2024). The project aimed in building a Knowledge Graph ([MiMoTextBase](https://data.mimotext.uni-trier.de/wiki/Main_Page "MiMoTextBase")) based on information about French novels, published between 1751 and 1800. The Knowledge Graph is fed from various sources: primary texts, bibliographic metadata and secondary literature.
​
Licence: CC-BY 4.0.

## corpora

This folder contains different variations of the corpus on French literature 1751-1800 (Röttgermann 2023 and 2024).

### "testcorpus":

* This corpus contains novels with known authorship.&#x20;

* For each author there must be at least 3 different novels present.

* The novel in question (*L'enfant du bordel*) is not included yet.

* It was used for preliminary tests with different most frequent words (MFW) and cosine delta-distance to determine a suitable score for MFWs. The results for this analysis is found in "results/testcorpus/nMFW".

### "corpus\_more\_than\_3\_samples\_Enfant\_Mirabeau"

* For each author there must be at least 3 different novels present.

* It contains additionally *L'enfant du bordel*.

* Additionally it contains two novels written by Mirabeau.

### "narrativeForm"

* This corpus has the same assembling as "corpus\_more\_than\_3\_samples\_Enfant\_Mirabeau".

* The filenames are changed according to the narrative form the novel is written in.

* Results on this analysis can be found in: xxx

## results

The folder "results" contains various subfolders:

* BCT: here are the results and plots for Bootstrap Consensus Tree (BCT) 500-2000 and 2000-3500 MFWs

* dendrograms: plots and files for creating dendrograms with different most frequent word (MFW) settings: 500, 1000, 2000, 3500

* narrForm: results and plots for testing influence of narrative forms. MFW=2000 (dendorgram) and 2000-3500 (BCT)

* testcorpus: results created by using the testcorpus

* final results for dendrogram and BCT

## Script: stylometric\_analysis.R

This is the script used to create all outputs shown in the paper. The main library used is *stylo* by Eder, Rybicki and Kestement (2016).

It can be used to perform stylometric analysis and create:

* a dendrogram

* a Bootstrap Consensus Tree

* General Imposters Method and optimization

​

## further explorations

This folder contains input and results for explorations on the corpus using texts that have a similar topic to *L'Enfant du bordel*.

### "corpus\_sim\_topics"

* This corpus contains novels with similar topics to that of *L'enfant du bordel* based on the SPARQL-Query:

* &#x20;<https://tinyurl.com/24pv9zu7>

* subfolder "sim\_topics":

  * Additionally: For each author there must be at least 3 different novels present. Exception: Pigault-Lebrun is represented with two novels. As he is a possible candidate for the authorship, they were added.

  * Additionally *L'enfant du bordel* is included.

  * Results on this analysis can be found in: sim\_topics

* subfolder  "sim\_topics\_mind\_2"

  * Additionally: For each author there must be at least 2 different novels present.

  * Additionally *L'enfant du bordel* is included.

  * Results on this analysis can be found in: sim\_topics\_mind\_2

### "results\_sim\_topics"

* results of stylometric analysis with novels having a similar topic to *L'enfant du bordel*

### "results\_sim\_topics\_mind\_2"

* results of stylometric analysis with novels having a similar topic to *L'enfant du bordel;​* there must be at least 2 novels per author in the corpus.

## get_distances.py

This python-Script was used to extract the n-smallest distances from the distance table that was output by the R package *stylo*.

## Bibliography

Eder, Maciej, Jan Rybicki, and Mike Kestemont. 2016. ‘Stylometry with R: A Package for Computational Text Analysis’. The R Journal 8 (January):107–21. <https://doi.org/10.32614/RJ-2016-007>.

Röttgermann, Julia. 2023. ‘Collection de romans français du dix-huitième siècle (1751-1800) / Eighteenth-Century French Novels (1751-1800)  \[dataset]’. Zenodo. <https://doi.org/10.5281/zenodo.10404966>.

Röttgermann, Julia. 2024. ‘The Collection of Eighteenth-Century French Novels 1751-1800’. Journal of Open Humanities Data 10 (1). <https://doi.org/10.5334/johd.201>.
