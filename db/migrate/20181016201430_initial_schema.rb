class InitialSchema < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :reputation 
      t.timestamps null:true
    end
    
    create_table :posts do |t|
      t.string :title
      t.string :location
      t.string :content
      t.integer :score
      t.integer :user_id
      t.integer :state_id
      t.timestamps null:true
    end

    create_table :comments do |t|
      t.string :content
      t.integer :score
      t.integer :post_id
      t.integer :user_id
      t.timestamps null:true
    end

    create_table :categories do |t|
      t.string :title
      t.timestamps null:true
    end

    create_table :states do |t|
      t.string :name
      t.timestamps null:true
    end
  end
end
