int sold = millis(),s = millis();
int[][] check;
int[][] ar;
int x,y;
boolean kt;


void setup(){
  size(800, 800);
  init();
  ar = new int[6][6];
  check = new int[6][6];
  draw_cell(int(random(1,5)),int(random(1,5)),2);
  spawn_point();
  //draw_cell(3,3,2);
  //draw_cell(3,4,2);
  
}

void draw() {
  if (keyPressed) {
    s = millis();
    if (s-sold>=200){
      sold = millis();
      if (key == 'w' || key == 'W') {
        move("up");
      }else if (key == 's' || key == 'S') {
        move("down");
      }else if (key == 'd' || key == 'D') {
        move("right");
      }else if (key == 'a' || key == 'A') {
        move("left");
      }
    }
  }
}

void init(){
  background(0,0,0);
  strokeWeight(3);
  stroke(255, 255, 255);
  line(200, 0, 200, 800);
  line(400, 0, 400, 800);
  line(600, 0, 600, 800);
  line(0, 200, 800, 200);
  line(0, 400, 800, 400);
  line(0, 600, 800, 600);
}

void spawn_point(){
  if (check_near() == 2){
    boolean state = false;
    while (state == false){
      x = int(random(1,5));
      y = int(random(1,5));
      if (check[x][y] == 0){
        state = true;
      }else{
        state = false;
      }
    }
    draw_cell(x,y,2);
  }else if (check_near() == 0){
    game_over();
  }
}

void game_over(){
  background(0,0,0);
  fill(255, 255, 255);
  textAlign(CENTER, CENTER);
  text("GAME OVER", 400, 400);
  noLoop();
}
int check_near(){
  for (int i=1; i<=4; i++){
    for (int j=1; j<=4; j++){
      if (check[i][j] == 1){
        kt = true;
      }
      else{
        kt = false;
        break;
      }
    }
  }   
  if (kt == true){
    kt = false;
    for (int i=1; i<=4; i++){
      for (int j=1; j<=4; j++){
        if (ar[i][j] == ar[i-1][j] || ar[i][j] == ar[i+1][j] || ar[i][j] == ar[i][j-1] || ar[i][j] == ar[i][j+1]){
          kt = true;
        }
      }
    }
    if (kt == true){
      return 1; //con cach het o
    }else{
      return 0; //het cach het o
    }
  }else{
    return 2; //con o
  }
}

void draw_cell(int cellx, int celly, int value){
  check[cellx][celly] = 1;
  ar[cellx][celly] = value;
  //print(cellx,celly,ar[cellx][celly],"\n");
  if (value < 100){
    textSize(100);
  } else if (value >= 100 && value < 10000){
    textSize(70);
  } else {
    textSize(50);
  } 
  fill(255, 255, 255);
  textAlign(CENTER, CENTER);
  //print(draw_text(cellx), draw_text(celly));
  text(value, draw_text(cellx), draw_text(celly));
}

int draw_text(int x){
  switch (x) {
    case 1:
      return int(100);
    case 2:
      return int(300);
    case 3:
      return int(500);
    case 4:
      return int(700);
  }
  return -100;
}

int draw_rect(int x){
  switch (x) {
    case 1:
      return int(0);
    case 2:
      return int(200);
    case 3:
      return int(400);
    case 4:
      return int(600);
  }
  return -100;
}

void over_write(int x, int y){
  fill(0, 0, 0);
  rect(draw_rect(x), draw_rect(y), 200, 200);
}



