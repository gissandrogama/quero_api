defmodule QueroApiWeb.CampuController do
  use QueroApiWeb, :controller

  alias QueroApi.Campus
  alias QueroApi.Campus.Campu

  action_fallback QueroApiWeb.FallbackController

  def index(conn, _params) do
    campus = Campus.list_campus()
    render(conn, "index.json", campus: campus)
  end

  def create(conn, %{"campu" => campu_params}) do
    with {:ok, %Campu{} = campu} <- Campus.create_campu(campu_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.campu_path(conn, :show, campu))
      |> render("show.json", campu: campu)
    end
  end

  def show(conn, %{"id" => id}) do
    campu = Campus.get_campu!(id)
    render(conn, "show.json", campu: campu)
  end

  def update(conn, %{"id" => id, "campu" => campu_params}) do
    campu = Campus.get_campu!(id)

    with {:ok, %Campu{} = campu} <- Campus.update_campu(campu, campu_params) do
      render(conn, "show.json", campu: campu)
    end
  end

  def delete(conn, %{"id" => id}) do
    campu = Campus.get_campu!(id)

    with {:ok, %Campu{}} <- Campus.delete_campu(campu) do
      send_resp(conn, :no_content, "")
    end
  end
end
