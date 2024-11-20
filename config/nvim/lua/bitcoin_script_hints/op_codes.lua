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

return {
  OP_TOALTSTACK = OP_TOALTSTACK,
  OP_DEPTH = OP_DEPTH,
  OP_0 = OP_0,
  OP_1 = OP_1,
  OP_2 = OP_2,
  OP_DUP = OP_DUP,
  OP_ADD = OP_ADD,
  OP_SUB = OP_SUB,
  OP_1ADD = OP_1ADD,
  OP_1SUB = OP_1SUB,
  OP_GREATERTHAN = OP_GREATERTHAN,
  OP_NUMEQUAL = OP_NUMEQUAL,
  OP_NUMNOTEQUAL = OP_NUMNOTEQUAL,
  OP_IF = OP_IF,
  OP_ELSE = OP_ELSE,
  OP_ENDIF = OP_ENDIF,
  OP_FROMALTSTACK = OP_FROMALTSTACK,
  OP_SWAP = OP_SWAP,
  OP_SHA256 = OP_SHA256,
  OP_CAT = OP_CAT,
  OP_2DUP = OP_2DUP,
  OP_ROT = OP_ROT,
}
