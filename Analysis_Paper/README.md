General Information
This repository was created during the work on a paper on stylometric analysis by Julia Röttgermann and Johanna Konstanciak. It contains all data used: the R-script for stylometric analysis, the corpora, results, and the images.
It focuses on authorship attribution of the novel L'enfant du bordel (1800), which was published anonymously.
Previously stylometric analysis were part of the project Mining and Modeling Text (2019-2024). The project aimed in building a Knowledge Graph (MiMoTextBase) based on information about French novels, published between 1751 and 1800. The Knowledge Graph is fed from various sources: primary texts, bibliographic metadata and secondary literature.


The repository can be used freely, please cite as: xxx .
Licence: CC-BY 4.0.
Corpora
This folder contains different variations on the corpus on French literatur 1751-1800 (Röttgermann 2023 and 2024).
"testcorpus":
This corpus contains novels with known authorship. 
For each author there must be at least 3 different novels present.
The novel in question (L'enfant du bordel) is not included.
It was used for preliminary tests with different most frequent words (MFW) and cosine delta-distance to determine a suitable score for MFWs. The results for this analysis is found in "results/testcorpus/nMFW".
"corpus_more_than_3_samples_Enfant_Mirabeau"
For each author there must be at least 3 different novels present.
It contains additionally L'enfant du bordel.
Additionally it contains 2 novels written by Mirabeau.
"corpus_sim_topics"
This corpus contains novels with similar topics to that of L'enfant du bordel based on the SPARQL-Query:
 https://tinyurl.com/24pv9zu7
Additionally: For each author there must be at least 3 different novels present. Exception: PigaultLebrun is represented with 2 novels. As he is a possible candidate for the authorship, they were added.
Additionally L'enfant du bordel is included.
Results on this analysis can be found in: xxx
"narrativeForm"
This corpus has the same assembling as "corpus_more_than_3_samples_Enfant_Mirabeau".
The filenames are changed accordingly to the narrative form the novel is written in.
Results on this analysis can be found in: xxx
results
Script: stylometric_analysis.R
This is the script used to create all outputs shown in the paper. The main library used is stylo by Eder, Rybicki and Kestement (2016).


Bibliography
Eder, Maciej, Jan Rybicki, and Mike Kestemont. 2016. ‘Stylometry with R: A Package for Computational Text Analysis’. The R Journal 8 (January):107–21. https://doi.org/10.32614/RJ-2016-007.
Röttgermann, Julia. 2023. ‘Collection de romans français du dix-huitième siècle (1751-1800) / Eighteenth-Century French Novels (1751-1800)  [dataset]’. Zenodo. https://doi.org/10.5281/zenodo.10404966.
Röttgermann, Julia. 2024. ‘The Collection of Eighteenth-Century French Novels 1751-1800’. Journal of Open Humanities Data 10 (1). https://doi.org/10.5334/johd.201.
