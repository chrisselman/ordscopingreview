************************************************************************
*	Do-file:			scopingreview_cleaning.do
*	Project:			Scoping Review - Statistical Analyses of Ordinal Outcomes in RCTs
*	Data used:			"dataextraction_firstclean.xlsx"
* 	Purpose:  			To conduct data cleaning before analysis 
*	Date:				29 November 2022
************************************************************************

set more off
capture log close
version 

cd "/Users/chrisselman/University/PhD/Scoping Review/Data Management/Data Cleaning"

// Open the dataset
import excel using "rawdata.xlsx", clear firstrow 

// Create log file to keep copy of commands/results
log using scopreviewcleaning.log, replace text 


// Remove double data 
keep if ReviewerName == "Chris Selman" | ReviewerName == "Consensus"

//Remove duplicates among those with consensus
drop if Covidence == 1145 & ReviewerName == "Chris Selman"
drop if Covidence == 1131 & ReviewerName == "Chris Selman"
drop if Covidence == 1094 & ReviewerName == "Chris Selman"
drop if Covidence == 1086 & ReviewerName == "Chris Selman"
drop if Covidence == 1077 & ReviewerName == "Chris Selman"
drop if Covidence == 1046 & ReviewerName == "Chris Selman"
drop if Covidence == 1041 & ReviewerName == "Chris Selman"
drop if Covidence == 1040 & ReviewerName == "Chris Selman"
drop if Covidence == 1032 & ReviewerName == "Chris Selman"
drop if Covidence == 1029 & ReviewerName == "Chris Selman"
drop if Covidence == 1019 & ReviewerName == "Chris Selman"
drop if Covidence == 1016 & ReviewerName == "Chris Selman"
drop if Covidence == 992 & ReviewerName == "Chris Selman"
drop if Covidence == 956 & ReviewerName == "Chris Selman"
drop if Covidence == 952 & ReviewerName == "Chris Selman"
drop if Covidence == 941 & ReviewerName == "Chris Selman"
drop if Covidence == 925 & ReviewerName == "Chris Selman"
drop if Covidence == 881 & ReviewerName == "Chris Selman"


//Drop unnecessary variables
drop Q1Whatisthetitleoftheman ReviewerName StudyID


//Rename variables 
rename Covidence idno
rename Title title
rename Q2Whatisthenameofthefirs authorname
rename Q3Whatwastheyearofpublica yearpub
rename Q4aWhatwasthefundingsou fundingsource
rename Q4bIfotherspecifytheot fundingother 
rename Q5Whatjournalwasthearticle journal 
rename Q6Wasanadaptivedesignused adaptivedes
rename Q1Wasthestudyconductedina medsetting
rename Q2Ifthestudywasconductedi medcondition
rename Q1Whattypeofordinalscalew ordscaletype
rename Q2Wastheordinaloutcomeapr primsecout
rename Q3Howmanycategoriesdidthe numcategories 
rename Q4Whatpropertiesofanordina ordinalproperties
rename Q5aWhatdidtheordinalout outcomemeasure
rename Q5bIfotherdescribewhat outcomemeasureother 
rename Q6aWasthesamplesizedete samplesizecalc
rename Q6bIfyeswhatmethodsdid samplesizemethod 
rename Q7Whatwasthenumberofstudy sampsize 
rename Q8aDidtheauthorsusedich dichot
rename Q8bIfyeshowwastheordi dichothow 
rename Q1aHowwasthedistribution groupsummaries
rename Q1bIfotherdescribehowt groupsummariesother 
rename Q2Ifinferentialstatisticswe inferentialstat
rename Q3aWhatwasthereportedta targetparameter
rename Q3bIfotherspecifythere targetparameterother 
rename Q4Howdidtheauthorsdefinet definetargetparameter
rename Q5aWhichstatisticalmodel statmodel 
rename Q5bIfotherspecifythest statmodelother
rename Q6aDidtheauthorsreportw diffstatmodel 
rename Q6bIfyesprovidedetaila diffstatmodeldetail 
rename Q7aWasthevalidityofthe modassumptionchecked
rename Q7bIfyeshowdidtheauth modassumptionhow
rename Q7cIfotherpleasedescrib modassumptionother
rename Q8aIftheordinaloutcomew repeatedmeasures
rename Q8bIfotherprovidedetail repeatedmeasuresother
rename Q1aWhatstatisticalsoftwar statsoftware
rename Q1bIfotherspecifywhats statsoftwareother
rename Q1Detailanyotherinformation otherinfo 


// Check for missing values 
//Note: any missing values will be updated in the Covidence database, not in Stata 
list idno title if title == ""
list idno title if authorname == ""
list idno title if yearpub == .
list idno title if journal== ""
list idno title if adaptivedes == ""
list idno title if medsetting == ""
list idno title if medcondition == "" & medsetting == "Medical setting"
list idno title if ordscaletype == ""
list idno title if primsecout == ""
list idno title if numcategories == .
list idno title if ordinalproperties == ""
list idno title if outcomemeasure == ""
list idno title if outcomemeasureother == "" & outcomemeasure == "Other" 
list idno title if samplesizecalc == ""
list idno title if samplesizemethod == "" & samplesizecalc == "Yes"
list idno title if sampsize == ""
list idno title if dichot == ""
list idno title if dichothow == "" & (dichot == "Yes - dichotomisation that involved a composite of the original ordinal scale" | dichot == "Yes - dichotomisation but no composite used")
list idno title if groupsummaries == ""
list idno title if groupsummariesother == "" & (groupsummaries == "Other" | _n == 25 | _n == 29 | _n == 34 | _n == 36 | _n == 70 | _n == 89 | _n == 141)
list idno title if inferentialstat == ""
list idno title if targetparameter == ""
list idno title if targetparameterother == "" & (targetparameter == "Other" | _n == 9 | _n == 29 | _n == 71 | _n == 113 | _n == 120 | _n == 131)
list idno title if definetargetparameter == ""
list idno title if statmodel == ""
list idno title if statmodelother == "" & (statmodel == "Other" | _n == 6 | _n == 11 | _n == 20 | _n == 38 | _n == 49 | _n == 50 | _n == 62 | _n == 63 | _n == 83 | _n == 107 | _n == 108 | _n == 110 | _n == 125 | _n == 133 | _n == 135 | _n ==  143)
list idno title if diffstatmodel == ""
list idno title if diffstatmodeldetail == "" & diffstatmodel == "Yes"
list idno title if modassumptionchecked == ""
list idno title if modassumptionhow == "" & modassumptionchecked == "Yes"
list idno title if modassumptionother == "" & modassumptionhow == "Other"
list idno title if repeatedmeasures == ""
list idno title if repeatedmeasuresother == "" & repeatedmeasures == "Other"
list idno title if statsoftware == ""
list idno title if statsoftwareother == "" & (statsoftware == "Other" | _n == 8 | _n == 22 | _n == 34 | _n == 37 | _n == 46 | _n == 98 | _n == 122)



