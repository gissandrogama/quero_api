defmodule QueroApiWeb.CampuView do
  use QueroApiWeb, :view
  alias QueroApiWeb.CampuView

  def render("index.json", %{campus: campus}) do
    %{data: render_many(campus, CampuView, "campu.json")}
  end

  def render("show.json", %{campu: campu}) do
    %{data: render_one(campu, CampuView, "campu.json")}
  end

  def render("campu.json", %{campu: campu}) do
    %{id: campu.id,
      name: campu.name,
      city: campu.city}
  end
end
