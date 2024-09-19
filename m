Return-Path: <linux-kernel+bounces-333052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E1097C2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BEF1F2201E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC271DA4C;
	Thu, 19 Sep 2024 02:20:18 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259022F1E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726712418; cv=none; b=tHQKf9C7aBk1keXEr+lW/YzOY/jeIxyX0+sNUG42mcuJ+cu0tyxtJoN8rCDY7xEWN8OwXKhfaaUn7OHn2FUD9OSQ78lA9gStuJtM7ndIj89iE7lNGuSt/MD4XguCQ9xM50pNnd4gyFG6eZFaTkg9uH1qThXzFn0KpmFgOSkg978=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726712418; c=relaxed/simple;
	bh=05pRkrF69KXBMwg+RZnz0ikYtjO+1YuUU4GoZPlHmGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNj/vT0EykMJPX9gerwEWmkoLKuD4juFwfPVLmwmqP/JTOjJWlky9CIKhr0G7P35x66JiirUKBaZJONFQa9qkuU0PEe3Kq9WF3Eux3wE9hNZMG6sPq5+T90BqGs5myRX4Owfq3Cl38lAFWYmzvwYDHim2cv9JodDERlmfOL8J3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f7f9a12e762c11efa216b1d71e6e1362-20240919
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:fa1cbd8c-61d1-438d-bbef-fdf271132602,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:fa1cbd8c-61d1-438d-bbef-fdf271132602,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:fa047362ea64576b5100683b8211021d,BulkI
	D:240919101459KGNNRF1N,BulkQuantity:0,Recheck:0,SF:44|66|24|17|19|102,TC:n
	il,Content:1,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: f7f9a12e762c11efa216b1d71e6e1362-20240919
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.160.255)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2029575759; Thu, 19 Sep 2024 10:14:58 +0800
From: liuye <liuye@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liuye@kylinos.cn
Subject: [PATCH v2] mm/vmscan: Fix hard LOCKUP in function isolate_lru_folios
Date: Thu, 19 Sep 2024 10:14:43 +0800
Message-Id: <20240919021443.9170-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814142743.c8227d72be4c5fd9777a4717@linux-foundation.org>
References: <20240814142743.c8227d72be4c5fd9777a4717@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This fixes the following hard lockup in function isolate_lru_folios
when memory reclaim.If the LRU mostly contains ineligible folios
May trigger watchdog.

watchdog: Watchdog detected hard LOCKUP on cpu 173
RIP: 0010:native_queued_spin_lock_slowpath+0x255/0x2a0
Call Trace:
	_raw_spin_lock_irqsave+0x31/0x40
	folio_lruvec_lock_irqsave+0x5f/0x90
	folio_batch_move_lru+0x91/0x150
	lru_add_drain_per_cpu+0x1c/0x40
	process_one_work+0x17d/0x350
	worker_thread+0x27b/0x3a0
	kthread+0xe8/0x120
	ret_from_fork+0x34/0x50
	ret_from_fork_asm+0x1b/0x30

lruvec->lru_lock owner：

PID: 2865     TASK: ffff888139214d40  CPU: 40   COMMAND: "kswapd0"
 #0 [fffffe0000945e60] crash_nmi_callback at ffffffffa567a555
 #1 [fffffe0000945e68] nmi_handle at ffffffffa563b171
 #2 [fffffe0000945eb0] default_do_nmi at ffffffffa6575920
 #3 [fffffe0000945ed0] exc_nmi at ffffffffa6575af4
 #4 [fffffe0000945ef0] end_repeat_nmi at ffffffffa6601dde
    [exception RIP: isolate_lru_folios+403]
    RIP: ffffffffa597df53  RSP: ffffc90006fb7c28  RFLAGS: 00000002
    RAX: 0000000000000001  RBX: ffffc90006fb7c60  RCX: ffffea04a2196f88
    RDX: ffffc90006fb7c60  RSI: ffffc90006fb7c60  RDI: ffffea04a2197048
    RBP: ffff88812cbd3010   R8: ffffea04a2197008   R9: 0000000000000001
    R10: 0000000000000000  R11: 0000000000000001  R12: ffffea04a2197008
    R13: ffffea04a2197048  R14: ffffc90006fb7de8  R15: 0000000003e3e937
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
    <NMI exception stack>
 #5 [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
 #6 [ffffc90006fb7cf8] shrink_active_list at ffffffffa597f788
 #7 [ffffc90006fb7da8] balance_pgdat at ffffffffa5986db0
 #8 [ffffc90006fb7ec0] kswapd at ffffffffa5987354
 #9 [ffffc90006fb7ef8] kthread at ffffffffa5748238
crash>

Scenario:
User processe are requesting a large amount of memory and keep page active.
Then a module continuously requests memory from ZONE_DMA32 area.
Memory reclaim will be triggered due to ZONE_DMA32 watermark alarm reached.
However pages in the LRU(active_anon) list are mostly from
the ZONE_NORMAL area.

Reproduce:
Terminal 1: Construct to continuously increase pages active(anon).
mkdir /tmp/memory
mount -t tmpfs -o size=1024000M tmpfs /tmp/memory
dd if=/dev/zero of=/tmp/memory/block bs=4M
tail /tmp/memory/block

