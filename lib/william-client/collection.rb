module William
  # Represents a William resource collection.
  class Collection
    extend Forwardable

    def_delegators :@collection, :last

    def each(&block)
      @collection.each(&block)
    end

    def [](index)
      @collection[index]
    end
  end
end
