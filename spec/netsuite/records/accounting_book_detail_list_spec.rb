require 'spec_helper'

describe NetSuite::Records::AccountingBookDetailList do
  let(:list) { described_class.new }

  it 'has an accounting_book_details attribute' do
    expect(list.accounting_book_details).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.accounting_book_details << NetSuite::Records::AccountingBookDetail.new(
        :exchange_rate => '3.14'
      )
    end

    it 'can represent itself as a SOAP record' do
      record = {
        "platformCommon:accountingBookDetail" => [
          {"platformCommon:exchangeRate" => "3.14"}
        ]
      }
      expect(list.to_record).to eql(record)
    end
  end
end
