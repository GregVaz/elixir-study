defmodule Discuss.Test.Contexts.TopicTest do
  use ExUnit.Case
  alias Discuss.{Repo}
  alias Discuss.Contexts.{TopicManager}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "Topics" do
    setup do
    end

    test "list all" do
      setup do
        # It is necesary to create a mockup with a github session to create a user for the belongs_to relation
        {:ok, _topic} = TopicManager.create(%{"title" => "Javascript"})
      end

      assert true
    end
  end
end
