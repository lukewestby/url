module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Url.Encode as Encode
import Http
import Fuzz exposing (..)


all : Test
all =
    describe "Url.Encode.encode"
        [ test "given two empty lists, returns empty string" <|
            \() ->
                ""
                    |> Expect.equal (Encode.encode [] [])
        , test "given multiple empty strings, returns slashes" <|
            \() ->
                "///"
                    |> Expect.equal (Encode.encode [ "", "", "", "" ] [])
        , test "given some path, does the right thing" <|
            \() ->
                "foo/bar"
                    |> Expect.equal (Encode.encode [ "foo", "bar" ] [])
        , test "does URIEncode on the parts" <|
            \() ->
                "foo%2Fbar/bar%2Fbaz"
                    |> Expect.equal (Encode.encode [ "foo/bar", "bar/baz" ] [])
        , fuzz (list string) "works for arbitrarily many parts with no query string" <|
            \parts ->
                parts
                    |> List.map Http.uriEncode
                    |> String.join "/"
                    |> Expect.equal (Encode.encode parts [])
        , test "works with one query param" <|
            \() ->
                "foo/bar?baz=qux"
                    |> Expect.equal
                        (Encode.encode [ "foo", "bar" ]
                            [ ( "baz", "qux" ) ]
                        )
        , test "works with multiple query params" <|
            \() ->
                "foo/bar?baz=qux&blah=42"
                    |> Expect.equal
                        (Encode.encode [ "foo", "bar" ]
                            [ ( "baz", "qux" )
                            , ( "blah", "42" )
                            ]
                        )
        , fuzz (list (tuple ( string, string ))) "works with arbitrary query params" <|
            \pairs ->
                let
                    withoutQuestionMark =
                        pairs
                            |> List.map queryFromPair
                            |> String.join "&"

                    result =
                        if String.isEmpty withoutQuestionMark then
                            ""
                        else
                            "?" ++ withoutQuestionMark
                in
                    result
                        |> Expect.equal
                            (Encode.encode [ "foo", "bar" ]
                                [ ( "baz", "qux" )
                                , ( "blah", "42" )
                                ]
                            )
        ]


queryFromPair : ( String, String ) -> String
queryFromPair ( key, value ) =
    Http.uriEncode key ++ "=" ++ Http.uriEncode value
