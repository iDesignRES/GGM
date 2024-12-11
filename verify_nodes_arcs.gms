set abort_a "Check these pipelines for missing or incorrect data."
    abort_n(n) "Check these nodes for missing or incorrect data."
    warn_n(n) "Isolated nodes, no (potential for) inward or outward connections."
;
*Isolated nodes
loop{n$(    sum(a,a_s(a,n)+a_e(a,n))<1 ) ,
  warn_n(n)=yes;
};
*No consumption no production no transit
loop{n$(sum((e,y,h),cap_p(n,e,y,h)+dmd(n,e,y,h))<0.01 AND (sum(a,a_s(a,n)+a_e(a,n))<2)),
  abort_n(n)=yes;
};
loop{a$(sum(n,a_s(a,n))<1 OR sum(n,a_e(a,n))<1 
         OR ((sum((e,y),cap_a(a,e,y))<0.1 AND sum((ao,e,y)$opp(a,ao),cap_a(ao,e,y))<0.1)
              AND sum(y,ub_ax(a,y))<0.1)
         OR sum(e,e_a(a,e))<1-dat_o('LossMax','','')) ,
  abort_a(a)=yes;
};
display abort_n,warn_n,abort_a
;
loop{n$abort_n(n),
     abort "Check nodes for missing or incorrect data.";
};
loop{a$abort_a(a),
     abort "Check pipelines for missing or incorrect data.";
};
