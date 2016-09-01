module Trains exposing (..)

import Url.Decode as Decode exposing (..)


type Page
    = Home
    | Stops TrainRoute String
    | NotFound


type TrainRoute
    = TrainRoute String



-- /train/routes/Red/stops/41230


trainRoute : Decoder TrainRoute
trainRoute =
    decode TrainRoute
        |> path "train"
        |> path "routes"
        |> pathVal string


stops : Decoder Page
stops =
    decode Stops
        |> custom trainRoute
        |> path "stops"
        |> pathVal string


topLevel : String -> Page
topLevel url =
    [ stops
    , default Home
    ]
        |> oneOf
        |> decodeUrl url
        |> Result.withDefault NotFound
