//+------------------------------------------------------------------+
//|                                                 Daily candle.mq4 |
//|                                                            Seyed |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Seyed Ali Fadaei"
#property version   "1.8"
#property description "BBS_1H"
#property strict
extern int T1=2;           //T1-Opening Near Bollinger (ABS)
extern int T2=3;           //T2-Near Main (ABS)
extern int T3=5;           //T3-Deleting Overbound
extern int T4=9;           //T4-Closing Near Bollinger (ABS)
extern int T5=9;           //T5-Delete for Range on Bollinger (ABS)
extern int T6=3;           //T5-Delete for Range On (ABS)
extern int Traill1=8;     //First Trail Modification on Main
extern int Traill2=27;     //Second Trail Modification on Main
extern int Overbond=43;    //Overbound Positions
extern int n=37;           //Number of Candlle Range
extern double l=0.02;      //Lots
extern int b=235;          //Bollinger Period
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
string inchannel()
{
   if ((Ask < iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0))  &&
       (Ask > iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0)   )   )
   return("UP");
   else if ((Bid> iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0))  && 
            (Bid< iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0)  )   )
   return("DOWN");
   else
   return("RANGE");
}
//--------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------
string fixinchannel()
{
   
   if (iClose(Symbol(),PERIOD_H1,1) < iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,1) &&
       iClose(Symbol(),PERIOD_H1,1) > iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,1) && 
       iClose(Symbol(),PERIOD_H1,0) < iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) &&
       iClose(Symbol(),PERIOD_H1,0) > iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0)  )
   return("UP");
   else if (iClose(Symbol(),PERIOD_H1,1) > iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,1) && 
            iClose(Symbol(),PERIOD_H1,1) < iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,1) &&
            iClose(Symbol(),PERIOD_H1,0) > iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0) && 
            iClose(Symbol(),PERIOD_H1,0) < iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0)  )
   return("DOWN");
   else
   return("RANGE");
}
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
string nearbol()
{ 
   if (fabs(Bid - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0)) < T1 )
   return("LOWERLINE");
   else if (fabs(Ask - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0)) < T1 )
   return("UPPERLINE");
   else
   return ("RANGE");
}
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
string posonmain()
{ 
   if (fabs(Ask - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0)) < T2 )
   return("ACTIVE");
   else if (fabs(Bid - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0)) < T2 )
   return("ACTIVE");
   else
   return("RANGE");
}
//----------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------
string overchannel()
{  
   if ( Bid - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) > Overbond  )
   return("VERYHIGH");
   else if ( iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0)-Ask > Overbond )
   return("VERYLOW");
   else
   return("RANGE");
}
//--------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------
string overbol_del()
{ 
   if (Ask - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) > T3)
   return("OVER");
   else if (iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0) - Bid > T3)
   return("OVER");
   else
   return("RANGE");
}
//-----------------------------------------------------------------------------
string posout()
{ 
   if (fabs(Bid - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0)) < T4 &&
            Bid > iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0))
   return("NEARLOWER");
   else if (fabs(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) - Ask) < T4 &&
                 iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) > Ask )
   return("NEARUPPER");
   else
   return("RANGE");
}
//---------------------------------------------------------------------------------------------------------------------------------
string rangeonbolingerdelete()
{
   if (fabs(iClose(Symbol(),PERIOD_H1,0) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0)) < T5  &&
       fabs(iClose(Symbol(),PERIOD_H1,1) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,1)) < T5  &&
       fabs(iClose(Symbol(),PERIOD_H1,2) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,2)) < T5  &&
       fabs(iClose(Symbol(),PERIOD_H1,3) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,3)) < T5  &&
       fabs(iClose(Symbol(),PERIOD_H1,4) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,4)) < T5  &&
       fabs(iClose(Symbol(),PERIOD_H1,5) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,5)) < T5  &&
       fabs(iClose(Symbol(),PERIOD_H1,6) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,6)) < T5  &&
       fabs(iClose(Symbol(),PERIOD_H1,7) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,7)) < T5  &&
       fabs(iClose(Symbol(),PERIOD_H1,8) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,8)) < T5  &&
       fabs(iClose(Symbol(),PERIOD_H1,9) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,9)) < T5 )
   return("RANGEONUPPER");
   else if (fabs(iClose(Symbol(),PERIOD_H1,0) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0)) < T5 &&
            fabs(iClose(Symbol(),PERIOD_H1,1) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,1)) < T5 &&
            fabs(iClose(Symbol(),PERIOD_H1,2) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,2)) < T5 &&
            fabs(iClose(Symbol(),PERIOD_H1,3) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,3)) < T5 &&
            fabs(iClose(Symbol(),PERIOD_H1,4) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,4)) < T5 &&
            fabs(iClose(Symbol(),PERIOD_H1,5) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,5)) < T5 &&
            fabs(iClose(Symbol(),PERIOD_H1,6) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,6)) < T5 &&
            fabs(iClose(Symbol(),PERIOD_H1,7) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,7)) < T5 &&
            fabs(iClose(Symbol(),PERIOD_H1,8) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,8)) < T5 &&
            fabs(iClose(Symbol(),PERIOD_H1,9) - iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,9)) < T5 )
   return ("RANGEONLOWER");
   else
   return("NORANGE");
}
//---------------------------------------------------------------------------------------------------------------------------------
string rangecandledelete()
{
   if (Close[iHighest(Symbol(),PERIOD_H1,MODE_CLOSE,n,0)] - Close[iLowest(Symbol(),PERIOD_H1,MODE_CLOSE,n,0)]< T6  )
   return("RANGEON");
   else
   return("NORANGE");
}
//---------------------------------------------------------------------------------------------------------------------------------
string openbolinger()
{
   if ( round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0)) > round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,1)) &&
        round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,1)) > round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,2)) &&
        round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,2)) > round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,3)) &&
        round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,3)) > round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,4)) &&
        round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,4)) > round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,5))   )
   return("UPPEROPEN");
   if ( round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0)) < round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,1)) &&
        round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,1)) < round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,2)) &&
        round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,2)) < round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,3)) &&
        round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,3)) < round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,4)) &&
        round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,4)) < round(iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,5))  )
   return("LOWEROPEN");
   else
   return("NOOPEN");
}
//---------------------------------------------------------------------------------------------------------------------------------
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//---------------------------------------------------------------------------------------------------------------------------------
//Open Position--------------------------------------------------------------------------------------------------------------------
void opennewpos(string command)
{
 if(command=="buy")
 int open1 = OrderSend(Symbol(),OP_BUY,l,Ask,3,0,0,"OPENbuy",212,0,clrGreen);
 else if (command=="sell")
 int open2 = OrderSend(Symbol(),OP_SELL,l,Bid,3,0,0,"OPENsell",213,0,clrGreen);
 return;
}
//Open OverBond Position-----------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------
void openvery(string command)
 {  
  if(command=="buy")
  int open3 = OrderSend(Symbol(),OP_BUY,l/2,Ask,3,0,0,"OPENbuy",214,0,clrGreen);
  else if (command=="sell")
  int open4 = OrderSend(Symbol(),OP_SELL,l/2,Bid,3,0,0,"OPENsell",215,0,clrGreen);
  return;
}
//---------------------------------------------------------------------------------------------------------------------------------
//Close Order----------------------------------------------------------------------------------------------------------------------
void closeorders(string command)
{
 if(command=="close1")
 bool close1 = OrderClose(OrderTicket(),l/2,OrderClosePrice(),3,clrRed);
 if(command=="close2")
 bool close2 = OrderClose(OrderTicket(),l,OrderClosePrice(),3,clrRed);
 return;
}
//---------------------------------------------------------------------------------------------------------------------------------
//Delete Order---------------------------------------------------------------------------------------------------------------------
void deletorder()
{
 for (int i=OrdersTotal()-1;i>=0;i--)
  {
  if (OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   {
    if((OrderMagicNumber()==212 || OrderMagicNumber()==213) && overbol_del()=="OVER" && nearbol()=="RANGE" && OrderLots()==l )
    bool delete1 = OrderClose(OrderTicket(),l,OrderClosePrice(),3,clrRed);
    if((OrderMagicNumber()==212 || OrderMagicNumber()==213) && overbol_del()=="OVER" && nearbol()=="RANGE" && OrderLots()==l/2 )
    bool delete2 = OrderClose(OrderTicket(),l/2,OrderClosePrice(),3,clrRed);
    }
  }
}
//Delete Order for range on bollinger------------------------------------------------------------------------------------------------
void deletorderrangeonbolinger()
{
 for (int i=OrdersTotal()-1;i>=0;i--)
  {
  if (OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   {
    if(rangeonbolingerdelete()=="RANGEONUPPER" && OrderLots()==l )
    bool delete3 = OrderClose(OrderTicket(),l,OrderClosePrice(),3,clrRed);
    if(rangeonbolingerdelete()=="RANGEONUPPER" && OrderLots()==l/2 )
    bool delete4 = OrderClose(OrderTicket(),l/2,OrderClosePrice(),3,clrRed);
    if(rangeonbolingerdelete()=="RANGEONLOWER" && OrderLots()==l )
    bool delete5 = OrderClose(OrderTicket(),l,OrderClosePrice(),3,clrRed);
    if(rangeonbolingerdelete()=="RANGEONLOWER" && OrderLots()==l/2 )
    bool delete6 = OrderClose(OrderTicket(),l/2,OrderClosePrice(),3,clrRed);
    }
  }
}
//--------------------------------------------------------------------------------------------------------------------------------
void deletecandlerange()
{
 for (int i=OrdersTotal()-1;i>=0;i--)
  {
  if (OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   {
    if(rangecandledelete()=="RANGEON" && OrderLots()==l )
    bool delete7 = OrderClose(OrderTicket(),l,OrderClosePrice(),3,clrRed);
    if(rangecandledelete()=="RANGEON" && OrderLots()==l/2 )
    bool delete8 = OrderClose(OrderTicket(),l/2,OrderClosePrice(),3,clrRed);
    }
  }
}
//--------------------------------------------------------------------------------------------------------------------------------
void deleteopenbolinger()
{
 for (int i=OrdersTotal()-1;i>=0;i--)
  {
  if (OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   {
    if(openbolinger()=="UPPEROPEN" && OrderMagicNumber()==213 && OrderLots()==l )
    bool delete7 = OrderClose(OrderTicket(),l,OrderClosePrice(),3,clrRed);
    if(openbolinger()=="UPPEROPEN" && OrderMagicNumber()==213 && OrderLots()==l/2 )
    bool delete7 = OrderClose(OrderTicket(),l/2,OrderClosePrice(),3,clrRed);
    if(openbolinger()=="LOWEROPEN" && OrderMagicNumber()==212 && OrderLots()==l )
    bool delete8 = OrderClose(OrderTicket(),l,OrderClosePrice(),3,clrRed);
    if(openbolinger()=="LOWEROPEN" && OrderMagicNumber()==212 && OrderLots()==l/2 )
    bool delete8 = OrderClose(OrderTicket(),l/2,OrderClosePrice(),3,clrRed);
    }
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//********************************************************************************************************************************
//--------------------------------------------------------------------------------------------------------------------------------
//modification on Main------------------------------------------------------------------------------------------------------------
void modif1()
{
 for (int i=OrdersTotal()-1;i>=0;i--)
 {
  if (OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
   {
    if ( OrderLots()==l && OrderMagicNumber()==212 && inchannel()=="DOWN" && posonmain()=="ACTIVE" )
    {bool modif1=OrderModify(OrderTicket(),OrderOpenPrice(),iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0)-Traill1,
                                                                                               OrderTakeProfit(),0,clrWhite);
     bool closeo1 = OrderClose(OrderTicket(),l/2,OrderClosePrice(),3,clrRed);}
     
     if ( OrderLots()==l && OrderMagicNumber()==213 && inchannel()=="UP" && posonmain()=="ACTIVE" )
     {bool modif2=OrderModify(OrderTicket(),OrderOpenPrice(),iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0)+Traill1,
                                                                                                OrderTakeProfit(),0,clrWhite);
     bool closeo2 = OrderClose(OrderTicket(),l/2,OrderClosePrice(),3,clrRed);}
    }
 }
}
//----------------------------------------------------------------------------------------------------------------------------------
//modification on Main--------------------------------------------------------------------------------------------------------------
void modif2()
{
 for (int i=OrdersTotal()-1;i>=0;i--)
 {
  if (OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
  {
   if ( OrderLots()==l/2 && OrderMagicNumber()==212 && inchannel()=="UP" && posonmain()=="ACTIVE" )
   bool modif3=OrderModify(OrderTicket(),OrderOpenPrice(),iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0)-Traill2,
                                                                                             OrderTakeProfit(),0,clrWhite);
                                                                                                     
   if ( OrderLots()==l/2 && OrderMagicNumber()==213 && inchannel()=="DOWN" && posonmain()=="ACTIVE" )
   bool modif4=OrderModify(OrderTicket(),OrderOpenPrice(),iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0)+Traill2,
                                                                                             OrderTakeProfit(),0,clrWhite);  
   }
 }
}
//---------------------------------------------------------------------------------------------------------------------------------
//Modificatiion of OverBond Position-----------------------------------------------------------------------------------------------
void modif3()
{
 for (int i=OrdersTotal()-1;i>=0;i--)
 {
  if (OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
  {
   if ( OrderLots()==l/2 && OrderMagicNumber()==214 )
   bool modif5=OrderModify(OrderTicket(),OrderOpenPrice(),0,iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0),0,clrWhite);
   if ( OrderLots()==l/2 && OrderMagicNumber()==215 )
   bool modif6=OrderModify(OrderTicket(),OrderOpenPrice(),0,iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0),0,clrWhite);  
  }
 }
}
//*********************************************************************************************************************************
//---------------------------------------------------------------------------------------------------------------------------------
//Chekin---------------------------------------------------------------------------------------------------------------------------
int chekin()
{
  if (OrdersTotal()==0)
  return(0);
  else
  return(1);
}
//---------------------------------------------------------------------------------------------------------------------------------
//Execution------------------------------------------------------------------------------------------------------------------------
void exe()
{
 if (  chekin()==0  )
  {
       if (inchannel()=="DOWN" && nearbol()=="LOWERLINE" && rangeonbolingerdelete()!="RANGEONLOWER" && openbolinger()!="LOWEROPEN" )
           opennewpos("buy");
        
       if (inchannel()=="UP" && nearbol()=="UPPERLINE" && rangeonbolingerdelete()!="RANGEONUPPER" && openbolinger()!="UPPEROPEN" )
           opennewpos("sell");
     
  }
       
 if ( chekin()==1 )
   {
       bool sel= OrderSelect(0,SELECT_BY_POS,MODE_TRADES);
       if(posout()=="NEARLOWER" && OrderMagicNumber()==213 && OrderLots()==l/2) 
       closeorders("close1");  //CLOSE SELL
       if(posout()=="NEARLOWER" && OrderMagicNumber()==213 && OrderLots()==l) 
       closeorders("close2");  //CLOSE SELL
       
       if(posout()=="NEARUPPER" && OrderMagicNumber()==212 && OrderLots()==l/2)
       closeorders("close1");  //CLOSE BUY
       if(posout()=="NEARUPPER" && OrderMagicNumber()==212 && OrderLots()==l)
       closeorders("close2");  //CLOSE BUY
    }
}
//---------------------------------------------------------------------------------------------------------------------------------
void exevery()
{
 if (  chekin()==0  )
  {
       if (inchannel()=="RANGE" && nearbol()=="RANGE" && overchannel()=="VERYLOW" )
         openvery("buy");
           
       if (inchannel()=="RANGE" && nearbol()=="RANGE" && overchannel()=="VERYHIGH" )
         openvery("sell");
  }
}   
//---------------------------------------------------------------------------------------------------------------------------------
//Expert tick function-------------------------------------------------------------------------------------------------------------                                             
//---------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------
void OnTick()
  {
  exe();
  exevery();
  modif1();
  modif2();
  modif3();

  deletorder();
  //deletorderrangeonbolinger();
  deletecandlerange();
  deleteopenbolinger();
  
  Comment("BBS EXPERT Version 1.8","\n",
          "------------------------------------------------------------","\n",
          "In Channel : ", inchannel(),"\n",
          "Fix In Channel : ", fixinchannel(),"\n",
          "Near Bollinger : ", nearbol(),"\n",
          "Near Main : ", posonmain(),"\n",
          "-----------------------------------------------------------","\n",
          "Open Order Over Channel : ", overchannel(),"\n",
          "Delete Order Over Channel : ",overbol_del(),"\n",
          "Position Out Near Channel :",posout(),"\n",
          "-----------------------------------------------------------","\n",
          "Range on Bollinger : ",rangeonbolingerdelete(),"\n",
          "Candle Range :", rangecandledelete(),"\n",
          "Open Bolinger : ", openbolinger(),"\n",
          "Bollinger Period : "  ,b
          );
                                           
//View Lines----------------------------------------------------------------------------------------------------------------------------------
//nearbol-------------------------------------------------------------------------------------------------------------------------------------   
   ObjectMove("nerabolhigh",0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) - T1);          
   ObjectMove("nearbollow",0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0) + T1);
//posonmain-----------------------------------------------------------------------------------------------------------------------------------
   ObjectMove("posonmainup",0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0) + T2);
   ObjectMove("posonmaindown",0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0) - T2);
