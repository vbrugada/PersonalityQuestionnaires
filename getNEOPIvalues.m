function [vectFacets, vectDomains] = getNEOPIvalues (vectNEOPI)

% n of question 
N1 = [1 31 61 91 121 151 181 211];
N2 = [2 32 62 92 122 152 182 212];
N3 = [3 33 63 93 123 153 183 213];
N4 = [4 34 64 94 124 154 184 214];
N5 = [5 35 65 95 125 155 185 215];
N6 = [6 36 66 96 126 156 186 216];
Ntot = [N1 N2 N3 N4 N5 N6];

E1 = [7 37 67 97 127 157 187 217];
E2 = [8 38 68 98 128 158 188 218];
E3 = [9 39 69 99 129 159 189 219];
E4 = [10 40 70 100 130 160 190 220];
E5 = [11 41 71 101 131 161 191 221];
E6 = [12 42 72 102 132 162 192 222];
Etot = [E1 E2 E3 E4 E5 E6];

O1 = [13 43 73 103 133 163 193 223];
O2 = [14 44 74 104 134 164 194 224];
O3 = [15 45 75 105 135 165 195 225];
O4 = [16 46 76 106 136 166 196 226];
O5 = [17 47 77 107 137 167 197 227];
O6 = [18 48 78 108 138 168 198 228];
Otot = [O1 O2 O3 O4 O5 O6];

A1 = [19 49 79 109 139 169 199 229];
A2 = [20 50 80 110 140 170 200 230];
A3 = [21 51 81 111 141 171 201 231];
A4 = [22 52 82 112 142 172 202 232];
A5 = [23 53 83 113 143 173 203 233];
A6 = [24 54 84 114 144 174 204 234];
Atot = [A1 A2 A3 A4 A5 A6];

C1 = [25 55 85 115 145 175 205 235];
C2 = [26 56 86 116 146 176 206 236];
C3 = [27 57 87 117 147 177 207 237];
C4 = [28 58 88 118 148 178 208 238];
C5 = [29 59 89 119 149 179 209 239];
C6 = [30 60 90 120 150 180 210 240];
Ctot = [C1 C2 C3 C4 C5 C6];

vectNfacets = [sum(vectNEOPI(N1)), sum(vectNEOPI(N2)), sum(vectNEOPI(N3)), ...
    sum(vectNEOPI(N4)), sum(vectNEOPI(N5)), sum(vectNEOPI(N6))];
vectEfacets = [sum(vectNEOPI(E1)), sum(vectNEOPI(E2)), sum(vectNEOPI(E3)), ...
    sum(vectNEOPI(E4)), sum(vectNEOPI(E5)), sum(vectNEOPI(E6))];
vectOfacets = [sum(vectNEOPI(O1)), sum(vectNEOPI(O2)), sum(vectNEOPI(O3)), ...
    sum(vectNEOPI(O4)), sum(vectNEOPI(O5)), sum(vectNEOPI(O6))];
vectAfacets = [sum(vectNEOPI(A1)), sum(vectNEOPI(A2)), sum(vectNEOPI(A3)), ...
    sum(vectNEOPI(A4)), sum(vectNEOPI(A5)), sum(vectNEOPI(A6))];
vectCfacets = [sum(vectNEOPI(C1)), sum(vectNEOPI(C2)), sum(vectNEOPI(C3)), ...
    sum(vectNEOPI(C4)), sum(vectNEOPI(C5)), sum(vectNEOPI(C6))];

vectFacets = [vectNfacets, vectEfacets, vectOfacets, vectAfacets, ... 
    vectCfacets];

vectDomains = [sum(vectNEOPI(Ntot)), sum(vectNEOPI(Etot)), ...
    sum(vectNEOPI(Otot)), sum(vectNEOPI(Atot)),sum(vectNEOPI(Ctot))];





end