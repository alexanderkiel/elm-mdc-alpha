module Material.CircularProgress exposing
    ( Property
    , determinate
    , indeterminate
    , reversed
    , view
    )

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options exposing (class)
import String
import Svg
import Svg.Attributes as SvgAttr


type alias Config =
    { value : Float
    , determinate : Bool
    , indeterminate : Bool
    , reversed : Bool
    }


defaultConfig : Config
defaultConfig =
    { value = 0
    , determinate = False
    , indeterminate = False
    , reversed = False
    }


type alias Property msg =
    Options.Property Config msg


indeterminate : Property msg
indeterminate =
    Options.updateConfig (\config -> { config | indeterminate = True })


determinate : Float -> Property msg
determinate value =
    Options.updateConfig (\config -> { config | determinate = True, value = value })


reversed : Property msg
reversed =
    Options.updateConfig (\config -> { config | reversed = True })


view : List (Property msg) -> List (Html msg) -> Html msg
view properties _ =
    let
        ({ config } as summary) =
            Options.collect defaultConfig properties
    in
    Options.apply summary
        Html.div
        [ class "mdc-circular-progress" ]
        []
        [ Svg.svg
            [ SvgAttr.class "mdc-circular-progress__circle"
            , SvgAttr.viewBox "25 25 50 50"
            ]
            [ Svg.circle
                [ SvgAttr.class "mdc-circular-progress__path"
                , SvgAttr.cx "50"
                , SvgAttr.cy "50"
                , SvgAttr.r "20"
                , SvgAttr.fill "none"
                , SvgAttr.strokeWidth "4"
                , SvgAttr.strokeMiterlimit "10"
                ]
                []
            ]
        ]
