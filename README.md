# PhyNI pipeline 

Use this pipeline to 1) blast sequences in a directory, 2) create overview and aligned sequence fasta with the blast results, 3) create a ML tree with all queries


----------------------------------------------------------------------------------------------------------------------------------
## Instructions

A) Open a terminal and paste this: git clone git@github.com:Jimi92/phyNI.git

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
--------------------------------------------------------------------------------------------------------------

The motivation
A couple of months ago, Vanesa wanted to blast around 80 sequences using the NCBI web server. At the moment, I thought that blasting them one by one was very inefficient, let alone further processing these files for phylogenetics and other analyses.
 
Pipeline developed to solve the issue
This issue motivated me to developed a small pipeline that takes the assemblies in a folder, blast them and creates:  1) overview tables of the queries and the blast results, 2) aligned sequenced files (fasta), ready for phylogenetic/popgen analyses, and 3) a ML tree of all natural isolates with RAxML.
 
The pipeline is used by Vanesa for a while now. Please find the specifications below. Let me know if the pipeline could be useful for you, even after she leaves. In that case, I will invite you as a contributor to the github repository so you can have access to the scripts and updates.
 
If a student will carry on with these analyses, I strongly support the idea that they have to struggle a bit for developing their tools and solutions to own their project.
 -----------------------------------------------------------------------------------------------
Pipeline specs:
 

 
1)    Blasts assemblies with blastn (NCBI) (classic “nt” database) (Camacho et. al. 2009)
2)    Reshape into tables and sort the blast results (Primary sort: E-value, secondary: percentage of identity)
3)    Creates:
              a.     Sequence (fasta) files with the sequences of query and results (one per query)
              b.     A fasta file with all the query sequences
              c.     An overview table were for each query, the query ID and the scientific names of first five hits are reported
4)    Aligns each fasta file using MAFFT (Katoh and Standley 2013)
5)    Creates a maximum likelihood tree with all natural isolates with RAxML v.8 (Stamatakis 2014)
 
The aligned fasta files can be used by the majority of phylogenetic/pop. genetic software to assess the phylogenetic distance/relationship, demographic history, and signatures of selection.
·       This steps can also be included in the pipeline. for example, you can feed the pipeline with assemblies and have another ML (ex. IQtree) or distance trees of queries and blast results on the other end. That could save some effort and time as one does not need to upload the aligned sequence files one by one on an online server to produce the trees for example.
 
Pipeline performance: approx. 12 min/assembly (depends on the phylogenetic or other analysis that will follow the multiple seq. alignments)
