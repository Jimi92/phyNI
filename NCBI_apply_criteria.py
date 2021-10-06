import pandas as pd
import glob


out_files = glob.glob("/home/taliadoros/Desktop/Vanesa/ncbi_blast/results/*.txt")

## process out files from out_DIR
for file in out_files:
	df = pd.read_csv(file, delimiter='\t', names=["Species", "Bit_score", "Coverage", "E_value","Identity","subject_acc", "subject_seq"])
	sorted_df = df.sort_values(by=['E_value','Bit_score', 'Identity', 'Coverage'], ascending=[True, False, False, False])
	sorted_df = sorted_df.drop_duplicates('subject_acc')
	save_name = "/".join(file.split("/")[:-1]) + "/output/" + file.split('/')[-1].strip('.txt') + ".xls"
	print(save_name)
	#save_name=file[:37] + "output/" + file.split('/')[-1].strip('.txt') + "xls"
	sorted_df.to_csv(save_name, sep="\t",index=False)

	print(sorted_df)


