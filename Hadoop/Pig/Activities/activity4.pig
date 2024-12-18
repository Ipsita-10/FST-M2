--Load the input file:
inputFile= LOAD '/root/input.txt' AS (line:chararray);
--Tokenize the lines into words:
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
--Group the words:(MAP)
grpd = GROUP words BY  word;
--Count the total no.of words:(REDUCE)
totalCount = FOREACH grpd GENERATE $0 AS word, COUNT($1) AS no_of_words;
--Store the output in the HDFS
rmf /root/PIGoutput2;
STORE totalCount INTO '/root/PIGoutput2';