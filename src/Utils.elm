module Utils exposing (..)


tuple2 : (b -> c) -> ( a, b ) -> ( a, c )
tuple2 transform ( a, b ) =
    ( a, transform b )
