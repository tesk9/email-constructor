module SaveAble
    exposing
        ( SaveAble
        , new
        , draft
        , save
        , isSaved
        , edit
        , map
        , toMaybe
        )


type SaveAble a
    = Empty
    | Draft a
    | Saved a
    | EditingSaved a a


new : SaveAble a
new =
    Empty


draft : a -> SaveAble a
draft a =
    Draft a


save : SaveAble a -> Maybe (SaveAble a)
save saveable =
    case saveable of
        Empty ->
            Nothing

        Draft value ->
            Saved value |> Just

        Saved _ ->
            saveable |> Just

        EditingSaved _ value ->
            Saved value |> Just


isSaved : SaveAble a -> Bool
isSaved saveable =
    case saveable of
        Saved value ->
            True

        _ ->
            False


edit : SaveAble a -> Maybe (SaveAble a)
edit saveable =
    case saveable of
        Empty ->
            Nothing

        Draft value ->
            Nothing

        Saved savedValue ->
            EditingSaved savedValue savedValue |> Just

        EditingSaved _ _ ->
            Nothing


map : (a -> b) -> SaveAble a -> SaveAble b
map transform saveable =
    case saveable of
        Empty ->
            Empty

        Draft value ->
            Draft (transform value)

        Saved value ->
            Saved (transform value)

        EditingSaved old new ->
            EditingSaved (transform old) (transform new)


toMaybe : SaveAble a -> Maybe a
toMaybe saveable =
    case saveable of
        Empty ->
            Nothing

        Draft value ->
            value |> Just

        Saved value ->
            value |> Just

        EditingSaved old value ->
            value |> Just
