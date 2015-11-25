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
       sample: String,
       typed: String
}

model : WordState
model = 
    { sample = "rake db:migragte", typed = "" }

-- VIEW
view : WordState -> Html
view model =
  div []
    [
    stringInput model
    , div [ myStyle ] [ text (toString model.sample) ]
    ]

stringInput : WordState -> Html
stringInput model =
  input
    [ placeholder "Text to reverse"
    , value model.typed
    , on "input" targetValue sendInput
    , myStyle
    ]
    []



sendInput: String -> Message
sendInput str =
  { sample = model.sample, typed = str } |> Signal.message actions.address 

myStyle : Attribute
myStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]

-- SIGNALS

actions : Signal.Mailbox WordState
actions =
  Signal.mailbox { sample = "rake db:migragte", typed = "" }

main : Signal Html
main =
  Signal.map view actions.signal