// Generate new variables and create label values where relevant 
//Funding 
gen funding_public = 1 if fundingsource == "Public "
replace funding_public = 1 if fundingsource == "Industry; Public "
replace funding_public = 1 if fundingsource == "Industry; Non-profit ; Public "
replace funding_public = 1 if fundingsource == "Non-profit ; Public "
replace funding_public = 0 if funding_public == .
lab def pubfund 0 "No public funding" 1 "Public funding"
lab val funding_public pubfund 

gen funding_industry = 1 if fundingsource == "Industry"
replace funding_industry = 1 if fundingsource == "Industry; Public "
replace funding_industry = 1 if fundingsource == "Industry; Non-profit ; Public "
replace funding_industry = 1 if fundingsource == "Industry; Non-profit "
replace funding_industry = 0 if funding_industry == .
lab def indfund 0 "No industry funding" 1 "Industry funding" 
lab val funding_industry indfund

gen funding_nonprofit = 1 if fundingsource == "Non-profit "
replace funding_nonprofit = 1 if fundingsource == "Non-profit ; Public "
replace funding_nonprofit = 1 if fundingsource == "Industry; Non-profit ; Public "
replace funding_nonprofit = 1 if fundingsource == "Industry; Non-profit "
replace funding_nonprofit = 0 if funding_nonprofit == .
lab def nonprofitfund 0 "No non-profit funding" 1 "Non-profit funding" 
lab val funding_nonprofit nonprofitfund

drop fundingsource 
order funding_public, after(yearpub)
order funding_industry, after(funding_public)
order funding_nonprofit, after(funding_industry)
drop fundingother //No other listed 

//Label variables 
lab var funding_public "Funding Source - Public"
lab var funding_industry "Funding Source - Industry"
lab var funding_nonprofit "Funding Source - Non-Profit"


//Journal 
gen journal1 = 1 if journal == "The Lancet"
replace journal1 = 2 if journal == "NEJM "
replace journal1 = 3 if journal == "JAMA"
replace journal1 = 4 if journal == "BMJ "
lab def journal 1 "The Lancet" 2 "NEJM" 3 "JAMA" 4 "BMJ"
lab val journal1 journal 
drop journal 
rename journal1 journal 
lab var journal "Journal"
order journal, after(funding_nonprofit)


//Adaptive design 
gen adaptive = 1 if adaptivedes == "Yes"
replace adaptive = 0 if adaptivedes == "No"
lab def yesno 0 "No" 1 "Yes"
lab val adaptive yesno 
drop adaptivedes 
order adaptive, after(journal)
rename adaptive adaptivedes 
lab var adaptivedes "Adaptive design used?"


//Medical setting 
gen medicalsetting = 1 if medsetting == "Medical setting"
replace medicalsetting = 0 if medsetting == "Non-medical setting"
lab val medicalsetting yesno 
drop medsetting 
order medicalsetting, after(adaptivedes)
rename medicalsetting medsetting 
lab var medsetting "Medical setting?"


//Ordinal scale type 
gen ordscaletype1 = 1 if ordscaletype == "Single-state ordinal scale"
replace ordscaletype1 = 2 if ordscaletype == "Transition-state ordinal scale"
lab def ordscale 1 "Single-state scale" 2 "Transition state scale"
lab val ordscaletype1 ordscale 
drop ordscaletype
order ordscaletype1, after(medcondition)
rename ordscaletype1 ordscaletype
lab var ordscaletype "Type of ordinal scale used"


//Type of outcome 
gen primsecout1 = 1 if primsecout == "Primary outcome"
replace primsecout1 = 2 if primsecout == "Secondary outcome"
lab def primsec 1 "Primary outcome" 2 "Secondary outcome"
lab val primsecout1 primsec 
drop primsecout 
order primsecout1, after(ordscaletype)
rename primsecout1 primsecout
lab var primsecout "Primary or secondary outcome used"


//Properties 
//Clearly defined 
gen clearlydefinedproperty = 0 if inlist(idno,1001)
replace clearlydefinedproperty = 1 if clearlydefinedproperty == .
lab val clearlydefinedproperty yesno 
lab var  clearlydefinedproperty "Clearly defined categories?"
order clearlydefinedproperty, after(ordinalproperties)

//Mutually exclusive 
gen mutexclusive = 1 
lab val mutexclusive yesno 
lab var mutexclusive "Mutually exclusive categories?"
order mutexclusive, after(ordinalproperties)



//Ordered in a hierarchical manner 
gen hierarchicalman = 1
lab val hierarchicalman yesno 
lab var hierarchicalman "Categories ordered in a hierarchical manner?"
order hierarchicalman, after(ordinalproperties)


//Detect improvement/deterioration 
gen improvdet = 0 if inlist(idno,1151)
replace improvdet = 1 if improvdet == . 
lab val improvdet yesno 
lab var improvdet "Scale can detect improvement/deterioration"
order improvdet, after(ordinalproperties)


//Symmetric 
gen symmetricscale = 1 if inlist(idno,1122,1045,1021,989,910,882,865,1133,1063,948,927,915,948,888,886,890)
replace symmetricscale = 0 if symmetricscale == . & ordscaletype == 2
lab val symmetricscale yesno 
lab var symmetricscale "Symmetric scale used (if transition-state scale)"
order symmetricscale, after(clearlydefinedproperty)

drop ordinalproperties

//Outcome measure 
gen outcomemeasure1 = 1 if outcomemeasure == "Clinical outcome (e.g. treatment success/failure, severity scores, symptoms)"
replace outcomemeasure1 = 2 if outcomemeasure == "Life impact (e.g. quality of life, compliance, mental health, satisfaction)"
replace outcomemeasure1 = 3 if outcomemeasure == "Physiological outcome (e.g. viral detection/load, biomarkers)"
replace outcomemeasure1 = 4 if outcomemeasure == "Adverse events "
replace outcomemeasure1 = 5 if outcomemeasure == "Other"
lab def measure 1 "Clinical outcome" 2 "Life impact" 3 "Physiological outcome" 4 "Adverse event" 5 "Other"
lab val outcomemeasure1 measure 
order outcomemeasure1, after(outcomemeasure)
drop outcomemeasure 
rename outcomemeasure1 outcomemeasure 
lab var outcomemeasure "Outcome Measure"


//Sample size calc 
gen samplesize = 1 if samplesizecalc == "Yes"
replace samplesize = 0 if samplesizecalc == "No"
lab val samplesize yesno 
lab var samplesize "Sample size calculation based on ordinal outcome"
order samplesize, after(samplesizecalc)
drop samplesizecalc
rename samplesize samplesizecalc 


//Sample size method 
gen samplesizemethod1 = 1 if samplesizemethod == "Analytical"
replace samplesizemethod1 = 2 if samplesizemethod == "Simulation "
lab def samplemethod 1 "Analytical" 2 "Simulation"
lab val samplesizemethod1 samplemethod 
lab var samplesizemethod1 "Sample size calculation method"
order samplesizemethod1, after(samplesizemethod)
drop samplesizemethod
rename samplesizemethod1 samplesizemethod


