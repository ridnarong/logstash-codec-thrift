# frozen_string_literal: true
require 'rubygems/test_case'
require 'rubygems/util'

class TestGemUtil < Gem::TestCase

  def test_class_popen
    skip "MJIT executes process and it's caught by Process.wait(-1)" if defined?(RubyVM::MJIT) && RubyVM::MJIT.enabled?
    assert_equal "0\n", Gem::Util.popen(Gem.ruby, '-e', 'p 0')

    assert_raises Errno::ECHILD do
      Process.wait(-1)
    end
  end

  def test_silent_system
    assert_silent do
      Gem::Util.silent_system Gem.ruby, '-e', 'puts "hello"; warn "hello"'
    end
  end

  def test_traverse_parents
    FileUtils.mkdir_p 'a/b/c'

    enum = Gem::Util.traverse_parents 'a/b/c'

    assert_equal File.join(@tempdir, 'a/b/c'), enum.next
    assert_equal File.join(@tempdir, 'a/b'),   enum.next
    assert_equal File.join(@tempdir, 'a'),     enum.next
    loop { break if enum.next.nil? } # exhaust the enumerator
  end

  def test_traverse_parents_does_not_crash_on_permissions_error
    skip 'skipped on MS Windows (chmod has no effect)' if win_platform?

    FileUtils.mkdir_p 'd/e/f'
    # remove 'execute' permission from "e" directory and make it
    # impossible to cd into it and its children
    FileUtils.chmod(0666, 'd/e')

    paths = Gem::Util.traverse_parents('d/e/f').to_a

    assert_equal File.join(@tempdir, 'd'), paths[0]
    assert_equal @tempdir, paths[1]
    # File.expand_path with macOS returns `/private` prefix.
    if RUBY_PLATFORM !~ /darwin/
      assert_equal Dir.tmpdir, paths[2]
      assert_equal '/', paths[3]
    end
  ensure
    # restore default permissions, allow the directory to be removed
    FileUtils.chmod(0775, 'd/e') unless win_platform?
  end

  def test_linked_list_find
    list = [1,2,3,4,5].inject(Gem::List.new(0)) { |m,o|
      Gem::List.new o, m
    }
    assert_equal 5, list.find { |x| x == 5 }
    assert_equal 4, list.find { |x| x == 4 }
  end

end

