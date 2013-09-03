@mode.com com%1:baud=1200
@sleep 1
@bossac_due.exe --port=COM%1 -U false -e -w -v -b -R %~f2
