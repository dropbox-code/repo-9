require 'spec_helper'

describe NetSuite::Records::LandedCostSummary do
  let(:summary) { NetSuite::Records::LandedCostSummary.new }

  it 'has all the right fields' do
    [
      :amount
    ].each do |field|
      expect(summary).to have_field(field)
    end
  end

  it 'has all the right record_refs' do
    [
      :category, :transaction
    ].each do |record_ref|
      expect(summary).to have_record_ref(record_ref)
    end
  end

  describe '#to_record' do
    before(:each) do
      summary.amount = 3.14
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'platformCommon:amount' => 3.14
      }
      expect(summary.to_record).to eql(record)
    end
  end
end
