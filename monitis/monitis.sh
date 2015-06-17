#!/bin/bash
# $Id: app.sh 314274 2004-05-24 21:04:46Z geiseri $
# monitis - Copyright (C) 2007 Monitis Inc. <support@monitis.com>


MONITIS_CONF="/etc/monitis.conf"
REWRITE_CONF=0


user_email=""
monitis_home=""
monitis_log=""
monitis_fpid=""
agent_name=""
monitis_host="https://internalmon.itor.us/fcgi-bin/agentgateway"

echo -e '\E[33;46m\033[1m\n\n\t\tMONITIS SMART AGENT\n\033[0m'
tput sgr0

home_detect()
{
	if [ ! -z $monitis_home ]
	then echo -en "\nCurrently used home directory is $monitis_home"
	fi

	echo -ne "\nEnter new path to the monitis home directory or\npress Enter if it is the current one\n: "
	read ANS
	if [ -z $ANS ]
	then ANS=$PWD 
	fi
	echo -n "$ANS   "
	if [ -f "$ANS/bin/monitis" ]
	then
	{
		echo -e 'OK\n'
		monitis_home="$ANS"
	}
	else
	{
		echo -e 'NOK\nCheck for monitis correct home path and re-configure it.\n'
		exit 1
	}
	fi
}

user_init()
{
	if [ ! -z $user_email ]
	then 
		echo -en "\nCurrently used e-mail address $user_email"
		echo -en "\nInsert a newly registered Monitis username(e-mail) or press Enter to leave it as it is\n: "
	else
		echo -en "Enter your Monitis username(e-mail)\n: "
	fi

	read ANS
	if [ ! -z $ANS ]
	then user_email=$ANS
	fi

	if [ -z $user_email ]
	then
	{
		echo -e "\nWizard was terminated.\n\n"
		exit 1
	}
	fi

	if [ -z $agent_name ]
	then agent_name="`uname -n`@`date -u +%d:%m:%Y:%H:%M:%S`"
	fi

	echo -en "\nEnter new name for Monitis agent or\npress Enter to use $agent_name \n: "
	read ANS
	if [ ! -z $ANS ]
	then
		agent_name=$ANS
	fi
}

host_init()
{
	if [ ! -z $monitis_host ]
	then echo -en  "\nCurrently used Host address: $monitis_host"
	fi
	
	echo -en "\nEnter new host address or press Enter to leave it as it is (do not change if you are not sure)\n: "
	
	read ANS
	if [ ! -z $ANS ]
	then
		monitis_host=$ANS
	fi

}

monitis_config()
{
	MONITIS_CONF="$PWD$MONITIS_CONF"

	if [ -f $MONITIS_CONF ]
	then
	{
		email_init
		default_init
	}
	fi



	echo -e "\nStarting Configuration..."
	home_detect
	user_init
	host_init

	if [ -d "$monitis_home/logs" ]
	then echo -e "\nlogs directory has been already created."
	else mkdir "$monitis_home/logs"
	fi

	if [ -d "$monitis_home/etc" ]
	then echo -e "\netc directory has been already created."
	else mkdir "$monitis_home/etc"
	fi

	REWRITE_CONF=1

	if [ -z $monitis_log ]
	then monitis_log="$PWD/logs/monitis.log"
	fi

	if [ -z $monitis_fpid ]
	then monitis_fpid="$PWD/logs/monitis.pid"
	fi

	write_conf_file

	echo -e '\nConfiguration was completed successfully!\n\n'
}

