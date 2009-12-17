# encoding: utf-8
#
# redMine - project management software
# Copyright (C) 2006-2007  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require File.dirname(__FILE__) + '/../test_helper'

class WikiTest < ActiveSupport::TestCase
  fixtures :wikis, :wiki_pages, :wiki_contents, :wiki_content_versions
  
  def test_create
    wiki = Wiki.new(:project => Project.find(2))
    assert !wiki.save
    assert_equal 1, wiki.errors.count
  
    wiki.start_page = "Start page"
    assert wiki.save
  end

  def test_update
    @wiki = Wiki.find(1)
    @wiki.start_page = "Another start page"
    assert @wiki.save
    @wiki.reload
    assert_equal "Another start page", @wiki.start_page
  end
  
  def test_titleize
    assert_equal 'Page_title_with_CAPITALES', Wiki.titleize('page title with CAPITALES')
    assert_equal 'テスト', Wiki.titleize('テスト')
  end

  def test_upcase_first
    assert_equal 'Page title', Wiki.upcase_first('page title')
    assert_equal 'テスト', Wiki.titleize('テスト')
  end

  def test_find_categories
    @wiki = Wiki.find(1)
    assert_equal ['Examples', 'Documentation'], @wiki.find_all_categories
  end

  def test_find_pages_in_category
    @wiki = Wiki.find(1)
    assert_equal [1], @wiki.find_pages_in_category('Documentation').map {|c| c.id }.sort
    assert_equal [1, 4, 5, 6], @wiki.find_pages_in_category('Examples').map {|c| c.id }.sort
    assert_equal [2], @wiki.find_pages_in_category('None').map {|c| c.id }.sort
  end
end
