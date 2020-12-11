defmodule QueroApiWeb.UniversityView do
  use QueroApiWeb, :view
  alias QueroApiWeb.UniversityView

  def render("index.json", %{universities: universities}) do
    %{data: render_many(universities, UniversityView, "university.json")}
  end

  def render("show.json", %{university: university}) do
    %{data: render_one(university, UniversityView, "university.json")}
  end

  def render("university.json", %{university: university}) do
    %{
      id: university.id,
      name: university.name,
      score: university.score,
      logo_url: university.logo_url
    }
  end
end