//Sample size 
assert sampsize != ""
replace sampsize = "" if sampsize == "N/A"
destring sampsize, replace 
lab var sampsize "Sample size in main analysis"


//Dichotomisation or not 
gen dichot1 = 0 if dichot == "No "
replace dichot1 = 1 if dichot == "Yes - dichotomisation but no composite used"
replace dichot1 = 2 if dichot == "Yes - dichotomisation that involved a composite of the original ordinal scale "
lab def dichot 0 "No" 1 "Yes - dichotomisation" 2 "Yes - dichotomisation that involved a composite of the original ordinal scale"
lab val dichot1 dichot
order dichot1, after(dichot)
drop dichot 
rename dichot1 dichot
lab var dichot "Dichotomisation used"


//Group summaries
//Frequencies 
gen freq = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific)"
replace freq = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Medians (across all categories); Interquartile ranges (across all categories)"
replace freq = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Means (across all categories); Standard deviations (across all categories)"
replace freq = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Medians (across all categories)"
replace freq = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Other "
replace freq = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Means (across all categories)"
replace freq = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Means (across all categories); Medians (across all categories); Interquartile ranges (across all categories)"
replace freq = 0 if freq == .

lab val freq yesno 
order freq, after(groupsummaries)
lab var freq "Frequencies and/or percentages used (category specific) used"


//Median
gen median = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Medians (across all categories); Interquartile ranges (across all categories)"
replace median = 1 if groupsummaries == "Medians (across all categories); Interquartile ranges (across all categories)"
replace median = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Medians (across all categories)"
replace median = 1 if groupsummaries == "Medians (across all categories); Other "
replace median = 1 if groupsummaries == "Means (across all categories); Medians (across all categories); Standard deviations (across all categories); Interquartile ranges (across all categories)"
replace median = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Means (across all categories); Medians (across all categories); Interquartile ranges (across all categories)"
replace median = 0 if median == .
lab val median yesno 
order median, after(freq)
lab var median "Median (across all categories) used"


//IQR 
gen iqr = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Medians (across all categories); Interquartile ranges (across all categories)"
replace iqr = 1 if groupsummaries == "Medians (across all categories); Interquartile ranges (across all categories)"
replace iqr = 1 if groupsummaries == "Means (across all categories); Medians (across all categories); Standard deviations (across all categories); Interquartile ranges (across all categories)"
replace iqr = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Means (across all categories); Medians (across all categories); Interquartile ranges (across all categories)"
replace iqr = 0 if iqr == .
lab val iqr yesno 
order iqr, after(median)
lab var iqr "IQR (across all categories) used"


//Mean 
gen mean = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Means (across all categories); Standard deviations (across all categories)"
replace mean = 1 if groupsummaries == "Means (across all categories); Other "
replace mean = 1 if groupsummaries == "Means (across all categories); Standard deviations (across all categories)"
replace mean = 1 if groupsummaries == "Means (across all categories)"
replace mean = 1 if groupsummaries == "Means (across all categories); Medians (across all categories); Standard deviations (across all categories); Interquartile ranges (across all categories)"
replace mean = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Means (across all categories); Medians (across all categories); Interquartile ranges (across all categories)"
replace mean = 0 if mean == .

lab val mean yesno 
order mean, after(iqr)
lab var mean "Means (across all categories) used"


//SD 
gen sd = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Means (across all categories); Standard deviations (across all categories)"
replace sd = 1 if groupsummaries == "Means (across all categories); Standard deviations (across all categories)"
replace sd = 1 if groupsummaries == "Means (across all categories); Medians (across all categories); Standard deviations (across all categories); Interquartile ranges (across all categories)"
replace sd = 0 if sd == .

lab val sd yesno 
order sd, after(mean)
lab var sd "Standard deviations (across all categories) used"


//Other 
gen other = 1 if groupsummaries == "Means (across all categories); Other "
replace other = 1 if groupsummaries == "Frequencies and/or proportions/percentages (category specific); Other "
replace other = 1 if groupsummaries == "Medians (across all categories); Other "
replace other = 1 if groupsummaries == "Other "
replace other = 0 if other == .

lab val other yesno 
order other, after(sd)
lab var other "Other methods to summarise by group used"

//Summaries not used 
gen summariesnotused = 1 if groupsummaries == "Summaries by group not used "
replace summariesnotused = 0 if summariesnotused == .
lab val summariesnotused yesno 
order summariesnotused, after(other)
lab var summariesnotused "Summarised by group not used"

drop groupsummaries 


// Inferential stats 
gen inferentialstat1 = 1 if inferentialstat == "Frequentist inference"
replace inferentialstat1 = 2 if inferentialstat == "Bayesian inference "
replace inferentialstat1 = 4 if inferentialstat == "Not applicable (descriptive analysis only)"
replace inferentialstat1 = 3 if idno == 908 | idno == 1129
lab def infer 1 "Frequentist inference" 2 "Bayesian inference" 3 "Frequentist and bayesian inference" 4 "Descriptive analysis only"
lab val inferentialstat1 infer 

order inferentialstat1, after(inferentialstat)
drop inferentialstat
rename inferentialstat1 inferentialstat
lab var inferentialstat "Type of inferential statistics used"


//Target parameter 
//Odds ratio 
gen oddsratio = 1 if targetparameter == "Odds ratio"
replace oddsratio = 1 if targetparameter == "Odds ratio; Risk difference "
replace oddsratio = 1 if targetparameter == "Odds ratio; Non-parametric procedure used "
replace oddsratio = 1 if targetparameter == "Odds ratio; Risk difference ; Non-parametric procedure used "
replace oddsratio = 1 if targetparameter == "Odds ratio; Difference in medians "
replace oddsratio = 1 if targetparameter == "Odds ratio; Risk difference ; Risk ratio "
replace oddsratio = 1 if targetparameter == "Odds ratio; Difference in means"
replace oddsratio = 1 if targetparameter == "Odds ratio; Other "
replace oddsratio = 0 if oddsratio == .

lab val oddsratio yesno 
order oddsratio, after(targetparameter)
lab var oddsratio "Target parameter - odds ratio"


//Non-parametric 
gen nonpara = 1 if inlist(idno, 1151, 1135, 1114,1080,1052,1041,1032,992,986,984,937,920,909,897,893,882,873,868,857)
replace nonpara = 0 if nonpara == . 

lab val nonpara yesno 
order nonpara, after(oddsratio)
lab var nonpara "Target parameter - non-parametric method used"


