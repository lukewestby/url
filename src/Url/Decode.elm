module Url.Decode exposing (..)


custom : Decoder a -> Decoder (a -> b) -> Decoder b
custom fn a =
    Debug.crash "TODO"


map : (a -> b) -> Decoder a -> Decoder b
map fn a =
    Debug.crash "TODO"


default : a -> Decoder a
default =
    Debug.crash "TODO"


decode : a -> Decoder a
decode =
    Debug.crash "TODO"


path : String -> Decoder a -> Decoder a
path =
    Debug.crash "TODO"


oneOf : List (Decoder a) -> Decoder a
oneOf =
    Debug.crash "TODO"


decodeUrl : String -> Decoder a -> Result String a
decodeUrl url =
    Debug.crash "TODO"


pathVal : PrimitiveDecoder a -> Decoder (a -> b) -> Decoder b
pathVal =
    Debug.crash "TODO"


string : PrimitiveDecoder a
string =
    Debug.crash "TODO"


type Decoder a
    = Decoder a


type PrimitiveDecoder a
    = PrimitiveDecoder a
