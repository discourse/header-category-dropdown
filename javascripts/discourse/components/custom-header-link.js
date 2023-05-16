import Component from "@glimmer/component";
import { inject as service } from "@ember/service";

export default class CustomHeaderLinks extends Component {
  @service site;

  get dropdownLinks() {
    const filteredCategories = this.site.categories.filter((category) => {
      return (
        settings.show_category_ids.includes(category.id.toString()) &&
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
}
