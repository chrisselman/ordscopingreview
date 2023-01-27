************************************************************************
*	Do-file:			scopingreview_analysis.do
*	Project:			Scoping Review - Statistical Analyses of Ordinal Outcomes in RCTs
*	Data used:			"scopingreview_clean.dta"
* 	Purpose:  			To conduct data analysis for scoping review
*	Date:				13 December 2022
************************************************************************

set more off
capture log close
version 

cd "/Users/chrisselman/University/PhD/Scoping Review/Data Management/Analysis"

// Open the dataset
use "scopingreview_clean.dta", clear 

// Create log file to keep copy of commands/results
log using scopreviewanalysis.log, replace text 


// Create listings to analyse 
preserve 
keep idno title medcondition medspecial 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("medcondition") replace 
restore 

preserve 
keep if ordscaletype == 1
keep idno title improvdet hierarchicalman mutexclusive clearlydefinedproperty otherinfo 
keep if improvdet == 0 | hierarchicalman == 0 | mutexclusive == 0 | clearlydefinedproperty == 0 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("ordscalepropsinglestate")  
restore 


preserve 
keep if ordscaletype == 2
keep idno title improvdet hierarchicalman mutexclusive clearlydefinedproperty symmetricscale otherinfo 
keep if improvdet == 0 | hierarchicalman == 0 | mutexclusive == 0 | clearlydefinedproperty == 0 | symmetricscale == 0
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("ordscaleproptranstate")  
restore 


preserve 
keep if samplesizecalc == 1
keep idno title samplesizecalc samplesizemethod otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("sampsizecalc")  
restore 

preserve 
keep if dichot != 0 
keep idno title dichot dichothow otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("dichot")  
restore 

preserve 
keep if other == 1 
keep idno title groupsummariesother otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("groupsummaryother")  
restore 


preserve 
keep if otherparam == 1 
keep idno title targetparameterother otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("othertargetparam")  
restore 

//Definition of target parameter - only for ordinal scales
preserve 
keep if dichot == 0 
keep idno title definetargetparameter otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("deftargetparameter")  
restore 


preserve 
keep if othsm == 1 
keep idno title statmodelother otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("otherstatmodel")  
restore 


//Different statistical model 
preserve 
keep if diffstatmodel == 1 
keep idno title diffstatmodeldetail otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("diffstatmodel")  
restore 


//Model assumptions - ordinal  
preserve 
keep if dichot == 0 
keep if modassumptionunk == 1 | modassumptionoth == 1 | modassumptiongraph == 1 | modassumptionpred == 1 | modassumptionstat == 1 
keep idno title cumlogitsm unknsm othsm nonesm cmhsm linregsm binregsm logitsm wilcoxsm statmodelother modassumptionunk modassumptionoth modassumptiongraph modassumptionpred modassumptionstat modassumptionother otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("modassumptionsord")  
restore 


//Model assumptions - dichot  
preserve 
keep if dichot != 0  
keep if modassumptionunk == 1 | modassumptionoth == 1 | modassumptiongraph == 1 | modassumptionpred == 1 | modassumptionstat == 1 
keep idno title cumlogitsm unknsm othsm nonesm cmhsm linregsm binregsm logitsm wilcoxsm statmodelother modassumptionunk modassumptionoth modassumptiongraph modassumptionpred modassumptionstat modassumptionother otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("modassumptionsdichot")  
restore 


// If they did not check model assumptions 
preserve 
keep if dichot == 0 
keep if modassumptionchecked == 0 | modassumptionchecked == 3
keep idno title modassumptionchecked cumlogitsm unknsm othsm nonesm cmhsm linregsm binregsm logitsm wilcoxsm statmodelother otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("modassumptionsuncheckedord")  
restore 

// If they did not check model assumptions 
preserve 
keep if dichot != 0 
keep if modassumptionchecked == 0 | modassumptionchecked == 3
keep idno title modassumptionchecked cumlogitsm unknsm othsm nonesm cmhsm linregsm binregsm logitsm wilcoxsm statmodelother otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("modassumptionsuncheckeddichot")  
restore 


//Bayesian methods 
preserve 
keep if dichot == 0 
keep if inferentialstat == 2 | inferentialstat == 3
keep idno title inferentialstat cumlogitsm unknsm othsm nonesm cmhsm linregsm binregsm logitsm wilcoxsm statmodelother otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("bayesianord")   
restore 


// Adaptive designs 
preserve 
keep if adaptivedes == 1 
keep idno title adaptivedes dichot otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("adaptivedes")   
restore 


//Repeated measures
preserve 
replace repeatedmeasuresunk = . if repeatedmeasuresna == 1
replace repeatedmeasuresoth = . if repeatedmeasuresna == 1
replace repeatedmeasuresgee = . if repeatedmeasuresna == 1
replace repeatedmeasuresbaseline = . if repeatedmeasuresna == 1
replace repeatedmeasuresmixed = . if repeatedmeasuresna == 1

keep if dichot == 0 & repeatedmeasuresna == 0 
keep idno title dichot repeatedmeasuresmixed repeatedmeasuresbaseline repeatedmeasuresgee repeatedmeasuresoth repeatedmeasuresunk otherinfo 
export excel using "listings_scopingreview.xlsx", firstrow(var) sheet("repeatord")   
restore 




//Save this as a listing for Kristin to check over - 12 Dec 2022
preserve 
keep idno title medcondition medspecial
export excel using "medicalspecialty_scopingreview_12dec2022_CS.xlsx", replace firstrow(var)
restore 



