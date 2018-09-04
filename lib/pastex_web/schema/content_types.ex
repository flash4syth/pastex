defmodule PastexWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  alias PastexWeb.ContentResolver

  object :content_queries do
    field :pastes, list_of(:paste) do
      resolve &ContentResolver.pastes/3
    end
  end

  object :paste do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :description, :string

    field :files, non_null(list_of(:file)) do
      resolve &ContentResolver.get_files/3
    end

    field :file_count, non_null(:integer)
  end

  object :file do
    field :id, non_null(:id)
    field :paste, non_null(:paste)

    field :name, :string do
      resolve fn file, _, _ ->
        {:ok, Map.get(file, :name) || "Untitled"}
      end
    end

    field :body, :string
  end
end