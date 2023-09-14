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
			println("\nYow! It's your boy, Ufuoma, here.")
			println("\nPlease select a workflow with either --illumina or --ont\n")
			System.exit(1)
		}
		
}



