parameter
        rep_f   'Flows, both energy and volume based'
        rep_k   'Capacities "energy based" and some input data'
        rep_n   'Nodal mass balances, flow based so not scaled with num represented hours'
        rep_y  
        rep_ar   'Arc changes over time: "Repurposing report"'
        rep_c   'Cost overview'
        rep_b   'Binary decisions'
        rep_w   'storage'
        rep_ff  Nodal arc flow details
        rep_fn  Nodal flows
        rep_y   Yearly aggregates
; 
rep_n(n,e,y,h,'+','P')=Q_P.l(n,e,y,h)+ sum(f,Q_B.l(n,e,f,y,h));
rep_n(n,e,y,h,'+','A')=sum(a$a_e(a,n),F_A.l(a,e,y,h)*e_a(a,e));
rep_n(n,e,y,h,'+','LNG')=Q_R.l(n,e,y,h);
rep_n(n,e,y,h,'+','W')=Q_E.l(n,e,y,h);
rep_n(n,e,y,h,'+',f)=  Q_B.l(n,f,e,y,h);
*rep_n(n,e,y,h,'-','D')=Q_S.l(n,e,y,h);
rep_n(n,e,y,h,'-','D')= dmd(n,e,y,h);
rep_n(n,e,y,h,'-','A')=sum(a$a_s(a,n),F_A.l(a,e,y,h));
rep_n(n,e,y,h,'-','W')=Q_I.l(n,e,y,h);
rep_n(n,e,y,h,'-',f)=  Q_B.l(n,e,f,y,h);
rep_n(n,e,y,h,'Z',z)=  ZDS.l(z,n,e,y,h);
*rep_n(n,e,y,h,'Z','A-')=sum(a$a_s(a,n),ZXA_FS.l(a,y));
rep_n(n,e,y,h,'-','D2')$is_h(e)=sum((c,rgn,nuts2)$(n_in_c(n,c)*n_in_r(n,rgn)*n_in_2(n,nuts2)),  dmd2 (nuts2,e,y,h)*dat_n(n,c,nuts2,rgn,e));
rep_n(n,e,y,h,'Z','N2')$is_h(e)=sum((c,rgn,nuts2)$(n_in_c(n,c)*n_in_r(n,rgn)*n_in_2(n,nuts2)),  ZN2.l(nuts2,e,y,h)*dat_n(n,c,nuts2,rgn,e));

set cat /'+','-','Z'/, item /P,LNG,D,D2,A,W,C,G,H,A-,ZA,ZD,ZMD,ZMS,ZPL,ZPU,N2/;
rep_y(n,e,y,cat,item)=sum(h, scaleUp(h)*rep_n(n,e,y,h,cat,item))*365/sum(h,scaleUp(h));

*rep_n(n,e,y,h,'0','MB-dual')=mb.m(n,e,y,h);
rep_ff(n,e,y,h,'+','A')=sum(a$a_e(a,n),F_A.l(a,e,y,h)*e_a(a,e));
rep_ff(n,e,y,h,'-','A')=sum(a$a_s(a,n),F_A.l(a,e,y,h));
rep_ff(n,e,y,h,a,'F+')$a_e(a,n)=F_A.l(a,e,y,h)*e_a(a,e);
rep_ff(n,e,y,h,a,'F-')$a_s(a,n)=F_A.l(a,e,y,h);

rep_fn(n,m,e,y,h)=sum(a$anm(a,n,m),F_A.l(a,e,y,h));


rep_k(n,e,y,h,'K','P')=cap_p(n,e,y,h);
rep_k(n,e,y,h,'K','D')=dmd(n,e,y,h);
rep_k(n,e,y,h,'K','A+')=sum(a$a_e(a,n),K_A.l(a,e,y)*e_a(a,e));
rep_k(n,e,y,h,'K','A+(+BD)')=sum(a$a_e(a,n),(K_A.l(a,e,y)+K_OPP.l(a,e,y))*e_a(a,e));
rep_k(n,e,y,h,'X','A+')=sum(a$a_e(a,n),X_A.l(a,e,y)*e_a(a,e));
rep_k(n,e,y,h,'K','A-')=sum(a$a_s(a,n),K_A.l(a,e,y));
rep_k(n,e,y,h,'K','A-(+BD)')=sum(a$a_s(a,n),K_A.l(a,e,y)+K_OPP.l(a,e,y));
rep_k(n,e,y,h,'X','A-')=sum(a$a_s(a,n),X_A.l(a,e,y));

