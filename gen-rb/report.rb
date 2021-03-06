#
# Autogenerated by Thrift Compiler (0.9.1)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'zigbee_types'

module Report
  class Client
    include ::Thrift::Client

    def sendReport(command)
      send_sendReport(command)
      recv_sendReport()
    end

    def send_sendReport(command)
      send_message('sendReport', SendReport_args, :command => command)
    end

    def recv_sendReport()
      result = receive_message(SendReport_result)
      return
    end

  end

  class Processor
    include ::Thrift::Processor

    def process_sendReport(seqid, iprot, oprot)
      args = read_args(iprot, SendReport_args)
      result = SendReport_result.new()
      @handler.sendReport(args.command)
      write_result(result, oprot, 'sendReport', seqid)
    end

  end

  # HELPER FUNCTIONS AND STRUCTURES

  class SendReport_args
    include ::Thrift::Struct, ::Thrift::Struct_Union
    COMMAND = 1

    FIELDS = {
      COMMAND => {:type => ::Thrift::Types::STRUCT, :name => 'command', :class => ::SendReportRequest}
    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

  class SendReport_result
    include ::Thrift::Struct, ::Thrift::Struct_Union

    FIELDS = {

    }

    def struct_fields; FIELDS; end

    def validate
    end

    ::Thrift::Struct.generate_accessors self
  end

end

