class ChangelogController < ApplicationController
  layout 'public'

  # GET /changelog
  def index
    @year = changelog_year
    @skip_container = true
    @changelog_releases = Changelog::ChangesService.new(@year).releases
  end

  private

  def changelog_year
    given_year = params[:year].to_i
    this_year = Time.zone.now.year

    given_year.in?((2021..this_year).to_a) ? given_year : this_year
  end
end
