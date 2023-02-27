require 'spec_helper'

describe NetSuite::Records::LandedCostData do
  let(:data) { NetSuite::Records::LandedCostData.new }

  it 'has all the right fields' do
    [
      :amount
    ].each do |field|
      expect(data).to have_field(field)
    end
  end

  it 'has all the right record_refs' do
    [
      :cost_category
    ].each do |record_ref|
      expect(data).to have_record_ref(record_ref)
    end
  end

  describe '#to_record' do
    before do
      data.amount = 3.14
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'platformCommon:amount' => 3.14
      }
      expect(data.to_record).to eql(record)
    end
  end
end
