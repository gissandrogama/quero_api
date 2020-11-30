defmodule QueroApi.CoursesTest do
  use QueroApi.DataCase

  alias QueroApi.Courses

  describe "courses" do
    alias QueroApi.Courses.Course

    @valid_attrs %{kind: "some kind", level: "some level", name: "some name", shift: "some shift"}
    @update_attrs %{kind: "some updated kind", level: "some updated level", name: "some updated name", shift: "some updated shift"}
    @invalid_attrs %{kind: nil, level: nil, name: nil, shift: nil}

    def course_fixture(attrs \\ %{}) do
      {:ok, course} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Courses.create_course()

      course
    end

    test "list_courses/0 returns all courses" do
      course = course_fixture()
      assert Courses.list_courses() == [course]
    end

    test "get_course!/1 returns the course with given id" do
      course = course_fixture()
      assert Courses.get_course!(course.id) == course
    end

    test "create_course/1 with valid data creates a course" do
      assert {:ok, %Course{} = course} = Courses.create_course(@valid_attrs)
      assert course.kind == "some kind"
      assert course.level == "some level"
      assert course.name == "some name"
      assert course.shift == "some shift"
    end

    test "create_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Courses.create_course(@invalid_attrs)
    end

    test "update_course/2 with valid data updates the course" do
      course = course_fixture()
      assert {:ok, %Course{} = course} = Courses.update_course(course, @update_attrs)
      assert course.kind == "some updated kind"
      assert course.level == "some updated level"
      assert course.name == "some updated name"
      assert course.shift == "some updated shift"
    end

    test "update_course/2 with invalid data returns error changeset" do
      course = course_fixture()
      assert {:error, %Ecto.Changeset{}} = Courses.update_course(course, @invalid_attrs)
      assert course == Courses.get_course!(course.id)
    end

    test "delete_course/1 deletes the course" do
      course = course_fixture()
      assert {:ok, %Course{}} = Courses.delete_course(course)
      assert_raise Ecto.NoResultsError, fn -> Courses.get_course!(course.id) end
    end

    test "change_course/1 returns a course changeset" do
      course = course_fixture()
      assert %Ecto.Changeset{} = Courses.change_course(course)
    end
  end
end
