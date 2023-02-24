require 'spec_helper'

describe NetSuite::Records::LandedCost do
  let(:landed_cost) { NetSuite::Records::LandedCost.new }

  describe "#to_record" do
    before(:each) do
      landed_cost.landed_cost_data_list = NetSuite::Records::LandedCostDataList.new
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'platformCommon:landedCostDataList' => {
          'platformCommon:landedCostData' => []
        }
      }
      expect(landed_cost.to_record).to eql(record)
    end
  end
end
