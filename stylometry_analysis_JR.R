# Stylometry 

# Install and call the package
install.packages("stylo")
install.packages("networkD3")
library(stylo)
library(networkD3)


# Important note:
# set working directory
setwd("/cloud/project/scripts/stylo/roman18")

# First analysis (dendrogram with 3500 MFW and Wurzburg distance)
stylo(corpus.format="plain",
      corpus.lang="French", 
      mfw.min=3500, 
      mfw.max=3500,
      mfw.incr=0,
      distance.measure="dist.wurzburg",
      custom.graph.title = "Stylometric Analysis of French novels 1751-1800", 
      analysis.type="CA",
      write.jpg.file=T,
      plot.custom.height=16,
      plot.custom.width=9)

# Second analysis (PCA  with 150 MFW and Wurzburg distance)
stylo(corpus.format="plain",
      corpus.lang="French", 
      analysis.type = "PCR",
      mfw.min=150, 
      mfw.max=150,
      distance.measure="dist.wurzburg",
      custom.graph.title = "Analysis with Stylo | French novels 1751-1800", 
      pca.visual.flavour = "loadings",
      write.png.file = TRUE, 
      gui = FALSE)

# Third analysis (dendrogram with 300 MFW and Classic Delta distance)
stylo(corpus.format="plain",
      corpus.lang="French", 
      mfw.min=300, 
      mfw.max=300,
      mfw.incr=0,
      distance.measure="dist.delta",
      analysis.type="CA",
      write.jpg.file=T,
      plot.custom.height=16,
      plot.custom.width=9)

# Fourth analysis (Consensus tree with 2000 MFW)
stylo(corpus.format="plain",
      corpus.lang="French", 
      mfw.min=100, 
      mfw.max=2000,
      mfw.incr=100,
      distance.measure="dist.wurzburg",
      analysis.type="BCT",
      write.jpg.file=T,
      plot.custom.height=16,
      plot.custom.width=16)

 # Oppose analysis
 oppose(text.slice.length = 3000,
       oppose.method = "craig.zeta",
       custom.graph.title = "Oppose method: Sade [left] vs. Voltaire [right]]", 
       write.png.file = TRUE)
            
# Much more details are available here: https://github.com/computationalstylistics/stylo_howto/blob/master/stylo_howto.pdf           