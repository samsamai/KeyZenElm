module KeyZenElm where

import StartApp.Simple as StartApp
import Random exposing (..)

import KeyZenElmModel exposing (..)
import KeyZenElmView exposing (..)

port startTime : Float

firstSeed : Seed
firstSeed =
  Random.initialSeed <| round startTime

main =
  StartApp.start { model = { model0 | next_seed = firstSeed }, view = view, update = update }
