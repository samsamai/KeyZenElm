module DevType where

import Html exposing (Html, Attribute, text, toElement, div, input, span)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)
import StartApp.Simple as StartApp
import String
import Html exposing (Html, Attribute, text, toElement, div, input, span)

main =
  StartApp.start { model = model, view = view, update = update }

type alias WordState = {
       sample: List Char,
       typed: List Char,
       current_char: Int
}

model: WordState
model = {
    sample = String.toList "rake db:migragte", 
    typed = [],
    current_char = 0 }

update: String -> WordState -> WordState
update string oldModel =
  { sample = oldModel.sample, typed = String.toList string, current_char = (oldModel.current_char + 1)}

--view : Address WordState -> Html
view address model =
  div []
    [
    sample_word model
    , input
      [ placeholder ""
      , value <| String.fromList model.typed
      , on "input" targetValue (test address)
      , myStyle
      ]
      []
    , div [] [ text <| toString model.current_char ]
    ]


test address str =
  Signal.message address str

sample_word: WordState -> Html
sample_word m =
  div [ myStyle ]
  --[ text ("TEST" ++ toString m.current_char)]
  --(List.indexedMap sample_char m.sample)
  --(List.indexedMap sample_char char_list)
  --(List.indexedMap (\i x -> sample_char) char_list)
  (List.map3 sample_char [ 0 .. (List.length m.sample) - 1 ] (List.repeat (List.length m.sample) m.current_char ) m.sample)

sample_char: Int -> Int -> Char -> Html
sample_char index current_char char = 
  let
    char_class =
      if index == current_char
        then currentChar
        else style []
  in
    span [ char_class ] [ text ((String.fromChar char)) ]  


--stringInput : WordState -> Html
--stringInput model =
--  input
--    [ placeholder ""
--    , value <| String.fromList model.typed
--    , on "input" targetValue sendInput
--    , myStyle
--    ]
--    []


--sendInput: String -> Signal.Message
--sendInput address str =
--  { sample = model.sample, typed = String.toList str, current_char = model.current_char } |> Signal.message address


--view : Address WordState -> WordState -> Html
--view address string =
--  div []
--    [ div [ myStyle ] [ text (toString string.word) ]
--    , input
--        [ placeholder "Text to reverse"
--        , value (toString string.word)
--        , on "input" targetValue (Signal.message address)
--        , myStyle
--        ]
--        []
--    , div [ myStyle ] [ text (toString string.word) ]
--    ]


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

