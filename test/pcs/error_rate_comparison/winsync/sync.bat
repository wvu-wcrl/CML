@ECHO OFF

SET User=tferrett
SET RemoteData=/home/tferrett/tasks
SET LocalData=c:\Documents and Settings\Terry\tmp

pscp -i id_rsa.ppk -r %User%@wcrlcluster.csee.wvu.edu:%RemoteData%/* "%LocalData%"
