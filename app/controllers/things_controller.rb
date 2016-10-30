class ThingsController < ApplicationController
  def create
    run Thing::Create do |op|
      return redirect_to things_path
    end

    render action: :new
  end

  def new
    form Thing::Create
  end

  def update
    run Thing::Update do |op|
      return redirect_to things_path
    end

    render action: :new
  end

  def edit
    form Thing::Update

    render action: :new
  end

  def show
    @thing = Thing.find_by_id(params[:id])
  end
end
