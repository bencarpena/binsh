#!/bin/csh
##############################################################
#                                                            #
#           DATABASE Startup Shell                           #
#                                                            #
##############################################################
 
setenv	ORACLE_HOME	/usr/local/oracle8i
setenv	ORACLE_SID	$1
setenv	ORACLE_DOC	$ORACLE_HOME/doc
setenv	LD_LIBRARY_PATH	$ORACLE_HOME/lib

$ORACLE_HOME/bin/svrmgrl << EOF
connect internal
startup
exit
EOF