//Risk difference 
gen riskdiff = 1 if targetparameter == "Risk difference "
replace riskdiff = 1 if targetparameter == "Odds ratio; Risk difference "
replace riskdiff = 1 if targetparameter == "Risk difference ; Risk ratio ; Other "
replace riskdiff = 1 if targetparameter == "Risk difference ; Risk ratio "
replace riskdiff = 1 if targetparameter == "Odds ratio; Risk difference ; Non-parametric procedure used "
replace riskdiff = 1 if targetparameter == "Risk difference ; Non-parametric procedure used "
replace riskdiff = 1 if targetparameter == "Risk difference ; Risk ratio ; Other "
replace riskdiff = 1 if targetparameter == "Odds ratio; Risk difference ; Risk ratio "
replace riskdiff = 1 if targetparameter == "Risk difference ; Other "
replace riskdiff = 1 if targetparameter == "Odds ratio; Risk difference ; Risk ratio "
replace riskdiff = 1 if targetparameter == "Odds ratio; Risk difference ; Risk ratio "
replace riskdiff = 0 if riskdiff == .
lab val riskdiff yesno 
order riskdiff, after(nonpara)
lab var riskdiff "Target parameter - risk difference"


//Risk ratio 
gen riskratio = 1 if targetparameter == "Risk ratio "
replace riskratio = 1 if targetparameter == "Risk difference ; Risk ratio ; Other "
replace riskratio = 1 if targetparameter == "Risk difference ; Risk ratio "
replace riskratio = 1 if targetparameter == "Risk difference ; Risk ratio ; Other "
replace riskratio = 1 if targetparameter == "Odds ratio; Risk difference ; Risk ratio "
replace riskratio = 1 if targetparameter == "Odds ratio; Risk difference ; Risk ratio "
replace riskratio = 1 if targetparameter == "Risk ratio ; Non-parametric procedure used "
replace riskratio = 0 if riskratio == .
lab val riskratio yesno 
order riskratio, after(nonpara)
lab var riskratio "Target parameter - risk ratio"


//Medians 
gen mediandiff = 1 if targetparameter == "Difference in medians "
replace mediandiff = 1 if targetparameter == "Odds ratio; Difference in medians "
replace mediandiff = 1 if targetparameter == "Difference in medians ; Non-parametric procedure used "
replace mediandiff = 0 if mediandiff == .
lab val mediandiff yesno 
order mediandiff, after(nonpara)
lab var mediandiff "Target parameter - difference in medians"

//Means 
gen meandiff = 1 if targetparameter == "Difference in means"
replace meandiff = 1 if targetparameter == "Difference in means; Other "
replace meandiff = 1 if targetparameter == "Odds ratio; Difference in means"
replace meandiff = 1 if targetparameter == "Difference in means; Non-parametric procedure used "
replace meandiff = 0 if meandiff == .
lab val meandiff yesno 
order meandiff, after(nonpara)
lab var meandiff "Target parameter - difference in means"


//Other 
gen otherparam = 1 if targetparameter == "Other "
replace otherparam = 1 if targetparameter == "Difference in means; Other "
replace otherparam = 1 if targetparameter == "Risk difference ; Risk ratio ; Other "
replace otherparam = 1 if targetparameter == "Risk difference ; Other "
replace otherparam = 1 if targetparameter == "Odds ratio; Other "

replace otherparam = 0 if otherparam == .
lab val otherparam yesno 
order otherparam, after(nonpara)
lab var otherparam "Target parameter - other"


//Unknown 
gen unknownparam = 1 if targetparameter == "Unknown "
replace unknownparam = 0 if unknownparam == .
lab val unknownparam yesno 
order unknownparam, after(nonpara)
lab var unknownparam "Target parameter - unknown"


//Descriptive analysis 
gen descanaparam = 1 if targetparameter == "Not applicable (descriptive analysis only)"
replace descanaparam = 0 if descanaparam == .
lab val descanaparam yesno 
order descanaparam, after(nonpara)
lab var descanaparam "Target parameter - descriptive analysis only"

drop targetparameter

replace oddsratio = 1 if idno == 1021
replace riskdiff = 1 if idno == 1021
replace riskratio = 1 if idno == 1021
replace otherparam = 1 if idno == 1021 


//Statistical model used 
//Cum logit 
gen cumlogitsm = 1 if statmodel == "Cumulative logit model "
replace cumlogitsm = 1 if statmodel == "Cumulative logit model ; Other"
replace cumlogitsm = 1 if statmodel == "Cumulative logit model ; Linear regression model "
replace cumlogitsm = 1 if statmodel == "Cumulative logit model ; Two-sample Wilcoxon test; Cochran-Mantel-Haenszel test"
replace cumlogitsm = 1 if statmodel == "Cumulative logit model ; Unknown"
replace cumlogitsm = 1 if statmodel == "Cumulative logit model ; Two-sample Wilcoxon test"
replace cumlogitsm = 0 if cumlogitsm == . 
lab val cumlogitsm yesno 
order cumlogitsm, after(statmodel)
lab var cumlogitsm "Statistical model - cumulative logit model"


//Wilcoxon 
gen wilcoxsm = 1 if statmodel == "Two-sample Wilcoxon test"
replace wilcoxsm = 1 if statmodel == "Two-sample Wilcoxon test; Other"
replace wilcoxsm = 1 if statmodel == "Cumulative logit model ; Linear regression model "
replace wilcoxsm = 1 if statmodel == "Cumulative logit model ; Two-sample Wilcoxon test; Cochran-Mantel-Haenszel test"
replace wilcoxsm = 1 if statmodel == "Cumulative logit model ; Two-sample Wilcoxon test"
replace wilcoxsm = 1 if statmodel == "Two-sample Wilcoxon test; Unknown"

replace wilcoxsm = 0 if wilcoxsm == . 
lab val wilcoxsm yesno 
order wilcoxsm, after(cumlogitsm)
lab var wilcoxsm "Statistical model - two-sample Wilcoxon test"


//Logistic regression 
gen logitsm = 1 if statmodel == "Logistic regression model "
replace logitsm = 1 if statmodel == "Logistic regression model ; Other"
replace logitsm = 1 if statmodel == "Logistic regression model ; Linear regression model "
replace logitsm = 1 if statmodel == "Logistic regression model ; Binomial regression model "
replace logitsm = 0 if logitsm == . 
lab val logitsm yesno 
order logitsm, after(cumlogitsm)
lab var logitsm "Statistical model - logistic regression model"



//Binomial regression 
gen binregsm = 1 if statmodel == "Binomial regression model "
replace binregsm = 1 if statmodel == "Logistic regression model ; Binomial regression model "
replace binregsm = 0 if binregsm == . 
lab val binregsm yesno 
order binregsm, after(cumlogitsm)
lab var binregsm "Statistical model - binomial regression model"


//Linear reg 
gen linregsm = 1 if statmodel == "Linear regression model "
replace linregsm = 1 if statmodel == "Cumulative logit model ; Linear regression model "
replace linregsm = 1 if statmodel == "Logistic regression model ; Linear regression model "
replace linregsm = 1 if statmodel == "Cumulative logit model ; Linear regression model "
replace linregsm = 0 if linregsm == . 
lab val linregsm yesno 
order linregsm, after(cumlogitsm)
lab var linregsm "Statistical model - linear regression model"