//overbol_del---------------------------------------------------------------------------------------------------------------------------------   
   ObjectMove("overbol_delhigh",0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) + T3);
   ObjectMove("overbol_dellow",0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0) - T3);
//posout-------------------------------------------------------------------------------------------------------------------------------------- 
   ObjectMove("posouthigh",0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) - T4); 
   ObjectMove("posoutlow",0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0) + T4);  
//Overbond------------------------------------------------------------------------------------------------------------------------------------
   ObjectMove("overbondhigh",0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) + Overbond); 
   ObjectMove("overbondlow",0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0) - Overbond);     
//--------------------------------------------------------------------------------------------------------------------------------------------                             
   }
//--------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------------
int OnInit()
  {
//nearbol-------------------------------------------------------------------------------------------------------------------------------------
   ObjectCreate("nerabolhigh", OBJ_HLINE , 0,Time[0],iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) - T1);
           ObjectSet("nerabolhigh", OBJPROP_STYLE, STYLE_DOT);
           ObjectSet("nerabolhigh", OBJPROP_COLOR, RoyalBlue);
           ObjectSet("nerabolhigh", OBJPROP_WIDTH, 0);
           ObjectSetText("nerabolhigh", "Some Text", 20, "Arial", Red);
   ObjectCreate("nearbollow", OBJ_HLINE , 0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0) + T1);
           ObjectSet("nearbollow", OBJPROP_STYLE, STYLE_DOT);
           ObjectSet("nearbollow", OBJPROP_COLOR, RoyalBlue);
           ObjectSet("nearbollow", OBJPROP_WIDTH, 0);
           ObjectSetText("nerabollow", "Some Text", 10, "Arial", Red);
