import Html exposing (beginnerProgram, div, button, text, ul, li, input, Html)
import Html.Events exposing (onClick, onInput)
import Array exposing (Array, toList, fromList, push, filter)


main =
  beginnerProgram { model = initialState, view = view, update = update }


type alias Model = { list: Array String, currentText: String }


initialState : Model
initialState = { list = Array.fromList [], currentText = "" }

view : Model -> Html Msg
view model =
  div []
    [ input [ onInput UpdateText] []
    , button [ onClick (AddTodo model.currentText) ] [ text "Add Todo" ]
    , button [ onClick (RemoveTodo model.currentText) ] [ text "Remove Todo" ]
    , ul [] (Array.toList (Array.map (\t -> li [] [text t]) model.list ))
    ]




type Msg = AddTodo String | RemoveTodo String | UpdateText String

update : Msg -> Model -> Model
update msg model =
  case msg of
    AddTodo todo ->
      { model | list = Array.push todo model.list }

    RemoveTodo todo ->
      { model | list = Array.filter (\t -> t /= todo) model.list }

    UpdateText todo ->
      { model | currentText = todo }
