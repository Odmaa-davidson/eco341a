// Week 13 - Lab 10: Extracting tables for your empirical paper

* saving the file to write to excel
* Export to Excel 
putexcel set "C:\Users\odnarantungalag\OneDrive - Davidson College\Teaching 2025-2026\Fall_2025\ECO 341A-Applied Impact Evaluation\Week 13 - Paper discussion\Lab\auto_summary.xlsx", sheet(Descriptive) replace
sysuse auto, clear

* Summarize selected variables
* tabstat price mpg weight length, statistics(n mean sd min max) by(foreign) save
tabstat price mpg weight length, by(foreign) save
return list

* transpose 
qui tabstat price mpg weight length, by(foreign) save
matrix Domestic = r(Stat1)'
matrix Foreign = r(Stat2)'
matrix N = r(StatTotal)'

putexcel A1 = "Variables"
putexcel B1 = "Domestic"
putexcel C1 = "Forein"
putexcel D1 = "Total"
putexcel A2 = matrix(Domestic), rownames nformat(number_d2)
putexcel C2 = matrix(Foreign), nformat(number_d2)
putexcel D2 = matrix(N), nformat(number_d2)

// Exporting results to excel



putexcel set "C:\Users\odnarantungalag\OneDrive - Davidson College\Teaching 2025-2026\Fall_2025\ECO 341A-Applied Impact Evaluation\Week 13 - Paper discussion\Lab\auto_results.xlsx", sheet(Estimation) replace
regress price mpg trunk foreign
ereturn list 
putexcel B1 = "Coef."
matrix b = e(b)'
matrix se = e(rmse)'
matrix N = e(N)'

putexcel A2 = matrix(b), rownames nformat(number_2)
putexcel A5:B5, border(bottom)
putexcel A6 = "N=", italic right border(bottom, medium)
putexcel B6 = matrix(N), nformat(number_sep) border(bottom, medium)

**** using eststo and esttab
sysuse auto, clear
reg price mpg 
eststo est1

reg price mpg trunk 
eststo est2

reg price mpg trunk foreign weight
eststo est3

reg price mpg trunk foreign weight headroom
eststo est4

esttab est1 est2 est3 est4 using "C:\Users\odnarantungalag\OneDrive - Davidson College\Teaching 2025-2026\Fall_2025\ECO 341A-Applied Impact Evaluation\Week 13 - Paper discussion\Lab\auto_results1.rtf",replace 

esttab est1 est2 est3 est4 using "C:\Users\odnarantungalag\OneDrive - Davidson College\Teaching 2025-2026\Fall_2025\ECO 341A-Applied Impact Evaluation\Week 13 - Paper discussion\Lab\auto_results2.rtf",replace se scalars(F r2_a df_m df_r)


