local OP_TOALTSTACK = require('bitcoin_script_hints.op_codes.OP_TOALTSTACK')
local OP_FROMALTSTACK = require('bitcoin_script_hints.op_codes.OP_FROMALTSTACK')
local OP_DEPTH = require('bitcoin_script_hints.op_codes.OP_DEPTH')
local OP_NUMBER = require('bitcoin_script_hints.op_codes.OP_NUMBER')
local OP_DUP = require('bitcoin_script_hints.op_codes.OP_DUP')
local OP_ADD = require('bitcoin_script_hints.op_codes.OP_ADD')
local OP_SUB = require('bitcoin_script_hints.op_codes.OP_SUB')
local OP_1ADD = require('bitcoin_script_hints.op_codes.OP_1ADD')
local OP_1SUB = require('bitcoin_script_hints.op_codes.OP_1SUB')
local OP_GREATERTHAN = require('bitcoin_script_hints.op_codes.OP_GREATERTHAN')
local OP_NUMEQUAL = require('bitcoin_script_hints.op_codes.OP_NUMEQUAL')
local OP_NUMEQUALVERIFY = require('bitcoin_script_hints.op_codes.OP_NUMEQUALVERIFY')
local OP_NUMNOTEQUAL = require('bitcoin_script_hints.op_codes.OP_NUMNOTEQUAL')
local OP_IF = require('bitcoin_script_hints.op_codes.OP_IF')
local OP_NOTIF = require('bitcoin_script_hints.op_codes.OP_NOTIF')
local OP_ELSE = require('bitcoin_script_hints.op_codes.OP_ELSE')
local OP_ENDIF = require('bitcoin_script_hints.op_codes.OP_ENDIF')
local OP_SWAP = require('bitcoin_script_hints.op_codes.OP_SWAP')
local OP_HASH = require('bitcoin_script_hints.op_codes.OP_HASH')
local OP_CAT = require('bitcoin_script_hints.op_codes.OP_CAT')
local OP_2DUP = require('bitcoin_script_hints.op_codes.OP_2DUP')
local OP_2DROP = require('bitcoin_script_hints.op_codes.OP_2DROP')
local OP_3DUP = require('bitcoin_script_hints.op_codes.OP_3DUP')
local OP_ROT = require('bitcoin_script_hints.op_codes.OP_ROT')
local OP_NOP = require('bitcoin_script_hints.op_codes.OP_NOP')
local OP_VERIFY = require('bitcoin_script_hints.op_codes.OP_VERIFY')
local OP_IFDUP = require('bitcoin_script_hints.op_codes.OP_IFDUP')
local OP_DROP = require('bitcoin_script_hints.op_codes.OP_DROP')
local OP_NIP = require('bitcoin_script_hints.op_codes.OP_NIP')
local OP_OVER = require('bitcoin_script_hints.op_codes.OP_OVER')
local OP_PICK = require('bitcoin_script_hints.op_codes.OP_PICK')
local OP_ROLL = require('bitcoin_script_hints.op_codes.OP_ROLL')
local OP_TUCK = require('bitcoin_script_hints.op_codes.OP_TUCK')
local OP_2OVER = require('bitcoin_script_hints.op_codes.OP_2OVER')
local OP_2ROT = require('bitcoin_script_hints.op_codes.OP_2ROT')
local OP_2SWAP = require('bitcoin_script_hints.op_codes.OP_2SWAP')
local OP_EQUAL = require('bitcoin_script_hints.op_codes.OP_EQUAL')
local OP_EQUALVERIFY = require('bitcoin_script_hints.op_codes.OP_EQUALVERIFY')
local OP_SIZE = require('bitcoin_script_hints.op_codes.OP_SIZE')
local OP_NEGATE = require('bitcoin_script_hints.op_codes.OP_NEGATE')
local OP_ABS = require('bitcoin_script_hints.op_codes.OP_ABS')
local OP_NOT = require('bitcoin_script_hints.op_codes.OP_NOT')
local OP_0NOTEQUAL = require('bitcoin_script_hints.op_codes.OP_0NOTEQUAL')
local OP_BOOLAND = require('bitcoin_script_hints.op_codes.OP_BOOLAND')
local OP_BOOLOR = require('bitcoin_script_hints.op_codes.OP_BOOLOR')
local OP_MIN = require('bitcoin_script_hints.op_codes.OP_MIN')
local OP_MAX = require('bitcoin_script_hints.op_codes.OP_MAX')
local OP_WITHIN = require('bitcoin_script_hints.op_codes.OP_WITHIN')
local OP_LESSTHAN = require('bitcoin_script_hints.op_codes.OP_LESSTHAN')
local OP_GREATERTHANOREQUAL = require('bitcoin_script_hints.op_codes.OP_GREATERTHANOREQUAL')
local OP_LESSTHANOREQUAL = require('bitcoin_script_hints.op_codes.OP_LESSTHANOREQUAL')

