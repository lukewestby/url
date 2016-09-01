module Url.Encode exposing (..)

import Http
import String


encode : List String -> List ( String, String ) -> String
encode parts queryKeyValues =
    let
        withoutQuery =
            parts
                |> List.map Http.uriEncode
                |> String.join "/"
    in
        withoutQuery ++ paramsToString queryKeyValues


paramsToString : List ( String, String ) -> String
paramsToString pairs =
    let
        withoutQuestionMark =
            pairs
                |> List.map queryFromPair
                |> String.join "&"
    in
        if String.isEmpty withoutQuestionMark then
            ""
        else
            "?" ++ withoutQuestionMark


queryFromPair : ( String, String ) -> String
queryFromPair ( key, value ) =
    let
        encodedKey =
            Http.uriEncode key
    in
        if String.isEmpty value then
            encodedKey
        else
            encodedKey ++ "=" ++ Http.uriEncode value
