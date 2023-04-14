local TYPES = {
  VALUE=0,
  OPERATOR=1,
  OP_BR=2,
  CL_BR=3,
}

function Number(value)
  return {
    apply=function (stack)
      table.insert(stack, value)
    end,
    kind=TYPES.VALUE,
  }
end

function AddOp()
  return {
    apply=function (stack)
      local r = table.remove(stack)
      local l = table.remove(stack)
      table.insert(stack, r + l)
    end,
    kind=TYPES.OPERATOR,
    priority=1,
  }
end

function MulOp()
  return {
    apply=function (stack)
      local r = table.remove(stack)
      local l = table.remove(stack)
      table.insert(stack, r * l)
    end,
    kind=TYPES.OPERATOR,
    priority=2,
  }
end

function DivOp()
  return {
    apply=function (stack)
      local r = table.remove(stack)
      local l = table.remove(stack)
      table.insert(stack, l / r)
    end,
    kind=TYPES.OPERATOR,
    priority=2,
  }
end

function SubOp()
  return {
    apply=function (stack)
      local r = table.remove(stack)
      local l = table.remove(stack)
      table.insert(stack, l - r)
    end,
    kind=TYPES.OPERATOR,
    priority=1,
  }
end

function RandomOp()
  return {
    apply=function (stack)
      local l = table.remove(stack)
      table.insert(stack, love.math.random(l))
    end,
    kind=TYPES.OPERATOR,
    priority=1,
  }
end

function EvalStackMachine(tokens)
  local stack ={}

  for _, token in ipairs(tokens) do
    token.apply(stack)
  end

  if #stack ~= 1 then
    print('AAAAA')
    print('STACK SIZE '.. #stack)
    return nil
  end
  return stack[#stack]
end

function OpenBrackets()
  return {
    kind=TYPES.OP_BR,
  }
end

function CloseBrackets()
  return {
    kind=TYPES.CL_BR,
  }
end

function ShuntingYardAlgorithm(tokens)
  local output = {}
  local stack = {}
  for _, token in ipairs(tokens) do
    if token.kind == TYPES.VALUE then
      table.insert(output, token)
    elseif token.kind == TYPES.OPERATOR then
      -- Обработка приоритетов операторов
      -- TODO: проверка ассоциативности операторов
      if #stack ~= 0 then
        local top = stack[#stack]
        if top.kind == TYPES.OPERATOR then
          if top.priority > token.priority then
            table.insert(output, table.remove(stack))
          end
        end
      end

      table.insert(stack, token)
    elseif token.kind == TYPES.OP_BR then
      table.insert(stack, token)
    elseif token.kind == TYPES.CL_BR then
      while stack[#stack].kind ~= TYPES.OP_BR do
        local top = table.remove(stack)
        table.insert(output, top)
      end
      table.remove(stack) -- удаляем скобку из стека
    else
      print('HELL')
    end
  end

  while #stack ~= 0 do
    local top = table.remove(stack)
    if top.kind == TYPES.CL_BR or top.kind == TYPES.OP_BR then
      print('Bad parenthesis')
      return {}
    end
    table.insert(output, top)
  end

  return output
end

function love.load()
  -- (1 + 2) * (3 + 5) / 2 == 3 * 8 / 2 == 12
  -- local infixTokens = {
  --   OpenBrackets(),
  --   Number(1),
  --   AddOp(),
  --   Number(2),
  --   CloseBrackets(),

  --   MulOp(),

  --   OpenBrackets(),
  --   Number(3),
  --   AddOp(),
  --   Number(5),
  --   CloseBrackets(),

  --   DivOp(),
  --   Number(2)
  -- }
  -- 4 * 2 + 3
  -- local infixTokens = {
  --   Number(4),
  --   MulOp(),
  --   Number(2),
  --   AddOp(),
  --   Number(3),
  -- }
  local infixTokens = {
    RandomOp(),
    Number(42),
  }
  local tokens = ShuntingYardAlgorithm(infixTokens)
  
  for _, value in ipairs(tokens) do
    print(value)
  end

  local res = EvalStackMachine(tokens)
  print(res)


end
