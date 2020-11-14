import processing.sound.*;

//画像・フォント・音
PFont myFont;
PImage wallImg, floorImg, clockImg, doorImg, keyImg;
PImage madoImg, teppanImg, hondanaImg, honImg, bedImg, butaImg, lightImg, tukueImg, minikeyImg;
PImage driverImg, bouImg, hon_oitaImg, denchiImg;
SceneManager SceneR, SceneL;
SoundFile getSound, cancelSound, ketteiSound, tyakkaSound, openSound, gatyagatyaSound, parinSound;
SoundFile kagiSound;
//クラス
Item door, clock, theKey, teppan, light, buta, hon, key2, driver, bou, bed, denchi;
Inventory inventory = new Inventory();
End end;
Title title;
window mes;
password pass;

//フラグ管理
boolean key_openFlg = false;
boolean pass_openFlg = false;
boolean bookFlg = false;
boolean clock_sch_Flg = false;
boolean book_on_Flg = false;
boolean denchiFlg = false;
boolean bouFlg = false;
boolean bed_schFlg = false;
boolean key_mini_Flg = false;
boolean driverFlg = false;
boolean teppanFlg = false;
boolean butaFlg = false;
boolean key_gol_Flg = false;
boolean buta_die_Flg = false;
boolean openFlg = false;
boolean lightFlg = false;


//変数宣言・代入
String message = "";
String where = "";
String keyPass = "";
int sceneSignal;
int time = 0;
int textLimit = 0;
int[] passrn ={floor(random(0, 10)), floor(random(0, 10)), floor(random(0, 10)), floor(random(0, 10))};

void setup() {
  size(480, 550);
  background(255);
  fill(0);
  noStroke();
  frameRate(40);
  myFont = createFont("YuGothic", 24, true);
  textFont(myFont);

  //画像の読み込み
  wallImg = loadImage("wall.jpg");
  floorImg = loadImage("yuka.jpg");
  clockImg = loadImage("clock.png");
  keyImg = loadImage("key.png");
  doorImg  = loadImage("door.jpg");
  madoImg = loadImage("mado.jpg");
  teppanImg = loadImage("teppan.jpg"); 
  butaImg = loadImage("buta.png");
  bedImg = loadImage("bed.png");
  tukueImg = loadImage("tukue.png");  
  lightImg = loadImage("light.png");
  honImg = loadImage("hon.png");
  hondanaImg = loadImage("kara.png");
  minikeyImg = loadImage("key2.png"); 
  driverImg = loadImage("driver.png");
  bouImg = loadImage("bou.png");
  hon_oitaImg = loadImage("hon_oita.png");
  denchiImg = loadImage("denchi.png");

  //効果音の読み込み
  getSound = new SoundFile(this, "get.ogg");
  cancelSound = new SoundFile(this, "cancel.ogg");
  ketteiSound = new SoundFile(this, "kettei.ogg");
  openSound = new SoundFile(this, "dooropen.ogg");
  parinSound = new SoundFile(this, "parin.mp3");
  gatyagatyaSound = new SoundFile(this, "gatyagatya.mp3");
  tyakkaSound = new SoundFile(this, "tyakka.ogg");
  kagiSound = new SoundFile(this, "kagi.mp3");

  //インスタンスの生成
  SceneR = new SceneManager(410, 180);
  SceneL = new SceneManager(10, 180);
  door = new Item(doorImg, 150, 80, 0.7);
  clock = new Item(clockImg, 320, 60, 0.24);
  theKey = new Item(keyImg, 230, 270, 0.5);
  key2 = new Item(minikeyImg, 0, 0, 0.1);
  teppan = new Item(teppanImg, 159, 87, 0.5);
  light = new Item(lightImg, 325, 136, 0.6);
  buta = new Item(butaImg, 252, 180, 0.05);
  hon = new Item(honImg, 133, 148, 0.17);
  bou = new Item(bouImg, 70, 148, 0.2);
  bed = new Item(bedImg, 110, 220, 0.19);
  denchi = new Item(denchiImg, 0, 0, 0.15);
  driver = new Item(driverImg, 0, 0, 0.2);
  title = new Title();
  end = new End();
  mes = new window();
  pass = new password();

  //変数の代入
  sceneSignal = 4;
  stay1 = false;
  stay2 = false;
  stay3 = false;
  stay4 = false;
  hyouji = false;
}

