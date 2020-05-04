describe("The peripheral library", function()
    local it_modem = peripheral.getType("top") == "modem" and it or pending

    describe("peripheral.isPresent", function()
        it("validates arguments", function()
            peripheral.isPresent("")
            expect.error(peripheral.isPresent, nil):eq("bad argument #1 (expected string, got nil)")
        end)
    end)

    describe("peripheral.getName", function()
        it("validates arguments", function()
            expect.error(peripheral.getName, nil):eq("bad argument #1 (expected table, got nil)")
            expect.error(peripheral.getName, {}):eq("bad argument #1 (table is not a peripheral)")
        end)

        it_modem("can get the name of a wrapped peripheral", function()
            expect(peripheral.getName(peripheral.wrap("top"))):eq("top")
        end)
    end)

    describe("peripheral.getType", function()
        it("validates arguments", function()
            peripheral.getType("")
            expect.error(peripheral.getType, nil):eq("bad argument #1 (expected string or table, got nil)")
            expect.error(peripheral.getType, {}):eq("bad argument #1 (table is not a peripheral)")
        end)

        it_modem("can get the type of a peripheral by side", function()
            expect(peripheral.getType("top")):eq("modem")
        end)

        it_modem("can get the type of a wrapped peripheral", function()
            expect(peripheral.getType(peripheral.wrap("top"))):eq("modem")
        end)
    end)

    describe("peripheral.getMethods", function()
        it("validates arguments", function()
            peripheral.getMethods("")
            expect.error(peripheral.getMethods, nil):eq("bad argument #1 (expected string, got nil)")
        end)
    end)

    describe("peripheral.call", function()
        it("validates arguments", function()
            peripheral.call("", "")
            expect.error(peripheral.call, nil):eq("bad argument #1 (expected string, got nil)")
            expect.error(peripheral.call, "", nil):eq("bad argument #2 (expected string, got nil)")
        end)

        it_modem("has the correct error location", function()
            expect.error(function() peripheral.call("top", "isOpen", false) end)
                :str_match("^peripheral_spec.lua:%d+: bad argument #1 %(number expected, got boolean%)$")
        end)
    end)

    describe("peripheral.wrap", function()
        it("validates arguments", function()
            peripheral.wrap("")
            expect.error(peripheral.wrap, nil):eq("bad argument #1 (expected string, got nil)")
        end)
    end)

    describe("peripheral.find", function()
        it("validates arguments", function()
            peripheral.find("")
            peripheral.find("", function()
            end)
            expect.error(peripheral.find, nil):eq("bad argument #1 (expected string, got nil)")
            expect.error(peripheral.find, "", false):eq("bad argument #2 (expected function, got boolean)")
        end)
    end)
end)
