class FeedbacksController < ApplicationController
  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      respond_to do |format|
        format.turbo_stream

        format.html do
          redirect_to about_path(anchor: "feedback_form"),
            flash: { feedback_sent: true },
            status: :see_other
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render :error, status: :unprocessable_entity
        end

        format.html do
          render "welcome/about", status: :unprocessable_entity
        end
      end
    end
  end

  private

  def feedback_params
    params.expect(feedback: [:body])
  end
end