module Material.LinearProgress exposing
    ( view
    , buffered
    , determinate
    , indeterminate
    , reversed
    )

{-| Progress indicators express an unspecified wait time or display the length of a process.


# View

@docs view


# Properties

@docs buffered
@docs determinate
@docs indeterminate
@docs reversed

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options exposing (class, style, styled, updateConfig, when)
import String


type alias Config =
    { value : Float
    , buffer : Float
    , determinate : Bool
    , indeterminate : Bool
    , buffered : Bool
    , reversed : Bool
    }


defaultConfig : Config
defaultConfig =
    { value = 0
    , buffer = 0
    , determinate = False
    , indeterminate = False
    , buffered = False
    , reversed = False
    }


type alias Property msg =
    Options.Property Config msg


{-| -}
indeterminate : Property msg
indeterminate =
    updateConfig (\config -> { config | indeterminate = True })


{-| -}
determinate : Float -> Property msg
determinate value =
    updateConfig (\config -> { config | determinate = True, value = value })


{-| -}
buffered : Float -> Float -> Property msg
buffered value buffer =
    updateConfig (\config -> { config | buffered = True, value = value, buffer = buffer })


{-| -}
reversed : Property msg
reversed =
    updateConfig (\config -> { config | reversed = True })


{-| -}
view : List (Property msg) -> List (Html msg) -> Html msg
view options _ =
    let
        ({ config } as summary) =
            Options.collect defaultConfig options
    in
    Options.apply summary
        Html.div
        [ class "mdc-linear-progress"
        , class "mdc-linear-progress--indeterminate" |> when config.indeterminate
        , class "mdc-linear-progress--reversed" |> when config.reversed
        ]
        []
        [ Html.div
            [ Attr.class "mdc-linear-progress__buffering-dots"
            ]
            []
        , styled Html.div
            [ class "mdc-linear-progress__buffer"
            , when config.buffered <|
                style "transform" ("scaleX(" ++ String.fromFloat config.buffer ++ ")")
            ]
            []
        , styled Html.div
            [ class "mdc-linear-progress__bar mdc-linear-progress__primary-bar"
            , when (not config.indeterminate) <|
                style "transform" ("scaleX(" ++ String.fromFloat config.value ++ ")")
            ]
            [ Html.span [ Attr.class "mdc-linear-progress__bar-inner" ] []
            ]
        , Html.div
            [ Attr.class "mdc-linear-progress__bar mdc-linear-progress__secondary-bar"
            ]
            [ Html.span [ Attr.class "mdc-linear-progress__bar-inner" ] []
            ]
        ]
