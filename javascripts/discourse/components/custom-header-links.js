import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { bind } from "discourse-common/utils/decorators";

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
    const categories = this.site.categories;
    const show_category_ids = settings.show_category_ids.split("|");
    const filteredCategories = categories.filter((category) => {
      return (
        show_category_ids.includes(category.id.toString()) &&
        !category.parent_category_id
      );
    });
    const headerLinks = filteredCategories.map((category) => {
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
}
