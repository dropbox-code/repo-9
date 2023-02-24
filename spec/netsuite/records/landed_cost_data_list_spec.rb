require 'spec_helper'

describe NetSuite::Records::LandedCostDataList do
  let(:data_list) { NetSuite::Records::LandedCostDataList.new }
  let(:data) { NetSuite::Records::LandedCostData.new }


  it 'can be initialized with a hash' do
    data_list = NetSuite::Records::LandedCostDataList.new(landed_cost_data: {})
    expect(data_list.landed_cost_data).to be_kind_of(Array)
    expect(data_list.landed_cost_data.length).to eql(1)
    expect(data_list.landed_cost_data.first).to be_kind_of(NetSuite::Records::LandedCostData)
  end

  it 'can be initialized with a hash list' do
    data_list = NetSuite::Records::LandedCostDataList.new(landed_cost_data: [{}])
    expect(data_list.landed_cost_data).to be_kind_of(Array)
    expect(data_list.landed_cost_data.length).to eql(1)
    expect(data_list.landed_cost_data.first).to be_kind_of(NetSuite::Records::LandedCostData)
  end

  it 'can have items added to it' do
    data_list.landed_cost_data << data
    expect(data_list.landed_cost_data).to be_kind_of(Array)
    expect(data_list.landed_cost_data.length).to eql(1)
    expect(data_list.landed_cost_data.first).to be_kind_of(NetSuite::Records::LandedCostData)
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'platformCommon:landedCostData' => []
      }
      expect(data_list.to_record).to eql(record)
    end
  end
end