rep_f(a,e,y,h,'Cap')= K_A.l(a,e,y);
rep_f(a,e,y,h,'Cap-BD')$K_OPP.l(a,e,y)= K_A.l(a,e,y)+K_OPP.l(a,e,y);
rep_f(a,e,y,h,'Flow')=F_A.l(a,e,y,h);
rep_f(a,e,y,h,'Vol')= F_A.l(a,e,y,h)*vola2(e);

*rep_ar(a,e,y,'purp+')=  max(0, sum(f,K_RA.l(a,f,e,y))-sum(f,K_RA.l(a,e,f,y)));
*rep_ar(a,e,y,'purp-')=  min(0, sum(f,K_RA.l(a,f,e,y))-sum(f,K_RA.l(a,e,f,y)));
rep_ar(a,e,y,'purp')=          sum(f,K_RA.l(a,f,e,y))-sum(f,K_RA.l(a,e,f,y));
rep_ar(a,e,y,'expans')= X_A.l(a,e,y);
rep_ar(a,e,y,'bidir')=  K_OPP.l(a,e,y);
rep_ar(a,e,y,'cap')=    K_A.l(a,e,y);
rep_ar(a,e,y,'capBD')$K_OPP.l(a,e,y)=  K_A.l(a,e,y)+K_OPP.l(a,e,y);
*rep_ar(a,e,y,'(F-H1)')= sum(h$(ord(h))=1,F_A.l(a,e,y,h));
*rep_ar(a,e,y,'(F-H2)')= sum(h$(ord(h))=2,F_A.l(a,e,y,h));
rep_ar(a,e,y,h)=        F_A.l(a,e,y,h);

rep_c(n,e,y,'TOT','expans-','nom')=  sum(a$a_s(a,n),     c_ax(a,e,y)*  X_A.l(a,e,y));
rep_c(n,f,y,'TOT','purp', 'nom')=    sum((a,e)$a_s(a,n), c_ar(a,e,f,y)*K_RA.l(a,e,f,y) + f_ar(a,e,f,y) * B_AR.l(a,e,f,y));
rep_c(n,e,y,'TOT','bidir','nom')=    sum(a$a_s(a,n),     c_ab(a,e,y)*  K_BD.l(a,e,y));
*rep_c(n,'',y,'TOT','bidfx','nom')= sum(a$a_s(a,n),     f_ab(a,y)*B_BD.l(a,y));
*rep_c(n,e,y,'TOT','bidfx','nom')$sum(a$a_s(a,n),K_BD.l(a,e,y))= sum(a$a_s(a,n),     f_ab(a,y)*B_BD.l(a,y));
rep_c(n,'TOT',y,'TOT','bidfx','nom')$sum((a,e)$a_s(a,n),K_BD.l(a,e,y))= sum(a$a_s(a,n),     f_ab(a,y)*B_BD.l(a,y));
rep_c(n,e,y,h,'prod', 'nom')=                            c_p(n,e,y)*  Q_P.l(n,e,y,h)*   scaleUp(h);
rep_c(n,e,y,h,'flow-','nom')=        sum(a$a_s(a,n),     c_a(a,e,y)*  F_A.l(a,e,y,h))*  scaleUp(h);
rep_c(n,e,y,h,Z,  'nom')=                                c_z(z,e)*    ZDS.l(z,n,e,y,h)* scaleUp(h);
*rep_c(n,e,y,h,'ZXA','nom')=          sum(a$a_s(a,n),     c_az*        ZXA_FS.l(a,y))  * scaleUp(h);
rep_c(n,e,y,h,'ZN2','nom')=          sum((c,rgn,nuts2)$(n_in_c(n,c)*n_in_r(n,rgn)*n_in_2(n,nuts2)), c_z('ZD2',e)* ZN2.l(nuts2,e,y,h)*dat_n(n,c,nuts2,rgn,e))* scaleUp(h);
rep_c(n,e,y,h,'Stor','nom')=                             c_we(n,e)*   Q_E.l(n,e,y,h)* scaleUp(h);
rep_c(n,e,y,h,'Regas','nom')=                            c_lr(n,e)*   Q_R.l(n,e,y,h)* scaleUp(h);
rep_c(n,e,y,h,'Blend','nom')=        sum(f,              c_bl(e,f)*   Q_B.l(n,e,f,y,h))* scaleUp(h);


rep_c(n,e,y,'TOT','expans-','vol')=sum(a$a_s(a,n),     X_A.l(a,e,y));
rep_c(n,f,y,'TOT','purp', 'vol')=  sum((a,e)$(a_s(a,n) AND ord(e)<>ord(f)), K_RA.l(a,e,f,y));
rep_c(n,e,y,'TOT','bidir','vol')=  sum(a$a_s(a,n),     K_BD.l(a,e,y));

