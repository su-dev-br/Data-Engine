import os 
import psycopg2
from .env import *

from flask import Blueprint, render_template
from flask_appbuilder import BaseView, expose
from airflow.plugins_manager import AirflowPlugin
from airflow.configuration import conf


print("cwd", os.getcwd())
# Create a blueprint
dashboard_blueprint = Blueprint(NAME, __name__, template_folder='templates')


appbuilder_mitem_toplevel = {
    "name": "MYPAGE1",
    "href": "/test",
}

class BaseMenuView(BaseView):
    default_view = "test"

    @expose("/test")
    def test(self):
        # return self.render_template("plugins/dashboard/templates/test.html", content="Hello galaxy!")
        return "Hellow galaxy!"

v_appbuilder_nomenu_view = BaseMenuView()
v_appbuilder_nomenu_package = {"view": v_appbuilder_nomenu_view}

class MyAirflowPlugin(AirflowPlugin):
    name = NAME
    flask_blueprints = [dashboard_blueprint]
    appbuilder_views = [v_appbuilder_nomenu_package]
    appbuilder_menu_items = [appbuilder_mitem_toplevel]
