defmodule SilverForest.Schemas.User do
    use Ecto.Schema
    import Ecto.Changeset

    schema "user" do
        field :name, :string
        field :email, :string
        field :gold, :integer, [default: 0]

        has_many :user_skill, SilverForest.Schemas.UserSkill

        timestamps()
    end

    def changeset(person, params \\ %{}) do
        person
        |> cast(params, [:name, :email])
        |> validate_required([:name, :email])
    end
end
