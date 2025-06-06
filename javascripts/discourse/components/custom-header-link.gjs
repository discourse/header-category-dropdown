import Component from "@glimmer/component";
import { on } from "@ember/modifier";
import { service } from "@ember/service";
import icon from "discourse/helpers/d-icon";
import CustomHeaderDropdown from "./custom-header-dropdown";

export default class CustomHeaderLinks extends Component {
  @service site;

  get dropdownLinks() {
    const filteredCategories = this.site.categories.filter((category) => {
      return (
        !settings.hide_category_ids.includes(category.id.toString()) &&
        category.parent_category_id
      );
    });

    const allDropdownItems = filteredCategories.map((category) => {
      return {
        id: category.id,
        title: category.name,
        url: category.url,
        parentId: category.parent_category_id,
      };
    });

    const dropdownLinks = allDropdownItems.filter(
      (d) => d.parentId === this.args.item.id
    );
    return dropdownLinks;
  }

  <template>
    <li class="custom-header-link" title={{@item.title}}>
      <span class="custom-header-link-title">
        <a
          class="category-link"
          href={{@item.url}}
          {{on "click" @onClick}}
        >{{@item.title}}</a>
      </span>
      {{#if this.dropdownLinks}}
        <span class="custom-header-link-caret">{{icon "caret-down"}}</span>
        <ul class="custom-header-dropdown">
          {{#each this.dropdownLinks as |link|}}
            <CustomHeaderDropdown @link={{link}} @onClick={{@onClick}} />
          {{/each}}
        </ul>
      {{/if}}
    </li>
  </template>
}
