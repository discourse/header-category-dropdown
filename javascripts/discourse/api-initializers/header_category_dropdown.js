import { hbs } from "ember-cli-htmlbars";
import { apiInitializer } from "discourse/lib/api";
import RenderGlimmer from "discourse/widgets/render-glimmer";
import { createWidget } from "discourse/widgets/widget";

export default apiInitializer("0.11.1", (api) => {
  createWidget("custom-header-links", {
    html() {
      return [
        new RenderGlimmer(
          this,
          "nav.custom-header-links",
          hbs`<CustomHeaderLinks />`
        ),
      ];
    },
  });

  api.decorateWidget("home-logo:after", (helper) => {
    return helper.attach("custom-header-links");
  });
});
