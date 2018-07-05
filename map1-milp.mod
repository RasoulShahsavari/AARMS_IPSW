param n;
param m:=2;
param d:=4;
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
s.t. c4{k in M, i in N}: -x1[i,k] +v[i,k]<= q[i,k];
s.t. c5{(i,j) in E}: sum{k in D }c[i,j,k]=1;
solve;

printf "Vertex locations:\n";
printf{i in N}  "%d\t%g\t%g\n", i, x1[i,1], x1[i,2];

data;

param n:=10;
param  w1:     1    2:=
      	1      1    0  
	2      0    1   
	3     -1    0  
	4      0   -1 ;

param: E : l :=
1	2	312.0785158
2	3	368.4901627
3	4	470.026595
4	5	494.025303
5	6	393.7321425
6	7	288.0433995
7	8	455.0175821
8	1	454.0275322
1	9	549.6071324
9	8	337.3796082
9	6	478.1223693
9	4	353.0509878
2	9	445.4492115
9	3	580.0000000
9	10	281.7374664
10	8	259.8788179
10	6	287.5708608
10	7	296.0574269
9	5	609.1830595;

param  v:     1    2:=
 1    	210	119
2	203	431
3	184	799
4	654	804
5	1148	799
6	1124	406
7	1119	118
8	664	114
9	648	451
10	868	275 ;   

end;

