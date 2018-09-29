module Material.Fab exposing (Property, class, mini, onClick, view)

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events as Events
import Material.Icon as Icon
import Material.Options as Options


type Property msg
    = Class String
    | Click msg


view : List (Property msg) -> String -> Html msg
view properties name =
    let
        toClass property =
            case property of
                Class className ->
                    Just className

                Click _ ->
                    Nothing

        toAttr property =
            case property of
                Class _ ->
                    Nothing

                Click msg ->
                    Just (Events.onClick msg)

        classAttr =
            "mdc-fab"
                :: List.filterMap toClass properties
                |> String.join " "
                |> Attr.class

        attrs =
            classAttr
                :: List.filterMap toAttr properties
    in
    Html.button attrs [ Icon.view [ icon ] name ]


mini : Property msg
mini =
    Class "mdc-fab--mini"


class : String -> Property msg
class name =
    Class name


onClick : msg -> Property msg
onClick msg =
    Click msg


icon : Icon.Property msg
icon =
    Options.class "mdc-fab__icon"
