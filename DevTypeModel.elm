module DevTypeModel where

import String
import List exposing (..)
import Array exposing (..)

type alias WordState = {
       sample: Array Char,
       typed: Array Char,
       current_char: Int,
       current_word: Int
}


wordArray : Array String
wordArray = 
  Array.fromList [ "rake db:migrate", 
    "rake db:reset", "rails s", "rails c", "binding.pry", "{h:'a', i:'b'}" ]


model: WordState
model = {
    sample = nextWord 0 
              |> String.toList 
              |> Array.fromList, 
    typed = Array.fromList [],
    current_char = 0,
    current_word = 0 }


nextWord : Int -> String
nextWord current_index =
  let 
    index = current_index
  in  
    wordArray
    |> Array.get current_index 
    |> Maybe.withDefault ""
    
