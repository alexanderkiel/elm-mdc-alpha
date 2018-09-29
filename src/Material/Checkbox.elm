module Material.Checkbox exposing (Property, view)

import Html exposing (Html)
import Html.Attributes as Attr
import Material.Internal.Options as Options
import Svg
import Svg.Attributes as SvgAttr


type alias Property msg =
    Options.Property () msg


view : List (Property msg) -> Bool -> Html msg
view properties checked =
    Options.styled Html.div
        (Options.class "mdc-checkbox" :: properties)
        [ Html.input
            [ Attr.class "mdc-checkbox__native-control"
            , Attr.type_ "checkbox"
            , Attr.checked checked
            ]
            []
        , Html.div [ Attr.class "mdc-checkbox__background" ]
            [ Svg.svg
                [ SvgAttr.class "mdc-checkbox__checkmark"
                , SvgAttr.viewBox "0 0 24 24"
                ]
                [ Svg.path
                    [ SvgAttr.class "mdc-checkbox__checkmark-path"
                    , SvgAttr.fill "none"
                    , SvgAttr.stroke "white"
                    , SvgAttr.d "M1.73,12.91 8.1,19.28 22.79,4.59"
                    ]
                    []
                ]
            , Html.div [ Attr.class "mdc-checkbox__mixedmark" ] []
            ]
        ]