//posonmain-----------------------------------------------------------------------------------------------------------------------------------
   ObjectCreate("posonmainup", OBJ_HLINE , 0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0) + T2 );
           ObjectSet("posonmainup", OBJPROP_STYLE, STYLE_DOT);
           ObjectSet("posonmainup", OBJPROP_COLOR, Green);
           ObjectSet("posonmainup", OBJPROP_WIDTH, 0);
   ObjectCreate("posonmaindown", OBJ_HLINE , 0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_MAIN,0) - T2);
           ObjectSet("posonmaindown", OBJPROP_STYLE, STYLE_DOT);
           ObjectSet("posonmaindown", OBJPROP_COLOR, Green);
           ObjectSet("posonmaindown", OBJPROP_WIDTH, 0);
//overbol_del----------------------------------------------------------------------------------------------------------------------------------    
   ObjectCreate("overbol_delhigh", OBJ_HLINE , 0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) + T3);
           ObjectSet("overbol_delhigh", OBJPROP_STYLE, STYLE_SOLID);
           ObjectSet("overbol_delhigh", OBJPROP_COLOR, Red);
           ObjectSet("overbol_delhigh", OBJPROP_WIDTH, 2);
   ObjectCreate("overbol_dellow", OBJ_HLINE , 0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0) - T3);
           ObjectSet("overbol_dellow", OBJPROP_STYLE, STYLE_SOLID);
           ObjectSet("overbol_dellow", OBJPROP_COLOR, Red);
           ObjectSet("overbol_dellow", OBJPROP_WIDTH, 2); 