void draw() {
  background(0);
  noStroke();


  //タイトル画面
  if (sceneSignal == 4) {
    title.startSet();
  }

  //クリア画面
  if (sceneSignal == 5) {
    end.Gameclear();
  }

  //　以降　ゲーム画面
  if (sceneSignal < 4) {
    image(wallImg, 0, 0, 480, 300);
    image(floorImg, 0, 300, 480, 150);

    //脱出成功時の処理
    if (time > 60) {
      time = 0;
      sceneSignal = 5;
    }

    //カギでドアを開ける
    if (key_openFlg && pass_openFlg && !openFlg) {
      fill(255);
      openSound.play();
      openFlg = true;
    }

    //部屋の北側
    if (sceneSignal==0) {
      door.draw();
      clock.draw();
      if (book_on_Flg) {
        image(hon_oitaImg, 335, 270, hon_oitaImg.width*0.17, hon_oitaImg.height*0.17);
      }
      if (openFlg) {
        fill(0);
        time++;
        rect(150, 80, doorImg.width*0.7, doorImg.height*0.7);
      }
      pass.pos();
      fill(0);
      where = "北";
    } 

    //部屋の東側
    else if (sceneSignal==1) {
      image(tukueImg, 230, 210, tukueImg.width*0.13, tukueImg.height*0.13);
      image(hondanaImg, 130, 145, hondanaImg.width*0.13, hondanaImg.height*0.13);
      if (!bookFlg) {
        hon.draw();
      }
      if (!bouFlg) {
        bou.draw();
      }
      light.draw();
      if (!butaFlg) {
        buta.draw();
      }  
      fill(0);
      where = "東";
    } 

    //部屋の南側
    else if (sceneSignal == 2) {
      image(madoImg, 150, 70, madoImg.width*0.5, madoImg.height*0.5);
      teppan.draw();
      if (buta_die_Flg&&!key_gol_Flg) {
        theKey.draw();
      }
      fill(0);
      where = "南";
    } 

    //部屋の西側
    else if (sceneSignal == 3) {
      if (lightFlg) {
        fill(255, 0, 0);
        textSize(80);
        text(nf(passrn[0], 1)+nf(passrn[1], 1)+nf(passrn[2], 1)+nf(passrn[3], 1), 140, 180);
      }
      bed.draw();
      fill(0);
      where = "西";
    }

    if (!lightFlg) {
      fill(0, 150);
      rect(0, 0, width, height);
      noFill();
    } else {
      fill(255, 183, 76, 50);
      rect(0, 0, width, height);
      noFill();
    }

    if (sceneSignal < 4) {
      //東西南北
      textSize(24);
      fill(255);
      text(where, 450, 25);
    }

    //テキストボックスの表示
    if (!(message=="")) mes.message();

    //ボタン
    SceneR.buttomR();
    SceneL.buttomL();

    //インベントリの表示
    inventory.draw();

    if (sceneSignal == 0) {
      if (hyouji) {
        if (keyPressed&&key == ENTER) {
          cancelSound.play();
          hyouji = false;
          startpass = false;
        }
      }
      pass.passWord();
      pass.num();
    }
  }
}

