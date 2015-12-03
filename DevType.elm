module DevType where

import StartApp.Simple as StartApp
import DevTypeModel exposing (..)
import DevTypeView exposing (..)

main =
  StartApp.start { model = model, view = view, update = update }
