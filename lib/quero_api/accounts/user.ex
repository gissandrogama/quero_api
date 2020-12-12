defmodule QueroApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> unique_constraint(:email, message: "Email já cadastrado")
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, ~r/@/, message: "Digite uma email válido")
    |> validate_length(:password,
      min: 6,
      max: 64,
      message: "senha deve conter no minimo 6 caracteres e no maximo 64"
    )
    |> validate_confirmation(:password, message: "senhas não estão iguais")
    |> hashing()
  end

  defp hashing(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp hashing(changeset), do: changeset
end
