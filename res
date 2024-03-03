mysql> use VOLBD;
ERROR 1049 (42000): Unknown database 'volbd'
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| bdvol              |
| centre_formation   |
| djallaba           |
| information_schema |
| isgi               |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| test               |
| vlog               |
| world              |
| zata               |
+--------------------+
13 rows in set (0.03 sec)

mysql> use bdvol;
Database changed
mysql> select * from avion order by nom;
Empty set (0.02 sec)

mysql> desc avion;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| ID_A     | int         | NO   | PRI | NULL    |       |
| Nom      | varchar(10) | YES  |     | NULL    |       |
| capacite | int         | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
3 rows in set (0.04 sec)

mysql> alter table avion
    -> add localite varchar(10);
Query OK, 0 rows affected (0.20 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc avion;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| ID_A     | int         | NO   | PRI | NULL    |       |
| Nom      | varchar(10) | YES  |     | NULL    |       |
| capacite | int         | YES  |     | NULL    |       |
| localite | varchar(10) | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> insert into avion
    -> values
    -> (100,'AIRBUS',300,'RABAT'),
    -> (101,'B737',250,'CASA'),
    -> (102,'B737',220,'RABAT');
Query OK, 3 rows affected (0.03 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select * from avion order by nom;
+------+--------+----------+----------+
| ID_A | Nom    | capacite | localite |
+------+--------+----------+----------+
|  100 | AIRBUS |      300 | RABAT    |
|  101 | B737   |      250 | CASA     |
|  102 | B737   |      220 | RABAT    |
+------+--------+----------+----------+
3 rows in set (0.00 sec)

mysql> select avion,capacite from avion;
ERROR 1054 (42S22): Unknown column 'avion' in 'field list'
mysql> SELECT nom,capacite FROM avion;
+--------+----------+
| nom    | capacite |
+--------+----------+
| AIRBUS |      300 |
| B737   |      250 |
| B737   |      220 |
+--------+----------+
3 rows in set (0.00 sec)

mysql> SELECT DISTINCT localite FROM avion;
+----------+
| localite |
+----------+
| RABAT    |
| CASA     |
+----------+
2 rows in set (0.00 sec)

mysql> SELECT * FROM avion WHERE localite IN('RABAT,'CASA');
    '> ';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'CASA');
'' at line 1
mysql> SELECT * FROM avion WHERE localite IN('RABAT','CASA');
+------+--------+----------+----------+
| ID_A | Nom    | capacite | localite |
+------+--------+----------+----------+
|  100 | AIRBUS |      300 | RABAT    |
|  101 | B737   |      250 | CASA     |
|  102 | B737   |      220 | RABAT    |
+------+--------+----------+----------+
3 rows in set (0.00 sec)

mysql> UPDATE avion SET capacite = 220 WHERE ID_A=101;
Query OK, 1 row affected (0.02 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM avion WHERE capacite< 200;
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT MAX(capacite) AS MAXcapacite, MIN(capacite) AS Mincapacite, AVG(capacite) AS moyenneCapacite FROM avion;
+-------------+-------------+-----------------+
| MAXcapacite | Mincapacite | moyenneCapacite |
+-------------+-------------+-----------------+
|         300 |         220 |        246.6667 |
+-------------+-------------+-----------------+
1 row in set (0.01 sec)

mysql> SELECT * FROM avion WHERE capacite = (SELECT MIN(capacite) from avion);
+------+------+----------+----------+
| ID_A | Nom  | capacite | localite |
+------+------+----------+----------+
|  101 | B737 |      220 | CASA     |
|  102 | B737 |      220 | RABAT    |
+------+------+----------+----------+
2 rows in set (0.01 sec)

mysql> SELECT * FROM avion where capacite>(select AVG(capacite) from avion);
+------+--------+----------+----------+
| ID_A | Nom    | capacite | localite |
+------+--------+----------+----------+
|  100 | AIRBUS |      300 | RABAT    |
+------+--------+----------+----------+
1 row in set (0.00 sec)
mysql> select nom,adresse from pilote join vol on pilote.ID_P = vol.ID_P where vol.ID_V in ('IT100','IT104');
+-----------+---------+
| nom       | adresse |
+-----------+---------+
| SOULAIMAN | CASA    |
| ZATA      | FES     |
+-----------+---------+
2 rows in set (0.00 sec)

mysql> select ID_P from pilote
    -> where ID_P in (select ID_P from vol);
+------+
| ID_P |
+------+
|  444 |
|  555 |
+------+
2 rows in set (0.00 sec)

mysql> select ID_P from pilote
    -> where ID_P not in (select ID_P from vol);
Empty set (0.01 sec)
