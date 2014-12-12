class quote_data{
   float alpha;
   String line;
   float len,posx,posy;
   PFont font;
   quote_data(String quote, String font1){
     print(quote + "\n");
      alpha = 1;
      line = quote; 
      alpha = 255;
      fill(105,12,12,255); 
      font = createFont(font1, 25);//rand.nextInt((35-12 +1)+12));
      textFont(font);
      len = textWidth(quote);
      Random rand = new Random();
      int temp = (int)(width -len - BUFFER + 1 + BUFFER);
      if (temp < 0){ temp = 1;}
      posx = rand.nextInt(temp);
      posy = rand.nextInt((int)(height*.75 - BUFFER*3) + 1) + BUFFER;

      text(line,posx,posy);
   }
   void reduce_alpha(){
      alpha -= 3;
      fill(105,12,12,alpha); 
      textFont(font);
      text(line,posx,posy);
   }
    
}
