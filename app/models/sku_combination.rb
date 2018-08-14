# == Schema Information
#
# Table name: sku_combinations
#
#  id               :bigint(8)        not null, primary key
#  sku_combination  :string
#  sku_denomination :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class SkuCombination < ApplicationRecord
	before_create :set_sku_denomination_number

	def set_sku_denomination_number
	  sku_denomination = SkuCombination.maximum(:sku_denomination)	  
	  self.sku_denomination = sku_denomination.to_i + 1 if sku_denomination.to_i > 0
	end
end
