defmodule QueroApi.CampusCoursesTest do
  use QueroApi.DataCase

  import QueroApi.FixturesAll

  alias QueroApi.CampusCourses

  describe "campus_courses" do
    alias QueroApi.CampusCourses.CampusCourse

    setup do
      course = courses_fixture()
      {:ok, course: course}
    end

    setup do
      campu = campus_fixture()
      {:ok, campu: campu}
    end

    setup do
      campu_course = campus_courses_fixture()
      {:ok, campu_course: campu_course}
    end

    # @valid_attrs %{}
    # @update_attrs %{}
    @invalid_attrs %{campu_id: nil, course_id: nil}

    test "list_campus_courses/0 returns all campus_courses", %{campu_course: campu_course} do
      assert CampusCourses.list_campus_courses() == [campu_course]
    end

    test "get_campus_course!/1 returns the campus_course with given id", %{campu_course: campu_course} do
      assert CampusCourses.get_campus_course!(campu_course.id) == campu_course
    end

    test "create_campus_course/1 with valid data creates a campus_course", %{
      course: course,
      campu: campu
    } do
      assert {:ok, %CampusCourse{} = campus_course} = CampusCourses.create_campus_course(%{campu_id: campu.id, course_id: course.id})

      assert campus_course.course_id == course.id
      assert campus_course.campu_id == campu.id
    end

    test "create_campus_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CampusCourses.create_campus_course(@invalid_attrs)
    end

    test "create_campus_course/1 with invalid insert ids that do not exist in leather and/or campu" do
      assert {:error, %Ecto.Changeset{}} =
              CampusCourses.create_campus_course(%{course_id: "4500", offer_id: "3474"})
    end

    test "update_campus_course/2 with valid data updates the campus_course", %{campu_course: campu_course} do
      campu = campus_fixture()
      course = courses_fixture()
      assert {:ok, %CampusCourse{}} = CampusCourses.update_campus_course(campu_course, %{campu_id: campu.id, course_id: course.id})
    end

    test "update_campus_course/2 with invalid data returns error changeset", %{campu_course: campu_course} do
      assert {:error, %Ecto.Changeset{}} = CampusCourses.update_campus_course(campu_course, @invalid_attrs)
      assert campu_course == CampusCourses.get_campus_course!(campu_course.id)
    end

    test "delete_campus_course/1 deletes the campus_course" do
      campus_course = campus_courses_fixture()
      assert {:ok, %CampusCourse{}} = CampusCourses.delete_campus_course(campus_course)
      assert_raise Ecto.NoResultsError, fn -> CampusCourses.get_campus_course!(campus_course.id) end
    end

    test "change_campus_course/1 returns a campus_course changeset" do
      campus_course = campus_courses_fixture()
      assert %Ecto.Changeset{} = CampusCourses.change_campus_course(campus_course)
    end
  end
end
