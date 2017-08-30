class Dsl::Trap::Context
  def self.generate
    klass = Class.new(BasicObject) {
      def self.trapper
        @trapper ||= ::Dsl::Trap::Base.new
      end
      def self.method_missing(name, *args, &block)
        trapper.method_missing(name, *args, &block)
      end
      def self.const_missing(name)
        trapper.method_missing(name)
      end
    }
    klass.define_singleton_method(:inspect) do
      "(Dsl::Trap::Context)..."
    end
    klass
  end
end