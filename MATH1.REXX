/* REXX */
ADDRESS TSO "CLRSCRN";
SAY 'Please enter two numbers (a,b):';
PARSE EXTERNAL A B;

IF DATATYPE(A,'NUM') = 0 THEN
 DO
   SAY 'a: <' || A || '> is not a number. ';
   EXIT 1;
END;

IF DATATYPE(B,'NUM') = 0 THEN
 DO
   SAY 'b: <' || B || '> is not a number. ';
   EXIT 2;
END;

SAY ' >> You entered ' || A  || ' and ' || B || '.';
SAY ' >> ' || A || ' + ' || B ' = ' A + B;
SAY ' >> ' || A || ' - ' || B ' = ' A - B;
SAY ' >> ' || A || ' * ' || B ' = ' A * B;
SAY ' >> ' || A || ' / ' || B ' = ' A / B;
D = A % B;
R = A // B;
SAY ' >> ' || A || ' divided by ' || B || ' is ' || D,
    ' with a remainder of ' || R;
EXIT_0:
SAY ' ** NORMAL END.';
EXIT 0;
