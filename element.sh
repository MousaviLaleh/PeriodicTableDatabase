#!/bin/bash
# PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
PSQL="psql -X -h localhost -p 54321 -U postgres --dbname=periodic_table --tuples-only -c"

echo -e "\n~~~~ Periodic Table ~~~~\n"

if [[ -z $1 ]]
then
  echo -e "\nPlease provide an element as an argument."
fi

# if input is a number
if [[ $1 =~ ^[1-9]+$ ]]
then
  ELEMENT=$($PSQL "SELECT atomic_number, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name 
                   FROM properties JOIN elements USING (atomic_number) 
                   JOIN types USING (type_id) 
                   WHERE atomic_number = $1 ")

# if input is a string
else
  ELEMENT=$($PSQL "SELECT atomic_number, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name 
                   FROM properties JOIN elements USING (atomic_number) 
                   JOIN types USING (type_id) 
                   WHERE name = '$1' OR symbol = '$1' ")

fi

#If element not found:
if [[ -z $ELEMENT ]]
then
  echo -e "I could not find that element in the database."
  exit
fi

echo $ELEMENT | while IFS=" |" read ATOMIC_NUMBER TYPE MASS MELTING_POINT BOILING_POINT SYMBOL NAME
do
  echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
done