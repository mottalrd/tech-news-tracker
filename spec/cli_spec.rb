require "spec_helper"
require 'stringio'

RSpec.describe NewsTracker::CLI do

  describe '#menu' do

    it 'prints the main menu' do
      # because we are describing the #menu method
      # here I would expect to call subject.menu
      str = subject.current_menu.display

      # this is arguably a standalone test
      # where we are describing that when we initialize the CLI
      # the main menu will be Main
      # To be honest it feels like implementation details, probably
      # I would delete that now
      expect(subject.current_menu).to be_a(NewsTracker::Menu::Main)
      expect(str).to include("Option menu:")
      expect(str).to include("Select a topic to list the latest articles")
      expect(str).to include("Type 'ruby' for Ruby and Rails news")
      expect(str).to include("Type 'js' for Javascript news")
      expect(str).to include("Type 'node' for NodeJS news")
      expect(str).to include("Type 'archive' to view article archive")
      expect(str).to include("Type 'exit' to quit")
    end

  end

  describe '#display_list' do

    context "when a user enters 'ruby'" do
      before do
        $stdin = StringIO.new("ruby\n")
      end

      after do
        $stdin = STDIN
      end

      it 'should display a list of articles related to ruby news' do
        # why instead of the following 3 lines
        # we can't simply execute subject.display_list ?
        subject.current_menu.read_menu_command
        current_menu = subject.current_menu.process_command
        str = current_menu.display

        expect(str).to be_a(String)
        expect(str).to include('Displaying ruby news:')
      end

    end

  end

  # change to
  #
  # describe '#display_article' do
  # end
  #
  # to keep following the convention in the rest of the file
  describe 'display an article to the user' do

    context 'should display the selected article' do
      before do
        $stdin = StringIO.new("1")
      end

      after do
        $stdin = STDIN
      end

      it 'an article should contain a title, author and description field and prompt the user to take action' do
        current_menu = NewsTracker::Menu::List.new('ruby')
        current_menu.read_menu_command
        article = current_menu.process_command
        article_string = subject.display_article(article)

        # when using multiple expectations for a test check
        # https://relishapp.com/rspec/rspec-core/docs/expectation-framework-integration/aggregating-failures
        expect(article_string).to include('Title:')
        expect(article_string).to include('Author:')
        expect(article_string).to include('Description:')
        # expect(article_string).to include("Type 'a' to archive the article and return to article list")
        expect(article_string).to include("Type 'o' to view in a browser")
        expect(article_string).to include("Type 'back' to review the list again")
      end

    end

  end

end
