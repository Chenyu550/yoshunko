const std = @import("std");
const pb = @import("proto").pb;
const network = @import("../network.zig");
const State = @import("../network/State.zig");
const Memory = State.Memory;
const Assets = @import("../data/Assets.zig");
const PlayerBasicComponent = @import("../logic/component/player/PlayerBasicComponent.zig");

pub fn onGetMiscDataCsReq(
    txn: *network.Transaction(pb.GetMiscDataCsReq),
    mem: Memory,
    assets: *const Assets,
    basic_comp: *PlayerBasicComponent,
) !void {
    errdefer txn.respond(.{ .retcode = 1 }) catch {};
    const templates = &assets.templates;

    var data: pb.MiscData = .{
        .business_card = .{},
        .player_accessory = .{
            .control_guise_avatar_id = basic_comp.info.control_guise_avatar_id,
        },
        .post_girl = .{},
    };

    try data.post_girl.?.post_girl_item_list.append(mem.arena, .{ .id = 3510041 });
    try data.post_girl.?.show_post_girl_id_list.append(mem.arena, 3510041);

    var unlocked_list = try mem.arena.alloc(i32, templates.unlock_config_template_tb.payload.data.len);
    for (templates.unlock_config_template_tb.payload.data, 0..) |template, i| {
        unlocked_list[i] = @intCast(template.id);
    }
    data.unlock = .{ .unlocked_list = .fromOwnedSlice(unlocked_list) };

    var teleport_list = try mem.arena.alloc(i32, templates.teleport_config_template_tb.payload.data.len);
    for (templates.teleport_config_template_tb.payload.data, 0..) |template, i| {
        teleport_list[i] = @intCast(template.teleport_id);
    }
    data.teleport = .{ .unlocked_list = .fromOwnedSlice(teleport_list) };

    try txn.respond(.{ .data = data });
}

const usm_keys: []const pb.MapEntry(u32, u64) = &.{
    .{ .key = 2594, .value = 4467266561939507470 },
    .{ .key = 2529, .value = 13968483637407856949 },
    .{ .key = 2568, .value = 15259010423462933427 },
    .{ .key = 2532, .value = 12528959072272708846 },
    .{ .key = 2555, .value = 8546898135554098239 },
    .{ .key = 2576, .value = 4380835394853404937 },
    .{ .key = 2566, .value = 8294158829540574718 },
    .{ .key = 2578, .value = 4327083970575039345 },
    .{ .key = 2575, .value = 1485815930250774942 },
    .{ .key = 2589, .value = 16440991805606597195 },
    .{ .key = 2553, .value = 15278715111505066720 },
    .{ .key = 2574, .value = 18200074716471469546 },
    .{ .key = 2572, .value = 15017715112388667835 },
    .{ .key = 2565, .value = 3941200226474834056 },
    .{ .key = 2506, .value = 14291798082091608945 },
    .{ .key = 2524, .value = 8159658256619680658 },
    .{ .key = 2564, .value = 12623443993576490497 },
    .{ .key = 2585, .value = 16440991805606597195 },
    .{ .key = 2534, .value = 2921484915745029756 },
    .{ .key = 2560, .value = 2979250444567898105 },
    .{ .key = 2460, .value = 399534112198758385 },
    .{ .key = 2583, .value = 442401425881169688 },
    .{ .key = 2551, .value = 17653640841158876937 },
    .{ .key = 2590, .value = 5531095304392363613 },
    .{ .key = 2558, .value = 11944976644102107149 },
    .{ .key = 2573, .value = 11364929749590955351 },
    .{ .key = 2581, .value = 16420219029453222549 },
    .{ .key = 2528, .value = 375470177504018724 },
    .{ .key = 2563, .value = 4230571604426115633 },
    .{ .key = 2580, .value = 4489053558247693917 },
    .{ .key = 2533, .value = 11561446229961895555 },
    .{ .key = 2530, .value = 10508062696221220705 },
    .{ .key = 2570, .value = 9644230727174596775 },
    .{ .key = 2559, .value = 4918860462171001811 },
    .{ .key = 2458, .value = 7451714203198873009 },
    .{ .key = 2582, .value = 1182608979979866172 },
    .{ .key = 2467, .value = 17006730454366894237 },
    .{ .key = 2531, .value = 4257951510558629830 },
    .{ .key = 2586, .value = 5531095304392363613 },
    .{ .key = 2556, .value = 18258413594235627089 },
    .{ .key = 2552, .value = 1429762263881724144 },
    .{ .key = 2584, .value = 8287325782388676899 },
    .{ .key = 2457, .value = 6764531406696823462 },
    .{ .key = 2554, .value = 17144483315722910054 },
    .{ .key = 2577, .value = 7420330399634232526 },
    .{ .key = 2465, .value = 1275663066846298853 },
    .{ .key = 2561, .value = 1955100867254013431 },
    .{ .key = 2557, .value = 12722988219986932409 },
    .{ .key = 2459, .value = 4252023969971935652 },
    .{ .key = 2593, .value = 18077251739658560742 },
    .{ .key = 2569, .value = 15999317281178507525 },
    .{ .key = 2571, .value = 1049526658689700862 },
    .{ .key = 2562, .value = 15987295174799927409 },
    .{ .key = 2592, .value = 5020456060714997278 },
    .{ .key = 2591, .value = 7192253913335593913 },
    .{ .key = 2579, .value = 9379304611229122119 },
    .{ .key = 2567, .value = 17703087493133519243 },
    .{ .key = 2525, .value = 220148305910663898 },
    .{ .key = 2466, .value = 8702115569357817493 },
    .{ .key = 2657, .value = 16674896414989947075 },
    .{ .key = 2659, .value = 13917936656939615982 },
    .{ .key = 2660, .value = 7951669154249915432 },
    .{ .key = 2661, .value = 6061018638010719763 },
};

pub fn onVideoGetInfoCsReq(
    txn: *network.Transaction(pb.VideoGetInfoCsReq),
) !void {
    errdefer txn.respond(.{ .retcode = 1 }) catch {};

    try txn.respond(.{
        .retcode = 0,
        .video_key_map = .{
            .capacity = usm_keys.len,
            .items = @constCast(usm_keys),
        },
    });
}
