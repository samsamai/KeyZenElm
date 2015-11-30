module DevType where

import Html exposing (Html, Attribute, text, toElement, div, input, span)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)
import StartApp.Simple as StartApp
import String
import Html exposing (Html, Attribute, text, toElement, div, input, span)
import List exposing (..)
import Array exposing (..)

main =
  StartApp.start { model = model, view = view, update = update }

type alias WordState = {
       sample: Array Char,
       typed: Array Char,
       current_char: Int
}

model: WordState
model = {
    sample = String.toList "rake db:migrate" |> Array.fromList, 
    typed = Array.fromList [],
    current_char = 0 }

update: WordState -> WordState -> WordState
update new_model old_model =
  new_model

view : Address WordState -> WordState -> Html
view address model =
  div [word]
    [
    sample_word model
    , input
      [ placeholder ""
      , value <| String.fromList <| Array.toList model.typed
      , on "input" targetValue (makeMessage address model)
      , myStyle
      ]
      []
    , div [] [ text <| toString model.current_char ]
    ]

makeMessage : Address WordState -> WordState -> String -> Signal.Message
makeMessage address model str =
  Signal.message address { sample = model.sample, typed = Array.fromList( String.toList str ), current_char = (String.length  str )}


sample_word: WordState -> Html
sample_word m =
  div [ myStyle ]
  --(List.map4 sample_char [ 0 .. (List.length m.sample) - 1 ] (List.repeat (List.length m.sample) m.current_char ) m.sample m.sample)
  --( Array.foldr (\x acc -> (sample_char x m) :: acc) [] Array.fromList([ 0 .. (Array.length m.sample) - 1 ]) )
  ( Array.foldr (\x acc -> (sample_char x m) :: acc) [] (Array.fromList[ 0 .. (Array.length m.sample) - 1 ]) )

--sample_char2 model index
--  let
--    char_class =
--      if index == current_char
--        then currentChar
--      else if model.sample[index] == model.typed[index]
--        then goodChar
--      else errorChar
--  in

sample_char: Int -> WordState -> Html
sample_char index model = 
    let
      char_class =
        if index > model.current_char
          then normalChar
        else if index == model.current_char
          then currentChar
        else if (Array.get index model.sample) == (Array.get index model.typed)
          then goodChar
        else if (Array.get index model.sample) /= (Array.get index model.typed)
          then errorChar
        else untypedChar
    in
    span [ char_class ] [ model.sample
              |> Array.get index 
              |> Maybe.withDefault ' ' 
              |> String.fromChar 
              |> text ]  

myStyle : Attribute
myStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]

word : Attribute
word = 
  style
  [
    ("color", "#AAA"),
    --("position", "absolute"),
    --("top", "50%"),
    --("margin-top", "-64px"),
    --("height", "128px"),
    --("font-size", "128px"),
    ("width", "100%"),
    ("padding", "0px"),
    ("text-align", "center"),
    ("margin-left", "auto"),
    ("margin-right", "auto"),
    ("word-wrap", "break-word"),
    ("text-shadow", "0px 2px 3px #000")
  ]  


normalChar : Attribute
normalChar = 
  style
  [ 
  ]

currentChar : Attribute
currentChar = 
  style
  [ ("border-bottom", "4px solid #f78d1d")
  ]

errorChar : Attribute
errorChar = 
  style
  [ ("color", "#FF0000") ]

goodChar : Attribute
goodChar = 
  style
  [ ("color", "#AAAAAA")
  , ("text-shadow", "0px 1px 1px #FFF, 0px 2px 2px #FFF")
  ]

untypedChar : Attribute
untypedChar = 
  style
  [ ("color", "#EEEEEE")
  ]
