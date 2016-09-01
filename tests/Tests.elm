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
        ]