//posout---------------------------------------------------------------------------------------------------------------------------------------      
   ObjectCreate("posouthigh", OBJ_HLINE , 0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) - T4);
           ObjectSet("posouthigh", OBJPROP_STYLE, STYLE_DOT);
           ObjectSet("posouthigh", OBJPROP_COLOR, OrangeRed);
           ObjectSet("posouthigh", OBJPROP_WIDTH, 0);
   ObjectCreate("posoutlow", OBJ_HLINE , 0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0) + T4);
           ObjectSet("posoutlow", OBJPROP_STYLE, STYLE_DOT);
           ObjectSet("posoutlow", OBJPROP_COLOR, OrangeRed);
           ObjectSet("posoutlow", OBJPROP_WIDTH, 0);
//Oveerbound-----------------------------------------------------------------------------------------------------------------------------------  
   ObjectCreate("overbondhigh", OBJ_HLINE , 0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_UPPER,0) + Overbond);
           ObjectSet("overbondhigh", OBJPROP_STYLE, STYLE_SOLID);
           ObjectSet("overbondhigh", OBJPROP_COLOR, DarkGreen);
           ObjectSet("overbondhigh", OBJPROP_WIDTH, 2);
   ObjectCreate("overbondlow", OBJ_HLINE , 0,Time[0], iBands(Symbol(),PERIOD_H1,b,2,0,PRICE_CLOSE,MODE_LOWER,0) - Overbond);
           ObjectSet("overbondlow", OBJPROP_STYLE, STYLE_SOLID);
           ObjectSet("overbondlow", OBJPROP_COLOR, DarkGreen);
           ObjectSet("overbondlow", OBJPROP_WIDTH, 2);
//---------------------------------------------------------------------------------------------------------------------------------------------
   return(INIT_SUCCEEDED);
  }
//---------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------------

   