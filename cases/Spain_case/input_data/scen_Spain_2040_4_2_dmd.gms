
*Do not allow natural gas inflow into France in any year?

*ub_bl(e,f)=1*ub_bl(e,f);

$ontext
1 Winter, 2 Summer, 3 Shoulder, 4 MIN
$offtext

*Assign to future years and weight with the relative NUTS3 gas share in the NUTS2 region "dat_n(n,c,nuts2,rgn,e)"
*Hard coded weights!

*"DECARB + EXPORT" - 18 jun 2024 Gas Demands Only

*2025
dmd(n,e,y,h)$(ord(h)=1)= sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)* (0.8*dat_c(nuts2,e,'POW') + dat_c(nuts2,e,'MAX' )));
dmd(n,e,y,h)$(ord(h)=2)= sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)* (0.8*dat_c(nuts2,e,'POW') + dat_c(nuts2,e,'MIN' )));
dmd(n,e,y,h)$(ord(h)=3)= sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)* (0.4*dat_c(nuts2,e,'POW') + dat_c(nuts2,e,'MEAN')));
dmd(n,e,y,h)$(ord(h)=4)= sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)* (0.1*dat_c(nuts2,e,'POW') + dat_c(nuts2,e,'MIN' )));

*2030
dmd(n,e,y,'1')$(ord(y)=2 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.4*dat_c(nuts2,e,'POW')+0.7*dat_c(nuts2,e,'MAX' )));
dmd(n,e,y,'2')$(ord(y)=2 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.3*dat_c(nuts2,e,'POW')+0.6*dat_c(nuts2,e,'MIN' )));
dmd(n,e,y,'3')$(ord(y)=2 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.2*dat_c(nuts2,e,'POW')+0.6*dat_c(nuts2,e,'MEAN')));
dmd(n,e,y,'4')$(ord(y)=2 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.1*dat_c(nuts2,e,'POW')+0.6*dat_c(nuts2,e,'MIN' )));

*2035
dmd(n,e,y,'1')$(ord(y)=3 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.1*dat_c(nuts2,e,'POW')+0.5*dat_c(nuts2,e,'MAX' )));
dmd(n,e,y,'2')$(ord(y)=3 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.4*dat_c(nuts2,e,'MIN' )));
dmd(n,e,y,'3')$(ord(y)=3 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.4*dat_c(nuts2,e,'MEAN')));
dmd(n,e,y,'4')$(ord(y)=3 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.4*dat_c(nuts2,e,'MIN' )));

*2040
dmd(n,e,y,'1')$(ord(y)=4 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.4*dat_c(nuts2,e,'MAX' )));
dmd(n,e,y,'2')$(ord(y)=4 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.3*dat_c(nuts2,e,'MIN' )));
dmd(n,e,y,'3')$(ord(y)=4 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.3*dat_c(nuts2,e,'MEAN')));
dmd(n,e,y,'4')$(ord(y)=4 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.2*dat_c(nuts2,e,'MIN' )));

*2045
dmd(n,e,y,'1')$(ord(y)=5 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.2*dat_c(nuts2,e,'MAX' )));
dmd(n,e,y,'2')$(ord(y)=5 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.2*dat_c(nuts2,e,'MIN' )));
dmd(n,e,y,'3')$(ord(y)=5 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.2*dat_c(nuts2,e,'MEAN')));
dmd(n,e,y,'4')$(ord(y)=5 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.1*dat_c(nuts2,e,'MIN' )));

*2050 and later
dmd(n,e,y,'1')$(ord(y)>5 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.1*dat_c(nuts2,e,'MAX' )));
dmd(n,e,y,'2')$(ord(y)>5 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.0*dat_c(nuts2,e,'MIN' )));
dmd(n,e,y,'3')$(ord(y)>5 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.1*dat_c(nuts2,e,'MEAN')));
dmd(n,e,y,'4')$(ord(y)>5 AND is_g(e))=sum((c,rgn,nuts2)$n_in_2(n,nuts2),dat_n(n,c,nuts2,rgn,e)*(0.0*dat_c(nuts2,e,'POW')+0.0*dat_c(nuts2,e,'MIN' )));

*dmd2(nuts2,e,y,h)$is_g(e) = sum(n$n_in_2(n,nuts2), dmd(n,e,y,h));
*option dmd:2:3:1, dmd2:2:3:1; display dmd,dmd2;
*dmd2(nuts2,e,y,h)$is_g(e) =0;

*Create H2 demand
*No H demand in 2025
*dmd(n,'H',y,h)$(ord(y)=1 AND dmd(n,e,y,h)>1E-3)= 1E-3;
dmd(n,'H',y,h)$(ord(y)=2) = 0.03* dmd(n,'G','2025',h);
dmd(n,'H',y,h)$(ord(y)=3) = 0.10* dmd(n,'G','2025',h);
dmd(n,'H',y,h)$(ord(y)=4) = 0.20* dmd(n,'G','2025',h);
dmd(n,'H',y,h)$(ord(y)=5) = 0.30* dmd(n,'G','2025',h);
dmd(n,'H',y,h)$(ord(y)>5) = 0.40* dmd(n,'G','2025',h);

*ES511-FRL04, H2Med; 2MTPA by 2030; €2 bln; estimate connections on land, could add another 1 bln
*2 MTPA = 7.5 GW 
dmd('FRL04',e,y,h)$(is_h(e) AND ord(y)>1)= 7.5;
dmd('FRL04',e,y,h)$(is_h(e) AND ord(y)>3)=15.0;
dmd('FRL04',e,y,h)$(is_h(e) AND ord(y)>5)=22.5;

*PT181-NL33C; Sines and Rotterdam H2Sines.RDAM Project; 2028; Sines: 400MW --> 0.4GWh; but then a bit lower
dmd('NL33C',e,y,h)$(is_h(e) AND ord(y)>1)=0.3;
dmd('NL33C',e,y,h)$(is_h(e) AND ord(y)>3)=1.0;
dmd('NL33C',e,y,h)$(is_h(e) AND ord(y)>5)=2.0;


*Gas demand future periods: 2025 demand - h2 demand; only works when H2 demand at the NUTS3 level
*dmd(n,e,y,h)$(ord(y)>1 AND is_g(e) AND dmd(n,e,y,h)>1E-3)= max(1E-3, dmd(n,e,y,h)-dmd(n,'H',y,h));

dmd('MA000',e,y,h)$(ord(y)>3)=0;
dmd(n,'C',y,h)=0;
*NUTS2 level demand for H2
dmd2(nuts2,e,y,h)$(is_h(e) AND ord(y)>1)= sum(n$n_in_2(n,nuts2), dmd(n,e,y,h));
dmd(n,'H',y,h)=0;

*display dmd,dmd2;