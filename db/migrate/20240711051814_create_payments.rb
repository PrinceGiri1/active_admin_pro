class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.string :razorpay_payment_id
      t.string :status, default: 'fail'

      t.timestamps
    end
  end
end
