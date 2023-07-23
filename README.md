# Serratia_multiconflict

**ATHENIAN: Association wiTH dEfeNce IslANds**: Starting from genomic coordinates of islands of interest, uses bedtools-pyfaidx-eutils to find and extract flanking regions of homologues. 
Uses helper python script **gbktofaa.py** to convert genbank files to protein fasta, then runs defence-finder on them

**DEPENDENCIES**
Entrez Eutils
MMseq2
Pandas
HMMER
Biopython
sed
wget
Biopython
Defense-finder

**NOTE**: need gbktofaa.py in the same directory to run