void mousePressed() {
  if (window_stay)return;

  if (sceneSignal==4||sceneSignal==5) return;

  //クリアしたら実行しない
  if (key_openFlg&&pass_openFlg) return;

  //シーン切り替えボタンの判定
  SceneR.isInR(mouseX, mouseY);
  SceneL.isInL(mouseX, mouseY);

  //////////
  //北側
  //////////
  if (sceneSignal==0) { 

    if (!pass_openFlg) {
      pass.poss(mouseX, mouseY);
    }

    //パスワード
    for (int i = 0; i<10; i++) {
      pass.isClicked4(mouseX, mouseY, i);
    }
    for (int i = 0; i<10; i++) {
      pass.isClicked3(mouseX, mouseY, i);
    }
    for (int i = 0; i<10; i++) {
      pass.isClicked2(mouseX, mouseY, i);
    }
    for (int i = 0; i<10; i++) {
      pass.isClicked1(mouseX, mouseY, i);
    }

    //ドアの判定
    if (door.isIn(mouseX, mouseY)) {
      if (!hyouji) {
        if (pass_openFlg&&!key_openFlg&&!openFlg) {
          mes.textSet("ドアが開いた！", 60);
          key_openFlg = true;
          return;
        }
        if (!key_gol_Flg&&!pass_openFlg)
        {
          gatyagatyaSound.play();
          mes.textSet("鍵がかかっている。 \nどうやら、鍵とパスコードの\n二重ロック式のようだ。", 70);
        }
        if (key_gol_Flg&&!pass_openFlg&&!key_openFlg) {
          mes.textSet("ロックが一つ解除された!", 70);
          kagiSound.play();
          key_openFlg = true;
          return;
        }
        if (key_gol_Flg&&!pass_openFlg&&key_openFlg) {
          mes.textSet("ロックが一つ解除されている。", 70);
        }
      }
    }
    if (clock.isIn(mouseX, mouseY)) {
      if (!clock_sch_Flg) {
        mes.textSet("立派な時計が飾られている。 \n高い位置にあって届きそうにない。", 90);
        clock_sch_Flg = true;
      }
      if (clock_sch_Flg&&!bookFlg) {
        mes.textSet("立派な時計が飾られている。 \n高い位置にあって届きそうにない。", 90);
      }
      if (clock_sch_Flg&&bookFlg&&!book_on_Flg) {
        mes.textSet("本束を置いた。", 80);
        book_on_Flg = true;
        return;
      }
      if (clock_sch_Flg&&bookFlg&&book_on_Flg&&!driverFlg) {
        mes.textSet("電池式の時計のようだ。\n特に変わったところはない", 90);
      }
      if (clock_sch_Flg&&bookFlg&&book_on_Flg&&driverFlg&&!denchiFlg) {
        mes.textSet("ドライバーを使って、\n電池を取り出した！", 70);
        getSound.play();
        denchiFlg = true;
        inventory.put(denchi);
        return;
      }
      if (denchiFlg) {
        mes.textSet("この時計にもう用は無い", 60);
      }
    }
  }

  //////
  //東側
  ///////
  if (sceneSignal==1) {
    if (bou.isIn(mouseX, mouseY)) {
      if (!bed_schFlg) {
        mes.textSet("長い棒が立て掛けられている。", 70);
      }
      if (bed_schFlg&&!bouFlg) {
        mes.textSet("長い棒を手に入れた。\nこれでベッドの奥にあるものを\n取れるかもしれない。", 70);
        getSound.play();
        bouFlg = true;
        inventory.put(bou);
      }
    }

    if (mouseX>=320&&mouseX<=360&&mouseY>=230&&mouseY<=310) {
      if (!key_mini_Flg) {
        mes.textSet("机の引き出しには、\n鍵がかかっている。", 70);
      }
      if (key_mini_Flg&&!driverFlg) {
        mes.textSet("鍵を開け、\n中にあるドライバーを手に入れた！", 70);
        getSound.play();
        driverFlg = true;
        inventory.put(driver);
        return;
      }
      if (driverFlg) {
        mes.textSet("もう中には何も無い", 60);
      }
    }

    if (buta.isIn(mouseX, mouseY)) {
      if (!teppanFlg) {
        mes.textSet("ブタの貯金箱のようだ。\n振るとカラカラと音がする。", 70);
      }
      if (teppanFlg&&!butaFlg) {
        mes.textSet("ブタの貯金箱を手に入れた。\n何かに使えるかもしれない...", 70); 
        getSound.play();
        butaFlg = true;
        inventory.put(buta);
      }
    }
    if (hon.isIn(mouseX, mouseY)) {
      if (!clock_sch_Flg) {
        mes.textSet("本束が置かれている。", 60);
      }
      if (clock_sch_Flg&&!bookFlg) {
        mes.textSet("本束を手に入れた。\nこれは台になりそうだ。", 70);
        getSound.play();
        bookFlg = true;
        inventory.put(hon);
      }
    }
    if (light.isIn(mouseX, mouseY)) {
      if (!denchiFlg) {
        mes.textSet("電池式のライトがある。\nどうやら電池が切れているようだ。", 80);
      }
      if (denchiFlg&&!lightFlg) {
        mes.textSet("電池を入れ、灯りをつけた！", 70);
        tyakkaSound.play();
        lightFlg = true;
        return;
      }
      if (lightFlg) {
        mes.textSet("仄かに暖かい...", 60);
      }
    }
  }

  ///////
  //南側
  ////////
  if (sceneSignal==2) {
    if (teppan.isIn(mouseX, mouseY)) {
      if (!teppanFlg||buta_die_Flg) {

        mes.textSet("窓があるが、\n鉄板が張られていて出られそうにない。", 70);
        teppanFlg = true;
      }
      if (teppanFlg&&!butaFlg) {
        mes.textSet("窓があるが、\n鉄板が張られていて出られそうにない。", 70);
      }
      if (teppanFlg&&butaFlg&&!buta_die_Flg) {
        mes.textSet("ブタの貯金箱を、\n思いっ切り鉄板に投げ付けた！", 70);
        parinSound.play();
        buta_die_Flg = true;
      }
    }
    if (theKey.isIn(mouseX, mouseY)) {
      if (buta_die_Flg&&!key_gol_Flg) {
        mes.textSet("玄関のカギを手に入れた！", 70);
        getSound.play();
        key_gol_Flg = true;
        inventory.put(theKey);
      }
    }
  }

  /////////
  //西側
  ///////
  if (sceneSignal==3) {
    if (bed.isIn(mouseX, mouseY)) {
      if (!bed_schFlg) {
        mes.textSet("ベッドの奥に何かある。\nだが、手では届きそうにない。", 70);
        bed_schFlg = true;
      }
      if (bed_schFlg&&!bouFlg) {
        mes.textSet("ベッドの奥に何かある。\nだが、手では届きそうにない。", 70);
      }
      if (bed_schFlg&&bouFlg&&!key_mini_Flg) {
        mes.textSet("長い棒を使い、\n小さな鍵を手に入れた！", 70);
        getSound.play();
        key_mini_Flg = true;
        inventory.put(key2);
        return;
      }
      if (key_mini_Flg) {
        mes.textSet("寝心地の良さそうな\nベッドだなぁ.......", 70);
      }
    }
  }
}

