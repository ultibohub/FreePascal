    {   Unicode implementation tables. 
 
        Copyright (c) 2013 - 2017 by Inoussa OUEDRAOGO 
 
        Permission is hereby granted, free of charge, to any person 
        obtaining a copy of the Unicode data files and any associated 
        documentation (the "Data Files") or Unicode software and any 
        associated documentation (the "Software") to deal in the Data 
        Files or Software without restriction, including without 
        limitation the rights to use, copy, modify, merge, publish, 
        distribute, and/or sell copies of the Data Files or Software, 
        and to permit persons to whom the Data Files or Software are 
        furnished to do so, provided that (a) the above copyright 
        notice(s) and this permission notice appear with all copies 
        of the Data Files or Software, (b) both the above copyright 
        notice(s) and this permission notice appear in associated 
        documentation, and (c) there is clear notice in each modified 
        Data File or in the Software as well as in the documentation 
        associated with the Data File(s) or Software that the data or 
        software has been modified. 
 
 
        This program is distributed in the hope that it will be useful, 
        but WITHOUT ANY WARRANTY; without even the implied warranty of 
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. }

unit unicodenumtable;
interface


const
  UC_NUMERIC_COUNT = 142;
  UC_NUMERIC_ARRAY : array[0..(UC_NUMERIC_COUNT-1)] of Double = (
    0 ,1 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,
    9 ,0.25 ,0.5 ,0.75 ,0.0625 ,0.125 ,0.1875 ,16 ,
    10 ,100 ,1000 ,0.00625 ,0.025 ,0.0375 ,0.05 ,0.1 ,
    0.15 ,0.2 ,1.5 ,2.5 ,3.5 ,4.5 ,5.5 ,6.5 ,
    7.5 ,8.5 ,-0.5 ,20 ,30 ,40 ,50 ,60 ,
    70 ,80 ,90 ,10000 ,17 ,18 ,19 ,0.142857142857143 ,
    0.111111111111111 ,0.333333333333333 ,0.666666666666667 ,0.4 ,0.6 ,0.8 ,0.166666666666667 ,0.833333333333333 ,
    0.375 ,0.625 ,0.875 ,11 ,12 ,500 ,5000 ,50000 ,
    100000 ,13 ,14 ,15 ,21 ,22 ,23 ,24 ,
    25 ,26 ,27 ,28 ,29 ,31 ,32 ,33 ,
    34 ,35 ,36 ,37 ,38 ,39 ,41 ,42 ,
    43 ,44 ,45 ,46 ,47 ,48 ,49 ,200 ,
    300 ,400 ,600 ,700 ,800 ,900 ,2000 ,3000 ,
    4000 ,6000 ,7000 ,8000 ,9000 ,20000 ,30000 ,40000 ,
    60000 ,70000 ,80000 ,90000 ,0.916666666666667 ,200000 ,300000 ,400000 ,
    500000 ,600000 ,700000 ,800000 ,900000 ,0.0833333333333333 ,0.416666666666667 ,0.583333333333333 ,
    0.003125 ,0.0125 ,0.015625 ,0.03125 ,0.046875 ,216000 ,432000 ,1000000 ,
    100000000 ,10000000000 ,1000000000000 ,10000000 ,20000000
  );


implementation

end.
