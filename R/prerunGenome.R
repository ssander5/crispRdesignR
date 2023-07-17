library(BSgenome)
library(crispRdesignR)
library(seqinr)

#define transcripts to pre-run and reference genome
transcripts="LRV0_1_genes.sorted.UCSC.renamed.gff"
genome=BSgenome.Dmagna.LRV0.UCSC::BSgenome.Dmagna.LRV0.UCSC

#load in sequences
seqs=read.fasta(file=transcripts)
i=1; 
#len=length(seqs)
len=4  #for testing

#loop through sequences and create RData object to sub in for "all_data"
while (i<len) 
{ 
    input = getSequence(seqs[[i]], as.string=TRUE); 
    hits = sgRNA_design(input[1], 
        genome, 
        transcripts,
        calloffs=TRUE, 
        annotateoffs=TRUE);
    #names(hits) = str_replace_all(names(hits), c(" " = ".", "," = ""))  #if you want to remove spaces from the tables
    filename = paste(getName(seqs)[i],".RData",sep="") 
    capture.output(hits, file = filename)
    i = i+1
}
