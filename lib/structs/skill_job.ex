defmodule SilverForest.Structs.SkillJob do
    defstruct [
        :id, #user id
        :skill, #the affected skill
        :params, #params of the job
        delay: 3000, #the time for the job to complete
    ]
end
