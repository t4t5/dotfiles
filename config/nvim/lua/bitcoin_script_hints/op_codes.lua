local OP_TOALTSTACK = require('bitcoin_script_hints.op_codes.OP_TOALTSTACK')
local OP_FROMALTSTACK = require('bitcoin_script_hints.op_codes.OP_FROMALTSTACK')
local OP_DEPTH = require('bitcoin_script_hints.op_codes.OP_DEPTH')
local OP_0 = require('bitcoin_script_hints.op_codes.OP_0')
local OP_1 = require('bitcoin_script_hints.op_codes.OP_1')
local OP_2 = require('bitcoin_script_hints.op_codes.OP_2')
local OP_DUP = require('bitcoin_script_hints.op_codes.OP_DUP')
local OP_ADD = require('bitcoin_script_hints.op_codes.OP_ADD')
local OP_SUB = require('bitcoin_script_hints.op_codes.OP_SUB')
local OP_1ADD = require('bitcoin_script_hints.op_codes.OP_1ADD')
local OP_1SUB = require('bitcoin_script_hints.op_codes.OP_1SUB')
local OP_GREATERTHAN = require('bitcoin_script_hints.op_codes.OP_GREATERTHAN')
local OP_NUMEQUAL = require('bitcoin_script_hints.op_codes.OP_NUMEQUAL')
local OP_NUMNOTEQUAL = require('bitcoin_script_hints.op_codes.OP_NUMNOTEQUAL')
local OP_IF = require('bitcoin_script_hints.op_codes.OP_IF')
local OP_ELSE = require('bitcoin_script_hints.op_codes.OP_ELSE')
local OP_ENDIF = require('bitcoin_script_hints.op_codes.OP_ENDIF')
local OP_SWAP = require('bitcoin_script_hints.op_codes.OP_SWAP')
local OP_SHA256 = require('bitcoin_script_hints.op_codes.OP_SHA256')
local OP_CAT = require('bitcoin_script_hints.op_codes.OP_CAT')
local OP_2DUP = require('bitcoin_script_hints.op_codes.OP_2DUP')
local OP_ROT = require('bitcoin_script_hints.op_codes.OP_ROT')

-- The opcodes follow the same order as displayed on:
-- https://en.bitcoin.it/wiki/Script

return {
  -- Constants:
  OP_0 = OP_0,
  -- TODO: OP_FALSE (same as OP_0)
  OP_1 = OP_1,
  OP_2 = OP_2,
  -- TODO: OP_PUSHDATA1, PUSHDATA2, PUSHDATA4
  -- TODO: OP_1NEGATE
  -- TODO: OP_TRUE (same as OP_1)
  -- OP_3-16 (works same way as OP_1, OP_2...)

  -- Flow control:
  -- TODO: OP_NOP
  OP_IF = OP_IF,
  -- TODO: OP_NOTIF
  OP_ELSE = OP_ELSE,
  OP_ENDIF = OP_ENDIF,
  -- TODO: OP_VERIFY
  -- TODO: OP_RETURN

  -- Stack:
  OP_TOALTSTACK = OP_TOALTSTACK,
  OP_FROMALTSTACK = OP_FROMALTSTACK,
  -- TODO: OP_IFDUP
  OP_DEPTH = OP_DEPTH,
  -- TODO: OP_DROP
  OP_DUP = OP_DUP,
  -- TODO: OP_NIP
  -- TODO: OP_OVER
  -- TODO: OP_PICK
  -- TODO: OP_ROLL
  OP_ROT = OP_ROT,
  OP_SWAP = OP_SWAP,
  -- TODO: OP_TUCK
  -- TODO: OP_2DROP
  OP_2DUP = OP_2DUP,
  -- TODO: OP_3DUP
  -- TODO: OP_2OVER
  -- TODO: OP_2ROT
  -- TODO: OP_2SWAP

  -- Splice:
  OP_CAT = OP_CAT,
  -- TODO: OP_SIZE

  -- Bitwise logic:
  -- TODO: OP_EQUAL
  -- TODO: OP_EQUALVERIFY

  -- Arithmetic:
  OP_1ADD = OP_1ADD,
  OP_1SUB = OP_1SUB,
  -- TODO: OP_NEGATE
  -- TODO: OP_ABS
  -- TODO: OP_NOT
  -- TODO: OP_0NOTEQUAL
  OP_ADD = OP_ADD,
  OP_SUB = OP_SUB,
  -- TODO: OP_BOOLAND
  -- TODO: OP_BOOLOR
  OP_NUMEQUAL = OP_NUMEQUAL,
  -- TODO: OP_NUMEQUALVERIFY
  OP_NUMNOTEQUAL = OP_NUMNOTEQUAL,
  -- TODO: OP_LESSTHAN
  OP_GREATERTHAN = OP_GREATERTHAN,
  -- TODO: OP_LESSTHANOREQUAL
  -- TODO: OP_GREATERTHANOREQUAL
  -- TODO: OP_MIN
  -- TODO: OP_MAX
  -- TODO: OP_WITHIN

  -- Crypto:
  -- TODO: OP_RIPEMD160 (same as sha)
  -- TODO: OP_SHA1 (same as sha)
  OP_SHA256 = OP_SHA256,
  -- TODO: OP_HASH160 (same as sha)
  -- TODO: OP_HASH256 (same as sha)
  -- TODO: OP_CODESSEPARATOR
  -- TODO: OP_CHECKSIG
  -- TODO: OP_CHECKSIGVERIFY
  -- TODO: OP_CHECKMULTISIG
  -- TODO: OP_CHECKMULTISIGVERIFY
  -- TODO: OP_CHECKSIGADD

  -- Locktime:
  -- TODO: OP_CHECKLOCKTIMEVERIFY
  -- TODO: OP_CHECKSEQUENCEVERIFY
}
