// enable dsl2
nextflow.enable.dsl=2


// import modules
include {fastP} from '../modules/fastP.nf'
include {hydra} from '../modules/hydra.nf'
include {sierra} from '../modules/sierra.nf'
include {reportDrugResistance} from '../modules/reportDrugResistance.nf'
include {fastPStats} from '../modules/fastPStats.nf'
include {fastPStatsCombine} from '../modules/fastPStatsCombine.nf'

workflow illumina {


	Channel
		.fromFilePairs("$PWD/${params.reads}/*_{R1,R2,1,2}{,_001}.{fastq,fq}{,.gz}", flat:true)
		.ifEmpty{error "Cannot find any reads matching: ${params.reads}"}
		.set{ch_sample}
		

	main:
		//ch_sample.view()
		fastP(ch_sample)
		fastPStats(fastP.out.json)
		fastPStatsCombine(fastPStats.out.stats.collect())
		hydra(fastP.out.trimmed)
		//sierra(hydra.out.consensus)
		//reportDrugResistance(sierra.out.json, params.reportPDF)

}



