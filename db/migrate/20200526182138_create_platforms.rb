class CreatePlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :platforms do |t|
      t.string :name

      t.timestamps
    end

    Platform.create(name: "ps4")
    Platform.create(name: "Xbox")
    Platform.create(name: "PC")
    Platform.create(name: "mobile")
  end
end
