open PL_functor
open PL_modules 
open PL_data 

let makeSilent ((): unit) : unit = 
  printLines := false 

let makePP ((): unit) : unit = 
  begin 
    nand.execute <- NANDPP.execute; 
    nand.addSS <- NANDPP_SS.addSS; 
  end 

let makeGG ((): unit) : unit = 
  begin 
    nand.execute <- NANDGG.execute; 
    nand.addSS <- NANDGG_SS.addSS; 
  end 

(* turns SS on by setting switch *) 
let turnSSOn ((): unit) : unit = 
  ssSwitch := true

let flags = 
  [("-s", makeSilent); 
   ("-pp", makePP);
   ("-ll", makeGG);
   ("-addSS", turnSSOn); 
    ] 
