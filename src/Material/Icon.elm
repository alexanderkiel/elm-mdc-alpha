module Material.Icon exposing (Property, view)

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options


type alias Property msg =
    Options.Property () msg


view : List (Property msg) -> String -> Html msg
view properties name =
    let
        summary =
            Options.collect () properties
    in
    Options.apply summary
        Html.span
        [ Options.class "material-icons" ]
        []
        [ Html.text name ]
