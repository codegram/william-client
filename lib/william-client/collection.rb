module William
  class Collection
    def each(&block)
      @collection.each(&block)
    end

    def [](index)
      @collection[index]
    end

    def last
      @collection.last
    end
  end
end
