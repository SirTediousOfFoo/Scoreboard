//DELAYS USED TO AVOID GETTING MULTIPLE CLICKS AT ONCE

int crveni, zuti, sekunde, minute, longPressTime, startingMinute = 3;
int bojaTajmera, red = #FF0505, yellow = #FFFF00;
int tajmerSec = 0, pocVrijeme = 0;
String vrijeme, pauziranoVrijeme;
boolean pauza = false, pressedLong = false;

PImage pauseBtn;
PImage playBtn;

void setup()
{
  sekunde = 0;
  minute = startingMinute; 
  pocVrijeme = millis();
  size(displayWidth, displayHeight); 
  zuti = 0;   //RED STARTING SCORE
  crveni = 0; //YELLOW STARTING SCORE
  noStroke();
  bojaTajmera = 255;  
  
  pauseBtn = loadImage("pause.png");
  playBtn = loadImage("play.png");
  
  pauseBtn.resize(displayWidth*2/10, displayWidth*2/10);
  playBtn.resize(displayWidth*2/10, displayWidth*2/10);
}

void draw()
{
  klik();
  //BACKGROUND STUFF
  background(0);
  fill(red); 
  rect(0,0,displayWidth/2,displayHeight/2);
  fill(yellow); 
  rect(displayWidth/2,0,displayWidth/2,displayHeight/2);
  textSize(displayHeight/5);
  textAlign(CENTER, CENTER);
  if(pauza == true)
  {
    fill(red);
    rect(0,displayHeight*7/8,displayWidth,displayHeight);
  }
  //YELLOW STUFF
  fill(yellow);
  text(zuti, displayWidth/4, displayHeight/4);
  textSize(displayHeight/8);
  text("+", displayWidth/4, displayHeight/14);
  text("-", displayWidth/4, displayHeight/2-displayHeight/12);
  
  //RED STUFF
  fill(red);
  textSize(displayHeight/5);
  text(crveni, displayWidth - displayWidth/4, displayHeight/4);
  textSize(displayHeight/8);
  text("+", displayWidth*3/4, displayHeight/14);
  text("-", displayWidth*3/4, displayHeight/2-displayHeight/12);
  
  //TIMER
  fill(bojaTajmera);
  textSize(displayWidth/4);  
  textAlign(CENTER, CENTER);
  text(tajmer(), displayWidth*4/10,displayHeight*3/4);
  textAlign(LEFT, TOP);
  text("+", 0, height/2);
  text("-", 0, height*7/8);
  //PAUSE BUTTON
  if(pauza == true)
  {
    imageMode(CENTER);
    image(playBtn, displayWidth*8/9, displayHeight*3/4);
  }
  else if(pauza == false)
  {
    imageMode(CENTER);
    image(pauseBtn, displayWidth*8/9, displayHeight*3/4);
  }
}
String tajmer()
{
  if(pauza == false)
  {
    if(sekunde != 00 && millis() - pocVrijeme >= 1000)
    {
      sekunde--;
      pocVrijeme = millis();
    }
    else if(sekunde == 00 && millis() - pocVrijeme >= 1000)
    {
      minute--;
      sekunde = 59;
      pocVrijeme = millis();
    }
    if(minute == 0 && sekunde == 0)
    {
      vrijeme = "00:00";
      pauza = true;
    }
    
    //don't go into negatives with the timer
    if(minute < 0)
      minute = 0;
    if(sekunde < 0)
      sekunde = 0;
    
    //output formatting for timer string
    else if(sekunde<10 && minute < 10)
      vrijeme = "0"+minute+":"+"0"+sekunde;
    else if(sekunde<10 && minute >= 10)
      vrijeme = minute+":"+"0"+sekunde;
    else if(sekunde >= 10 && minute < 10)
      vrijeme = "0"+minute+":"+ sekunde;
    else if(sekunde >= 10 && minute >= 10)
      vrijeme = minute+":"+ sekunde;
     
    //if(minute == 2 && sekunde == 0)
    //{
    //  bojaTajmera = #FFBE00;
    //}
    //else if(minute == 3 && sekunde == 0) USE FOR COLOR SWITCHING IF TIMER GOES UP
    //{
    //  bojaTajmera = #FF0000;
    //}
    pauziranoVrijeme = vrijeme;
    return vrijeme;
  }
  else if(pauza == true)
  {
    return pauziranoVrijeme;
  }
  return vrijeme;
}
void klik()
{
  if(mousePressed)
  {
      if(mouseX > 0 && mouseX < displayWidth/2 && mouseY <= displayHeight/8)
      {
       zuti++;
       delay(150);
      }
      else if(mouseX>0 && mouseX <displayWidth/2 && mouseY > displayHeight/2-displayHeight/8 && mouseY < displayHeight/2)
      {
       zuti--;
       delay(150);
      }
      else if(mouseX > displayWidth/2 && mouseX < displayWidth && mouseY <= displayHeight/8)
      {
       crveni++;
       delay(150);
      }
      else if(mouseX > displayWidth/2 && mouseX <displayWidth && mouseY > displayHeight/2-displayHeight/8 && mouseY < displayHeight/2)
      {
       crveni--;
       delay(150);
      }
      else if(mouseX < width/8 && mouseY > height/2 && mouseY < height*13/20)
      {
        if(pauza == true)
        {
          pauza = false;
          startingMinute++;
          minute = startingMinute;
          vrijeme = tajmer();
          redraw();
          pauza = true;
        }
        else
        {
          startingMinute++;
          minute = startingMinute;
          redraw();
        }
        delay(150);
      }
      else if(mouseX < width/8 && mouseY > height*8/9)
      {
        if(pauza == true)
        {
          pauza = false;
          startingMinute--;
          minute = startingMinute;
          vrijeme = tajmer();
          redraw();
          pauza = true;
        }
        else
        {
          startingMinute--;
          minute = startingMinute;
          redraw();
        }
        delay(150);
      }
      else if(mouseX > displayWidth/8 && mouseX < displayWidth-displayWidth/4 && mouseY > displayHeight-displayHeight/3 && mouseY < displayHeight*7/8)
      {
       pauza = false;
       crveni = 0;
       zuti = 0;
       sekunde = 0;
       minute = startingMinute;              //RESET DIO
       bojaTajmera = 255;
       vrijeme = tajmer();
       redraw();       
       pauza = true;
       delay(150);
    }
      else if(mouseX > displayWidth*3/4 && mouseX < displayWidth && mouseY > displayHeight-displayHeight/3 && mouseY < displayHeight*7/8)
      {
        if(pauza == false)
        {
          pauza = true;
          delay(150);
        }
        else if(pauza == true)
        {          
          pauza = false;
          delay(150); 
        }
      }
  } 
}