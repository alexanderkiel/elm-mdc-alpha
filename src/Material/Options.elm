module Material.Options exposing
    ( class
    , id
    , onClick
    , style
    , noOp
    , when
    , styled
    )

{-| Common properties for Material components.


# Properties

@docs class
@docs id
@docs onClick
@docs style
@docs noOp


# Modifier

@docs when


# Working with HTML

@docs styled

-}

import Html exposing (Attribute)
import Html.Attributes
import Material.Internal.Options as Options exposing (Property)


{-| A single CSS class property.
-}
class : String -> Property config msg
class =
    Options.class


{-| A CSS style as property.
-}
style : String -> String -> Property config msg
style =
    Options.style


{-| Style HTML elements using properties instead of HTML attributes.

    Takes an HTML element constructor and a list of properties and returns that
    element constructor with the corresponding HTML attributes applied.

    Example:

        styled Html.h2 [ class "title" ]

-}
styled :
    (List (Attribute msg) -> a)
    -> List (Property config msg)
    -> a
styled =
    Options.styled


{-| Like HTML onClick but as property.
-}
onClick : msg -> Property config msg
onClick =
    Options.onClick


{-| Conditionally apply a property.

    Example:

        onClick Msg |> when enabled

-}
when : Bool -> Property config msg -> Property config msg
when =
    Options.when


{-| Sets the HTML id attribute of a component. In components like `Checkbox` or
`TextField` the id is set on the native control HTML element.
-}
id : String -> Property { config | id : Maybe String } msg
id s =
    Options.updateConfig (\config -> { config | id = Just s })


{-| A property which just does nothing.

    This is useful in `Maybe.withDefault`.

    Example:

        Maybe.map (onClick << Tell) maybeValue
            |> Maybe.withDefault Options.noOp

-}
noOp : Property config msg
noOp =
    Options.noOp
