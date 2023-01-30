#include <stdio.h>
#include <stdlib.h>
#include <wiringPiI2C.h>
#include <wiringPi.h>
#include <mysql/mysql.h>
#include <string.h>

#define ONE_TIME_HIGH_RES_MODE_1  0x21	//hight mode (1lx) BH1750
#define idDev 0x23					            //addr BH1750 (AADR - GND)

// light sensor 
float light_measure(){
	int device; // variable
	
 	if((device = wiringPiI2CSetup(idDev)) == -1)				  //finding device
    printf("ERROR initialize I2C\n BH1750 not found!\n"); //Error handling
	
	int data = wiringPiI2CReadReg16(device,ONE_TIME_HIGH_RES_MODE_1);	//reading 2bytes
	
	float light = ((data >> 8) + ((data & 255) << 8))/1.2 ;		//calculations
 	
 	printf("I2C module BH1750\n");				//result 
	printf("Light level = %.2f lx\n",light);
  
	return light;
} 

  
void finish_with_error(MYSQL *con)
{
  fprintf(stderr, "%s\n", mysql_error(con));
  mysql_close(con);
  exit(1);
}

int main(int argc, char **argv)
{
  
  MYSQL *con = mysql_init(NULL);
    
  if(wiringPiSetup() == -1)	//initialize WiringPi  
		exit(1);
    
  if (con == NULL){
      fprintf(stderr, "%s\n", mysql_error(con));
      exit(1);
  }

  if (mysql_real_connect(con, "localhost", "bh1750", "lux","measurment", 0, NULL, 0) == NULL){
      finish_with_error(con);
  }

  char query[50], x[10];
  
  sprintf(query,"INSERT INTO light (luxlevel) VALUES('%s');",gcvt(light_measure(), 6, x));
  if (mysql_query(con, query))
      finish_with_error(con);
  
  
  if (mysql_query(con, "SELECT * FROM light"))
      finish_with_error(con);
  
   MYSQL_RES *result = mysql_store_result(con);

  if (result == NULL)
      finish_with_error(con);
 
  int num_fields = mysql_num_fields(result);

  MYSQL_ROW row;

  while ((row = mysql_fetch_row(result))){
      for(int i = 0; i < num_fields; i++)
          printf("%s ", row[i] ? row[i] : "NULL");
      printf("\n");
  }

  mysql_free_result(result);

  mysql_close(con);
  exit(0);
}