-- The opcodes follow the same order as displayed on:
-- https://en.bitcoin.it/wiki/Script

return {
  -- Constants:
  OP_0 = OP_NUMBER(0),
  OP_FALSE = OP_NUMBER(0),
  OP_1 = OP_NUMBER(1),
  OP_PUSHDATA1 = OP_NOP,
  OP_PUSHDATA2 = OP_NOP,
  OP_PUSHDATA4 = OP_NOP,
  OP_1NEGATE = OP_NUMBER(-1),
  OP_TRUE = OP_NUMBER(1),
  OP_2 = OP_NUMBER(2),
  OP_3 = OP_NUMBER(3),
  OP_4 = OP_NUMBER(4),
  OP_5 = OP_NUMBER(5),
  OP_6 = OP_NUMBER(6),
  OP_7 = OP_NUMBER(7),
  OP_8 = OP_NUMBER(8),
  OP_9 = OP_NUMBER(9),
  OP_10 = OP_NUMBER(10),
  OP_11 = OP_NUMBER(11),
  OP_12 = OP_NUMBER(12),
  OP_13 = OP_NUMBER(13),
  OP_14 = OP_NUMBER(14),
  OP_15 = OP_NUMBER(15),
  OP_16 = OP_NUMBER(16),

  -- Flow control:
  OP_NOP = OP_NOP,
  OP_IF = OP_IF,
  OP_NOTIF = OP_NOTIF,
  OP_ELSE = OP_ELSE,
  OP_ENDIF = OP_ENDIF,
  OP_VERIFY = OP_VERIFY,
  OP_RETURN = OP_NOP,

  -- Stack:
  OP_TOALTSTACK = OP_TOALTSTACK,
  OP_FROMALTSTACK = OP_FROMALTSTACK,
  OP_IFDUP = OP_IFDUP,
  OP_DEPTH = OP_DEPTH,
  OP_DROP = OP_DROP,
  OP_DUP = OP_DUP,
  OP_NIP = OP_NIP,
  OP_OVER = OP_OVER,
  OP_PICK = OP_PICK,
  OP_ROLL = OP_ROLL,
  OP_ROT = OP_ROT,
  OP_SWAP = OP_SWAP,
  OP_TUCK = OP_TUCK,
  OP_2DROP = OP_2DROP,
  OP_2DUP = OP_2DUP,
  OP_3DUP = OP_3DUP,
  OP_2OVER = OP_2OVER,
  OP_2ROT = OP_2ROT,
  OP_2SWAP = OP_2SWAP,

  -- Splice:
  OP_CAT = OP_CAT,
  OP_SIZE = OP_SIZE,

  -- Bitwise logic:
  OP_EQUAL = OP_EQUAL,
  OP_EQUALVERIFY = OP_EQUALVERIFY,

  -- Arithmetic:
  OP_1ADD = OP_1ADD,
  OP_1SUB = OP_1SUB,
  OP_NEGATE = OP_NEGATE,
  OP_ABS = OP_ABS,
  OP_NOT = OP_NOT,
  OP_0NOTEQUAL = OP_0NOTEQUAL,
  OP_ADD = OP_ADD,
  OP_SUB = OP_SUB,
  OP_BOOLAND = OP_BOOLAND,
  OP_BOOLOR = OP_BOOLOR,
  OP_NUMEQUAL = OP_NUMEQUAL,
  OP_NUMEQUALVERIFY = OP_NUMEQUALVERIFY,
  OP_NUMNOTEQUAL = OP_NUMNOTEQUAL,
  OP_LESSTHAN = OP_LESSTHAN,
  OP_GREATERTHAN = OP_GREATERTHAN,
  OP_LESSTHANOREQUAL = OP_LESSTHANOREQUAL,
  OP_GREATERTHANOREQUAL = OP_GREATERTHANOREQUAL,
  OP_MIN = OP_MIN,
  OP_MAX = OP_MAX,
  OP_WITHIN = OP_WITHIN,

  -- Crypto:
  OP_RIPEMD160 = OP_HASH,
  OP_SHA1 = OP_HASH,
  OP_SHA256 = OP_HASH,
  OP_HASH160 = OP_HASH,
  OP_HASH256 = OP_HASH,
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
