module EditorsHelper
  def potential_editors
    Kernel.const_get(SIMPLESTONE[:user_class]).find(:all, :select => "id, #{SIMPLESTONE[:user_identifier].to_s}").map {|u| [u.send(SIMPLESTONE[:user_identifier]), u.id]}
  end
end
