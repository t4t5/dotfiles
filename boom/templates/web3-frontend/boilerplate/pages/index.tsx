import { useProvider } from "wagmi"
import { ethers } from "ethers"
import { ConnectButton } from "@rainbow-me/rainbowkit"
import { MyContract__factory } from "contracts/factories/MyContract__factory"

const contractAddress = process.env.NEXT_PUBLIC_MY_CONTRACT_ADDRESS

export default function IndexPage() {
  const provider = useProvider()

  const getName = async () => {
    const myContract = MyContract__factory.connect(
      contractAddress || "",
      provider,
    )

    const nameHex = await myContract.getName()
    const name = ethers.utils.parseBytes32String(nameHex)
    console.log("NAME", name)
  }

  return (
    <div>
      <ConnectButton />
      <button onClick={getName}>Say name</button>
    </div>
  )
}
