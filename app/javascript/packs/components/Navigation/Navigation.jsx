import React from "react";
import Aux from "../../hoc/Aux";

const navigation = () => (
  <Aux>
    <nav class="nav-bar wrapper bgkWhite">
      <div class="central">
        <div class="logo col">
          <a href="<%= dashboard_pages_path %>">  <img src="<%= image_path('logo.png') %>" class="logo-image" alt=""/></a>
        </div>
        <div class="col1 col">
          <div class="contBlock event">
            <div id="events" class="events">
            </div>
          </div>
          <div class="events-container">
          </div>
        </div>
        <div class="col1 col">
          <div class="contBlock">
            <div class="navbar-perfil">
              <button class="hamburger hamburger--squeeze" type="button">
                <span class="hamburger-box">
                  <span class="hamburger-inner"></span>
                </span>
              </button>
              <div class="hamburguer-perfil">
                <ul>
                  <a href="<%= edit_profile_pages_path %>"><li>Editar Perfil</li></a>
                  <a href="<%= destroy_user_session_path %>" data-method="delete"><li>Cerrar Sesión</li></a>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </nav>
  </Aux>
)

export default navigation;