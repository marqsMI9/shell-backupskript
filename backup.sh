#!/bin/bash

# Backupscript
# Author : Markus Rößler
# E-Mail : roesslerma@mail-elektronikschule.de
# Version: version 1


function menu(){
	clear
	echo "|----------------------------------------------|"
	echo "| Haupmenu:                                    |"
	echo "|                                              |"
	echo "|      Backup erstellen:      B                |"
	echo "|      Inhalt eines Backups:  L                |"
	echo "|      Backup zurück spielen: R                |"
	echo "|      Backup löschen:        D                |"
	echo "|      Programm beenden:      X                |"
	echo "|                                              |"
	read -p "| Eingabe: " EINGABE
}


function compress(){
	clear
	echo "|----------------------------------------------|"
	echo "| Kompressionsmenü:                            |"
	echo "|                                              |"
	echo "|      ZIP:                   z                |"
	echo "|      BZIP2:                 j                |"
	echo "|      XZ:                    J                |"
	echo "|                                              |"
	read -p "| Eingabe: " COMPRESS
}

function where2Backup(){
	clear
	echo "|----------------------------------------------|"
	echo "| Wo soll das Backup gespeichert werden:       |"
	echo "|                                              |"
	read -p "| Eingabe: " WHERE2BACKUP 
}

function what2Backup(){
	clear
	echo "|----------------------------------------------|"
	echo "| Was soll im Backup gespeichert werden:      |"
	echo "|                                              |"
	read -p "| Eingabe: " WHAT2BACKUP 
}

function whichBackuplist(){
    clear
    echo "|----------------------------------------------|"
	echo "| Welches Backup soll gelisted werden:         |"
	echo "|                                              |"
	read -p "| Eingabe: " WHICHBACKUPLIST
}

function backup(){
    DATEINAME
	echo "BACKUP"

	YESNO=0

	until [ $YESNO = 1 ]
	do
        compress
        echo "Sind Sie sich sicher, dass Sie die Option $COMPRESS ausführen wollen?"
        read -p "0: nein | 1: ja" YESNO
    done

    YESNO=0

	until [ $YESNO = 1 ]
	do
        where2Backup
        echo "Sind Sie sich sicher, dass Sie in $WHERE2BACKUP speichern wollen?"
        read -p "0: nein | 1: ja" YESNO
    done

    YESNO=0

	until [ $YESNO = 1 ]
	do
        what2Backup
        echo "Sind Sie sich sicher, dass Sie $WHAT2BACKUP als Backup erstellen wollen?"
        read -p "0: nein | 1: ja" YESNO
    done
    echo "tar cf - $(COMPRESS) I pv I gzip > $(WHERE2BACKUP)/, $WHAT2BACKUP"
    sleep 5
}

function unbackup(){
	echo "UNBACKUP"
}

function listbackup(){
	echo "LISTBACKUP"

	YESNO=0

	until [ $YESNO = 1 ]
	do
        whichBackuplist
        echo "Sind Sie sich sicher, dass Sie das Backup $WHICHBACKUPLIST gelistet haben wollen?"
        read -p "0: nein | 1: ja" YESNO
    done
    echo "tar -tf $WHICHBACKUPLIST"
    sleep 5
}

function deletebackup(){
	echo "DELETEBACKUP"
}

while :
do
	menu
	case $EINGABE in
		b|B)
			backup
			;;
		r|R)
			unbackup
			;;
		l|L)
			listbackup
			;;
		d|D)
			deletebackup
			;;
		*)
			echo "Und Tschüss!"
			exit 1
	esac
	sleep 2
done

exit 0

