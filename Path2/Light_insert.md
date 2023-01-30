# RaspberryPi & MySQL #

  Projects that demonstrate C code programming skills 

- [RaspberryPi \& MySQL](#raspberrypi--mysql)
  - [Main objectives](#main-objectives)
    - [PHOTO](#photo)
    - [Description](#description)
    - [MYSQL settings](#mysql-settings)
    - [Raspberry Pi](#raspberry-pi)


## Main objectives ##



### PHOTO ###

<img src="lux.png" alt="lux" width="300"/>

### Description ###

- Light Sensor BH1750 - I2C interface
- Program inserts next lux value and show all records

### MYSQL settings ###

- logging: 
  
    <p><code> mysql -u root -p </p></code>

- creating database: 

    <p><code>CREATE DATABASE measurment;</code></p>

- creating table: 

    <p><code>CREATE TABLE light(lp SERIAL, luxlevel REAL);</code></p>

- creating user: 

    <p><code>CREATE USER 'bh1750'@'localhost' IDENTIFIED BY 'lux';</code></p>

 - user privileges:

    <p><code>GRANT INSERT, SELECT ON measurment.light TO 'bh1750'@'localhost';</code></p>

### Raspberry Pi ###

- Electrical diagram


    <p><img src="i2c.png" alt="electrical" width="500"/></p>


- Find sensor address:
    <p><code> i2cdetect -y 1 </p></code>

- Install MariaDB Connector/C:
    <p><code> sudo apt install libmariadb3 libmariadb-dev </p></code>
    
    You can check version by typing:

    - <p>logging: <code> mariadb -u root -p </p></code>
    - <p> password: ****** </p>
    - <p>type: <code> SELECT @@VERSION </p></code>

- copy C code
  
- compilation: 
  <p><code> gcc light_insert.c -o light_insert -lwiringPi -lmysqlclient </p></code>
- run code:
   <p><code> ./light_insert </p></code>
