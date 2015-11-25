module KeyElm where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import String
import Signal exposing (..)
import Graphics.Input exposing (..)
import Signal exposing (..)
import Json.Decode as Json
import Graphics.Element exposing (..)


type alias WordState = {
       sample: List Char,
       typed: List Char,
       current_char: Int
}


model : WordState
model = {
    sample = String.toList "rake db:migragte", 
    typed = [],
    current_char = 0 }


-- VIEW
view : WordState -> Html
view model =
  div []
    [
    stringInput model
    , sample_word model.sample,
    div [] [ text <| toString model.current_char ]
    ]


sample_word: List Char -> Html
sample_word char_list =
  div [ myStyle ]
  (List.indexedMap sample_char char_list)
  --(List.indexedMap sample_char char_list)
  --(List.indexedMap (\i x -> sample_char) char_list)


sample_char: Int -> Char -> Html
sample_char index char = 
  let
    char_class =
      if index == model.current_char
        then currentChar
        else style []
  in
    span [ char_class ] [ text (String.fromChar char) ]  


stringInput : WordState -> Html
stringInput model =
  input
    [ placeholder ""
    , value <| String.fromList model.typed
    , on "input" targetValue sendInput
    , myStyle
    ]
    []


sendInput: String -> Message
sendInput str =
  { sample = model.sample, typed = String.toList str, current_char = model.current_char } |> Signal.message actions.address 


-- STYLES

myStyle : Attribute
myStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]


currentChar : Attribute
currentChar = 
  style
  [ ("border-bottom", "4px solid #f78d1d")
  ]


-- SIGNALS

actions : Signal.Mailbox WordState
actions =
  Signal.mailbox { sample = String.toList "rake db:migragte", typed = [], current_char = model.current_char + 1 }


main : Signal Html
main =
  Signal.map view actions.signal
