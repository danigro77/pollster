class PollsController < ApplicationController

  def index
    @polls = Poll.all
  end

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.new params[:poll]
    @poll.poll_url = create_poll_url(params[:poll][:name])
    @poll.admin_url = create_admin_url
    @other_poll = other_poll(params[:poll][:name])

    if @poll.save
      redirect_to edit_poll_path(@poll.admin_url)
    else

      render :new
    end
  end

  def edit
    @poll = Poll.find_by_admin_url(params[:admin_url])
    @poll.questions.push Question.new
  end

  private
    def create_poll_url(name)
      url = ""
      name.split(' ').each do |word|
        url += (word.downcase + "_")
      end
      url += "poll"
    end

    def create_admin_url
      SecureRandom.urlsafe_base64(25)
    end

    def other_poll(name)
      Poll.where("name LIKE '#{name}%' ").first
    end
end