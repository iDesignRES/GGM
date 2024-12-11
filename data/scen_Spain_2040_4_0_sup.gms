*MODERATE

cap_p(n,'H',y,h)$(ord(y)>=3 and  n_in_c(n,'FR'))=   cap_p(n,'H','2030',h);
cap_p(n,'H',y,h)$(ord(y)>=3)=                   max(cap_p(n,'H','2030',h),sup_aux(n,y));

c_p(n,'H',y)    $(ord(y)>=3)=sup_aux(n,'MC');

*lb_p(n,e,y,h)=  dat_p(n,e,y,'LB');

