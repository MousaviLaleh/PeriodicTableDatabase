# Periodic Table Database


## Instructions

You are started with a periodic_table database that has information about some chemical elements. <br/>
Connect to your database using Bash terminal. Your database has initial tables as below:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Read the instructions below and complete user stories to finish the project. <br/>
Part 1: Fix the database<br/>
There are some mistakes in the database that need to be fixed or changed. See the user stories below for what to change.
<br/>

Part 2: Create your git repository<br/>
You need to make a small bash program. The code needs to be version controlled with git, so you will need to turn the suggested folder into a git repository.
<br/>

Part 3: Create the script<br/>
Lastly, you need to make a script that accepts an argument in the form of an atomic number, symbol, or name of an element and outputs some information about the given element. In your script, you should create a PSQL variable for querying the database like this:<br/>
`PSQL="psql --username=<your_postgres_username> --dbname=<database_name> -t --no-align -c"` <br/>
add more flags if you need to.


## Complete the tasks below** 

You should rename the weight column to atomic_mass 
~~~~~~~~~~~~~~~~~~~~~~~~~~
ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
~~~~~~~~~~~~~~~~~~~~~~~~~~


You should rename the melting_point column to melting_point_celsius and the boiling_point column to boiling_point_celsius
~~~~~~~~~~~~~~~~~~~~~~~~~~
ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;
~~~~~~~~~~~~~~~~~~~~~~~~~~


Your melting_point_celsius and boiling_point_celsius columns should not accept null values
~~~~~~~~~~~~~~~~~~~~~~~~~~
ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL; 
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;
~~~~~~~~~~~~~~~~~~~~~~~~~~


You should add the UNIQUE constraint to the symbol and name columns from the elements table 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ALTER TABLE elements ADD UNIQUE(symbol);
ALTER TABLE elements ADD UNIQUE(name);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Your symbol and name columns should have the NOT NULL constraint
~~~~~~~~~~~~~~~~~~~~~~~~~~
ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL; 
ALTER TABLE elements ALTER COLUMN name SET NOT NULL;
~~~~~~~~~~~~~~~~~~~~~~~~~~


You should set the atomic_number column from the properties table as a foreign key that references the column of the same name in the elements table
~~~~~~~~~~~~~~~~~~~~~~~~~~
ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number);
~~~~~~~~~~~~~~~~~~~~~~~~~~


You should create a types table that will store the three types of elements <br/>
Your types table should have a type_id column that is an integer and the primary key  <br/>
Your types table should have a type column that's a VARCHAR and cannot be null.It will store the different types from the type column in the properties table
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CREATE TABLE types(type_id INT PRIMARY KEY, type VARCHAR(20) NOT NULL); 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


You should add three rows to your types table whose values are the three different types from the properties table
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INSERT INTO types(type_id, type) VALUES(1, 'metal'), (2, 'nonmetal'), (3, 'metalloid');
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Your properties table should have a type_id foreign key column that references the type_id column from the types table. It should be an INT with the NOT NULL constraint  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INSERT INTO types(type_id, type) VALUES(0, ''); 
ALTER TABLE properties ADD COLUMN type_id INT NOT NULL DEFAULT(0);
ALTER TABLE properties ADD FOREIGN KEY(type_id) REFERENCES types(type_id);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Each row in your properties table should have a type_id value that links to the correct type from the types table
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
UPDATE properties p SET type_id=(SELECT type_id FROM types WHERE type=p.type);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


You should capitalize the first letter of all the symbol values in the elements table. Be careful to only capitalize the letter and not change any others 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
UPDATE elements SET symbol = INITCAP(symbol);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


You should remove all the trailing zeros after the decimals from each row of the atomic_mass column. You may need to adjust a data type to DECIMAL for this. The final values they should be are in the atomic_mass.txt file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;
UPDATE properties SET atomic_mass=TRIM(TRAILING '0' FROM CAST(atomic_mass AS TEXT))::DECIMAL;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


You should add the element with atomic number 9 to your database. Its name is Fluorine, symbol is F, mass is 18.998, melting point is -220, boiling point is -188.1, and it's a nonmetal
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INSERT INTO elements(atomic_number, symbol, name) VALUES(9, 'F', 'Fluorine');
INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
            VALUES(9, 'nonmetal', 18.998, -220, -188.1, 2);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


You should add the element with atomic number 10 to your database. Its name is Neon, symbol is Ne, mass is 20.18, melting point is -248.6, boiling point is -246.1, and it's a nonmetal
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
INSERT INTO elements(atomic_number, symbol, name) VALUES(10, 'Ne', 'Neon');
INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
            VALUES(10, 'nonmetal', 20.18, -248.6, -246.1, 2);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


You should create a periodic_table folder in the project folder and turn it into a git repository with git init  <br/>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mkdir periodic_table
cd periodic_table
git init   
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Your repository should have a main branch with all your commits
~~~~~~~~~~~~~~~~~~~~~
git checkout -b main
~~~~~~~~~~~~~~~~~~~~~


Your periodic_table repo should have at least five commits
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
touch README.md
git add .
git commit -m "Initial commit"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


You should create an element.sh file in your repo folder for the program I want you to make
~~~~~~~~~~~~~~~~~
touch element.sh
~~~~~~~~~~~~~~~~~


Your script (.sh) file should have executable permissions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
chmod +x element.sh
git add .
git commit -m "Add element.sh file"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



If you run ./element.sh, it should output only Please provide an element as an argument. and finish running. <br/>
If you run `./element.sh 1`, `./element.sh H`, or `./element.sh Hydrogen`, it should output only The element with atomic number 1 is Hydrogen (H). <br/> Like this: <br/>
`It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.` <br/>

If you run ./element.sh script with another element as input, you should get the same output but with information associated with the given element. <br/>
If the argument input to your element.sh script doesn't exist as an atomic_number, symbol, or name in the database, the only output should be I could not find that element in the database. The message for the first commit in your repo should be Initial commit <br/>


The rest of the commit messages should start with `fix:`, `feat:`, `refactor:`, `chore:`, or `test:`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- after writing the first version of your code
git add .
git commit -m "feat: add the script"


- after testing your code and finalizing
git add .
git commit -m "feat: test the script"


- last commit. you can add some data into your README file
git commit -m "feat: edit README and add the rpojet instruction"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


You should delete the non existent element, whose atomic_number is 1000, from the two tables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DELETE FROM properties WHERE atomic_number=1000;
DELETE FROM elements WHERE atomic_number=1000;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Your properties table should not have a type column
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ALTER TABLE properties DROP COLUMN type;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You should finish your project while on the main branch. Your working tree should be clean and you should not have any uncommitted changes

<br/>
