param n;
param m:=2;
param d:=8;
set D, default{1..d};
set N, default{1..n};
set M, default{1..m};
var x1{N,M};
set E, within N cross N;
param w1{D,M};
var e{E,M}, >=0;
var c{E,D},binary;
param l{E};
param v{N,M};
var q{N,M}, >=0;

minimize obj: sum{(i,j) in E}(e[i,j,1]+e[i,j,2])+ sum{j in N}(q[j,1]+q[j,2]);

s.t. c1{k in M, (i,j) in E}:e[i,j,k] >= x1[i,k]+sum{a in D} (c[i,j,a]*w1[a,k]*l[i,j])-x1[j,k];
s.t. c2{k in M, (i,j) in E}:e[i,j,k] >= -x1[i,k]-sum{a in D}(c[i,j,a]*w1[a,k]*l[i,j])+x1[j,k];
s.t. c3{k in M, (i,j) in E}: x1[i,k]-v[i,k]<= q[j,k];
s.t. c4{k in M, i in N}: -x1[i,k]+v[i,k]<= q[i,k];
s.t. c5{(i,j) in E}: sum{k in D }c[i,j,k]=1;
solve;
display x1,e,q,c;

printf "Vertex location: \n";
printf "index\tx\ty\n";
printf{i in N} "%d\t%g\t%g\n", i, x1[i,1], x1[i,2];

data;

param n:=10;
param  w1:     1    2:=
1	0.707106781	0.707106781
2	0	1
3	-0.707106781	0.707106781
4	-1	0
5	-0.707106781	-0.707106781
6	0	-1
7	0.707106781	-0.707106781
8	1	0;

param: E : l :=
1        2        312.07851576165893
2        3        368.4901626909462
3        4        470.0265949922408
4        5        494.0253029957069
5        6        393.7321424522006
6        7        288.0433995077825
7        8        455.0175820778797
8        1        454.0275322048212
1        9        549.6071324136906
9        8        337.37960815674677
9        6        478.1223692738084
9        4        353.0509878190401
2        9        445.44921147084773
9        3        580
9        10        281.73746644704534
10        8        259.8788179132728
10        6        287.5708608325955
10        7        296.05742686174926
9        5        609.183059514954
;

param  v:     1    2:=
1	210	119
2	203	431
3	184	799
4	654	804
5	1148	799
6	1124	406
7	1119	118
8	664	114
9	648	451
10	868	275;   

end;



