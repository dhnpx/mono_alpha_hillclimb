const std = @import("std");

const Entry = struct {
    letter: u8,
    count: u16,
};

pub fn main() void {
    const ciphertext = "xqcmzoqcaluhsadkmevhcuewbsmneqbvwurqccqsuqrcsqsakfrraesmzvavqdqroqwcgaazkqcuhzqsadgwumdacqzduhbvaecqzdoqzsadsmraqezymeaqgmfsvmosvawomejqzdvmosmgeaqjsvayvaqeehiadqssvaurqccemmyqzdsmmjqcaqszalssmvhckehazdrqfeqovmqrcmcvqeadvhchzsaeacshzuewbsmneqbvwsvahzcsefusmecyhradqssvacsfdazscqzdhzsemdfuadvhycarkoarumyaaiaewmzahybemkaccmeoqznqzdsvhchcuewbsmneqbvwhzsvhcurqccoaohrrraqezsvagqchucmkuewbsmneqbvwhzurfdhznurqcchuqrqzdymdaezuhbvaeccwyyasehuqzdqcwyyasehuazuewbshmzvqcvkfzushmzcqzddhnhsqruaeshkhuqsacoaohrrqrcmraqezvmosmqzqrwpauewbsmcwcsaycqzdkhzdsvaheoaqjzaccacfchzniqehmfcqssqujccfuvqckeatfazuwqzqrwchcgefsakmeuaqzduvmcazbrqhzsalsxqcmzkarsqsvehrrmkqzshuhbqshmzqcbemkaccmeoqznumzshzfadsmalbrqhzsvaumfecamfsrhzaqzdcwrrqgfcvaumfrdzsoqhssmnascsqesadmzsvaqcchnzyazscqzdbemxauscsvqsomfrduvqrraznavhcueaqshihswqzdbemgraycmrihzncjhrrcnrqfeqraqzadmiaeqzdovhcbaeadsmxqcmzsvhchcnmhznsmgacmkfzhdmzsjzmoqgmfswmfgfshyeaqdwsmuequjcmyaumdacxqcmzzmddadqzdcyhradgqujyasmmvaqneaadsvhchcnmhznsmgasvagacsurqccaiae";

    // const freq_letters: [26]f32 = .{
    //     0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015, 0.06094, 0.06966, 0.00153,
    //     0.00772, 0.04025, 0.02406, 0.06749, 0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056,
    //     0.02758, 0.00978, 0.02360, 0.00150, 0.01974, 0.00074,
    // };

    const keys: [5][26]u8 = .{
        "etaoinshrdlucmfwypvbgkqjxz".*,
        "eaitnoshrdlcumfpgwybvkxjqz".*,
        "etainoshrdlcumfpgwybvkxjqz".*,
        "eaintoshrdluvcmwfgypbjxkqz".*,
        "etoiansrhlducmfwgypbvkxjqz".*,
    };

    var freq_ciphertext: [26]Entry = undefined;
    for (0..26) |i| {
        freq_ciphertext[i] = .{ .letter = ('a' + @as(u8, @intCast(i))), .count = 0 };
    }

    for (ciphertext) |c| {
        freq_ciphertext[c - 'a'].count += 1;
    }

    std.mem.sort(Entry, &freq_ciphertext, {}, compEntry);

    std.debug.print("Ciphertext letter frequencies\n\n", .{});

    for (0..26) |i| {
        std.debug.print("letter: {c}, count: {d}\n", .{ freq_ciphertext[i].letter, freq_ciphertext[i].count });
    }

    var plaintext: [ciphertext.len]u8 = undefined;
    for (keys) |key| {
        for (0..26) |i| {
            for (0..ciphertext.len) |j| {
                if (ciphertext[j] == freq_ciphertext[i].letter) {
                    plaintext[j] = key[i];
                }
            }
        }
        std.debug.print("Key: {s}\n", .{key});
        std.debug.print("{s}\n\n", .{plaintext});
    }
}

fn compEntry(_: void, a: Entry, b: Entry) bool {
    return a.count > b.count;
}

fn dispEntries(entries: []Entry) void {
    for (0..26) |i| {
        std.debug.print("letter: {c}, count: {d}\n", .{ entries[i].letter, entries[i].count });
    }
}
