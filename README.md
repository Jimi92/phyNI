# PhyNI pipeline 

Use this pipeline to 1) blast sequences in a directory, 2) create overview and aligned sequence fasta with the blast results, 3) create a ML tree with all queries


-------------------------------------------------- Instructions -----------------------------------------------------

A) Open a terminal and paste this: git clone git@github.com:Jimi92/phylo-of-natural-isolates.git

B) From the downloaded file copy the two scripts (Master_script.sh and the NCBI_apply_criteria.py) to the file with the assemblies

--> B1) With a text editor edit the Master_script.sh to give the paths to the software and the assemblies (edit the part of the script that looks like the block below)



##############    PATHS   ###############

/# Path to blastn

blastn_soft=/ADD/BLAST+/folder_HERE/

/# Path to assemblies

home_path=/ADD/Assemblie/folder_HERE/

/# Path to MAFFT

/#MAFFT_soft=/ADD/MAFFT/DIR_HERE/

/# Path to RAxML

RAxML_soft=/ADD/Assemblie/folder_HERE/


--> B2) ith a text editor edit the NCBI_apply_criteria.py to give the paths to the software and the assemblies (edit the part of the script that looks like the block below)

out_files = glob.glob("/ADD/PATH/HERE/*.txt")

----------------------------------------------------------------------------------------------------------


The script will create four new folders

home_path/done_fasta      -->   The fasta that have been processed already (blasted) are here

home_path/results         -->   Raw blast results are temporarily stored here

home_path/results/done    -->   Raw blast results and intermediate files are stored here

home_path/results/output  -->   Find your blast overview, aligned fasta and tree here
