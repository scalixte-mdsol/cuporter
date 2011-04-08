# Copyright 2010 ThoughtWorks, Inc. Licensed under the MIT License
module Cuporter
  class Report

    attr_reader :filter, :title, :doc

    def initialize(input_file_pattern, doc, filter_args = nil, title = nil)
      @input_file_pattern = input_file_pattern
      @doc = doc
      @filter = Filter.new(filter_args || {})
      @title = title
    end

    def files
      Dir[@input_file_pattern].collect {|f| File.expand_path f}
    end

    def self.create(type, input_file_pattern, filter_args = nil, title = nil, format = nil)
      klass = Cuporter.const_get("#{type.downcase}Report".to_class_name)
      doc = Cuporter::Document.new_doc(format, input_file_pattern.split(File::SEPARATOR).first)
      klass.new(input_file_pattern, doc, filter_args, title)
    end

  end
end
