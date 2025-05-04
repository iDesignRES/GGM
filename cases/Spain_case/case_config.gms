

$setglobal KeepGdx    ''
$setglobal Verify     '*'
$setglobal data       Spain
$setglobal path       cases/%data%_case
$setglobal hor        2040
$setglobal oper       4
$setglobal scen       0
$setglobal string     %data%_%hor%_%oper%_%scen%

$setglobal excel_file "%path%/input_data/%data%.xlsx"

$include load_input_from_Excel_v0_2_0.gms

