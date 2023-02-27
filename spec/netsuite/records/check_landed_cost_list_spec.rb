require 'spec_helper'

describe NetSuite::Records::CheckLandedCostList do
  let(:landed_cost_list) { NetSuite::Records::CheckLandedCostList.new }
  let(:landed_cost) { NetSuite::Records::CheckLandedCost.new }

  it 'has a landed_costs attribute' do
    expect(landed_cost_list.landed_costs).to be_kind_of(Array)
  end

  describe '#to_record' do
    before(:each) do
      landed_cost_list.landed_costs << NetSuite::Records::LandedCostSummary.new(
        :amount => 3.14
      )
    end

    it 'can represent itself as a SOAP record' do
      record = {
        "tranBank:landedCost" => [
          {"platformCommon:amount" => 3.14}
        ]
      }
      expect(landed_cost_list.to_record).to eql(record)
    end
  end
end
