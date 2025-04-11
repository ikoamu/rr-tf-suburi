import { getUser } from "../services/auth";
import {
  type unstable_MiddlewareFunction as MiddlewareFunction,
} from "react-router";
import { userContext } from "./user-context";

export const authMiddleware: MiddlewareFunction = async ({ context }) => {
  const user = await getUser();
  context.set(userContext, user);
};
