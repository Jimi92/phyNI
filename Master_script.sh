#!/bin/bash
#
#  submit by  sbatch full_pipe_until_prinseq.sh
#
#  specify the job name
#SBATCH --job-name=blast
#  how many cpus are requested
#SBATCH --ntasks=4
#  run on one node, importand if you have more than 1 ntasks
#SBATCH --nodes=1
#  maximum walltime, here 72h
#SBATCH --time=72:00:00
#  maximum requested memory
#SBATCH --mem=100G
#  write std out and std error to these files
#SBATCH --error=NC.%J.err
#SBATCH --output=NC.%J.out
#  send a mail for job start, end, fail, etc.
#  which partition?
#  there are global,testing,highmem,standard,fast
#SBATCH --partition=standard

#  add your code here:

##>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>##
##	Use this pipeline to 1) blast sequences in a directory 									 ##
##						 2)	created overview and aligned fasta files with the results		 ##
##						 3)	Create a ML tree with  all queries with RAxML(Stamatakis 2014)	 ##
##	Developed by Demetris Taliadoros, last update: 14/08/2021								 ##
##>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>>><<<>##

##############    PATHS   ###############

# Path to blastn
blastn_soft=/home/taliadoros/software/ncbi-blast-2.12.0+/bin/

# Path to assemblies
home_path=/home/taliadoros/Desktop/Vanesa/ncbi_blast/

# Path to MAFFT
#MAFFT_soft=

# Path to RAxML
RAxML_soft=/home/taliadoros/software/standard-RAxML/raxmlHPC

############   Directories  #############
mkdir ${home_path}done_fasta 		# the fasta that have been blasted are here
mkdir ${home_path}results 			# raw blast results are temporarily stored here
mkdir ${home_path}results/done		# raw blast results and intermediate files are stored here
mkdir ${home_path}results/output	# find your blast overview, aligned fasta and tree here


cd ${home_path}
###########  copy reshape script to result directory ############
cp NCBI_apply_criteria.py ${home_path}results

# BLAST with blastn 
for each in *.fasta 
do
${blastn_soft}blastn -db nt -query ${each} -out results/${each%.fasta}_results.out \
-outfmt "7 stitle sscinames bitscore qcovs evalue pident sacc sseq" \
-word_size 28 -remote
mv ${each} done_fasta
done

# Reshape and sort the blast results
cd ${home_path}results 
# enable this bit if you are running it on the cluster
#source /data/modules/python/python-anaconda3/etc/profile.d/conda.sh
#conda activate
rm ${home_path}results/output/*

mkdir done
mkdir output
for each in *.out
do
tail -n +7 ${each} | cut -f 2- -d "	" | uniq > ${each%.out}.txt
done

python3 NCBI_apply_criteria.py 

mv *.out done
mv *.txt done
rm output/*NC.*

# Create overview, aligned fasta files and ML tree
cd ${home_path}results/output
# Overview file
> tmp.txt
> tmp2.txt
> Overview.xls

for each in *.xls
do
while read p
do
echo ${each%_results.xls} >> tmp.txt
done < ${each}
paste tmp.txt ${each} > tmp2.txt
> tmp.txt
cat tmp2.txt > ${each}
sed -i "0,/${each%_results.xls}/s/${each%_results.xls}/Query/" ${each}
done

echo "Query	Species	Bit_score	Coverage	Identity	E_value" > Overview.xls

for each in *results*
do
head -n 6 ${each} | tail -n 5 | cut -f 1,2,3,4,5,6 >> Overview.xls
done 

# creation of fasta files 
> fasta_names1_temp.txt
> fasta_names2_temp.txt
> fasta_name3_temp.txt

for each in *_results.xls
do
> fasta_names1_temp.txt
> fasta_names2_temp.txt
> fasta_name3_temp.txt
> ${each%_results.xls}_blast.fasta
cut -f 2,7 ${each} | sed "s/	/,/g" | tail -n +2 > fasta_names1_temp.txt
while read p
do
echo ">" >> fasta_names2_temp.txt
done < fasta_names1_temp.txt

paste fasta_names2_temp.txt fasta_names1_temp.txt > fasta_name3_temp.txt
sed -i "s/	//g" fasta_name3_temp.txt
cut -f 8 ${each} | tail -n +2 | paste fasta_name3_temp.txt - | sed "s/	/\n/g" >> ${each%_results.xls}_blast.fasta
done

> good_seq_uniq.txt
for each in *_blast.fasta
do
echo ${each%_blast.fasta} >> good_seq_uniq.txt
done
while read p;do cat ../../done_fasta/${p}.fasta >> ${p}_blast.fasta; done < good_seq_uniq.txt
while read p;do cat ../../done_fasta/${p}.fasta >> all_query.fasta; done < good_seq_uniq.txt

# Align with MAFFT
mafft --auto all_query.fasta > all_query.fasta.algn

# Create ML tree with RAxML
${RAxML_soft} -s all_query.fasta.algn -n all_query_ML_tree -m GTRCAT
echo "All done Cpt. Jimmy"
