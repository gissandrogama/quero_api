defmodule QueroApiWeb.CourseControllerTest do
  use QueroApiWeb.ConnCase

  alias QueroApi.Courses
  alias QueroApi.Courses.Course

  @create_attrs %{
    kind: "some kind",
    level: "some level",
    name: "some name",
    shift: "some shift"
  }
  @update_attrs %{
    kind: "some updated kind",
    level: "some updated level",
    name: "some updated name",
    shift: "some updated shift"
  }
  @invalid_attrs %{kind: nil, level: nil, name: nil, shift: nil}

  def fixture(:course) do
    {:ok, course} = Courses.create_course(@create_attrs)
    course
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all courses", %{conn: conn} do
      conn = get(conn, Routes.course_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create course" do
    test "renders course when data is valid", %{conn: conn} do
      conn = post(conn, Routes.course_path(conn, :create), course: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.course_path(conn, :show, id))

      assert %{
               "id" => id,
               "kind" => "some kind",
               "level" => "some level",
               "name" => "some name",
               "shift" => "some shift"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.course_path(conn, :create), course: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update course" do
    setup [:create_course]

    test "renders course when data is valid", %{conn: conn, course: %Course{id: id} = course} do
      conn = put(conn, Routes.course_path(conn, :update, course), course: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.course_path(conn, :show, id))

      assert %{
               "id" => id,
               "kind" => "some updated kind",
               "level" => "some updated level",
               "name" => "some updated name",
               "shift" => "some updated shift"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, course: course} do
      conn = put(conn, Routes.course_path(conn, :update, course), course: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete course" do
    setup [:create_course]

    test "deletes chosen course", %{conn: conn, course: course} do
      conn = delete(conn, Routes.course_path(conn, :delete, course))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.course_path(conn, :show, course))
      end
    end
  end

  defp create_course(_) do
    course = fixture(:course)
    %{course: course}
  end
end
