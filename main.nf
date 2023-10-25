// enable dsl2
nextflow.enable.dsl=2


// import modules
include {illumina} from './workflows/illumina.nf'

workflow {

	main:
		if (params.illumina) {
			illumina()
		}
		else if (params.ont) {
			ont()
		}
		else {
			println("\n#############################################################################\n")
			println("\n\tYow! This is your boy, Ufuoma, here.")
			println("\nPlease select a workflow with either --illumina or --ont")
			println("then indicate the location of the raw reads (i.e., after --reads)")
			println("and where to place the results (i.e., after --out_dir)\n")
			println("\nFor example,\n")
			println("nextflow run Karumata --illumina --reads raw_fastq --out_dir results_illumina \n")
			println("\n#############################################################################")
			System.exit(1)
		}
		
}



