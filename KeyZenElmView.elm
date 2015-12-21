module KeyZenElmView where

import Html exposing (Html, Attribute, text, toElement, div, input, span)
import Html.Attributes exposing (..)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)
import StartApp.Simple as StartApp
import String
import Html exposing (Html, Attribute, text, toElement, div, input, span)
import List exposing (..)
import Array exposing (..)
import Debug exposing (..)
import Random exposing (..)

import KeyZenElmModel exposing (..)


update: WordState -> WordState -> WordState
update new_model old_model =
  new_model


view : Address WordState -> WordState -> Html
view address model =
  div [body]
    [
      div [word]
        [
        sample_word model
        , input
          [ placeholder ""
          , value <| String.fromList <| Array.toList model.typed
          , on "input" targetValue (makeMessage address model)
          , autofocus True
          , input_style
          ]
          []
        , div [] [ text <| toString model.current_char ]
        ]
    ]


makeMessage : Address WordState -> WordState -> String -> Signal.Message
makeMessage address model str =
  let
    typed_count = String.length str

    new_model = 
      if typed_count > Array.length model.sample
        then
          let
            current_word = 
              if (model.current_word + 1) >= Array.length wordArray
                then 0
              else
                model.current_word + 1
          in
            { model0 | sample = nextWord current_word |> String.toList |> Array.fromList, typed = Array.fromList [], current_char = 0, current_word = current_word }
          --createNextModel model
      else
        { model | typed = Array.fromList( String.toList str ), current_char = (String.length str )}
  in
    Signal.message address new_model


createNextModel : WordState -> WordState
createNextModel old_model =
  let
    (_,seed') = (Random.generate (Random.int 0 500) (old_model.next_seed))
    new_model = { model0 | next_seed = seed' }
  in
    { new_model | sample = nextRandomWord new_model, next_seed = seed' }


sample_word: WordState -> Html
sample_word m =
  div [ myStyle ]
  ( Array.foldr (\x acc -> (sample_char x m) :: acc) [] (Array.fromList[ 0 .. (Array.length m.sample) - 1 ]) )


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

body : Attribute
body = 
  style
  [
    ("background-image", "url('brushed_alu.png')"),
    ("font-family", "'Ubuntu Monokz', sans-serif"),
    ("padding", "0"),
    ("margin", "0"),
    ("min-height", "100%"),
    ("outline", "none")
  ]


myStyle : Attribute
myStyle =
  style
    [ ("width", "100%")
    , ("height", "68px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]

input_style : Attribute
input_style =
  style
    [ ("width", "100%")
    , ("height", "68px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    , ("background", "transparent")
    , ("border", "none")
    ]

word : Attribute
word = 
  style
  [
    ("color", "#AAA"),
    --("position", "absolute"),
    --("top", "50%"),
    --("margin-top", "-64px"),
    ("font-size", "28px"),
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
