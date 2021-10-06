# phylo-of-natural-isolates
##>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>##
##	Use this pipeline to 1) blast sequences in a directory 									                 ##
##						           2)	created overview and aligned fasta files with the results		     ##
##						           3)	Create a ML tree with  all queries with RAxML(Stamatakis 2014)	 ##
##	                                                                   						                 ##
##>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>##

Edit the master_script.sh file to add the software and assembly paths (edit the part of the script that looks like the example below)
Edit the NCBI_apply_criteria.py to add the path to NCBI blast results

##############    PATHS   ###############

# Path to blastn
blastn_soft= ADD/PATH/TO_BLAST_HERE

# Path to assemblies
home_path=ADD/PATH/TO_ASSEMBLIES

# Path to MAFFT
#MAFFT_soft=ADD/PATH/TO_MAFFT

# Path to RAxML
RAxML_soft=ADD/PATH/TO_RAxML
---------------------------------------------------------------------------------------------------
The script creates four directories 

home_path/done_fasta     -->		The fasta that have been blasted are here
home_path/results 		   -->	  Raw blast results are temporarily stored here
home_path/results/done   -->	  Raw blast results and intermediate files are stored here
home_path/results/output --> 	  Find your blast overview, aligned fasta and tree here
 
