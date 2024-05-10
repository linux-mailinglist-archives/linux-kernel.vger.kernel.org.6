Return-Path: <linux-kernel+bounces-175913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB8D8C270F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75779281114
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A0171078;
	Fri, 10 May 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm0U8a7T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6E12C526
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352038; cv=none; b=o3sBmuDmBSGnK+s98/7uayDsyKR2YR0Dl0hzGpf1bkSD+KdC/QCtFBmgRaoyIS+MY4ZX5+lFAFQIKf1QKCyTVFasbiMTvGY/QshLw59E4MZUfV4wGN6nbQIjksChcy1KIoG/G6vZu219RtNGqmXlrokbxL9dFHJGyGkI8O71tRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352038; c=relaxed/simple;
	bh=0eRaul/Y8OhHivZtqo7+o8zpgztMV9CM2N14z1LQNwM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OVGCcDHCTVdTB+Nu871ajG5DfKRV1aRvfjOgM8zGs9/ysOw+9iPpJo7rZqxMEIxNEz85W9ogCWzMjzbqkqeaUsfGRHwAPQySLqQXTwJjpk/MhCnbArZ89ggYIiJ/p6k6HPNvyL+0Xkl9nXy6pQOG/ZMMPcw75v1z6Z7SEAk1JQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm0U8a7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4C8C113CC;
	Fri, 10 May 2024 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715352037;
	bh=0eRaul/Y8OhHivZtqo7+o8zpgztMV9CM2N14z1LQNwM=;
	h=Date:From:To:Cc:Subject:From;
	b=lm0U8a7TkYqWf3FHoGjWjViIthFrwPIQhpRfGPgJzxpUYjCX1Mays44MaK5qJBMv2
	 POmhrJQMSQnhX/5Y8gK57kaqfyaicPYx9n7Q4+bSGD+JdcXAGAhlRbh1LD59iKyjNk
	 wOOCVLgpy+MLv5kk9OlR9exhNWw8H+Mr9Ggf5WgDp7sGkjOcCNnW+wRPqD0vzyKrXN
	 ikIQVlHL2pqxLdGcnY9uP+lfe1g7zw/Z3PLGE5uyx5QftxWPqIl62H6mXdHL9657ES
	 zQVMVgEisqjuaMfpfrY+364CXintzY6xJ0iDFkvCZZQkSyvu8FCw3oW1tF1GNPBXbC
	 rXHH/gNTteJbg==
Date: Fri, 10 May 2024 11:40:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: perf annotate --data-type segfault
Message-ID: <Zj4x4g0avd6ZW8Jl@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

root@number:~# perf --debug type-profile annotate --data-type -i perf.data.perf-trace-bpf &> perf--debug.type-profile-annotate--data-type.perf-trace-bpf.output
Segmentation fault (core dumped)
root@number:~#

The output ended in:

Annotate type: 'struct sk_security_struct' in [kernel.kallsyms] (1 samples):
============================================================================
 Percent     offset       size  field
  100.00          0         32  struct sk_security_struct        {
    0.00          0          4      enum        nlbl_state;
    0.00          8          8      struct netlbl_lsm_secattr*  nlbl_secattr;
  100.00         16          4      u32 sid;
    0.00         20          4      u32 peer_sid;
    0.00         24          2      u16 sclass;
    0.00         28          4      enum        sctp_assoc_state;
                                };

Annotate type: 'struct hlist_head[]' in [kernel.kallsyms] (1 samples):
============================================================================
 Percent     offset       size  field
  100.00          0         72  struct hlist_head[]     ;

