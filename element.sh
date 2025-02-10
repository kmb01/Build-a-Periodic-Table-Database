#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

INPUT=$1

if [[ $INPUT =~ ^[0-9] ]]
	then
	#echo testing
	 GET_RESULT_ATOMIC_NUMBER=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where atomic_number = $INPUT")
	if [[ -z $GET_RESULT_ATOMIC_NUMBER ]]
	then
	echo "I could not find that element in the database."
	else
	 echo "$GET_RESULT_ATOMIC_NUMBER" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
		do
		echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
		done
        fi
elif [[ $INPUT =~ ^[A-Z][a-z]{,1}$ ]]
	then
	GET_RESULT_SYMBOL=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where symbol = '$INPUT';")
	if [[ -z $GET_RESULT_SYMBOL ]]
        then
        echo "I could not find that element in the database."
	else
	echo "$GET_RESULT_SYMBOL" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
	do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
        done
        fi
elif [[ $INPUT =~ ^[A-Z][a-z] ]]
	then 
	GET_RESULT_NAME=$($PSQL "select atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where NAME = '$INPUT';")
	if [[ -z $GET_RESULT_NAME ]]
        then
        echo "I could not find that element in the database."
	else
	echo "$GET_RESULT_NAME" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
	 do
         echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
         done
	fi
elif [[ -z $INPUT ]]
	then
        echo Please provide an element as an argument.
else
 	echo "I could not find that element in the database."
fi
