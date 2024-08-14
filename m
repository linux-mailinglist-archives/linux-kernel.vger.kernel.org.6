Return-Path: <linux-kernel+bounces-286170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC6E951784
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C9D1F230C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8DE143C5D;
	Wed, 14 Aug 2024 09:19:47 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D335219EA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627187; cv=none; b=gL4ZpxBkYxF8JcjabROL5olvtc+kmpO6vQkkWYvqi4Qm7M9i6lC7mX1Jvc4wISbnO2/Oq5YKLZjdPNwobrLyg920mjGyPcLO70QjfDrRJbMR/8+th/QcF4DN7erOS6S+hwMzPC2Ifv79FC4SOtZMFAdMcaL7y+RtEhMVCURA0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627187; c=relaxed/simple;
	bh=e2WSRhpd3uw/kMhfxEZdSGNBeHFgIXdx9uo8t0sVKTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dvdx3lrO+nO3mm79cnaVyZNsQoE2Xx/VT+51gjnZVkhS7bIxPSwlTDVa0W1Aa4kCebDm6q0wbULBa+XvbE2JeSex5rIdD6iZeAzBq2BvA1pd5SaRxmhnVTgJjhJQGOll0cf1SmAoDrTdYBP2pzq9AdFvBT5FnkwCQ4R06TQdWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 509545c05a1e11efa216b1d71e6e1362-20240814
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED
	SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:0e63fb48-8fd2-4258-9a96-6b1e513c1a52,IP:25,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:0e63fb48-8fd2-4258-9a96-6b1e513c1a52,IP:25,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:77a89f181d9a5d44dd87b10eda787846,BulkI
	D:240814164706XOKLLZ1K,BulkQuantity:2,Recheck:0,SF:66|24|72|19|44|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 509545c05a1e11efa216b1d71e6e1362-20240814
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 268203527; Wed, 14 Aug 2024 17:19:31 +0800
From: liuye <liuye@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	liuye@kylinos.cn
Subject: [PATCH] mm/vmscan: Fix hard LOCKUP in function isolate_lru_folios
Date: Wed, 14 Aug 2024 17:18:25 +0800
Message-Id: <20240814091825.27262-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

Fixes: b2e18757f2c9 ("mm, vmscan: begin reclaiming pages on a per-node basis")
Signed-off-by: liuye <liuye@kylinos.cn>
---
 include/linux/swap.h | 1 +
 mm/vmscan.c          | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

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
index cfa839284b92..02a8f86d4883 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1655,6 +1655,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
 	unsigned long skipped = 0;
 	unsigned long scan, total_scan, nr_pages;
+	unsigned long max_nr_skipped = 0;
 	LIST_HEAD(folios_skipped);
 
 	total_scan = 0;
@@ -1669,10 +1670,12 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		nr_pages = folio_nr_pages(folio);
 		total_scan += nr_pages;
 
-		if (folio_zonenum(folio) > sc->reclaim_idx ||
-				skip_cma(folio, sc)) {
+		/* Using max_nr_skipped to prevent hard LOCKUP*/
+		if ((max_nr_skipped < SWAP_CLUSTER_MAX_SKIPPED) &&
+			(folio_zonenum(folio) > sc->reclaim_idx || skip_cma(folio, sc))) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
 			move_to = &folios_skipped;
+			max_nr_skipped++;
 			goto move;
 		}
 
-- 
2.25.1