*Try conditional on K_BD.l(a,e,y)
rep_c(n,'TOT',y,'TOT','bidfx','vol')$sum((a,e)$a_s(a,n),K_BD.l(a,e,y))= sum(a$a_s(a,n),    B_BD.l(a,y));
*rep_c(n,e,y,'TOT','bidfx','vol')$  sum(a$a_s(a,n),     K_BD.l(a,e,y))= sum(a$a_s(a,n),     B_BD.l(a,y));

rep_c(n,e,y,h,'prod', 'vol')=                        Q_P.l(n,e,y,h)*    scaleUp(h);
rep_c(n,e,y,h,'flow-','vol')=      sum(a$a_s(a,n),     F_A.l(a,e,y,h))* scaleUp(h);
rep_c(n,e,y,h,z,  'vol')=                              ZDS.l(z,n,e,y,h)*scaleUp(h);
*rep_c(n,e,y,h,'ZXA','vol')=        sum(a$a_s(a,n), ZXA_FS.l(a,y))  *scaleUp(h);


$onText
Make conditional on positive volumes
rep_c(n,e,y,'TOT','expans-','ucost')=sum(a$a_s(a,n),     c_ax(a,e,y));
rep_c(n,f,y,'TOT','purp', 'ucost')=  sum((a,e)$a_s(a,n), c_ar(a,e,f,y));
rep_c(n,e,y,'TOT','bidir','ucost')=  sum(a$a_s(a,n),     c_ab(a,e,y));
rep_c(n,'',y,'TOT','bidfx','ucost')= sum(a$a_s(a,n),     f_ab(a,y));
rep_c(n,e,y,h,'prod', 'ucost')=                        c_p(n,e,y);
rep_c(n,e,y,h,'flow-','ucost')=    sum(a$a_s(a,n),     c_a(a,e,y));
rep_c(n,e,y,h,'Z_D',  'ucost')=                        c_dz(e);
rep_c(n,e,y,h,'Z_U',  'ucost')=                        c_pz(e);
rep_c(n,e,y,h,'Z_L',  'ucost')=                        c_pz(e);
$offText

rep_c(n,e,y,h,    aux_rep_c, 'disc')=  r(y)*EOH(y)*rep_c(n,e,y,h,aux_rep_c,'nom');
rep_c(n,'TOT',y,'TOT','bidfx','disc')= r(y)*EOH(y)*rep_c(n,'TOT',y,'TOT','bidfx','nom');
rep_c(n,e,y,'TOT',aux_rep_c, 'disc')=  r(y)*EOH(y)*rep_c(n,e,y,'TOT',aux_rep_c,'nom')+sum(h,rep_c(n,e,y,h,aux_rep_c, 'disc'));
rep_c('TOT','TOT','TOT','TOT','TOT','disc')=sum((n,e,y,aux_rep_c),rep_c(n,e,y,'TOT',aux_rep_c, 'disc'))+sum((n,y),rep_c(n,'TOT',y,'TOT','bidfx','disc'));
rep_c('TOT','TOT','TOT','TOT','TOT','Obj')=TC.l;

rep_b(a,e,e,y,'invest')$X_A.l(a,e,y)=       1;
*rep_b(a,e,f,y,'RepurpArc')$(ord(e)<>ord(f))=   B_AR.l(a,e,f,y);
rep_b(a,e,f,y,'RepurpArc')$((K_BD.l(a,e,y)>0.001))=   B_AR.l(a,e,f,y);
rep_b(a,e,e,y,'bidir')$(K_BD.l(a,e,y)>0.001)=  B_BD.l(a,y);

rep_w(n,e,h,y,'Flow')=            Q_E.l(n,e,y,h)-Q_I.l(n,e,y,h);
rep_w(n,e,h,y,'Vol')= scaleUp(h)*(Q_E.l(n,e,y,h)-Q_I.l(n,e,y,h));

* Backup old result file if it exists
* Make sure the folder exists
** Ensure GDX folder exists
$call if not exist "gdx" mkdir "gdx"

* Delete old backup if it exists
$call if exist "gdx/%string%_results_old.gdx" del "gdx/%string%_results_old.gdx"

* Rename previous result to backup
$call if exist "gdx/%string%_results.gdx" ren "gdx/%string%_results.gdx" "%string%_results_old.gdx"

* Save new results
execute_unload 'gdx/%string%_results',
    rep_n, rep_k, rep_f, rep_ar, rep_c, rep_b, rep_w, rep_ff, rep_fn, rep_y;


* Save new results
execute_unload 'gdx/%string%_results',
    rep_n, rep_k, rep_f, rep_ar, rep_c, rep_b, rep_w, rep_ff, rep_fn, rep_y;

