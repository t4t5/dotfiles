import "@rainbow-me/rainbowkit/styles.css"
import { ReactNode } from "react"

import { getDefaultWallets, RainbowKitProvider } from "@rainbow-me/rainbowkit"
import { chain, configureChains, createClient, WagmiConfig } from "wagmi"
import { publicProvider } from "wagmi/providers/public"

const { chains, provider } = configureChains(
  [chain.localhost, chain.mainnet, chain.polygon],
  [publicProvider()],
)

const { connectors } = getDefaultWallets({
  appName: "My RainbowKit App",
  chains,
})

const wagmiClient = createClient({
  autoConnect: true,
  connectors,
  provider,
})

export default function Web3Provider({ children }: { children: ReactNode }) {
  return (
    <WagmiConfig client={wagmiClient}>
      <RainbowKitProvider chains={chains}>{children}</RainbowKitProvider>
    </WagmiConfig>
  )
}
