defmodule QueroApi.Campus do
  @moduledoc """
  The Campus context.
  """

  import Ecto.Query, warn: false
  alias QueroApi.Repo

  alias QueroApi.Campus.Campu

  @doc """
  Returns the list of campus.

  ## Examples

      iex> list_campus()
      [%Campu{}, ...]

  """
  def list_campus do
    Repo.all(Campu)
  end

  @doc """
  Gets a single campu.

  Raises `Ecto.NoResultsError` if the Campu does not exist.

  ## Examples

      iex> get_campu!(123)
      %Campu{}

      iex> get_campu!(456)
      ** (Ecto.NoResultsError)

  """
  def get_campu!(id), do: Repo.get!(Campu, id)

  @doc """
  Creates a campu.

  ## Examples

      iex> create_campu(%{field: value})
      {:ok, %Campu{}}

      iex> create_campu(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_campu(attrs \\ %{}) do
    %Campu{}
    |> Campu.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a campu.

  ## Examples

      iex> update_campu(campu, %{field: new_value})
      {:ok, %Campu{}}

      iex> update_campu(campu, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_campu(%Campu{} = campu, attrs) do
    campu
    |> Campu.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a campu.

  ## Examples

      iex> delete_campu(campu)
      {:ok, %Campu{}}

      iex> delete_campu(campu)
      {:error, %Ecto.Changeset{}}

  """
  def delete_campu(%Campu{} = campu) do
    Repo.delete(campu)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking campu changes.

  ## Examples

      iex> change_campu(campu)
      %Ecto.Changeset{data: %Campu{}}

  """
  def change_campu(%Campu{} = campu, attrs \\ %{}) do
    Campu.changeset(campu, attrs)
  end
end
