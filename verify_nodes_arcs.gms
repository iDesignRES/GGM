set 
    abort_a        "Check these pipelines for missing or incorrect data.",
    abort_n(n)     "Check these nodes for missing or incorrect data.",
    warn_n(n)      "Isolated nodes, no (potential for) inward or outward connections."
;

*-----------------------------------------*
* 1. Detect isolated nodes (no connection)
*-----------------------------------------*
loop(n$(sum(a, a_s(a,n) + a_e(a,n)) < 1),
    warn_n(n) = yes;
);

*-----------------------------------------------------------*
* 2. Nodes with no consumption, no production, no transit
*-----------------------------------------------------------*
loop(n$(
    sum((e,y,h), cap_p(n,e,y,h) + dmd(n,e,y,h)) < 0.01 AND
    sum(a, a_s(a,n) + a_e(a,n)) < 2
),
    abort_n(n) = yes;
);

*-----------------------------------------------------------*
* 3. Arcs with no valid start/end or capacity definition
*-----------------------------------------------------------*
loop(a$(
    sum(n, a_s(a,n)) < 1 OR
    sum(n, a_e(a,n)) < 1 OR
    (
        (sum((e,y), cap_a(a,e,y)) < 0.1 AND 
         sum((ao,e,y)$opp(a,ao), cap_a(ao,e,y)) < 0.1) AND
        sum(y, ub_ax(a,y)) < 0.1
    ) OR
    sum(e, e_a(a,e)) < 1 - dat_o('LossMax','','')
),
    abort_a(a) = yes;
);

*-------------------------------*
* 4. Save verification results
*-------------------------------*
*$call if not exist gdx mkdir gdx
execute_unload 'gdx/%string%_verify',
    abort_n, warn_n, abort_a;

*-------------------------------*
* 5. Abort if errors detected
*-------------------------------*
loop(n$abort_n(n),
     abort " ERROR: Check nodes for missing or incorrect data.");
loop(a$abort_a(a),
     abort " ERROR: Check pipelines for missing or incorrect data.");
