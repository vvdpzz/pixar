class RechargeController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:notify]

  def index
    @orders = current_user.recharge_records
  end

  def create
    order = current_user.recharge_records.build credit: params[:credit]
    if order.save
      redirect_to recharge_url(order)
    else
      render :new
    end
  end

  def generate_order
    order = current_user.recharge_records.build credit: params[:credit]
    if order.save
      render json: {:order_id => order.id, :order_credit => order.credit, :html => render_to_string(:partial => 'alipay_form', :locals => {:order => order})}, :status :ok
    else
      render status: :unprocessable_entity
    end
  end

  def show
    @order = current_user.recharge_records.find params[:id]
  end

  def notify
    r = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)
    render :text => "fail" unless r.acknowledge

    @order = RechargeRecord.find r.out_trade_no
    if r.complete? and @order.trade_status == 0
      @order.update_attribute(:trade_status, 1)
      @order.user.update_attribute(:credit, @order.user.credit + r.total_fee.to_f)
      render :text => "success"
    end
  end

  def done
    r = ActiveMerchant::Billing::Integrations::Alipay::Return.new(request.query_string)
    @order = RechargeRecord.find r.order
    if (params[:trade_status] == "TRADE_SUCCESS" or params[:trade_status] == "TRADE_FINISHED") and @order.trade_status == 0
      @order.update_attribute(:trade_status, 1)
      @order.user.update_attribute(:credit, @order.user.credit + r.amount.to_f)
    end
    redirect_to recharge_index_url
  end
end