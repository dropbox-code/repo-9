require 'spec_helper' 

describe NetSuite::Records::AccountingBookDetail do
  let(:detail) { NetSuite::Records::AccountingBookDetail.new }

  it 'has the right fields' do
    [
      :exchange_rate
    ].each do |field|
      expect(detail).to have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :accounting_book, :currency
    ].each do |field|
      expect(detail).to have_record_ref(field)
    end
  end

  it 'can initialize from a record' do
    record = NetSuite::Records::AccountingBookDetail.new(:exchange_rate => 3.14)
    detail = NetSuite::Records::AccountingBookDetail.new(record)
    expect(detail).to be_kind_of(NetSuite::Records::AccountingBookDetail)
    expect(detail.exchange_rate).to eql(3.14)
  end

  describe '#to_record' do
    before do
      detail.exchange_rate = '3.14'
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'platformCommon:exchangeRate' => '3.14'
      }
      expect(detail.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP record type' do
      expect(detail.record_type).to eql('platformCommon:AccountingBookDetail')
    end
  end
end