class End {

  void draw() {
  };

  void Gameclear()
  {
    String messageE1 ="";
    fill(255);
    messageE1 = "クリアおめでとう！";
    text(messageE1, 100, 200);
  };
}

class Inventory {

  int itemMax = 7; 
  Item[] items = new Item[itemMax];
  int found = 0;
  int key_gol_Use = -1;
  int butaUse = -1;
  int denchiUse = -1;
  int bouUse = -1;
  int driverUse = -1;
  int key_mini_Use = -1;
  int bookUse = -1;

  void put(Item i) {
    if (found < itemMax) {
      items[found] = i;
      if (butaFlg && butaUse == -1)butaUse = use();
      if (denchiFlg && denchiUse == -1)denchiUse = use();
      if (bouFlg && bouUse == -1)bouUse = use();
      if (driverFlg && driverUse == -1)driverUse = use();
      if (key_mini_Flg && key_mini_Use == -1)key_mini_Use = use();
      if (key_gol_Flg && key_gol_Use == -1)key_gol_Use = use();
      if (bookFlg && bookUse == -1)bookUse = use();
      found++;
    }
  }

  void draw() {
    fill(0);
    stroke(255, 215, 0);
    strokeWeight(2);

    if (buta_die_Flg&&!(items[butaUse] == null)) {
      items[butaUse] = null;
    }
    if (lightFlg&&!(items[denchiUse] == null)) {
      items[denchiUse] = null;
    }
    if (key_mini_Flg&&!(items[bouUse] == null)) {
      items[bouUse] = null;
    }
    if (driverFlg&&!(items[key_mini_Use] == null)) {
      items[key_mini_Use] = null;
    }
    if (denchiFlg&&!(items[driverUse] == null)) {
      items[driverUse] = null;
    }
    if (key_openFlg&&!(items[key_gol_Use] == null)) {
      items[key_gol_Use] = null;
    }
    if (book_on_Flg&&!(items[bookUse] == null)) {
      items[bookUse] = null;
    }

    for (int i = 0; i < itemMax; i++) {
      rect(i * 30 + 20, 20, 30, 30);
      if (items[i] != null) {
        image(items[i].img, i * 30 + 20, 20, 28, 28);
      }
    }
  }

  //アイテムの入手順を記憶
  int use() {
    int wait = this.found;
    return wait;
  }
}

