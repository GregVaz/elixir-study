defmodule DiscussWeb.CommentChannel do
  use DiscussWeb, :channel
  alias Discuss.Repo
  alias Discuss.Contexts.Topic

  @impl true
  def join("comment:" <> topic_id, _payload, socket) do
    topic = Repo.get(Topic, topic_id)

    {:ok, %{}, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (comment:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end
end
