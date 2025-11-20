ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    # Top Row: Quick Stats
    columns do
      column do
        panel "Total Patients" do
          h1 User.where(role: :patient).count, style: "text-align: center; font-size: 2em;"
        end
      end
      column do
        panel "Total Audiologists" do
          h1 User.where(role: :audiologist).count, style: "text-align: center; font-size: 2em;"
        end
      end
      column do
        panel "Inventory Stock" do
          h1 HearingAid.sum(:stock), style: "text-align: center; font-size: 2em;"
        end
      end
    end

    # Bottom Row: Activity
    columns do
      column do
        panel "Recent Recommendations" do
          table_for Recommendation.order('created_at desc').limit(5) do
            column("Patient") { |rec| link_to rec.user.name, admin_user_path(rec.user) }
            column("Hearing Aid") { |rec| rec.hearing_aid.device_model }
            column("Status") { |rec| status_tag rec.status }
          end
        end
      end
    end
  end
end