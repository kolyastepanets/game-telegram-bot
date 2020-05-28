class CreatePlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :platforms do |t|
      t.string :name

      t.timestamps
    end

    Platform.create(name: "PS4")
    Platform.create(name: "Xbox One")
    Platform.create(name: "PC")
    Platform.create(name: "Switch")
    Platform.create(name: "Mobile")
  end
end
