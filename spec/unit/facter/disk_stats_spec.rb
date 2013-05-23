#!/usr/bin/env rspec
require 'spec_helper'

describe "The disk_stats fact" do
  before :each do
    # Explicitly load the disk_stats.rb file which has the facts.
    if Facter.collection.respond_to? :load
      Facter.collection.load(:disk_stats)
    else
      Facter.collection.loader.load(:disk_stats)
    end
  end

  context "when on a system that supports disk_stats" do
    it "returns a disk_stats_disks fact" do
      Facter.fact(:disk_stats_disks).value.should_not == nil
    end

    it "returns a list of comma separated disk labels" do
      Facter.fact(:disk_stats_disks).value.split(',').size.should > 0
    end

    context "when displaying facts about each disk" do

      before :each do
        @disks = Facter.fact(:disk_stats_disks).value.split(',')
      end

      %w[type path size free used options].each do |opt|
        it "returns a #{opt} fact for the disk" do
          @disks.each do |disk|
            Facter.fact("disk_stats_#{disk}_#{opt}").value.should_not == nil
          end
        end
      end
    
    end
  end
end
