require 'event_stream'
class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def update
    task = Task.where(id: params[:id]).first
    if task
      task.update_attribute(:completed, params[:completed])
      task.reload
      result = EventStream.post_event(task.to_json)
      render json: task
    else
      render nothing: true, status: 404
    end
  end

  def event_stream
    render json: EventStream.connection_info.to_json
  end
end
