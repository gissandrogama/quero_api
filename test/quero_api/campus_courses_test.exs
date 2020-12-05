defmodule QueroApi.CampusCoursesTest do
  use QueroApi.DataCase

  alias QueroApi.CampusCourses

  describe "campus_courses" do
    alias QueroApi.CampusCourses.CampusCourse

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def campus_course_fixture(attrs \\ %{}) do
      {:ok, campus_course} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CampusCourses.create_campus_course()

      campus_course
    end

    test "list_campus_courses/0 returns all campus_courses" do
      campus_course = campus_course_fixture()
      assert CampusCourses.list_campus_courses() == [campus_course]
    end

    test "get_campus_course!/1 returns the campus_course with given id" do
      campus_course = campus_course_fixture()
      assert CampusCourses.get_campus_course!(campus_course.id) == campus_course
    end

    test "create_campus_course/1 with valid data creates a campus_course" do
      assert {:ok, %CampusCourse{} = campus_course} = CampusCourses.create_campus_course(@valid_attrs)
    end

    test "create_campus_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CampusCourses.create_campus_course(@invalid_attrs)
    end

    test "update_campus_course/2 with valid data updates the campus_course" do
      campus_course = campus_course_fixture()
      assert {:ok, %CampusCourse{} = campus_course} = CampusCourses.update_campus_course(campus_course, @update_attrs)
    end

    test "update_campus_course/2 with invalid data returns error changeset" do
      campus_course = campus_course_fixture()
      assert {:error, %Ecto.Changeset{}} = CampusCourses.update_campus_course(campus_course, @invalid_attrs)
      assert campus_course == CampusCourses.get_campus_course!(campus_course.id)
    end

    test "delete_campus_course/1 deletes the campus_course" do
      campus_course = campus_course_fixture()
      assert {:ok, %CampusCourse{}} = CampusCourses.delete_campus_course(campus_course)
      assert_raise Ecto.NoResultsError, fn -> CampusCourses.get_campus_course!(campus_course.id) end
    end

    test "change_campus_course/1 returns a campus_course changeset" do
      campus_course = campus_course_fixture()
      assert %Ecto.Changeset{} = CampusCourses.change_campus_course(campus_course)
    end
  end
end
