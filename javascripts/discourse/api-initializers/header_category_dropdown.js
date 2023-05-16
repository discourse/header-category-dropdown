import { apiInitializer } from "discourse/lib/api";
import { createWidget } from "discourse/widgets/widget";
import { hbs } from "ember-cli-htmlbars";
import RenderGlimmer from "discourse/widgets/render-glimmer";

export default apiInitializer("0.11.1", (api) => {
  createWidget("custom-header-links", {
    html(attrs) {
      return [
        new RenderGlimmer(
          this,
          "nav.custom-header-links",
          hbs`<CustomHeaderLinks />`
        ),
      ];
    },
  });

  if (!settings.show_category_ids) {
    return;
  }

  api.decorateWidget("home-logo:after", (helper) => {
    const scrolling = helper.attrs.minimized;
    return helper.attach("custom-header-links");
  });
});
