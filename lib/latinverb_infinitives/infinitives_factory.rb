module Linguistics
  module Latin
    module Verb
      class LatinVerb
        INFINITIVE_METHODS = [
          :future_active_infinitive,
          :future_passive_infinitive,
          :perfect_active_infinitive,
          :perfect_passive_infinitive,
          :present_passive_infinitive
        ]
        class InfinitivesFactory
          extend Forwardable
          def_delegators :@verb, :irregular?, :deponent?, :semideponent?, :original_string

          def initialize(verb)
            @verb = verb
          end

          def infinitives
            return irregular if irregular?
            if deponent? || semideponent?
              deponent
            else
              standard
            end
          end

          private

            def irregular
              Linguistics::Latin::Verb::LatinVerb::IrregularInfinitivesRetriever.new(@verb.original_string).retrieve
            end

            def deponent
              DeponentInfinitivizer.new(@verb)
            end

            def standard
              Infinitivizer.new(@verb)
            end
        end
      end
    end
  end
end
