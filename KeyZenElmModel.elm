module KeyZenElmModel where

import String
import List exposing (..)
import Array exposing (..)
import Random exposing (..)
import Time exposing (..)
import Signal exposing (..)

chars = " jfkdlsahgyturieowpqbnvmcxz6758493021`-=[]\\;',./ABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*()_+{}|:\"<>?"
        |> String.toList |> Array.fromList

wordLength = 7

gen = Random.int 0 100
seed0 = Random.initialSeed 42

type alias WordState = {
       sample: Array Char,
       training_chars: Array Char,
       typed: Array Char,
       current_char: Int,
       current_word: Int,
       char_index: Int,
       next_seed : Seed
}

type alias RandState = {
       seed: Random.Seed,
       char: Char
}

randState0 = { 
  seed = seed0, 
  char = '_' }


intList : Generator (List Int)
intList =
    list 5 (int 0 100)


randomInt : WordState -> WordState -> WordState
randomInt model old_model =
  let
      (i, s) = Random.generate (Random.int 0 (Array.length old_model.training_chars)) old_model.next_seed
  in
      { model | next_seed = s, char_index = i }


nextRandomWord : WordState -> Array Char
nextRandomWord model =
    List.repeat 10 (model0) |> List.scanl randomInt model0 |> Array.fromList |> Array.map x

x : WordState -> Char
x model =
  Array.get model.char_index model.training_chars |> Maybe.withDefault ' '

seed =
  Random.initialSeed 4321


wordArray : Array String
wordArray = 
  Array.fromList [ "rake db:migrate", 
    "rake db:reset", "rails s", "rails c", "binding.pry", "{h:'a', i:'b'}" ]


model0: WordState
model0 = {
    sample = Array.fromList [], 
    typed = Array.fromList [],
    current_char = 0,
    current_word = 0,
    char_index = 0,
    training_chars = chars,
    next_seed = seed0
  }


nextWord : Int -> String
nextWord current_index =
  let 
    index = current_index
  in  
    wordArray
    |> Array.get current_index 
    |> Maybe.withDefault ""
    
