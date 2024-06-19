import { type inferAsyncReturnType, initTRPC } from "@trpc/server";
import { type CreateNextContextOptions } from "@trpc/server/adapters/next";
import { type NextApiRequest } from "next";
import superjson from "superjson";

const createInnerTRPCContext = (req?: NextApiRequest) => {
  const userAgent = req?.headers["user-agent"];

  return {
    userAgent,
    req,
    // prisma?
  };
};

export const createTRPCContext = (opts?: CreateNextContextOptions) => {
  const req = opts?.req;

  return createInnerTRPCContext(req);
};

export type Context = inferAsyncReturnType<typeof createTRPCContext> & {};

const t = initTRPC.context<Context>().create({
  transformer: superjson,
  errorFormatter({ shape }) {
    return shape;
  },
});

export const createTRPCRouter = t.router;

export const publicProcedure = t.procedure;
// .use(logMiddleware);
