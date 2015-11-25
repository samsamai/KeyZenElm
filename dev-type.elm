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
       word: String
   }

model: WordState
model = 
    { word = "rake db:migragte" }

--word: Int -> String
--word count = 
--    String.append nextWord (toString count)

initialState = { word = "rake db:migragte" }

--nextWord =
--    "rake db:migragte"

update  newStr oldStr =
  newStr


view : Address WordState -> WordState -> Html
view address string =
  div []
    [ div [ myStyle ] [ text (toString string.word) ]
    , input
        [ placeholder "Text to reverse"
        , value (toString string.word)
        , on "input" targetValue (Signal.message address)
        , myStyle
        ]
        []
    , div [ myStyle ] [ text (toString string.word) ]
    ]


myStyle : Attribute
myStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]
