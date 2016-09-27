import Counter exposing (Msg(..))
import Html exposing (Html, button, div, text)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)

init : Model
init = Model Nothing [] []


main =
  Html.App.program
    { init = (init, Cmd.none)
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    }

type Msg =
    AddButton
    | CounterMsg Counter.Msg


type alias Model =
    { current: Maybe Counter.Model
    , after: List Counter.Model
    , before: List Counter.Model
    }


view : Model -> Html Msg
view model =
    div []
        (List.concat
            [ [button [onClick AddButton] [text "We are great"]]
            , showMeCounters model
            ])


showMeCounters : Model -> List (Html Msg)
showMeCounters model =
    List.map (Html.App.map CounterMsg) (List.map Counter.view model.after)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        AddButton ->
            (appendItem model Counter.model) ! []
        CounterMsg msg ->
            model ! []
--            Counter.update msg model


appendItem : Model -> Counter.Model -> Model
appendItem model item =
    case model.current of
        Nothing ->
            {model | current = Just item}
        Just _ ->
            {model | after = model.after ++ [item]}

