require 'spec_helper'

describe NetSuite::Records::CheckExpenseList do
  let(:expense_list) { NetSuite::Records::CheckExpenseList.new }
  let(:expense) { NetSuite::Records::CheckExpense.new }

  it 'can be initialized with a hash' do
    expense_list = NetSuite::Records::CheckExpenseList.new(expense: {})
    expect(expense_list.expenses).to be_kind_of(Array)
    expect(expense_list.expense.length).to eql(1)
    expect(expense_list.expenses.first).to be_kind_of(NetSuite::Records::CheckExpense)
  end

  it 'can be initialized with a hash list' do
    expense_list = NetSuite::Records::CheckExpenseList.new(expense: [{}])
    expect(expense_list.expenses).to be_kind_of(Array)
    expect(expense_list.expenses.length).to eql(1)
    expect(expense_list.expenses.first).to be_kind_of(NetSuite::Records::CheckExpense)
  end

  it 'can have expenses added to it' do
    expense_list.expenses << expense
    expect(expense_list.expenses).to be_kind_of(Array)
    expect(expense_list.expenses.length).to eql(1)
    expect(expense_list.expenses.first).to be_kind_of(NetSuite::Records::CheckExpense)
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'tranBank:expense' => []
      }
      expect(expense_list.to_record).to eql(record)
    end
  end
end
