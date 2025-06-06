import { on } from "@ember/modifier";

const CustomHeaderDropdown = <template>
  <a class="category-link" href={{@link.url}} {{on "click" @onClick}}>
    <li title={{@link.title}} class="custom-header-dropdown-link">
      <span class="custom-header-link-title">
        {{@link.title}}
      </span>
    </li>
  </a>
</template>;

export default CustomHeaderDropdown;