Annotate type: 'struct x86_pmu' in [kernel.kallsyms] (5 samples):
============================================================================
 Percent     offset       size  field
  100.00          0        640  struct x86_pmu   {
    0.00          0          8      char*       name;
    0.00          8          4      int version;
  100.00         16          8      (function_type)*    handle_irq;
    0.00         24          8      (function_type)*    disable_all;
    0.00         32          8      (function_type)*    enable_all;
    0.00         40          8      (function_type)*    enable;
    0.00         48          8      (function_type)*    disable;
    0.00         56          8      (function_type)*    assign;
    0.00         64          8      (function_type)*    add;
    0.00         72          8      (function_type)*    del;
    0.00         80          8      (function_type)*    read;
    0.00         88          8      (function_type)*    set_period;
    0.00         96          8      (function_type)*    update;
    0.00        104          8      (function_type)*    hw_config;
    0.00        112          8      (function_type)*    schedule_events;
    0.00        120          4      unsigned int        eventsel;
    0.00        124          4      unsigned int        perfctr;
    0.00        128          8      (function_type)*    addr_offset;
    0.00        136          8      (function_type)*    rdpmc_index;
    0.00        144          8      (function_type)*    event_map;
    0.00        152          4      int max_events;
    0.00        156          4      int num_counters;
    0.00        160          4      int num_counters_fixed;
    0.00        164          4      int cntval_bits;
    0.00        168          8      u64 cntval_mask;
    0.00        176          8      union        {
    0.00        176          8          long unsigned int       events_maskl;
    0.00        176          8          long unsigned int[]     events_mask;
                                    };
    0.00        184          4      int events_mask_len;
    0.00        188          4      int apic;
    0.00        192          8      u64 max_period;
    0.00        200          8      (function_type)*    get_event_constraints;
    0.00        208          8      (function_type)*    put_event_constraints;
    0.00        216          8      (function_type)*    start_scheduling;
    0.00        224          8      (function_type)*    commit_scheduling;
    0.00        232          8      (function_type)*    stop_scheduling;
    0.00        240          8      struct event_constraint*    event_constraints;
    0.00        248          8      struct x86_pmu_quirk*       quirks;
    0.00        256          8      (function_type)*    limit_period;
    0.00          0          4      unsigned int        late_ack;
    0.00          0          4      unsigned int        mid_ack;
    0.00          0          4      unsigned int        enabled_ack;
    0.00        268          4      int attr_rdpmc_broken;
    0.00        272          4      int attr_rdpmc;
    0.00        280          8      struct attribute**  format_attrs;
    0.00        288          8      (function_type)*    events_sysfs_show;
    0.00        296          8      struct attribute_group**    attr_update;
    0.00        304          8      long unsigned int   attr_freeze_on_smi;
    0.00        312          8      (function_type)*    cpu_prepare;
    0.00        320          8      (function_type)*    cpu_starting;
    0.00        328          8      (function_type)*    cpu_dying;
    0.00        336          8      (function_type)*    cpu_dead;
    0.00        344          8      (function_type)*    check_microcode;
    0.00        352          8      (function_type)*    sched_task;
    0.00        360          8      u64 intel_ctrl;
    0.00        368          8      union perf_capabilities     intel_cap {
    0.00        368          8          struct   {
    0.00        368          8              u64 lbr_format;
    0.00        368          8              u64 pebs_trap;
    0.00        368          8              u64 pebs_arch_reg;
    0.00        368          8              u64 pebs_format;
    0.00        368          8              u64 smm_freeze;
    0.00        368          8              u64 full_width_write;
    0.00        368          8              u64 pebs_baseline;
    0.00        368          8              u64 perf_metrics;
    0.00        368          8              u64 pebs_output_pt_available;
    0.00        368          8              u64 pebs_timing_info;
    0.00        368          8              u64 anythread_deprecated;
                                        };
    0.00        368          8          u64     capabilities;
                                    };
    0.00          0          4      unsigned int        bts;
    0.00          0          4      unsigned int        bts_active;
    0.00          0          4      unsigned int        pebs;
    0.00          0          4      unsigned int        pebs_active;
    0.00          0          4      unsigned int        pebs_broken;
    0.00          0          4      unsigned int        pebs_prec_dist;
    0.00          0          4      unsigned int        pebs_no_tlb;
    0.00          0          4      unsigned int        pebs_no_isolation;
    0.00          0          4      unsigned int        pebs_block;
    0.00          0          4      unsigned int        pebs_ept;
    0.00        380          4      int pebs_record_size;

0x00000000006c3fba in __zfree (ptr=0x0) at ../../lib/zalloc.c:13
13		free(*ptr);
(gdb) bt
#0  0x00000000006c3fba in __zfree (ptr=0x0) at ../../lib/zalloc.c:13
#1  0x00000000006728b5 in delete_data_type_histograms (adt=0xd151f70) at util/annotate-data.c:1829
#2  0x0000000000672958 in annotated_data_type__tree_delete (root=0xe82e40) at util/annotate-data.c:1843
#3  0x000000000055658e in dso__delete (dso=0xe82dd0) at util/dso.c:1487
#4  0x000000000055673e in dso__put (dso=0xe82dd0) at util/dso.c:1523
#5  0x000000000058289d in __dso__zput (dso=0x11fc500) at util/dso.h:644
#6  0x0000000000583dc5 in map__exit (map=0x11fc4e0) at util/map.c:298
#7  0x0000000000583e03 in map__delete (map=0x11fc4e0) at util/map.c:303
#8  0x0000000000583e6c in map__put (map=0x11fc4e0) at util/map.c:310
#9  0x00000000005854c3 in __map__zput (map=0x11fcdf0) at util/map.h:196
#10 0x0000000000585e13 in maps__exit (maps=0x11fb740) at util/maps.c:236
#11 0x0000000000585f0e in maps__delete (maps=0x11fb740) at util/maps.c:258
#12 0x0000000000585fcf in maps__put (maps=0x11fb740) at util/maps.c:275
#13 0x0000000000597d2c in thread__delete (thread=0x11fb580) at util/thread.c:96
#14 0x0000000000597fd6 in thread__put (thread=0x11fb580) at util/thread.c:140
#15 0x00000000005c4940 in __thread__zput (thread=0x25bb7c8) at util/thread.h:83
#16 0x00000000005c8267 in hist_entry__delete (he=0x25bb720) at util/hist.c:1318
#17 0x00000000005c5bc2 in hists__delete_entry (hists=0xe7f9f0, he=0x25bb720) at util/hist.c:388
#18 0x00000000005c5d10 in hists__delete_entries (hists=0xe7f9f0) at util/hist.c:416
#19 0x00000000005cc62d in hists__delete_all_entries (hists=0xe7f9f0) at util/hist.c:2872
#20 0x00000000005cc6a7 in hists_evsel__exit (evsel=0xe7f780) at util/hist.c:2884
#21 0x000000000053378a in evsel__exit (evsel=0xe7f780) at util/evsel.c:1495
#22 0x00000000005337cf in evsel__delete (evsel=0xe7f780) at util/evsel.c:1503
#23 0x00000000005288af in evlist__purge (evlist=0xe7e410) at util/evlist.c:163
#24 0x00000000005289bc in evlist__delete (evlist=0xe7e410) at util/evlist.c:185
#25 0x0000000000589c2d in perf_session__delete (session=0xe7daf0) at util/session.c:313
#26 0x00000000004136cb in cmd_annotate (argc=0, argv=0x7fffffffe400) at builtin-annotate.c:936
#27 0x0000000000507cf9 in run_builtin (p=0xe55fd8 <commands+408>, argc=4, argv=0x7fffffffe400) at perf.c:350
#28 0x0000000000507f68 in handle_internal_command (argc=4, argv=0x7fffffffe400) at perf.c:403
#29 0x00000000005080b7 in run_argv (argcp=0x7fffffffe1dc, argv=0x7fffffffe1d0) at perf.c:447
#30 0x00000000005083ae in main (argc=4, argv=0x7fffffffe400) at perf.c:561
(gdb)

1826	static void delete_data_type_histograms(struct annotated_data_type *adt)
1827	{
1828		for (int i = 0; i < adt->nr_histograms; i++)
1829			zfree(&(adt->histograms[i]));
1830		zfree(&adt->histograms);
1831	}


