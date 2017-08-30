puts Raft::Type.constants.inspect
describe Raft::Type::Any do
  let(:has) {
    Raft::Type::Any.new
  }
  describe '#fields' do
    it {has.fields}
  end
end