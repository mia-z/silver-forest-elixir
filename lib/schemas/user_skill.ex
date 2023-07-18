defmodule SilverForest.Schemas.UserSkill do
    use Ecto.Schema

    schema "user_skill" do
        field :level, :integer, [default: 1]
        field :experience, :integer, [default: 0]

        belongs_to :user, SilverForest.Schemas.User
        belongs_to :skill, SilverForest.Schemas.UserSkill

        timestamps()
    end
end
