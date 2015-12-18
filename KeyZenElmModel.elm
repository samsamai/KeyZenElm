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


--getRandom : Seed -> Int
--getRandom seed =
--  let
--    (index,_) = Random.generate intList seed
--  in
--    index

randomInt : WordState -> WordState -> WordState
randomInt model old_model =
  let
      (i, s) = Random.generate (Random.int 0 (Array.length old_model.training_chars)) old_model.next_seed
  in
      { model | next_seed = s, char_index = i }


nextRandomWord : WordState -> Array Char
nextRandomWord model =
    --Array.repeat 10 (x model)
    --Array.repeat 10 (model0) |> Array.map randomInt |> Array.map x
    List.repeat 10 (model0) |> List.scanl randomInt model0 |> Array.fromList |> Array.map x
  --Array.repeat 10 (randState0) |> newRandom |> chooseChar
  --need to use some sort of accumulation here, fold?

x : WordState -> Char
x model =
  Array.get model.char_index model.training_chars |> Maybe.withDefault ' '


--newRandom : RandState -> RandState
--newRandom old_model  = 
--  let
--    seed1 = old_model.seed
--    (index,seed') = (Random.generate (Random.int 0 (Array.length old_model.training_chars)) seed1)
--  in
--    { old_model | seed <- seed', char <- 'x' }

--test : Time -> Int
--test time = 
--  10

seed =
  Random.initialSeed 4321

--chooseChar : RandState -> Char
--chooseChar model = 
--  let
--    --(index,_) = (Random.generate (Random.int 0 (Array.length trainingCharArray)) (model.seed))
--    (index, seed') = Random.generate (Random.int 0 (Array.length model.training_chars)) (model.seed)
--  in
--    --Array.get model.char_index model.training_chars |> Maybe.withDefault ' '
--    'p'


--getRandomChar : WordState -> Char
--getRandomChar model =
--  chars |> Array.get 10 |> Maybe.withDefault ' '
  
  --function generate_word() {
  --    word = '';
  --    for(var i = 0; i < data.word_length; i++) {
  --        c = choose(get_training_chars());
  --        if(c != undefined && c != word[word.length-1]) {
  --            word += c;
  --        }
  --        else {
  --            word += choose(get_level_chars());
  --        }
  --    }
  --    return word;
  --}


  --function get_training_chars() {
  --    var training_chars = [];
  --    var level_chars = get_level_chars();
  --    for(var x in level_chars) {
  --        if (data.in_a_row[level_chars[x]] < data.consecutive) {
  --            training_chars.push(level_chars[x]);
  --        }
  --    }
  --    return training_chars;
  --}

  --function choose(a) {
  --    return a[Math.floor(Math.random() * a.length)];
  --}


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


--step : a -> WordState -> WordState
--step _ state =
--    let (index, seed') = Random.generate gen state.seed
--    --in State seed' first second
--    --in WordState (Array.fromList [])  (Array.fromList []) 0 0 0 
--    in
--      { old_model | seed <- seed', char_index <- index }


nextWord : Int -> String
nextWord current_index =
  let 
    index = current_index
  in  
    wordArray
    |> Array.get current_index 
    |> Maybe.withDefault ""
    
