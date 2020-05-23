ActiveAdmin.register User do
  permit_params :nickname, :time_to_play
end