//CMH 
gen cmhsm = 1 if statmodel == "Cochran-Mantel-Haenszel test"
replace cmhsm = 1 if statmodel == "Cochran-Mantel-Haenszel test; Other"
replace cmhsm = 1 if statmodel == "Cumulative logit model ; Two-sample Wilcoxon test; Cochran-Mantel-Haenszel test"
replace cmhsm = 1 if statmodel == "Cochran-Mantel-Haenszel test; Unknown"
replace cmhsm = 0 if cmhsm == . 
lab val cmhsm yesno 
order cmhsm, after(cumlogitsm)
lab var cmhsm "Statistical model - Cochran-Mantel-Haenszel method"


//None 
gen nonesm = 1 if statmodel == "None (descriptive analysis)"
replace nonesm = 0 if nonesm == . 
lab val nonesm yesno 
order nonesm, after(cumlogitsm)
lab var nonesm "Statistical model - none (descriptive analysis)"



//Other 
gen othsm = 1 if statmodel == "Other"
replace othsm = 1 if statmodel == "Cochran-Mantel-Haenszel test; Other"
replace othsm = 1 if statmodel == "Logistic regression model ; Other"
replace othsm = 1 if statmodel == "Cumulative logit model ; Other"
replace othsm = 1 if statmodel == "Two-sample Wilcoxon test; Other"
replace othsm = 1 if statmodel == "Other; Unknown"
replace othsm = 0 if othsm == . 
lab val othsm yesno 
order othsm, after(cumlogitsm)
lab var othsm "Statistical model - other"



//Unknown 
gen unknsm = 1 if statmodel == "Unknown"
replace unknsm = 1 if statmodel == "Other; Unknown"
replace unknsm = 1 if statmodel == "Cumulative logit model ; Unknown"
replace unknsm = 1 if statmodel == "Cochran-Mantel-Haenszel test; Unknown"
replace unknsm = 1 if statmodel == "Other; Unknown"
replace unknsm = 1 if statmodel == "Other; Unknown"

replace unknsm = 0 if unknsm == . 
lab val unknsm yesno 
order unknsm, after(cumlogitsm)
lab var unknsm "Statistical model - unknown"


//Fisher's exact test or Chi square 
gen fishersm = 1 if inlist(idno,1133,1114,1041,986,939,937,920,909,897,893,857,856)
replace fishersm = 0 if fishersm == . 
lab val fishersm yesno 
replace othsm = 0 if inlist(idno,1114,1041,986,939,937,909,893,857)
replace statmodelother = "" if inlist(idno,1114,1041,986,939,937,909,893,857)
order fishersm, after(cmhsm)
drop statmodel


//Different statistical model 
gen diffstatmodel1 = 0 if diffstatmodel == "No"
replace diffstatmodel1 = 1 if diffstatmodel == "Yes"
replace diffstatmodel1 = 2 if diffstatmodel == "Not applicable (e.g. descriptive analysis)"
replace diffstatmodel1 = 3 if diffstatmodel == "Unknown"

lab def diffmodel 0 "No" 1 "Yes" 2 "Not applicable" 3 "Unknown"
lab val diffstatmodel1 diffmodel 
order diffstatmodel1, after(diffstatmodel)
drop diffstatmodel
rename diffstatmodel1 diffstatmodel
lab var diffstatmodel "Different statistical model have to be used?"


//Model assumption checked 
gen modassumptionchecked1 = 0 if modassumptionchecked == "No"
replace modassumptionchecked1 = 1 if modassumptionchecked == "Yes"
replace modassumptionchecked1 = 2 if modassumptionchecked == "Not applicable "
replace modassumptionchecked1 = 3 if modassumptionchecked == "Unknown"

lab def modassumptionchecked1 0 "No" 1 "Yes" 2 "Not applicable" 3 "Unknown"
lab val modassumptionchecked1 modassumptionchecked1 
order modassumptionchecked1, after(modassumptionchecked)
drop modassumptionchecked
rename modassumptionchecked1 modassumptionchecked
lab var modassumptionchecked "Model assumptions checked?"


//Model assumption how 
//Stats 
gen modassumptionstat = 1 if modassumptionhow == "Statistical methods " 
replace modassumptionstat = 0 if modassumptionstat == . & modassumptionchecked == 1

lab val modassumptionstat yesno 
order modassumptionstat, after(modassumptionhow)
lab var modassumptionstat "Statistical methods used to check model assumption"


//Prediction 
gen modassumptionpred = 1 if modassumptionhow == "Statistical methods ; Prediction methods "
replace modassumptionpred = 0 if modassumptionpred == . & modassumptionchecked == 1

lab val modassumptionpred yesno 
order modassumptionpred, after(modassumptionhow)
lab var modassumptionpred "Prediction methods used to check model assumption"


//Graphical 
gen modassumptiongraph = 1 if modassumptionhow == "Graphical methods"
replace modassumptiongraph = 0 if modassumptiongraph == . & modassumptionchecked == 1

lab val modassumptiongraph yesno 
order modassumptiongraph, after(modassumptionhow)
lab var modassumptiongraph "Graphical methods used to check model assumption"


//Other 
gen modassumptionoth = 1 if modassumptionhow == "Other "
replace modassumptionoth = 0 if modassumptionoth == . & modassumptionchecked == 1

lab val modassumptionoth yesno 
order modassumptionoth, after(modassumptionhow)
lab var modassumptionoth "Other methods used to check model assumption"

//Unknown
gen modassumptionunk = 1 if modassumptionhow == "Unknown "
replace modassumptionunk = 0 if modassumptionunk == . & modassumptionchecked == 1

lab val modassumptionunk yesno 
order modassumptionunk, after(modassumptionhow)
lab var modassumptionunk "Methods used to check model assumption not reported" 


drop modassumptionhow 


//Repeated measures 
//N/A 
gen repeatedmeasuresna = 1 if repeatedmeasures == "Not applicable (i.e. only one measure was used in the analysis of the outcome)"
replace repeatedmeasuresna = 0 if repeatedmeasuresna == . 

lab val repeatedmeasuresna yesno 
order repeatedmeasuresna, after(repeatedmeasures)
lab var repeatedmeasuresna "Not applicable"

//Mixed effects 
gen repeatedmeasuresmixed = 1 if repeatedmeasures == "Mixed effects models "
replace repeatedmeasuresmixed = 1 if repeatedmeasures == "Mixed effects models ; Adjusted for baseline measurement "
replace repeatedmeasuresmixed = 0 if repeatedmeasuresmixed == . 

lab val repeatedmeasuresmixed yesno 
order repeatedmeasuresmixed, after(repeatedmeasures)
lab var repeatedmeasuresmixed "Mixed effects models"


