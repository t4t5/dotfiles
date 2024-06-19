import { z } from "zod";

import { createTRPCRouter, publicProcedure } from "@/trpc/context";

export const helloRouter = createTRPCRouter({
  sayHi: publicProcedure
    .input(
      z.object({
        name: z.string(),
      }),
    )
    .query(({ input }) => {
      const { name } = input;

      return `Hello, ${name}!`;
    }),
});
