/* Rexx

  Choose functions from the following list to accomplish the
  requested tasks:

         ABBREV             RIGHT         WORD
         INSERT             SPACE         WORDS
         JUSTIFY            SUBSTR        DELSTR
         LEFT               SUBWORD
         LENGTH             TRANSLATE
         OVERLAY            WORDINDEX
         POS                WORDPOS

   In this exercise, any reference to a word includes text
   surrounded by blanks or commas.

   Answers 1 through 13 require only one function.

   Starting at number 14 some answers will require more than one
   function to achieve the desired results.

   Use command %FCHK to check your answers.
*/

s1 = 'APROFLERILISTBOPYTY'
s2 = 'aa     bbb   cccc  ee      fff       gg'
s3 = 'CAR, DOG, CAT,T BIRD,MAN'


ADDRESS TSO "CLRSCRN";

/*************** 1 *****************/
Say 1.,
  'Code a function to execute columns 10 through 14 of s1 as a command.'
  /* Place answer here */
SAY '>> s1:'
CALL COLS;
SAY s1
SAY 'COMMAND: ' SUBSTR(s1, 10, 05)
SUBSTR(s1, 10, 05)
SAY;
/*************** 2 *****************/
Say 2.,
  'Display the last five characters of s1.'
  /* Place answer here */
SAY '>> s1:'
CALL COLS;
SAY s1
SAY RIGHT(s1, 05)
SAY;
/*************** 3 *****************/
Say 3.,
  'Display the first five characters of s1.'
  /* Place answer here */
SAY '>> s1:'
CALL COLS;
SAY s1
SAY LEFT(s1, 05)
SAY;
/*************** 4 *****************/
Say 4.,
  'Display the length of s1.'
  /* Place answer here */
SAY '>> s1:'
CALL COLS;
SAY s1
SAY LENGTH(s1)
SAY;
/*************** 5 *****************/
Say 5.,
  'Display the fourth word of s2.'
  /* Place answer here */
SAY '>> s2:'
CALL COLS;
SAY s2
SAY WORD(s2, 04)
SAY;
/*************** 6 *****************/
Say 6.,
  'Display the number of words in s2.'
  /* Place answer here */
SAY '>> s2:'
CALL COLS;
SAY s2
SAY WORDS(s2)
SAY;
/*************** 7 *****************/
Say 7.,
  'Display the column number of the fourth word of s2.'
  /* Place answer here */
SAY '>> s2:'
CALL COLS;
SAY s2
SAY WORDINDEX(s2, 04)
SAY;
/*************** 8 *****************/
Say 8.,
  'Display the third through the fifth word of s2.'
  /* Place answer here */
SAY '>> s2:'
CALL COLS;
SAY s2
SAY SUBWORD(s2, 03, 03)
SAY;
/*************** 9 *****************/
Say 9.,
  'Display s2 so that there is only one space between each word.'
  /* Place answer here */
SAY '>> s2:'
CALL COLS;
SAY s2
SAY SPACE(s2)
SAY;
/************** 10 *****************/
Say 10.,
  'Display s2 so that each word is separated by one comma (aa,bbb,c).'
  /* Place answer here */
SAY '>> s2:'
CALL COLS;
SAY s2
SAY SPACE(s2, 1, ',')
SAY;

/************** 11 *****************/
Say 11.,
  'Change each blank in s2 into a comma.'
  /* Place answer here */
SAY '>> s2:'
CALL COLS;
SAY s2
SAY TRANSLATE(s2, ',', ' ')
SAY;

/************** 12 *****************/
Say 12.,
  'Display s2 so you can verify the previous change.'
  /* Place answer here */
SAY '>> s2:'
CALL COLS;
SAY s2
SAY TRANSLATE(s2, ',', ' ')
SAY;

/************** 13 *****************/
Say 13.,
  "Display the column number of the first occurance of 'T' in s3."
  /* Place answer here */
SAY '>> s3:'
CALL COLS;
SAY s3
SAY POS('T', s3)
SAY;
/************** 14 *****************/
Say 14. 'Converting the commas to blanks,',
  "display the word number of the word 'T' in s3."
  /* Place answer here */
SAY '>> s3:'
CALL COLS;
SAY s3
SAY TRANSLATE(s3, ' ', ',')
SAY WORDPOS('T', TRANSLATE(s3, ' ', ','))
SAY;

/************** 15 *****************/
Say 15. 'Converting the commas to blanks,',
  "display the number of words in s3."
  /* Place answer here */
SAY '>> s3:'
CALL COLS;
SAY s3
SAY TRANSLATE(s3, ' ', ',')
SAY WORDS(TRANSLATE(s3, ' ', ','))
SAY;

/************** 16 *****************/
Say 16.,
  "Insert 'PIG, ' into s3 after column 9."
  /* Place answer here */
SAY '>> s3:'
CALL COLS;
SAY s3
SAY INSERT('PIG', s3, 09)
SAY;

/************** 17 *****************/
Say 17.,
  "Display s3."
  /* Place answer here */
SAY '>> s3:'
CALL COLS;
SAY s3
SAY;

/************** 18 *****************/
Say 18.,
  "Replace 'CAT' with 'RAT' in s3."
  /* Place answer here */
SAY '>> s3:'
CALL COLS;
SAY s3
A = TRANSLATE(s3, ' ', ',');
/*
SAY 'WORDPOS(''CAT'', A): ' WORDPOS('CAT', A)
SAY 'WORDINDEX(A, WORDPOS(''CAT'', A)): ',
     WORDINDEX(s3, WORDPOS('CAT', A))
*/
SAY OVERLAY('RAT', s3, WORDINDEX(A, WORDPOS('CAT', A)))
SAY;

/************** 19 *****************/
Say 19.,
  "Display s3 with no blanks (CAR,DOG,RAT,...)."
  /* Place answer here */
SAY '>> s3:'
CALL COLS;
SAY s3
A = TRANSLATE(s3, ' ', ',');
B = OVERLAY('RAT', s3, WORDINDEX(A, WORDPOS('CAT', A)))
C = TRANSLATE(B ,   ' ',   ',')
SAY SPACE(C, 1, ',')
SAY;

/************** 20 *****************/
Say 20.,
  "Display s3 with the character positions containing 'T ' deleted."
  /* Place answer here */
SAY '>> s3:'
CALL COLS;
SAY s3
S = s3
DO UNTIL POS('T ', S) = 0
   P = POS('T ', S)
/* SAY '>> POS(''T '', S): ' P
   SAY '>> SUBSTR(S,1,P-1) : ' SUBSTR(S,1,P-1)
   SAY '>> SUBSTR(S, P+2, LENGTH(S) - (P+1)): ',
           SUBSTR(S, P+2, LENGTH(S) - (P+1))
*/
   S = SUBSTR(S,1,P-1) || SUBSTR(S, P+2, LENGTH(S) - (P+1))
/* SAY S */
END /* DO UNTIL */
SAY S
Exit
/************** Sr *****************/
COLS:
SAY COPIES('-',4) || '+' || COPIES('-',4) || '1',
 || COPIES('-',4) || '+' || COPIES('-',4) || '2',
 || COPIES('-',4) || '+' || COPIES('-',4) || '3',
 || COPIES('-',4) || '+' || COPIES('-',4) || '4',
 || COPIES('-',4) || '+' || COPIES('-',4) || '5',
 || COPIES('-',4) || '+' || COPIES('-',4) || '6',
 || COPIES('-',4) || '+' || COPIES('-',4) || '7',
 || COPIES('-',4) || '+' || COPIES('-',4);
RETURN;