Terminal 2:
vmstat -a 1
active will increase.
procs ---memory--- ---swap-- ---io---- -system-- ---cpu--- ...
 r  b   swpd   free  inact active   si   so    bi    bo
 1  0   0 1445623076 45898836 83646008    0    0     0
 1  0   0 1445623076 43450228 86094616    0    0     0
 1  0   0 1445623076 41003480 88541364    0    0     0
 1  0   0 1445623076 38557088 90987756    0    0     0
 1  0   0 1445623076 36109688 93435156    0    0     0
 1  0   0 1445619552 33663256 95881632    0    0     0
 1  0   0 1445619804 31217140 98327792    0    0     0
 1  0   0 1445619804 28769988 100774944    0    0     0
 1  0   0 1445619804 26322348 103222584    0    0     0
 1  0   0 1445619804 23875592 105669340    0    0     0

cat /proc/meminfo | head
Active(anon) increase.
MemTotal:       1579941036 kB
MemFree:        1445618500 kB
MemAvailable:   1453013224 kB
Buffers:            6516 kB
Cached:         128653956 kB
SwapCached:            0 kB
Active:         118110812 kB
Inactive:       11436620 kB
Active(anon):   115345744 kB
Inactive(anon):   945292 kB

When the Active(anon) is 115345744 kB, insmod module triggers
the ZONE_DMA32 watermark.

perf record -e vmscan:mm_vmscan_lru_isolate -aR
perf script
isolate_mode=0 classzone=1 order=1 nr_requested=32 nr_scanned=2
nr_skipped=2 nr_taken=0 lru=active_anon
isolate_mode=0 classzone=1 order=1 nr_requested=32 nr_scanned=0
nr_skipped=0 nr_taken=0 lru=active_anon
isolate_mode=0 classzone=1 order=0 nr_requested=32 nr_scanned=28835844
nr_skipped=28835844 nr_taken=0 lru=active_anon
isolate_mode=0 classzone=1 order=1 nr_requested=32 nr_scanned=28835844
nr_skipped=28835844 nr_taken=0 lru=active_anon
isolate_mode=0 classzone=1 order=0 nr_requested=32 nr_scanned=29
nr_skipped=29 nr_taken=0 lru=active_anon
isolate_mode=0 classzone=1 order=0 nr_requested=32 nr_scanned=0
nr_skipped=0 nr_taken=0 lru=active_anon

See nr_scanned=28835844.
28835844 * 4k = 115343376KB approximately equal to 115345744 kB.

If increase Active(anon) to 1000G then insmod module triggers
the ZONE_DMA32 watermark. hard lockup will occur.

In my device nr_scanned = 0000000003e3e937 when hard lockup.
Convert to memory size 0x0000000003e3e937 * 4KB = 261072092 KB.

   [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
    ffffc90006fb7c30: 0000000000000020 0000000000000000
    ffffc90006fb7c40: ffffc90006fb7d40 ffff88812cbd3000
    ffffc90006fb7c50: ffffc90006fb7d30 0000000106fb7de8
    ffffc90006fb7c60: ffffea04a2197008 ffffea0006ed4a48
    ffffc90006fb7c70: 0000000000000000 0000000000000000
    ffffc90006fb7c80: 0000000000000000 0000000000000000
    ffffc90006fb7c90: 0000000000000000 0000000000000000
    ffffc90006fb7ca0: 0000000000000000 0000000003e3e937
    ffffc90006fb7cb0: 0000000000000000 0000000000000000
    ffffc90006fb7cc0: 8d7c0b56b7874b00 ffff88812cbd3000

About the Fixes:
Why did it take eight years to be discovered?

The problem requires the following conditions to occur:
1. The device memory should be large enough.
2. Pages in the LRU(active_anon) list are mostly from the ZONE_NORMAL area.
3. The memory in ZONE_DMA32 needs to reach the watermark.

If the memory is not large enough, or if the usage design of ZONE_DMA32
area memory is reasonable, this problem is difficult to detect.

notes:
The problem is most likely to occur in ZONE_DMA32 and ZONE_NORMAL,
but other suitable scenarios may also trigger the problem.

Fixes: b2e18757f2c9 ("mm, vmscan: begin reclaiming pages on a per-node basis")
Signed-off-by: liuye <liuye@kylinos.cn>

---
V1->V2 : Adjust code format and add scenario description, reproduction method.
---
---
 include/linux/swap.h | 1 +
 mm/vmscan.c          | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ba7ea95d1c57..afb3274c90ef 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -223,6 +223,7 @@ enum {
 };
 
 #define SWAP_CLUSTER_MAX 32UL
+#define SWAP_CLUSTER_MAX_SKIPPED (SWAP_CLUSTER_MAX << 10)
 #define COMPACT_CLUSTER_MAX SWAP_CLUSTER_MAX
 
 /* Bit flag in swap_map */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd489c1af228..d2e436a4f47d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1636,6 +1636,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
 	unsigned long skipped = 0;
 	unsigned long scan, total_scan, nr_pages;
+	unsigned long max_nr_skipped = 0;
 	LIST_HEAD(folios_skipped);
 
 	total_scan = 0;
@@ -1650,9 +1651,12 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		nr_pages = folio_nr_pages(folio);
 		total_scan += nr_pages;
 
-		if (folio_zonenum(folio) > sc->reclaim_idx) {
+		/* Using max_nr_skipped to prevent hard LOCKUP*/
+		if (max_nr_skipped < SWAP_CLUSTER_MAX_SKIPPED &&
+		    (folio_zonenum(folio) > sc->reclaim_idx)) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
 			move_to = &folios_skipped;
+			max_nr_skipped++;
 			goto move;
 		}
 
-- 
2.25.1


