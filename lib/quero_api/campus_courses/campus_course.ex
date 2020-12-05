defmodule QueroApi.CampusCourses.CampusCourse do
  use Ecto.Schema
  import Ecto.Changeset

  schema "campus_courses" do
    belongs_to :campu, QueroApi.Campus.Campu
    belongs_to :course, QueroApi.Courses.Course

    timestamps()
  end

  @doc false
  def changeset(campus_course, attrs) do
    campus_course
    |> cast(attrs, [:campu_id, :course_id])
    |> validate_required([:campu_id, :course_id])
  end
end
