param n;
param m:=2;
param d:=8;
set D, default{1..d};
set N, default{0..n-1};
set M, default{1..m};
var x1{N,M};
set E, within N cross N;
param w1{D,M};
var e{E,M}, >=0;
var c{E,D},binary;
param l{E};
param v{N,M};
var q{N,M}, >=0;

param file, symbolic, default "map1.json";

minimize obj: sum{(i,j) in E}(e[i,j,1]+e[i,j,2])+ sum{j in N}(q[j,1]+q[j,2]);

s.t. c1{k in M, (i,j) in E}:e[i,j,k] >= x1[i,k]+sum{a in D} (c[i,j,a]*w1[a,k]*l[i,j])-x1[j,k];
s.t. c2{k in M, (i,j) in E}:e[i,j,k] >= -x1[i,k]-sum{a in D}(c[i,j,a]*w1[a,k]*l[i,j])+x1[j,k];
s.t. c3{k in M, (i,j) in E}: x1[i,k]-v[i,k]<= q[j,k]; 
s.t. c4{k in M, i in N}: -x1[i,k] +v[i,k]<= q[i,k];
s.t. c5{(i,j) in E}: sum{k in D }c[i,j,k]=1;
solve;

printf "{\n" > file;

printf '"vertices":[\n' >> file;
printf{i in 0..n-2}  '{"x":%g, "y":%g },\n', x1[i,1], x1[i,2] >> file;
printf{i in {n-1}}  '{"x":%g, "y":%g }\n', x1[i,1], x1[i,2]>> file;
printf "],\n" >>file;

printf '"edges":[\n' >>file; 
printf{(i,j) in E}  '{"v1":%d, "v2":%d, "distance": 0, "speed": 0 },\n', i,j >> file;
printf '{"v1":%d, "v2":%d, "distance": 0, "speed": 0 }\n', 0,0 >> file;
printf "]\n">>file;
printf "}\n" >>file;

data;

param n:=10;
param  w1:     1    2:=
       1	0.707106781	0.707106781
       2	6.12E-17	1
       3	-0.707106781	0.707106781
       4	-1	1.22E-16
       5	-0.707106781	-0.707106781
       6	-1.84E-16	-1
       7	0.707106781	-0.707106781
       8	1	-2.45E-16;
       
param: E : l :=
0	1	312.078515761659
1	2	368.490162690946
2	3	470.026594992241
3	4	494.025302995707
4	5	393.732142452201
5	6	288.043399507783
6	7	455.017582077880
7	0	454.027532204821
0	8	549.607132413691
8	7	337.379608156747
8	5	478.122369273808
8	3	353.050987819040
1	8	445.449211470848
8	2	580
8	9	281.737466447045
9	7	259.878817913273
9	5	287.570860832596
9	6	296.057426861749
8	4	609.183059514954;

param  v:     1    2:=
0	210	119
1	203	431
2	184	799
3	654	804
4	1148	799
5	1124	406
6	1119	118
7	664	114
8	648	451
9	868	275;

end;