//Adjusted for baseline 
gen repeatedmeasuresbaseline= 1 if repeatedmeasures == "Adjusted for baseline measurement "
replace repeatedmeasuresbaseline = 1 if repeatedmeasures == "Mixed effects models ; Adjusted for baseline measurement "
replace repeatedmeasuresbaseline = 0 if repeatedmeasuresbaseline == . 

lab val repeatedmeasuresbaseline yesno 
order repeatedmeasuresbaseline, after(repeatedmeasures)
lab var repeatedmeasuresbaseline "Adjusted for baseline measurement"


//GEEs 
gen repeatedmeasuresgee= 1 if repeatedmeasures == "Generalised estimating equations"
replace repeatedmeasuresgee = 1 if repeatedmeasures == "Generalised estimating equations; Not applicable (i.e. only one measure was used in the analysis of the outcome)"
replace repeatedmeasuresgee = 0 if repeatedmeasuresgee == . 

lab val repeatedmeasuresgee yesno 
order repeatedmeasuresgee, after(repeatedmeasures)
lab var repeatedmeasuresgee "Generalised estimating equations"



//Other 
gen repeatedmeasuresoth= 1 if repeatedmeasures == "Other"
replace repeatedmeasuresoth = 0 if repeatedmeasuresoth == . 

lab val repeatedmeasuresoth yesno 
order repeatedmeasuresoth, after(repeatedmeasures)
lab var repeatedmeasuresoth "Other method used to account for repeated measures"


//Unknown
gen repeatedmeasuresunk = 1 if repeatedmeasures == "Unknown "
replace repeatedmeasuresunk = 0 if repeatedmeasuresunk == . 

lab val repeatedmeasuresunk yesno 
order repeatedmeasuresunk, after(repeatedmeasures)
lab var repeatedmeasuresunk "Unknown method used to account for repeated measures"

drop repeatedmeasures


//Software used 
//SAS
gen statsoftwaresas = 1 if statsoftware == "SAS"
replace statsoftwaresas = 1 if statsoftware == "R; SAS"
replace statsoftwaresas = 1 if statsoftware == "SAS; Other"
replace statsoftwaresas = 1 if statsoftware == "SAS; Stata"
replace statsoftwaresas = 0 if statsoftwaresas == .

lab val statsoftwaresas yesno 
order statsoftwaresas, after(statsoftware)
lab var statsoftwaresas "Software used - SAS"


//Stata 
gen statsoftwarestata = 1 if statsoftware == "Stata"
replace statsoftwarestata = 1 if statsoftware == "R; Stata"
replace statsoftwarestata = 1 if statsoftware == "SPSS; Stata; Other"
replace statsoftwarestata = 1 if statsoftware == "R; SPSS; Stata; Other"
replace statsoftwarestata = 1 if statsoftware == "SAS; Stata"
replace statsoftwarestata = 1 if statsoftware == "R; SPSS; Stata"
replace statsoftwarestata = 0 if statsoftwarestata == .

lab val statsoftwarestata yesno 
order statsoftwarestata, after(statsoftware)
lab var statsoftwarestata "Software used - Stata"


//SPSS 
gen statsoftwarespss = 1 if statsoftware == "SPSS"
replace statsoftwarespss = 1 if statsoftware == "SPSS; Stata; Other"
replace statsoftwarespss = 1 if statsoftware == "R; SPSS; Stata; Other"
replace statsoftwarespss = 1 if statsoftware == "R; SPSS"
replace statsoftwarespss = 1 if statsoftware == "R; SPSS; Stata"
replace statsoftwarespss = 0 if statsoftwarespss == .

lab val statsoftwarespss yesno 
order statsoftwarespss, after(statsoftware)
lab var statsoftwarespss "Software used - SPSS"


// R 
gen statsoftwarer = 1 if statsoftware == "R"
replace statsoftwarer = 1 if statsoftware == "R; SPSS; Stata; Other"
replace statsoftwarer = 1 if statsoftware == "R; SPSS"
replace statsoftwarer = 1 if statsoftware == "R; SAS"
replace statsoftwarer = 1 if statsoftware == "R; Other"
replace statsoftwarer = 1 if statsoftware == "R; Stata"
replace statsoftwarer = 1 if statsoftware == "R; SPSS; Stata"
replace statsoftwarer = 0 if statsoftwarer == .

lab val statsoftwarer yesno 
order statsoftwarer, after(statsoftware)
lab var statsoftwarer "Software used - R"


//Other
gen statsoftwareoth = 1 if statsoftware == "Other"
replace statsoftwareoth = 1 if statsoftware == "R; SPSS; Stata; Other"
replace statsoftwareoth = 1 if statsoftware == "SPSS; Stata; Other"
replace statsoftwareoth = 1 if statsoftware == "Other; Unknown"
replace statsoftwareoth = 1 if statsoftware == "R; Other"
replace statsoftwareoth = 1 if statsoftware == "SAS; Other"
replace statsoftwareoth = 0 if statsoftwareoth == .

lab val statsoftwareoth yesno 
order statsoftwareoth, after(statsoftware)
lab var statsoftwareoth "Software used - Other" 


//Unknown 
gen statsoftwareunknown = 1 if statsoftware == "Unknown"
replace statsoftwareunknown = 1 if statsoftware == "Other; Unknown"
replace statsoftwareunknown = 0 if statsoftwareunknown == .

lab val statsoftwareunknown yesno 
order statsoftwareunknown, after(statsoftware)
lab var statsoftwareunknown "Software used - Unknown" 

drop statsoftware


// Check for consistency and missingness 
//Public funding
assert funding_public != .
assert funding_industry != .
assert funding_nonprofit != .

//At least one option selected?
assert funding_nonprofit == 1 | funding_public == 1 | funding_industry == 1


//Journal 
assert journal != . 

// Adaptive design 
assert adaptivedes != . 

// Medical setting 
rename medsetting clinicalsetting
lab var clinicalsetting "Clinical setting?"

assert clinicalsetting != . 

assert medcondition != "" if clinicalsetting == 1
assert medcondition == "" if clinicalsetting == 0


//Type of ordinal scale used 
assert ordscaletype != .


//Prim/secondary
assert primsecout != . 


// Number of categories 
assert numcategories != . 


//Properties of ordinal outcome
// At least one selected?
assert improvdet == 1 | hierarchicalman == 1 | mutexclusive == 1 | clearlydefinedproperty == 1 | symmetricscale == 1 

//Non missing?
assert improvdet != . 
assert hierarchicalman != . 
assert mutexclusive != . 
assert clearlydefinedproperty != . 
assert symmetricscale != . if ordscaletype == 2


// Outcome measure 
//Non missing ?
assert outcomemeasure != . 

//Response if specified 'other'
assert outcomemeasureother == "" if outcomemeasure != 5
assert outcomemeasureother != "" if outcomemeasure == 5


//Sample size calculation 
assert samplesizecalc != . 


// Sample size method 
assert samplesizemethod != . if samplesizecalc == 1
assert samplesizemethod == . if samplesizecalc == 0


// Dichotomisation used?
assert dichot != . 