void move(String state){
  init();
  switch (state){
    case "up":
      for (int i=1; i<=4; i++){
        for (int j=1; j<=4; j++){
          if (check[i][j] == 1){
            if (j != 1){ 
              int k = j;
              while (k!=1){
                if (check[i][k-1] == 1 && ar[i][k-1] == ar[i][k]){
                  over_write(i,k);
                  over_write(i,k-1);
                  check[i][k] = 0;
                  check[i][k-1] = 1;
                  draw_cell(i,k-1,ar[i][k]*2); //meet same num
                  ar[i][k] = 0;
                  break;
                }else if (check[i][k-1] == 1 && ar[i][k-1] != ar[i][k]){
                  draw_cell(i,k,ar[i][k]);
                  break;
                }else if (check[i][k-1] == 0){
                  over_write(i,k);
                  over_write(i,k-1);
                  check[i][k] = 0;
                  check[i][k-1] = 1;
                  draw_cell(i,k-1,ar[i][k]);
                  ar[i][k] = 0;
                  k--; //meet no num
                }
              } 
            }else{
                draw_cell(i,j,ar[i][j]);
            }  
          }
        }
      }  
      break;
    case "down":
      for (int i=4; i>=1; i--){
        for (int j=4; j>=1; j--){
          if (check[i][j] == 1){
            if (j != 4){ 
              int k = j;
              while (k!=4){
                if (check[i][k+1] == 1 && ar[i][k+1] == ar[i][k]){
                  over_write(i,k);
                  over_write(i,k+1);
                  check[i][k] = 0;
                  check[i][k+1] = 1;
                  draw_cell(i,k+1,ar[i][k]*2); //meet same num
                  ar[i][k] = 0;
                  break;
                }else if (check[i][k+1] == 1 && ar[i][k+1] != ar[i][k]){
                  draw_cell(i,k,ar[i][k]);
                  break;
                }else if (check[i][k+1] == 0){
                  over_write(i,k);
                  over_write(i,k+1);
                  check[i][k] = 0;
                  check[i][k+1] = 1;
                  draw_cell(i,k+1,ar[i][k]);
                  ar[i][k] = 0;
                  k++; //meet no num
                }
              } 
            }else{
                draw_cell(i,j,ar[i][j]);
            }  
          }
        }
      }  
      break;
    case "right":
      for (int j=4; j>=1; j--){
        for (int i=4; i>=1; i--){
          if (check[i][j] == 1){
            if (i != 4){ 
              int k = i;
              while (k!=4){
                if (check[k+1][j] == 1 && ar[k+1][j] == ar[k][j]){
                  over_write(k,j);
                  over_write(k+1,j);
                  check[k][j] = 0;
                  check[k+1][j] = 1;
                  draw_cell(k+1,j,ar[k][j]*2); //meet same num
                  ar[k][j] = 0;
                  break;
                }else if (check[k+1][j] == 1 && ar[k+1][j] != ar[k][j]){
                  draw_cell(k,j,ar[k][j]);
                  break;
                }else if (check[k+1][j] == 0){
                  over_write(k,j);
                  over_write(k+1,j);
                  check[k][j] = 0;
                  check[k+1][j] = 1;
                  draw_cell(k+1,j,ar[k][j]);
                  ar[k][j] = 0;
                  k++; //meet no num
                }
              } 
            }else{
                draw_cell(i,j,ar[i][j]);
            }  
          }
        }
      }  
      break;
    case "left":
      for (int j=1; j<=4; j++){
        for (int i=1; i<=4; i++){
          if (check[i][j] == 1){
            if (i != 1){ 
              int k = i;
              while (k!=1){
                if (check[k-1][j] == 1 && ar[k-1][j] == ar[k][j]){
                  over_write(k,j);
                  over_write(k-1,j);
                  check[k][j] = 0;
                  check[k-1][j] = 1;
                  draw_cell(k-1,j,ar[k][j]*2); //meet same num
                  break;
                }else if (check[k-1][j] == 1 && ar[k-1][j] != ar[k][j]){
                  draw_cell(k,j,ar[k][j]);
                  break;
                }else if (check[k-1][j] == 0){
                  over_write(k,j);
                  over_write(k-1,j);
                  check[k][j] = 0;
                  check[k-1][j] = 1;
                  draw_cell(k-1,j,ar[k][j]);
                  ar[k][j] = 0;
                  k--; //meet no num
                }
              } 
            }else{
                draw_cell(i,j,ar[i][j]);
            }  
          }
        }
      }  
      break;
  }
  spawn_point();
  
  /*for (int i=1; i<=4; i++){
    for (int j=1; j<=4; j++){
      print(ar[j][i]);
    }
    print("\n");
  }    
  print("-------------------------------\n");
  
  for (int i=1; i<=4; i++){
    for (int j=1; j<=4; j++){
      print(check[j][i]);
    }
    print("\n");
  }    
  print("-------------------------------\n");*/
}
