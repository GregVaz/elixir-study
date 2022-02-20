defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  import Ecto, warn: false

  alias Discuss.Contexts.TopicManager

  plug DiscussWeb.Plugs.RequiredAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    topics = TopicManager.list()
    render(conn, "index.html", topics: topics)
  end

  def show(conn, %{"id" => topic_id}) do
    topic = TopicManager.get!(topic_id)
    render(conn, "show.html", topic: topic)
  end

  def new(conn, _params) do
    changeset = TopicManager.change(%{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    changeset =
      conn.assigns.user
      |> build_assoc(:topics)
      |> TopicManager.change(topic)

    case TopicManager.create(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = TopicManager.get!(topic_id)
    changeset = TopicManager.change(topic)

    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = TopicManager.get!(topic_id)

    case TopicManager.update(old_topic, topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    TopicManager.get!(topic_id) |> TopicManager.delete!()

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  def check_topic_owner(%{params: %{"id" => topic_id}} = conn, _params) do
    if TopicManager.get!(topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end
end
