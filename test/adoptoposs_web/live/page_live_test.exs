defmodule AdoptopossWeb.PageLiveTest do
  use AdoptopossWeb.ConnCase

  import Phoenix.LiveViewTest
  import Adoptoposs.Factory

  alias AdoptopossWeb.PageLive

  test "GET / shows the landing page for not logged in users", %{conn: conn} do
    conn = get(conn, Routes.live_path(conn, PageLive))

    assert html_response(conn, 200) =~ "Adoptoposs."
    refute html_response(conn, 200) =~ "Projects For You"
    {:ok, _view, _html} = live(conn)
  end

  test "GET / shows the user dashboard for logged in users", %{conn: conn} do
    user = insert(:user)

    conn =
      conn
      |> init_test_session(%{current_user: user})
      |> put_req_header("content-type", "html")
      |> get(Routes.live_path(conn, PageLive))

    assert html_response(conn, 200) =~ "Projects For You"
    refute html_response(conn, 200) =~ "Adoptoposs."
    {:ok, _view, _html} = live(conn)
  end
end
