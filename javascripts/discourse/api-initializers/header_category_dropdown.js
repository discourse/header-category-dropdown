import { apiInitializer } from "discourse/lib/api";
import CustomHeaderLinks from "../components/custom-header-links";

export default apiInitializer("1.15.0", (api) => {
  api.renderInOutlet("before-header-panel", CustomHeaderLinks);
});