//Create tables 
// Summary of study characteristics 

baselinetable yearpub funding_nonprofit funding_industry funding_public journal adaptivedes clinicalsetting medspecialanalysis, title("Study characteristics") headingrow headingrowtab(N) pcformat(%5.0f) exportexcel(studycharacteristics, replace)


//Summary of study design   
replace samplesizecalc = . if dichot != 0 & idno != 1071
baselinetable ordscaletype primsecout dichot outcomemeasure numcategories(cts tab("Median = p50 (IQR p25-p75; Range min-max)")) samplesizecalc samplesizemethod sampsize(cts tab("Median = p50 (IQR p25-p75)")), title("Summary of study design") headingrow headingrowtab(N) medianformat(%5.0f) minmaxformat(%5.0f)pcformat(%5.0f) exportexcel(studydesign, replace)


//Statistical methods 
//Only want to summarise those that had repeated measures
replace repeatedmeasuresunk = . if repeatedmeasuresna == 1
replace repeatedmeasuresoth = . if repeatedmeasuresna == 1
replace repeatedmeasuresgee = . if repeatedmeasuresna == 1
replace repeatedmeasuresbaseline = . if repeatedmeasuresna == 1
replace repeatedmeasuresmixed = . if repeatedmeasuresna == 1

baselinetable freq median iqr mean sd other summariesnotused inferentialstat oddsratio meandiff mediandiff riskdiff riskratio nonpara otherparam descanaparam unknownparam cumlogitsm logitsm binregsm linregsm wilcoxsm cmhsm fishersm othsm unknsm nonesm diffstatmodel modassumptionchecked modassumptionstat modassumptiongraph modassumptionpred modassumptionoth modassumptionunk repeatedmeasuresmixed repeatedmeasuresbaseline repeatedmeasuresgee repeatedmeasuresoth repeatedmeasuresunk statsoftwarer statsoftwaresas statsoftwarespss statsoftwarestata statsoftwareoth statsoftwareunknown, title("Statistical methods") pcformat(%5.0f) headingrow headingrowtab(N) exportexcel(statmethods, replace)


//Stratify by cum logit model 
baselinetable yearpub funding_nonprofit funding_industry funding_public journal adaptivedes clinicalsetting medspecialanalysis, title("Study characteristics") headingrow headingrowtab(N) pcformat(%5.0f) exportexcel(studycharacteristics_stratcumlog, replace) by(cumlogitsm, totalcolumn)

baselinetable ordscaletype primsecout dichot outcomemeasure numcategories(cts tab("Median = p50 (IQR p25-p75; Range min-max)")) samplesizecalc samplesizemethod sampsize(cts tab("Median = p50 (IQR p25-p75)")), title("Summary of study design") headingrow headingrowtab(N) medianformat(%5.0f) minmaxformat(%5.0f)pcformat(%5.0f) exportexcel(studydesign_stratcumlog, replace) by(cumlogitsm, totalcolumn)

baselinetable freq median iqr mean sd other summariesnotused inferentialstat oddsratio meandiff mediandiff riskdiff riskratio nonpara otherparam descanaparam unknownparam cumlogitsm logitsm binregsm linregsm wilcoxsm cmhsm fishersm othsm unknsm nonesm diffstatmodel modassumptionchecked modassumptionstat modassumptiongraph modassumptionpred modassumptionoth modassumptionunk repeatedmeasuresmixed repeatedmeasuresbaseline repeatedmeasuresgee repeatedmeasuresoth repeatedmeasuresunk statsoftwarer statsoftwaresas statsoftwarespss statsoftwarestata statsoftwareoth statsoftwareunknown, title("Statistical methods") pcformat(%5.0f) headingrow headingrowtab(N) exportexcel(statmethods_cumlog, replace) by(cumlogitsm, totalcolumn)


//Stratify by primary outcome 
baselinetable yearpub funding_nonprofit funding_industry funding_public journal adaptivedes clinicalsetting medspecialanalysis, title("Study characteristics") headingrow headingrowtab(N) pcformat(%5.0f) exportexcel(studycharacteristics_stratprimout, replace) by(primsecout, totalcolumn)

baselinetable ordscaletype primsecout dichot outcomemeasure numcategories(cts tab("Median = p50 (IQR p25-p75; Range min-max)")) samplesizecalc samplesizemethod sampsize(cts tab("Median = p50 (IQR p25-p75)")), title("Summary of study design") headingrow headingrowtab(N) medianformat(%5.0f) minmaxformat(%5.0f)pcformat(%5.0f) exportexcel(studydesign_stratprimout, replace) by(primsecout, totalcolumn)

baselinetable freq median iqr mean sd other summariesnotused inferentialstat oddsratio meandiff mediandiff riskdiff riskratio nonpara otherparam descanaparam unknownparam cumlogitsm logitsm binregsm linregsm wilcoxsm cmhsm fishersm othsm unknsm nonesm diffstatmodel modassumptionchecked modassumptionstat modassumptiongraph modassumptionpred modassumptionoth modassumptionunk repeatedmeasuresmixed repeatedmeasuresbaseline repeatedmeasuresgee repeatedmeasuresoth repeatedmeasuresunk statsoftwarer statsoftwaresas statsoftwarespss statsoftwarestata statsoftwareoth statsoftwareunknown, title("Statistical methods") pcformat(%5.0f) headingrow headingrowtab(N) exportexcel(statmethods_primout, replace) by(primsecout, totalcolumn)








