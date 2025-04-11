import type { AppUser } from "../services/auth";
import { unstable_createContext } from "react-router";

export const userContext = unstable_createContext<AppUser | null>();
