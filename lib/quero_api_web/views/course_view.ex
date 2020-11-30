defmodule QueroApiWeb.CourseView do
  use QueroApiWeb, :view
  alias QueroApiWeb.CourseView

  def render("index.json", %{courses: courses}) do
    %{data: render_many(courses, CourseView, "course.json")}
  end

  def render("show.json", %{course: course}) do
    %{data: render_one(course, CourseView, "course.json")}
  end

  def render("course.json", %{course: course}) do
    %{id: course.id,
      name: course.name,
      kind: course.kind,
      level: course.level,
      shift: course.shift}
  end
end