class Item {
  PImage img;
  int xpos;
  int ypos;
  float scale;
  int scene;
  Item(PImage _img, int _xpos, int _ypos, float _scale) {
    img = _img;
    xpos = _xpos;
    ypos = _ypos;
    scale = _scale;
  }

  void draw() {
    float imgWidth = img.width * scale;
    float imgHeight = img.height * scale;
    image(img, xpos, ypos, imgWidth, imgHeight);
  }

  boolean isIn(int x, int y) {
    if (x >= xpos && x <= xpos + img.width * scale &&
      y >= ypos && y <= ypos + img.height * scale) {
      return true;
    } else {
      return false;
    }
  }
}

class SceneManager {
  int xpos, ypos;
  int pushTime;
  boolean push;

  SceneManager(int x, int y) {
    xpos = x;
    ypos = y;
    pushTime = 0;
    push = false;
  }
  void buttomR() {
    stroke(0);
    strokeWeight(1);
    if (push)pushTime++;
    if (pushTime==0)fill(250, 50, 50);
    else fill(250, 150, 150);
    if (pushTime > 3) {
      pushTime = 0;
      push = !push;
    }
    triangle(xpos, ypos, xpos+60, ypos+30, xpos, ypos+60);
  }

  void buttomL() {
    stroke(0);
    strokeWeight(1);
    if (push)pushTime++;
    if (pushTime==0)fill(250, 50, 50);
    else fill(250, 150, 150);
    if (pushTime > 3) {
      pushTime = 0;
      push = !push;
    }
    triangle(xpos, ypos+30, xpos+60, ypos+60, xpos+60, ypos);
  }

  void isInR(int x, int y) {
    if (x >= xpos && x <= xpos + 60 &&
      y >= ypos && y <= ypos + 60) {
      push = !push;
      hyouji = false;
      startpass = false;
      sceneSignal = (sceneSignal+1)%4;
    } else {
      return;
    }
  }

  void isInL(int x, int y) {
    if (x >= xpos && x <= xpos + 60 &&
      y >= ypos && y <= ypos + 60) {
      push = !push;
      hyouji = false;
      startpass = false;
      sceneSignal = (sceneSignal+3)%4;
    } else {
      return;
    }
  }
}

class Title {

  void draw() {
  };

  void startSet()
  {
    background(0);
    if (keyPressed&&key == ENTER) {
      sceneSignal = 0;
      ketteiSound.play();
      return;
    }
    String messageT1 ="";
    String messageT2 ="";
    fill(255);
    textSize(24);
    messageT1 = "脱出ゲーム";
    text(messageT1, 200, 200);
    messageT2 = "Press Enter";
    text(messageT2, 200, 400);
  };
}

boolean stay1, stay2, stay3, stay4; //打った数字を消さない
boolean hyouji; //暗証番号を打つ画面の表示
boolean startpass; //装置を押す

class password {
  String[] pad = new String [10];
  boolean[] numberA = new boolean[10];
  boolean[] numberB = new boolean[10];  
  boolean[] numberC = new boolean[10];  
  boolean[] numberD = new boolean[10];  
  String mess ="";
  int[] xpos = new int[10];
  int[] ypos = new int[10];

  password() {
    for (int i = 0; i<10; i++) {
      String k = nf(i, 1);
      pad[i] = k;
    }
    for (int i = 1; i<10; i++) {
      xpos[i] = 135+70*((i-1)%3);
    }
    for (int i = 1; i<4; i++) {
      ypos[i] = 183;
    }
    for (int i = 4; i<7; i++) {
      ypos[i] = 231;
    }
    for (int i = 7; i<10; i++) {
      ypos[i] = 279;
    }
    xpos[0] = 231;
    ypos[0] = 327;

    for (int i = 0; i<10; i++) {
      numberA[i] = false;
      numberB[i] = false;
      numberC[i] = false;
      numberD[i] = false;
    }
    startpass = false;
  }

  void pos() {
    stroke(0);
    strokeWeight(1);
    fill(255);
    rect(125, 200, 20, 25);
  }


  void poss(int x, int y) {
    if (x >= 125&&x <=145&&y>=200&&y<=225&&startpass==false) {
      startpass = true;
    }
  }

