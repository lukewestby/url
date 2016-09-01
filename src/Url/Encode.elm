module Url.Encode exposing (..)

import Http
import String


type Page
    = Home
    | Profile String


encode : List String -> List ( String, String ) -> String
encode parts queryKeyValues =
    -- TODO do something with queryKeyValues
    parts
        |> List.map Http.uriEncode
        |> String.join "/"