//If yes, is there an option?
assert dichothow != "" if dichot != 0
assert dichothow == "" if dichot == 0


//Summ stat by group - any missing?
assert freq != . 
assert median != . 
assert iqr != . 
assert mean != . 
assert sd != . 
assert other != . 
assert summariesnotused != . 


// Is there at least one response for summary statistics used by intervention group?
assert freq == 1 | median == 1 | iqr == 1 | mean == 1 | sd == 1 | other == 1 | summariesnotused == 1 


// Group summary - other ?
//Check there is a response if specified 'other'
assert groupsummariesother != "" if other == 1
assert groupsummariesother == "" if other == 0 


//Inferential stat - check non missing 
assert inferentialstat != . 


//Target parameter - check non missing 
assert oddsratio != . 
assert nonpara != . 
assert descanaparam != . 
assert unknownparam != . 
assert otherparam != . 
assert meandiff != . 
assert mediandiff != . 
assert riskratio != . 
assert riskdiff != . 

//Target parameter - check at least one response 
assert oddsratio == 1 | nonpara == 1 | descanaparam == 1 | unknownparam == 1 | otherparam == 1 | meandiff == 1 | mediandiff == 1 | riskratio == 1 | riskdiff == 1 


//Target parameter - other 
assert targetparameterother != "" if otherparam == 1 
assert targetparameterother == "" if otherparam == 0 


// Definition of target parameter 
assert definetargetparameter != ""


// Statistical model used 
//Check non missing 
assert cumlogitsm != . 
assert unknsm != . 
assert othsm != . 
assert nonesm != . 
assert cmhsm != . 
assert linregsm != . 
assert binregsm != . 
assert logitsm != . 
assert wilcoxsm != . 

//At least one response?
assert cumlogitsm == 1 | unknsm == 1 | othsm == 1 | nonesm == 1 | cmhsm == 1 | linregsm == 1 | binregsm == 1 | logitsm == 1 | wilcoxsm == 1 | fishersm == 1
lab var fishersm "Statistical model - Chi Square/Fisher exact test"


// Stat model - other 
assert statmodelother != "" if othsm == 1 
assert statmodelother == "" if othsm == 0 


//Different stat model have to be used?
assert diffstatmodel != . 

assert diffstatmodeldetail != "" if diffstatmodel == 1
assert diffstatmodeldetail == "" if diffstatmodel != 1


// Mod assumption reported to be checked?
assert modassumptionchecked != . 

// Type of model assumption used 
// Check non missing 
assert modassumptionunk != . if modassumptionchecked == 1
assert modassumptionoth != . if modassumptionchecked == 1
assert modassumptiongraph != . if modassumptionchecked == 1
assert modassumptionpred != . if modassumptionchecked == 1
assert modassumptionstat != . if modassumptionchecked == 1

replace modassumptionstat = 1 if idno == 997
replace modassumptionoth = 1 if idno == 997

//At least one response? 
assert (modassumptionunk == 1 | modassumptionoth == 1 | modassumptiongraph == 1 | modassumptionpred == 1 |modassumptionstat == 1 ) if modassumptionchecked == 1


// Other way of checking assumption 
assert modassumptionother != "" if modassumptionoth == 1
assert modassumptionother == "" if modassumptionoth == 0 


//Repeated measures - any missing?
assert repeatedmeasuresunk != . 
assert repeatedmeasuresoth != .
assert repeatedmeasuresgee != .
assert repeatedmeasuresbaseline != . 
assert repeatedmeasuresmixed != . 
assert repeatedmeasuresna != . 

//At least one response ?
assert repeatedmeasuresunk == 1 | repeatedmeasuresoth == 1 | repeatedmeasuresgee == 1 | repeatedmeasuresbaseline == 1 | repeatedmeasuresmixed == 1 | repeatedmeasuresna == 1 


// If other - consistent ?
assert repeatedmeasuresother != "" if repeatedmeasuresoth == 1
assert repeatedmeasuresother == "" if repeatedmeasuresoth == 0 


//Software - non missing ?
assert statsoftwareunknown != .
assert statsoftwareoth != . 
assert statsoftwarer != .
assert statsoftwarespss != . 
assert statsoftwarestata != . 
assert statsoftwaresas != . 


//At least one response for software? 
assert statsoftwareunknown == 1 | statsoftwareoth == 1 | statsoftwarer == 1 | statsoftwarespss == 1 | statsoftwarestata == 1 | statsoftwaresas == 1 


//If other software used - consistent? 
assert statsoftwareother != "" if statsoftwareoth == 1
assert statsoftwareother == "" if statsoftwareoth == 0 


//Label variables 
lab var authorname "Name of the first author"
lab var yearpub "Year of publication"
lab var medcondition "Medical condition under study"
lab var numcategories "Number of categories"
lab var outcomemeasureother "If other, describe what the ordinal outcome measured"
lab var dichothow "How was the ordinal scale used to define the dichotomy"
lab var groupsummariesother "Other methods used to summarise ordinal outcome in treatment groups"
lab var targetparameterother "Other reported target parameter"
lab var definetargetparameter "Definition of the target parameter"
lab var statmodelother "Other statistical model or method that was used"
lab var diffstatmodeldetail "Initial statistical model or method planned"
lab var modassumptionother "How authors checked model assumption (other method)"
lab var repeatedmeasuresother "Other methods used to account for repeated measures"
lab var statsoftwareother "Other software that was used"
lab var otherinfo "Other information deemed relevant to the review"



//Tidy free text
//Title 
replace title = "Endovascular thrombectomy versus standard bridging thrombolytic with endovascular thrombectomy within 4.5 h of stroke onset: an open-label, blinded-endpoint, randomised non-inferiority trial." if idno == 1153


//Author name 
replace authorname = "J Bosel et al." if idno == 1146
replace authorname = "N de la Ossa et al." if idno == 1145
replace authorname = "A Renu et al." if idno == 1135
replace authorname = "PO Guimaraes et al." if idno == 1108


//Dichotomised - how 
replace dichothow = "The outcome was dichotomised with terminal descriptors of 'much worse' to 'much better'." if idno == 1122
replace dichothow = "Defined as a vIGA-AD score of 0 (clear) or 1 (almost clear) with 2 or more grades of reduction from baseline." if idno == 1099
replace dichothow = "IGA response defined as a score of 0 (clear) or 1 (almost clear) on the IGA with an improvement of 2 or more points from baseline" if idno == 1086
replace dichothow = "Dichotomised into favourable (GOSE score more than 4 [moderate disability or good recovery]) and poor (GOSE score 4 or less [severe disability, vegetative state, death]). " if idno == 1040
replace dichothow = "The IGA response was defined as a score of 0 [clear] or 1 [almost clear] and a 2 or more grade improvement from baseline" if idno == 1032
replace dichothow = "Worsening of EDSS score from baseline (increase of 2 or more from baseline of 0, increase of 1 or more from baseline of 1-5, or increase of 0.5 or more from baseline of 5.5 or more). This was coded as a binary variable." if idno == 995
replace dichothow = "Physician's Global Assessment (PGA) subscore indicative of mild disease (1 or less) at Week 52" if idno == 992
replace dichothow = "Favourable neurologic status at discharge (mRS 3 or less)" if idno == 944



