# frozen_string_literal: true

module Cops
  class AllCopsMapper
    def self.all_cops_hash
      {
        binding_pry: [],
        send: [],
        public_send: []
      }
    end
  end
end
