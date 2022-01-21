defmodule Discuss.Schema do
  @moduledoc """
  Base schema attributes configuration. This macro must be used in all schemas.

  For more reference vistit: https://hexdocs.pm/ecto/Ecto.Schema.html#module-schema-attributes.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamps_opts [type: :utc_datetime_usec]
    end
  end
end
