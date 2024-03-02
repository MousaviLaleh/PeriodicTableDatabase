# Periodic Table Database
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Instructions
You are started with a periodic_table database that has information about some chemical elements. <br/>
Connect to your database using Bash terminal. Your database has initial tables as below:

select * from elements;
 atomic_number | symbol |   name    
---------------+--------+-----------
             1 | H      | Hydrogen
             2 | he     | Helium
             3 | li     | Lithium
             4 | Be     | Beryllium
             5 | B      | Boron
             6 | C      | Carbon
             7 | N      | Nitrogen
             8 | O      | Oxygen
          1000 | mT     | moTanium

select * from properties;
 atomic_number |   type    |  weight   | melting_point | boiling_point 
---------------+-----------+-----------+---------------+---------------
             1 | nonmetal  |  1.008000 |        -259.1 |        -252.9
             2 | nonmetal  |  4.002600 |        -272.2 |          -269
             3 | metal     |  6.940000 |        180.54 |          1342
             4 | metal     |  9.012200 |          1287 |          2470
             5 | metalloid | 10.810000 |          2075 |          4000
             6 | nonmetal  | 12.011000 |          3550 |          4027
             7 | nonmetal  | 14.007000 |        -210.1 |        -195.8
             8 | nonmetal  | 15.999000 |          -218 |          -183
          1000 | metalloid |  1.000000 |            10 |           100


### Read the instructions below and complete user stories to finish the project.
Part 1: Fix the database
There are some mistakes in the database that need to be fixed or changed. See the user stories below for what to change.

Part 2: Create your git repository
You need to make a small bash program. The code needs to be version controlled with git, so you will need to turn the suggested folder into a git repository.

Part 3: Create the script
Lastly, you need to make a script that accepts an argument in the form of an atomic number, symbol, or name of an element and outputs some information about the given element. 
In your script, you should create a PSQL variable for querying the database like this:
PSQL="psql --username=<your_postgres_username> --dbname=<database_name> -t --no-align -c"
add more flags if you need to.


