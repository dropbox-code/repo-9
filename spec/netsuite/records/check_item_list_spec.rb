require 'spec_helper'

describe NetSuite::Records::CheckItemList do
  let(:item_list) { NetSuite::Records::CheckItemList.new }
  let(:item) { NetSuite::Records::CheckItem.new }

  it 'can be initialized with a hash' do
    item_list = NetSuite::Records::CheckItemList.new(item: {})
    expect(item_list.items).to be_kind_of(Array)
    expect(item_list.items.length).to eql(1)
    expect(item_list.items.first).to be_kind_of(NetSuite::Records::CheckItem)
  end

  it 'can be initialized with a hash list' do
    item_list = NetSuite::Records::CheckItemList.new(item: [{}])
    expect(item_list.items).to be_kind_of(Array)
    expect(item_list.items.length).to eql(1)
    expect(item_list.items.first).to be_kind_of(NetSuite::Records::CheckItem)
  end

  it 'can have items added to it' do
    item_list.items << item
    expect(item_list.items).to be_kind_of(Array)
    expect(item_list.items.length).to eql(1)
    expect(item_list.items.first).to be_kind_of(NetSuite::Records::CheckItem)
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'tranBank:item' => []
      }
      expect(item_list.to_record).to eql(record)
    end
  end
end