  void passWord() {
    if (!openFlg||!pass_openFlg) {
      if (startpass&&!hyouji) {
        hyouji = !hyouji;
        for (int i = 0; i<10; i++) {
          numberA[i] = false;
          numberB[i] = false;
          numberC[i] = false;
          numberD[i] = false;
          stay1 = false;
          stay2 = false;
          stay3 = false;
          stay4 = false;
        }
      }
      if (hyouji==true) {
        stroke(255, 215, 0);
        strokeWeight(1.5);
        fill(0);
        rect(135, 100, 210, 240);
        for (int i = 0; i<4; i++) {
          rect(135, 183+48*i, 70, 48);
          rect(205, 183+48*i, 70, 48);
          rect(275, 183+48*i, 70, 48);
        }
        textSize(40);
        fill(255);
        for (int i = 1; i<4; i++) {
          text(pad[i], 90+70*i, 220);
        }
        for (int i = 4; i<7; i++) {
          text(pad[i], 90+70*(i-3), 268);
        }
        for (int i = 7; i<10; i++) {
          text(pad[i], 90+70*(i-6), 316);
        }
        text(pad[0], 230, 364);
        fill(255);
        textSize(24);
        mess = "ENTERで中断する";
        text(mess, 140, 418);
      }
    }
  }

  void isClicked1(int x, int y, int l) {
    if (x >= xpos[l]&&x <= xpos[l]+70&&y>= ypos[l]&&y <=ypos[l]+48&&stay1==false) {
      stay1 = true;
      numberA[l] = true;
    }
  }
  void isClicked2(int x, int y, int l) {
    if (x >= xpos[l]&&x <= xpos[l]+70&&y>= ypos[l]&&y <=ypos[l]+48&&stay2==false&&stay1==true) {
      stay2 = true;
      numberB[l] = true;
    }
  }
  void isClicked3(int x, int y, int l) {
    if (x >= xpos[l]&&x <= xpos[l]+70&&y>= ypos[l]&&y <=ypos[l]+48&&stay3==false&&stay2==true) {
      stay3 = true;
      numberC[l] = true;
    }
  }
  void isClicked4(int x, int y, int l) {
    if (x >= xpos[l]&&x <= xpos[l]+70&&y>= ypos[l]&&y <=ypos[l]+48&&stay4==false&&stay3==true) {
      stay4 = true;
      numberD[l] = true;
    }
  }

  void num() {
    if (!pass_openFlg) {
      if (numberA[passrn[0]]==true&&numberB[passrn[1]]==true&&numberC[passrn[2]]&&numberD[passrn[3]])
      {
        if (key_openFlg&&!pass_openFlg&&!openFlg)
        {
          mes.textSet("ドアが開いた！", 60);
        }
        if (!key_openFlg&&!pass_openFlg) {
          mes.textSet("ロックが一つ解除された！", 80);
          kagiSound.play();
        }
        pass_openFlg = true;
        hyouji = false;
        startpass = false;
        return;
      }
      if (hyouji == true) {
        if (stay1==true) {
          for (int i = 0; i<10; i++) {
            if (numberA[i] == true) {
              textSize(48);
              fill(255);
              text(pad[i], 135, 150);
            }
          }
        }
        if (stay1==true&&stay2==true) {
          for (int i = 0; i<10; i++) {
            if (numberB[i] == true) {
              textSize(48);
              fill(255);
              text(pad[i], 165, 150);
            }
          }
        }
        if (stay1==true&&stay2==true&&stay3==true) {
          for (int i = 0; i<10; i++) {
            if (numberC[i] == true) {
              textSize(48);
              fill(255);
              text(pad[i], 195, 150);
            }
          }
        }
        if (stay1==true&&stay2==true&&stay3==true&stay4==true) {
          for (int i = 0; i<10; i++) {
            if (numberD[i] == true) {
              textSize(48);
              fill(255);
              text(pad[i], 225, 150);
            }
          }
        }
      }
    }
  }
}

boolean window_stay = false;

class window {

  boolean ex = false;
  private int flame = 0;

  void message() {
    flame++;
    if (flame >= textLimit) {
      message = "";
      flame = 0;
      window_stay = false;
      ex = true;
    }
    if (!ex) {
      fill(30);
      stroke(255, 215, 0);
      strokeWeight(2);
      rect(1, 400, 475, 147);
      fill(255);
      text(message, 20, 430);
      window_stay = true;
    }
  }

  void textSet(String mes, int limit) {
    ex = false;
    textSize(24);
    message = mes;
    textLimit = limit;
  }
}
