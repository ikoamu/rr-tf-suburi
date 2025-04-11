import { authMiddleware } from "../middlewares/auth-middleware";
import { Outlet } from "react-router";

export const unstable_clientMiddleware = [authMiddleware];

export default function PublicLayout () {
  return (
    <Outlet/>
  );
}