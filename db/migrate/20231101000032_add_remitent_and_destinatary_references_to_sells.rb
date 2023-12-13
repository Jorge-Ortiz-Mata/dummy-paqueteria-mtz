class AddRemitentAndDestinataryReferencesToSells < ActiveRecord::Migration[7.0]
  def change
    add_reference :sells, :remitent, foreign_key: true
    add_reference :sells, :destinatary, foreign_key: true
  end
end
