require 'spec_helper'

describe NetSuite::Records::CheckItem do
  let(:item) { NetSuite::Records::CheckItem.new }

  it 'has the right fields' do
    [
      :amount, :bin_numbers, :description, :expiration_date, :gross_amt,
      :is_billable, :line, :quantity, :rate, :serial_numbers, :tax_1_amt,
      :tax_rate_1, :tax_rate_2, :vendor_name
    ].each do |field|
      expect(item).to have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :klass, :customer, :department, :item, :location, :tax_code, :units
    ].each do |record_ref|
      expect(item).to have_record_ref(record_ref)
    end
  end

  it 'can initialize from a record' do
    record = NetSuite::Records::CheckItem.new(:gross_amt => 123, :description => 'some item')
    item = NetSuite::Records::CheckItem.new(record)
    expect(item).to be_kind_of(NetSuite::Records::CheckItem)
    expect(item.gross_amt).to eql(123)
    expect(item.description).to eql('some item')
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :value => 10,
          :script_id => 'custfield_value'
        }
      }
      item.custom_field_list = attributes
      expect(item.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(item.custom_field_list.custom_fields.length).to eql(1)
      expect(item.custom_field_list.custfield_value.attributes[:value]).to eq(10)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      item.custom_field_list = custom_field_list
      expect(item.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '#options' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :value => 10,
          :script_id => 'custfield_value'
        }
      }
      item.options = attributes
      expect(item.options).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(item.options.custom_fields.length).to eql(1)
      expect(item.options.custfield_value.attributes[:value]).to eq(10)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      item.options = custom_field_list
      expect(item.options).to eql(custom_field_list)
    end
  end

  describe '#to_record' do
    before do
      item.gross_amt = '123'
      item.description = 'some item'
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'tranBank:grossAmt' => '123',
        'tranBank:description' => 'some item'
      }
      expect(item.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP record type' do
      expect(item.record_type).to eql('tranBank:CheckItem')
    end
  end
end
