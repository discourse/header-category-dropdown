import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import { bind } from "discourse/lib/decorators";
import CustomHeaderLink from "./custom-header-link";

export default class CustomHeaderLinks extends Component {
  @service site;

  @tracked showLinks = !this.site.mobileView;

  constructor() {
    super(...arguments);

    if (this.site.mobileView) {
      document.addEventListener("click", this.outsideClick);
    }
  }

  willDestroy() {
    super.willDestroy(...arguments);
    if (this.site.mobileView) {
      document.removeEventListener("click", this.outsideClick);
    }
  }

  @bind
  outsideClick(event) {
    const dropdown = document.querySelector(".top-level-links");
    if (dropdown && !dropdown.contains(event.target)) {
      this.toggleHeaderLinks();
    }
  }

  get headerLinks() {
    let categories = this.site.categoriesList;
    const hide_category_ids = settings.hide_category_ids
      .split("|")
      .filter(Boolean);

    if (hide_category_ids.length > 0) {
      categories = categories.filter((category) => {
        return (
          !hide_category_ids.includes(category.id.toString()) &&
          !category.parent_category_id
        );
      });
    }
    const headerLinks = categories.map((category) => {
      return {
        id: category.id,
        title: category.name,
        url: category.url,
      };
    });
    return headerLinks;
  }

  @action
  toggleHeaderLinks() {
    if (this.site.desktopView) {
      return;
    }

    this.showLinks = !this.showLinks;
    if (this.showLinks) {
      document.body.classList.add("dropdown-header-open");
    } else {
      document.body.classList.remove("dropdown-header-open");
    }
  }

  <template>
    <nav class="custom-header-links">
      {{#if this.site.mobileView}}
        <span class="btn-custom-header-dropdown-mobile">
          <DButton
            @icon="square-caret-down"
            @title="header_category_dropdown.show_header_links"
            @action={{this.toggleHeaderLinks}}
          />
        </span>
      {{/if}}
      {{#if this.showLinks}}
        <ul class="top-level-links">
          {{#each this.headerLinks as |item|}}
            <CustomHeaderLink
              @item={{item}}
              @showHeaderLinks={{this.showLinks}}
              @onClick={{this.toggleHeaderLinks}}
            />
          {{/each}}
        </ul>
      {{/if}}
    </nav>
  </template>
}
