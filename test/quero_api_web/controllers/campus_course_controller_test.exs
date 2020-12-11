defmodule QueroApiWeb.CampusCourseControllerTest do
  use QueroApiWeb.ConnCase

  # alias QueroApi.CampusCourses
  # alias QueroApi.CampusCourses.CampusCourse

  # @create_attrs %{

  # }
  # @update_attrs %{

  # }
  # @invalid_attrs %{}

  # def fixture(:campus_course) do
  #   {:ok, campus_course} = CampusCourses.create_campus_course(@create_attrs)
  #   campus_course
  # end

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  # describe "index" do
  #   test "lists all campus_courses", %{conn: conn} do
  #     conn = get(conn, Routes.campus_course_path(conn, :index))
  #     assert json_response(conn, 200)["data"] == []
  #   end
  # end

  # describe "create campus_course" do
  #   test "renders campus_course when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.campus_course_path(conn, :create), campus_course: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.campus_course_path(conn, :show, id))

  #     assert %{
  #              "id" => id
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.campus_course_path(conn, :create), campus_course: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update campus_course" do
  #   setup [:create_campus_course]

  #   test "renders campus_course when data is valid", %{conn: conn, campus_course: %CampusCourse{id: id} = campus_course} do
  #     conn = put(conn, Routes.campus_course_path(conn, :update, campus_course), campus_course: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.campus_course_path(conn, :show, id))

  #     assert %{
  #              "id" => id
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, campus_course: campus_course} do
  #     conn = put(conn, Routes.campus_course_path(conn, :update, campus_course), campus_course: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete campus_course" do
  #   setup [:create_campus_course]

  #   test "deletes chosen campus_course", %{conn: conn, campus_course: campus_course} do
  #     conn = delete(conn, Routes.campus_course_path(conn, :delete, campus_course))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.campus_course_path(conn, :show, campus_course))
  #     end
  #   end
  # end

  # defp create_campus_course(_) do
  #   campus_course = fixture(:campus_course)
  #   %{campus_course: campus_course}
  # end
end
