#
# Autogenerated by Thrift Compiler (1.0.0-dev)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'gen-rb/zigbee_types'

module IndicationService
  class Client
    include ::Thrift::Client

    def indicationCommand(command)
      send_indicationCommand(command)
    end

    def send_indicationCommand(command)
      send_message('indicationCommand', IndicationCommand_args, :command => command)
    end
  end

  class Processor
    include ::Thrift::Processor

    def process_indicationCommand(seqid, iprot, oprot)
      args = read_args(iprot, IndicationCommand_args)
      @handler.indicationCommand(args.command)
      return
    end

  end

  # HELPER FUNCTIONS AND STRUCTURES

  class IndicationCommand_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    COMMAND = 1

    FIELDS = {
      COMMAND => {:type => ::Thrift::Types::STRUCT, :name => 'command', :class => ::IndicationCommandRequest}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class IndicationCommand_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

end

