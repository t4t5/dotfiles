import { createNextApiHandler } from "@trpc/server/adapters/next";

import { appRouter } from "@/trpc/root";
import { createTRPCContext } from "@/trpc/context";

// export API handler
export default createNextApiHandler({
  router: appRouter,
  createContext: createTRPCContext,
  onError:
    process.env.NODE_ENV === "development"
      ? ({ path, error }) => {
          console.error(
            `❌ tRPC failed on ${path ?? "<no-path>"}: ${error.message}`,
            error.stack,
          );
        }
      : undefined,
});
