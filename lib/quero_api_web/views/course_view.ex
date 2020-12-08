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
    course = Enum.into(course, %{})

    %{
      course: %{
        name: course.course.name,
        kind: course.course.kind,
        level: course.course.level,
        shift: course.course.shift,
        university: %{
          name: course.university.name,
          score: course.university.score,
          logo_url: course.university.logo_url
        },
        campus: %{
          name: course.campus.name,
          city: course.campus.city
        }
      }
    }
  end
end
