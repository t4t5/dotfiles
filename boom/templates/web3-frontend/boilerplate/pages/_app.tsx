import type { AppProps } from "next/app"
import Web3Provider from "contexts/web3"

function App({ Component, pageProps }: AppProps) {
  return (
    <Web3Provider>
      <Component {...pageProps} />
    </Web3Provider>
  )
}

export default App
