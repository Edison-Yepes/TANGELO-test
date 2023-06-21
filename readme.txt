In order to create the database, you need the datasets
contained in the folder `data`. To create the database
follow these steps:

1. Open your terminal in this folder and execute that file running
the command `./docker_executable.sh`.

2. Once the docker container is up and running, you shold check on wich
host the connection is being held, use this command to get the IP address
of the container:
    `ip addr show docker0 | grep -Po 'inet \K[\d.]+'`

3. Test your connection. In other terminal you should be able to
connect to the database being held in the docker container, for that you may
test the connection using the command
    `mysql -h <docker_host_ip> -P 5555 -u root`
then inside the mysql CLI you may specify the database using:
    `USE your_database_name;`
and finally getting the tables that where just created running:
    `SHOW TABLES;`

Once these steps have worked, you are free to continue with the exercise
as you see best. Remember, YOU MUST USE THIS CONNECTION to create your data
platform.

Best of lucks and have fun!