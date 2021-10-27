#!/bin/csh -f
##############################################################
#                                                            #
#    HESTIA DB BACKUP                                        #
#    File Name: backup_hestia.sh                             #
#                                                            #
##############################################################
 
setenv	ORACLE_HOME	/usr/local/oracle8i
setenv	ORACLE_TERM	vt100
setenv	ORA_NLS		$ORACLE_HOME/ocommon/nls/admin/data
setenv	ORACLE_DOC	$ORACLE_HOME/doc
setenv	LD_LIBRARY_PATH	$ORACLE_HOME/lib
setenv	PATH		${ORACLE_HOME}/bin:/usr/local/bin:${PATH}

setenv	SH		/home/sh
setenv	BACKUP		/var/backup
setenv	HTTPDATA	/httpdata
setenv  ORACLEDB        /oracledb
setenv	LOG		/home/log/log.backup
setenv	LOG2	        /home/log/lg2.backup
setenv	DF		/home/log/log.df
setenv	DF2		/home/log/lg2.df
setenv	CLEAN		/home/log/log.clean
setenv	CLEAN2		/home/log/lg2.clean

mv $LOG $LOG2
mv $CLEAN $CLEAN2
mv $DF $DF2

echo "Backup Procedure Start Time                       => `date`"	>$LOG
 
#################
# 1 Delete all core file 
#################
echo "Delete core files Start Time                      => `date`"	>>$LOG
 
find / -name core -print -exec ls -l {} \;				>$CLEAN
find / -name core -print -exec rm {} \;

echo "Check disk space Start Time                       => `date`" 	>>$LOG
echo `date`                                                             >$DF
df -k									>>$DF
 
echo "Delete core files End Time                        => `date`"	>>$LOG

#################
# 2. SHUTDOWN DB (HRD) 
#################
su - oracle -c "$SH/db_shut.sh hrd immediate"

#################
# 3. Backup 
#################
echo "Backup HESTIA DB/HTTP (PHYSICAL FILES) Start Time => `date`"	>>$LOG

rm $BACKUP/oracledb.tar.Z
rm $BACKUP/httpdata.tar.Z

cd $ORACLEDB
tar cf - . | compress - > $BACKUP/oracledb.tar.Z

cd $HTTPDATA
tar cf - . | compress - > $BACKUP/httpdata.tar.Z 
echo "Backup HESTIA DB/HTTP (PHYSICAL FILES) End Time   => `date`"	>>$LOG

#################
# 4. START DB (HRD) 
#################
su - oracle -c "$SH/db_start.sh hrd"

#################
# 5.COPY BACKUP DATA TO TAPE
#################
#echo "Backup TO DAT Start Time                          => `date`"	>>$LOG

#cd $BACKUP
#tar cf /dev/rmt/0 *.Z

#################
# 6.TEMPORARY REMOTE COPY TO FALCON (/backup2/hestia)
#################
echo "Backup TO FALCON Start Time                        => `date`"	>>$LOG

rcp -p hestia:/var/backup/*.Z falcon:/backup2/hestia/.

echo "Backup Procedure End Time                         => `date`"       >>$LOG

#################
# 7. BACKUP TO HERMES
#################
echo "Backup To HERMES Start Time		=> `date`"	>>$LOG

rcp -p /var/backup/*.Z hermes:/usr/local/backup/hestia/.

echo "Backup Procedure End Time			=> `date`"	>>$LOG      

################
# 8. BACKUP LATEST LOG_BACKUP to HERMES
################
 
rcp -p hestia:/home/log/log.backup hermes:/usr/local/backup/hestia/.
rcp -p hestia:/home/log/lg2.backup hermes:/usr/local/backup/hestia/.
rcp -p hestia:/home/log/lg2.df hermes:/usr/local/backup/hestia/.

################
# 9. BACKUP DF information to HERMES
################

rcp -p hestia:/home/log/log.df hermes:/usr/local/backup/hestia/.

