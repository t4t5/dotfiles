import { Hono } from "hono";
import { serveStatic } from "@hono/node-server/serve-static";

import HomePage from "@/pages/home";

const app = new Hono();

app.get("/", (c) => {
  return c.html(<HomePage />);
});

app.get("/api/hello", (c) => {
  return c.json({ message: "Hello, world!" });
});

app.use("/*", serveStatic({ root: "./src/public" }));

export default app;