//Generate medical specialty variable 
br idno medcondition

gen medspecial = "Neurology" if medcondition == "Stroke"
replace medspecial = "Neurology" if medcondition == "Stroke "
replace medcondition = "Stroke" if medcondition == "Stroke "
replace medspecial = "Infectious diseases" if medcondition == "COVID-19"
replace medspecial = "Cardiology" if medcondition == "Cardiac arrest"
replace medspecial = "Cardiology" if medcondition == "Cardiac arrest "
replace medspecial = "Rheumatology" if inlist(idno,1142,1122,1117,1021,920,1041)
replace medspecial = "Pediatrics" if inlist(idno,870,1155)
replace medspecial = "Orthopedics" if inlist(idno,1151,1132)
replace medspecial = "Psychiatry" if inlist(idno,1133,1107,1093,1080,1022,998,989,948,915,890,888,863)
replace medspecial = "Dermatology" if inlist(idno,1099,1098,1086,1032,1029,860,1125,1075,1074,1031,1076,1015,857)
replace medspecial = "Neurology" if inlist(idno,1113,1063,910,891,1064,1005,995,987,969,956,953,909,902,882,868,865)
replace medcondition = "Parkinson's disease" if inlist(idno,1113)
replace medspecial = "Neurosurgery" if inlist(idno,1095,1040,951,1066)
replace medspecial = "Intensive care medicine" if inlist(idno,1017,979,941)
replace medspecial = "Gynecology" if idno == 997
replace medspecial = "Gastroenterology" if idno == 992
replace medspecial = "Oncology" if inlist(idno,986,975)
replace medspecial = "Otorhinolaryngology" if idno == 937
replace medspecial = "Pulmonology" if inlist(idno,873,934)
replace medspecial = "Neonatology" if inlist(idno,911)
replace medspecial = "Cardiology" if inlist(idno,893)

//Unsure about these
replace medspecial = "Immunology" if inlist(idno,881)
replace medspecial = "Psychiatry" if idno == 897
replace medspecial = "Primary care" if idno == 927
replace medspecial = "Cardiology" if inlist(idno,1114,1009,1065)
replace medspecial = "Rheumatology" if inlist(idno,1045,1007,886)

//Changing those which were double checked by Kristin 
replace medspecial = "Cardiac Surgery" if idno == 1114
replace medspecial = "Gynaecology" if idno == 1045
replace medspecial = "Intensive Care" if idno == 1009
replace medspecial = "Radiation Oncology" if idno == 1007
replace medspecial = "Palliative Care" if idno == 897
replace medspecial = "Pain Medicine" if idno == 886
replace medspecial = "Rheumatology" if idno == 881

//Missing ?
assert medspecial != "" if clinicalsetting == 1
assert medspecial == "" if clinicalsetting == 0

lab var medspecial "Medical Specialisation"

order medspecial, after(medcondition)


//Not reported - target parameter (going through these to make sure all are consistent)
replace definetargetparameter = "Not reported" if idno == 1155
replace definetargetparameter = "Not reported" if idno == 1132
replace definetargetparameter = "Not reported" if idno == 1122
replace definetargetparameter = "Not reported" if idno == 1094
replace definetargetparameter = "Not reported" if idno == 941



//Tidy up free text to avoid weird symbols 
replace definetargetparameter = "There were no significant differences regarding the full distribution of modified Rankin scale scores at 90 days (common odds ratio for a better outcome 0·75)" if idno == 1152
replace definetargetparameter = "Secondary outcomes included the shift in the modified Rankin Scale score at day 90, estimated by means of an odds ratio using a proportional odds logistic regression model combining the highest 2 scores of 5 and 6 into a single worst rank" if idno == 1135
replace definetargetparameter = "The shift across CPC scores in the direction of a better outcome in the anti-seizure-treatment group... A value greater than 1 indicates lower CPC scores in the antiseizure treatment group than in the control group" if idno == 1134
replace definetargetparameter = "The median adjusted proportional odds ratio for the effect of therapeutic-dose anticoagulation on organ support free days was 0.83" if idno == 1110
replace definetargetparameter = "The difference in the investigator global assessment response rate between the placebo and abrocitinib 100 mg group was 15·8% and 36·0% for the abrocitinib 200 mg group" if idno == 1032
replace definetargetparameter = "Adjusted common odds ratio for a decrease of 1 point in the score on the modified Rankin scale" if idno == 1028
replace definetargetparameter = "The between-group least-squares mean differences in the changes from baseline in the CGI-S scale score at week 4 was 0.5 points" if idno == 1022
replace definetargetparameter = "The percentages of patients with any response to treatment were significantly higher in the venetoclax-obinutuzumab group than in the chlorambucil-obinutuzumab group" if idno == 975 
replace definetargetparameter = "For our primary outcome we did an ordinal analysis expressing the result as a common OR and 95% CI, where a common OR in favour of placebo is less than 1·0. The primary outcome, an ordinal comparison of the distribution of patients across the mRS categories at 6 months, adjusted for variables included in the minimisation algorithm, was similar in the two groups" if idno == 957 
replace definetargetparameter = "The relative risk of any hearing loss with cisplatin-sodium thiosulfate treatment was 0.52" if idno == 937
replace definetargetparameter = "The effect of the idalopirdine doses was estimated as a mean difference vs placebo at week 24 using least-squares means for the treatment — visit interaction effect in the mixed model. The definition of the common odds ratio was not explicitly reported." if idno == 910
replace definetargetparameter = "The differences in proportion of 180 day mRS 3 or less in the saline group vs in the alteplase group." if idno == 856

** For medical specialisation, we will simplify this into some key categories 
tab medspecial 
codebook medspecial 
gen medspecialanalysis = 1 if medspecial == "Neurology"
replace medspecialanalysis = 2 if medspecial == "Infectious diseases"
replace medspecialanalysis = 3 if medspecial == "Psychiatry"
replace medspecialanalysis = 4 if medspecial == "Dermatology"
replace medspecialanalysis = 6 if medspecial == "Cardiology"
replace medspecialanalysis = 5 if medspecial == "Psychiatry"
replace medspecialanalysis = 7 if medspecial == "Rheumatology"
replace medspecialanalysis = 8 if medspecialanalysis == . & clinicalsetting == 1
lab def medspecialana 1 "Neurology" 2 "Infectious diseases" 3 "Psychiatry" 4 "Dermatology" 6 "Cardiology" 5 "Psychiatry" 8 "Other" 7 "Rheumatology"
lab val medspecialanalysis medspecialana
lab var medspecialanalysis "Medical Specialisation"

// Save dataset 
save "scopingreview_clean.dta", replace 



log close 

exit 







 
