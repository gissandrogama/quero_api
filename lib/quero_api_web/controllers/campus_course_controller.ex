defmodule QueroApiWeb.CampusCourseController do
  use QueroApiWeb, :controller

  alias QueroApi.CampusCourses
  alias QueroApi.CampusCourses.CampusCourse

  action_fallback QueroApiWeb.FallbackController

  def index(conn, _params) do
    campus_courses = CampusCourses.list_campus_courses()
    render(conn, "index.json", campus_courses: campus_courses)
  end

  def create(conn, %{"campus_course" => campus_course_params}) do
    with {:ok, %CampusCourse{} = campus_course} <-
           CampusCourses.create_campus_course(campus_course_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.campus_course_path(conn, :show, campus_course))
      |> render("show.json", campus_course: campus_course)
    end
  end

  def show(conn, %{"id" => id}) do
    campus_course = CampusCourses.get_campus_course!(id)
    render(conn, "show.json", campus_course: campus_course)
  end

  def update(conn, %{"id" => id, "campus_course" => campus_course_params}) do
    campus_course = CampusCourses.get_campus_course!(id)

    with {:ok, %CampusCourse{} = campus_course} <-
           CampusCourses.update_campus_course(campus_course, campus_course_params) do
      render(conn, "show.json", campus_course: campus_course)
    end
  end

  def delete(conn, %{"id" => id}) do
    campus_course = CampusCourses.get_campus_course!(id)

    with {:ok, %CampusCourse{}} <- CampusCourses.delete_campus_course(campus_course) do
      send_resp(conn, :no_content, "")
    end
  end
end
