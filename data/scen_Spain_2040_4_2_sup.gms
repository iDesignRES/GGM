*AMBITIOUS

cap_p(n,'H',y,h)$(ord(y)>=2 and  n_in_c(n,'FR'))=   cap_p(n,'H','2030',h);
cap_p(n,'H',y,h)$(ord(y)>=2 and NOT n_in_c(n,'FR'))=max((ord(y)-1)*cap_p(n,'H','2030',h),3*sup_aux(n,y));

c_p(n,'H',y)    $(ord(y)>=2)=sup_aux(n,'MC');

*lb_p(n,e,y,h)=  dat_p(n,e,y,'LB');



