#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'cuporter'

tag_report = Cuporter::TagReport.new(Cuporter::Options[:input_file] || Cuporter::Options[:input_dir])

formatter = Cuporter::Formatters.const_get(Cuporter::Options[:format])
formatter.new(tag_report.scenarios_per_tag, Cuporter::Options[:output]).write