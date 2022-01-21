defmodule CumbucaWeb.Router do
  use CumbucaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]

    plug Plug.Parsers,
      parsers: [:urlencoded, :multipart, :json],
      pass: ["*/*"],
      json_decoder: Poison

    plug Cumbuca.Context
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: Cumbuca.Graphql.Schema,
      interface: :simple,
      context: %{pubsub: CumbucaWeb.Endpoint}
  end
end
