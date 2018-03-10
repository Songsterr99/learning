#include <stdio.h>
#include <stdlib.h>
#include <sqlite3.h>

sqlite3 *db = NULL;
char *errMsg = {0};

void UI() {
  printf("MENU:\n");
  printf("0 - to print photo.\n" );
	printf("1 - to insert data.\n");
	printf("2 - to print data.\n");
	printf("3 - to delete data.\n");
	printf("4 - EXIT. \n");
}

void select_UI(){
  printf("Select by:\n");
  printf("1 - id\n");
  printf("2 - surname\n");
  printf("3 - country\n");
}


void sql_execute(char command[500]){
  if(sqlite3_exec(db, command, 0, 0, &errMsg) != SQLITE_OK){
    printf("SQL error: %s\n", errMsg );
    sqlite3_free(errMsg);
  }
}

void insert(){

  printf("Employee:\n");

  int index = 0;
  printf("1-fill main data\n2-fill full data\n");
  scanf("%d",&index );

  char name[20];
  printf("Name:\n" );
  scanf("%s", name);

  char surname[20];
  printf("Surname:\n" );
  scanf("%s", surname);

  char patronymic[20];
  printf("Patronymic:\n" );
  scanf("%s", patronymic);

  char command[500] = {0};
  if(index == 1){
      sprintf(command, "insert into Employees(Name, Surname, Patronymic) values('%s', '%s','%s')",name, surname, patronymic);
      sql_execute(command);
      return;
  }

  char birthDate[20];
  printf("Birthday date(DD.MM.YYYY):\n" );
  scanf("%s", birthDate);

  char hiringDate[20];
  printf("Hiring date(DD.MM.YYYY):\n" );
  scanf("%s", hiringDate);

  char department[20];
  printf("Department: \n" );
  scanf("%s", department);

  char position[20];
  printf("Position: \n" );
  scanf("%s", position);

  char street[20];
  printf("Street: \n" );
  scanf("%s", street);

  char city[20];
  printf("City: \n" );
  scanf("%s", city);

  char country[20];
  printf("Country: \n" );
  scanf("%s", country);

  char path[40];
  printf("Path to the file: \n" );
  scanf("%s", path);



  sprintf(command, "insert into Departments (Department) values ('%s');", department);
  sqlite3_exec(db, command, 0, 0, &errMsg);

  sprintf(command, "insert into Positions (Position, Department_ID)\
   values ('%s', (select id from Departments where Department='%s'));",
   position, department);
  sqlite3_exec(db, command, 0, 0, &errMsg);

  sprintf(command,"insert into Countries (Country) values ('%s');", country);
  sqlite3_exec(db, command, 0, 0, &errMsg);

  sprintf(command, "insert into Cities (City, Country_ID)\
   values ('%s', (select id from Countries where Country='%s'));",
   city, country);
  sqlite3_exec(db, command, 0, 0, &errMsg);

  sprintf(command, "insert into Address (Street, City_ID)\
   values ('%s', (select id from Cities where City='%s'));",
   street, city);
  sqlite3_exec(db, command, 0, 0, &errMsg);



  sprintf(command, "insert into Employees(Name, Surname, Patronymic, BirthDate, HiringDate, Position_ID, Address_ID, Image)\
   values ('%s', '%s', '%s', '%s', '%s', ( select id from Positions \
   where Position='%s' and Department_ID=(select id from Departments where Department='%s')), ( select id from Address \
   where Street='%s' and City_ID=(select id from Cities where City='%s')), ?);",
   name, surname, patronymic, birthDate, hiringDate, position, department, street, city);

  FILE *fp = fopen(path, "rb");
  int rc;
  if (fp == NULL) {
    printf("Cannot open image file\n");
    return;
  }

  fseek(fp, 0, SEEK_END);
  int flen = (int)ftell(fp);
  fseek(fp, 0, SEEK_SET);

  char data[flen+1];
  int size = (int)fread(data, 1, flen, fp);
  if (ferror(fp)) {
    printf("fread() failed\n");
    return;
  }
  fclose(fp);

  sqlite3_stmt *pStmt;
  if (sqlite3_prepare(db, command, -1, &pStmt, 0) != SQLITE_OK) {
     printf("Cannot prepare statement: %s\n", sqlite3_errmsg(db));
     return;
  }
  sqlite3_bind_blob(pStmt, 1, data, size, SQLITE_STATIC);
  if (sqlite3_step(pStmt) != SQLITE_DONE) {
     printf("execution failed: %s", sqlite3_errmsg(db));
  } else {
     printf("Input succeed\n");
  }

  sqlite3_finalize(pStmt);

  //sql_execute(command);

}

