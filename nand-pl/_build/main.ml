open PL_functor 
open PL_modules
open SS 

module NAND = PLFromBackEnd(NANDPP_back_end)  
module SS_lang = SSFromBackEnd(NANDPP_back_end) 
let () =
  let _ =
    if Array.length Sys.argv <> 3 then
     ((Format.printf "Usage: nand <file> <flags> <binary input>\n"); exit 0) in
  let fileName = Sys.argv.(1) in
  let startExt = (String.rindex fileName '.') + 1 in
  let ext = String.sub fileName startExt ((String.length fileName) - startExt) in
    let _ =
      if ext <> "nand" then
       ((Format.printf "Must provide a .nand file as input\n"); exit 0) in
  let file = open_in fileName in
  let lexbuf = Lexing.from_channel file in
  let program = NANDparser.parseProg NANDlexer.token lexbuf in
   let program = SS_lang.addSS program in  
  let output = NAND.execute program Sys.argv.(2) in
      Printf.printf "Output is %s\n" output