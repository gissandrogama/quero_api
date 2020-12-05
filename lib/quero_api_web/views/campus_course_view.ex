defmodule QueroApiWeb.CampusCourseView do
  use QueroApiWeb, :view
  alias QueroApiWeb.CampusCourseView

  def render("index.json", %{campus_courses: campus_courses}) do
    %{data: render_many(campus_courses, CampusCourseView, "campus_course.json")}
  end

  def render("show.json", %{campus_course: campus_course}) do
    %{data: render_one(campus_course, CampusCourseView, "campus_course.json")}
  end

  def render("campus_course.json", %{campus_course: campus_course}) do
    %{id: campus_course.id}
  end
end