int callback(void *NotUsed, int argc, char **argv, char **azColName) {
    for (int i = 0; i < argc; i++) {
        printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
    }
    printf("\n");
    return 0;
}

void select_id(){
  int id = 0;
  printf("Your id:\n");
  scanf("%d", &id);
  char command[250] = {0};
  sprintf(command, "Select e.Name, e.Surname, e.Patronymic, e.BirthDate, e.HiringDate, e.Street, p.Position from \
  (Select * from Employees as e1 inner join Address as a on e1.Address_ID=a.ID )\
  as e inner join Positions as p on e.Position_ID=p.ID where e.id=%d ", id);
  sqlite3_exec(db, command, callback, 0, &errMsg);

}

void select_surname(){
  char surname[20];
  printf("Your surname:\n");
  scanf("%s", surname);
  char command[250] = {0};
  sprintf(command, "Select Name, Surname, Patronymic, BirthDate, HiringDate from Employees where Surname='%s'", surname);
  sqlite3_exec(db, command, callback, 0, &errMsg);

}

void select_country(){
  char country[20];
  printf("Your country:\n");
  scanf("%s", country);
  char command[250] = {0};
  sprintf(command, "Select Name, Surname, Patronymic, BirthDate, HiringDate from Employees \
  where Address_ID=( select id from Address \
    where City_ID=(select id from Cities\
       where Country_ID=(select id from Countries where Country='%s')))", country);
  sqlite3_exec(db, command, callback, 0, &errMsg);
}

void select(){
  select_UI();
  int ind = 0;
  scanf("%d", &ind);
  switch (ind) {
    case 1:
      select_id();
      break;
    case 2:
      select_surname();
      break;
    case 3:
      select_country();
      break;
    default:
      break;
  }
}

void delete(){
  int id = 0;
  printf("Your id:\n");
  scanf("%d", &id);
  char command[250] = {0};
  sprintf(command, "delete from Employees where id=%d ", id);
  sqlite3_exec(db, command, 0, 0, &errMsg);
}

void print_photo( ){
  int id = 0;
  printf("Your id:\n");
  scanf("%d", &id);

  FILE *fp = fopen("photo.jpg", "wb");
  if (fp == NULL) {
    printf("Cannot open image file\n");
    return;
  }


  char command[250] = {0};
  sprintf(command, "Select Image from Employees where id=%d ", id);

  sqlite3_stmt *pStmt;
  int  rc = sqlite3_prepare_v2(db, command, -1, &pStmt, 0);

  if (rc != SQLITE_OK ) {
    printf("Failed to prepare statement\n");
    sqlite3_close(db);
    return;
  }

  rc = sqlite3_step(pStmt);

  int bytes = 0;

  if (rc == SQLITE_ROW) {
    bytes = sqlite3_column_bytes(pStmt, 0);
  }

  fwrite(sqlite3_column_blob(pStmt, 0), bytes, 1, fp);

  if (ferror(fp)) {
    printf( "fwrite() failed\n");
    return ;
  }

  fclose(fp);
  sqlite3_finalize(pStmt);
}

int main(int argc, char* argv[]) {
   if(sqlite3_open("Employees.db", &db)) {
      fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
      return 1;
   }
   int cur = -1;
   while (cur != 4) {
     UI();
     scanf("%d", &cur);
     switch (cur) {
       case 0:
         print_photo();
         break;
       case 1:
         insert();
         break;
       case 2:
         select();
         break;
       case 3:
         delete();
         break;
       default:
         break;
     }

   }
   sqlite3_close(db);
   return 0;
}
