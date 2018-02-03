int crveni, zuti, sekunde, minute;
int bojaTajmera;
int tajmerSec = 0, pocVrijeme = 0;
String vrijeme, pauziranoVrijeme;
boolean pauza = false;
void setup()
{
  sekunde = 0;
  pocVrijeme = millis();
  size(displayWidth, displayHeight); 
  zuti = 0;
  crveni = 0;
  noStroke();
  minute = 0;
  bojaTajmera = 255;
}
void draw()
{
  klik();
  //POZADINA
  background(0);
  fill(#FF0505);
  rect(0,0,displayWidth/2,displayHeight/2);
  fill(#FFFF00);
  rect(displayWidth/2,0,displayWidth/2,displayHeight/2);
  textSize(displayHeight/5);
  textAlign(CENTER, CENTER);
  if(pauza == true)
  {
    fill(#FF0505);
    rect(0,displayHeight*7/8,displayWidth,displayHeight);
  }
  //ZUTI SIMBOLI
  fill(#FFFF00);
  text(zuti, displayWidth/4, displayHeight/4);
  textSize(displayHeight/8);
  text("+", displayWidth/4, displayHeight/14);
  text("-", displayWidth/4, displayHeight/2-displayHeight/12);
  
  //CRVENI SIMBOLI
  fill(#FF0505);
  textSize(displayHeight/5);
  text(crveni, displayWidth - displayWidth/4, displayHeight/4);
  textSize(displayHeight/8);
  text("+", displayWidth*3/4, displayHeight/14);
  text("-", displayWidth*3/4, displayHeight/2-displayHeight/12);
  
  //TAMJER
  fill(bojaTajmera);
  textSize(displayWidth/3);  
  text(tajmer(), displayWidth/2,displayHeight-(displayHeight-displayWidth/2)/3 );
}
String tajmer()
{
  if(pauza == false)
  {
    if(millis() - pocVrijeme >= 1000)
    {
      sekunde--;
      pocVrijeme = millis();
    }
    if(sekunde == 00)
    {
      minute--;
      sekunde = 0;
    }
    if(sekunde<10)
      vrijeme = "0"+minute+":"+"0"+sekunde;
    else
      vrijeme = "0"+minute+":"+sekunde;
    //if(minute == 2 && sekunde == 0)
    //{
    //  bojaTajmera = #FFBE00;
    //}
    //else if(minute == 3 && sekunde == 0) OVO ODKOMENTIRATI AKO TIMER BUDE TREBAO RASTI
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
      else if(mouseX > displayWidth/4 && mouseX < displayWidth-displayWidth/4 && mouseY > displayHeight-displayHeight/3)
      {
       pauza = false;
       crveni = 0;
       zuti = 0;
       sekunde = 0;
       minute = 0;
       bojaTajmera = 255;
       vrijeme = tajmer();
       redraw();       
       delay(150);
       pauza = true;
    }
      else if(mouseX > displayWidth*3/4 && mouseX < displayWidth && mouseY > displayHeight-displayHeight/3)
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
