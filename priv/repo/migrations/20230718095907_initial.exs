defmodule SilverForest.Repo.Migrations.Initial do
    use Ecto.Migration

    def change do
        create table ("user") do
            add :name, :string
            add :email, :string
            add :gold, :integer

            timestamps()
        end

        create table ("skill") do
            add :name, :string
        end

        create table ("user_skill") do
            add :level, :integer
            add :experience, :integer

            add :skill_id, references(:skill)
            add :user_id, references(:user)

            timestamps()
        end

    end
end