get_pid()
{
	monitis_pid="0"
	if test ! -f $MONITIS_CONF;then return 1;fi
	pid_file=`grep -w "PIDFILE" $MONITIS_CONF`
	if test -z "$pid_file";then return 1;fi
	pid_file=${pid_file#"PIDFILE"}
	if test -z "$pid_file";then return 1;fi
	if test ! -f $pid_file;then return 1;fi
	monitis_pid=`head -n 1 $pid_file`
}

monitis_status()
{
	if [ $monitis_pid == "0" ] 
	then return 1; 
	fi

	if kill -0 $monitis_pid 2>/dev/null
		then return 0
	else return 1
	fi
}

email_init()
{
	user_email=`grep '^USEREMAIL' $MONITIS_CONF`
	user_email=${user_email#"USEREMAIL"}
	user_email=${user_email// /}
	user_email=${user_email//   /}
	if [ -z "$user_email" ]
	then return 1
	else return 0
	fi
}

main_init()
{
	MONITIS_CONF="$PWD$MONITIS_CONF"


	if [ ! -f $MONITIS_CONF ]
	then 
	{
		echo -e "\nFile: $MONITIS_CONF was not found\nTry to configure it first\n\n"
		return 1
	}
	fi


	if ! email_init
	then
	{
		echo -e "\nUSEREMAIL was not specified.\nTry to configure it first\n\n"
		return 1
	}
	fi

	return 0
}

default_init()
{
	monitis_home=`grep '^MONITISHOME' $MONITIS_CONF`
	monitis_home=${monitis_home#"MONITISHOME"}
	monitis_home=${monitis_home// /}
	monitis_home=${monitis_home//   /}
	if [ -z "$monitis_home" ]
	then
	{
		REWRITE_CONF=1
		monitis_home=$PWD
	}
	fi

	monitis_log=`grep '^LOGFILE' $MONITIS_CONF`
	monitis_log=${monitis_log#"LOGFILE"}
	monitis_log=${monitis_log// /}
	monitis_log=${monitis_log//	/}
	if [ -z "$monitis_log" ]
	then
	{
		REWRITE_CONF=1
		monitis_log="$PWD/logs/monitis.log"
	}
	fi

	monitis_fpid=`grep '^PIDFILE' $MONITIS_CONF`
	monitis_fpid=${monitis_fpid#"PIDFILE"}
	monitis_fpid=${monitis_fpid// /}
	monitis_fpid=${monitis_fpid//	/}
	if [ -z "$monitis_fpid" ]
	then
	{
		REWRITE_CONF=1
		monitis_fpid="$PWD/logs/monitis.pid"
	}
	fi

	agent_name=`grep '^AGENTNAME' $MONITIS_CONF`
	agent_name=${agent_name#"AGENTNAME"}
	agent_name=${agent_name// /}
	agent_name=${agent_name//	/}
	if [ -z "$agent_name" ]
	then
	{
		REWRITE_CONF=1
		agent_name=`uname -n`
		if [ -z "$agent_name" ]
		then 
			agent_name="Unknown"
		fi
		agent_name="$agent_name@`date -u +%d:%m:%Y:%H:%M:%S`"
	}
	fi

	monitis_host=`grep '^USEHOST' $MONITIS_CONF`
	monitis_host=${monitis_host#"USEHOST"}
	monitis_host=${monitis_host// /}
	monitis_host=${monitis_host//	/}
}

write_conf_file()
{
	if [ $REWRITE_CONF == 1 ]
	then
	{
		echo "MONITISHOME $monitis_home" >  $MONITIS_CONF
		echo "LOGFILE     $monitis_log"  >> $MONITIS_CONF
		echo "PIDFILE     $monitis_fpid" >> $MONITIS_CONF
		echo "USEREMAIL   $user_email"   >> $MONITIS_CONF
		echo "AGENTNAME   $agent_name"   >> $MONITIS_CONF

		if [ ! -z "$monitis_host" ]
		then
		echo "USEHOST     $monitis_host" >> $MONITIS_CONF
		fi
	}
	fi
}

monitis_start()
{
	if monitis_status > /dev/null
	then 
		echo -e "\nmonitis process is already exists ( process ID: $monitis_pid )\n\n"
		return
	fi
		
	
	echo -e '\nStarting monitis...\n'
	
	monitis_exec="$monitis_home/bin/monitis"
	if [ -f monitis_exec ]
	then
	{
		echo -e "\nExecutable file $monitis_exec was not found.\nExiting.\n\n"
		exit 1
	}
	fi

	if [ ! -d $monitis_home/logs ]
	then mkdir $monitis_home/logs
	fi


	$monitis_exec -C $MONITIS_CONF


	echo -ne '\nWaiting for monitis to start .'
	for i in 1 2 3 4 5 6 7 8 9 10; do
		get_pid
		if monitis_status > /dev/null
		then echo -e "done\n\nmonitis process was started with process ID: $monitis_pid\n\n";break
		else echo -n ' .'; sleep 1
		fi
	done

}

monitis_stop()
{
	if ! monitis_status > /dev/null
	then 
		echo -e "\nmonitis process does not exists\n\n";
		return;
	fi

	kill -1 $monitis_pid

	echo -ne '\nShutting down monitis...\nWaiting for monitis to exit .'
	for i in 1 2 3 4 5 6 7 8 9 10; do
		if monitis_status > /dev/null
		then echo -n ' .';sleep 1
		else break
		fi
	done

	if monitis_status > /dev/null
	then echo -e '\nWarning - monitis process can not be stopped in time\n\n'
	else echo -e 'done.\n\n'
	fi		
		
}


show_conf()
{
	echo -e "\nMain Configuration\n\n"

	if [ -r $PWD/etc/monitis.conf ]
	then
		echo -e "`cat $PWD/etc/monitis.conf`"
	else
		echo -e "Not found!\nTry to configure first."
	fi

	echo -e "\n\n"
}


cd `dirname $0`


case "$1" in
	conf)
		monitis_config
		;;
	start)
		if ! main_init
		then exit 1
		fi
		default_init
		write_conf_file
		get_pid
		monitis_start
		;;
	stop)
		if ! main_init
		then exit 1
		fi
		get_pid
		monitis_stop
		;;
	restart)
		if ! main_init
		then exit 1
		fi
		default_init
		get_pid
		monitis_stop
		monitis_start
		;;
	status)
		if ! main_init
		then exit 1
		fi
		get_pid
		if monitis_status > /dev/null
		then echo -e "\nRunning ( process ID: $monitis_pid )\n\n"
		else echo -e "\nStopped\n\n"
		fi
		;;
	show)
		show_conf
		;;
	log)
		if main_init
		then default_init
		else exit 1
		fi
		if [ -z $2 ]
		then
			line_cnt=100
		else
			line_cnt=$2
		fi
		tail -f -n $line_cnt $monitis_log
		;;
	*)
	echo $"Usage: $0 {conf|start|stop|restart|status|show|log}"
	cat<<EOF

	conf	run configuration wizard
	start	start monitis
	stop	stop  monitis
	restart	stop if running and start again 
	status	show monitis current status
	show    show main configuration
	log     open log file with 'tail -f'. 
	        Specify line count or use default value: 100

EOF
	ERROR=2
		;;
esac

exit $?
