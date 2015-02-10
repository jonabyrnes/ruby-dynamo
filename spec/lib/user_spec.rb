require './spec/spec_helper'
require './lib/user'

describe User do
  it 'is named jon' do
    user = User.new 'Jon'
    expect(user.name).to eq('Jon')
  end
end