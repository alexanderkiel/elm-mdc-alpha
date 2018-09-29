module Material.Options exposing
    ( Property
    , class
    , id
    , noOp
    , onClick
    , style
    , styled
    , when
    )

import Html exposing (Attribute)
import Html.Attributes
import Material.Internal.Options as Options


type alias Property config msg =
    Options.Property config msg


class : String -> Property c m
class =
    Options.class


style : String -> String -> Property c m
style =
    Options.style


styled :
    (List (Attribute msg) -> a)
    -> List (Property config msg)
    -> a
styled =
    Options.styled


onClick : msg -> Property config msg
onClick =
    Options.onClick


noOp : Property config msg
noOp =
    Options.noOp


when : Bool -> Property config msg -> Property config msg
when =
    Options.when


id =
    Options.id
