defmodule QueroApiWeb.CourseController do
  use QueroApiWeb, :controller

  alias QueroApi.Courses
  # alias QueroApi.Courses.Course

  action_fallback QueroApiWeb.FallbackController

  def index(conn, %{
        "kind" => kind,
        "level" => level,
        "university" => university,
        "shift" => shift
      }) do
    params = [kind: kind, level: level, university: university, shift: shift]
    courses = Courses.list_all_in_courses(params)
    render(conn, "index.json", courses: courses)
  end

  # def create(conn, %{"course" => course_params}) do
  #   with {:ok, %Course{} = course} <- Courses.create_course(course_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.course_path(conn, :show, course))
  #     |> render("show.json", course: course)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   course = Courses.get_course!(id)
  #   render(conn, "show.json", course: course)
  # end

  # def update(conn, %{"id" => id, "course" => course_params}) do
  #   course = Courses.get_course!(id)

  #   with {:ok, %Course{} = course} <- Courses.update_course(course, course_params) do
  #     render(conn, "show.json", course: course)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   course = Courses.get_course!(id)

  #   with {:ok, %Course{}} <- Courses.delete_course(course) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
