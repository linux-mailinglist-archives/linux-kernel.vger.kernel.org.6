Return-Path: <linux-kernel+bounces-187408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8415A8CD162
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242801F222B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6E01487D2;
	Thu, 23 May 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ABRFT+h2"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD450276
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464403; cv=none; b=tTckUIPH3jK0HlTB7Jb1tgijlVT+83hMAYV5GYmaVavMWlY/6xVeK8tgs8b4w43q5940ZCQTg3oh27uN+WiCHvoNrIjEf95PDFjbS+R2pYLj+rjrKfaX4VAoOZ3VlQ6cZC92KnyxEOC6n1Jmhr1pmrHMgQjK8mbblsQ9vhHMVCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464403; c=relaxed/simple;
	bh=PJxDBJ/55/p7RxADevKkQdGnkcUyvrTy2w6YKI8b4IY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o7NeQjQFOo0FIKV6qSchhxIlWYWkV/2mulTZWX3SPnzsyz4f345NxbTTmiDaHHWmf4jWq5PnV7gVnmkPsFfhePw29GV1mlSWNSKE1swagAGcROWZBK2W1/BsXU1D5kNaW2VHNldMZG6G/AJykUBpZ7HCuUnv3OSM86uEDSlqqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ABRFT+h2; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2cb659d418f911efbfff99f2466cf0b4-20240523
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BMiyz5iUdNSJDfbPTHgKO+oOHd+vDD99lj6IHQQx1VY=;
	b=ABRFT+h2WVwPcJH6gSeQKCl9N9j9PDClDi3zsaZiTv5W3VnzbjjH6IHYVK5mZb+FE1EtJpgI69z5r4H4T31DfFbLzBq+9CeR7kpu5jVBWlam1sCXOOh1Mg/+K+0qhZN2k843ZZtyhULHdGTrpGB0SwZO0t9Y0f+uzy6HoBW6XqY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:d38658b9-b49c-4b67-996d-58973994a890,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:f5bcb987-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2cb659d418f911efbfff99f2466cf0b4-20240523
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <dicken.ding@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1291056628; Thu, 23 May 2024 19:39:54 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 23 May 2024 19:39:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 23 May 2024 19:39:51 +0800
From: dicken.ding <dicken.ding@mediatek.com>
To: Thomas Gleixner <tglx@linutronix.de>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <hanks.chen@mediatek.com>,
	<ivan.tseng@mediatek.com>, <cheng-jui.wang@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, dicken.ding <dicken.ding@mediatek.com>
Subject: [PATCH 1/1] irq: Fix uaf issue in irq_find_at_or_after
Date: Thu, 23 May 2024 19:39:49 +0800
Message-ID: <20240523113949.10444-1-dicken.ding@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-4.177400-8.000000
X-TMASE-MatchedRID: 2aTVZGXuTB8ff24atxvqbrMjW/sniEQKuoYFb0nRiqNx1e3NhjX9AiX5
	3Srl2nNUxo7ed0Rl0pgsXpgfc4uq3GF9INTZ2jjMSHCU59h5KrGkWoMjFfK3XtSVUkz9BPXe7j8
	sAI9BuGov53aacJHWeJ+Db2Vym711hCZu5goHpcabYgXsVVm7zEJfxXUWJFGS31GU/N5W5BB3Hs
	0YS1IA83Apm8RB2n0t42WC8ffme7UfE8yM4pjsD23U7j2vVURrxEHRux+uk8jQ9TRN0mhS13wZJ
	S/5YqMnXVKv7/WG8TXYQnlb38PjIG0VCOqEk9p23uBhPc05NEF4Zvr17pnQUPueCzBmgUWhUuPw
	TjND/xoICtGLeyfJS46H7DI0GsVcMmI24qiENwrMpIbcl3IoA+q1XYAYw09quxzcuGDedhg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-4.177400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: FE9282E63577086F736FFDFCA4986544633F2DCF74F2105A3F1396C83B7110892000:8
X-MTK: N

The function "irq_find_at_or_after" is at the risk of use-after-free
due to the race condition between the functions "delayer_free_desc"
and "irq_desc_get_irq". The function "delayer_free_desc" could be
called between "mt_find" and "irq_desc_get_irq" due to the absence
of any locks to ensure atomic operations on the "irq_desc" structure.

In this patch, we introduce a pair of locks, namely "rcu_read_lock"
and "rcu_read_unlock" to prevent the occurrence of use-after-free in
"irq_find_at_or_after".

Call trace:
 dump_backtrace+0xec/0x138
 show_stack+0x18/0x24
 dump_stack_lvl+0x50/0x6c
 print_report+0x1b0/0x714
 kasan_report+0xc4/0x124
 __do_kernel_fault+0xc0/0x368
 do_bad_area+0x30/0xdc
 do_tag_check_fault+0x20/0x34
 do_mem_abort+0x58/0x118
 el1_abort+0x3c/0x5c
 el1h_64_sync_handler+0x54/0x90
 el1h_64_sync+0x68/0x6c
 irq_get_next_irq+0x58/0x84
 show_stat+0x638/0x824
 seq_read_iter+0x158/0x4ec
 proc_reg_read_iter+0x94/0x12c
 vfs_read+0x1e0/0x2c8
 __arm64_sys_pread64+0x84/0xcc
 invoke_syscall+0x58/0x114
 el0_svc_common+0x80/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x38/0x68
 el0t_64_sync_handler+0x68/0xbc
 el0t_64_sync+0x1a8/0x1ac

Freed by task 4471:
 kasan_save_stack+0x40/0x70
 save_stack_info+0x34/0x128
 kasan_save_free_info+0x18/0x28
 ____kasan_slab_free+0x254/0x25c
 __kasan_slab_free+0x10/0x20
 slab_free_freelist_hook+0x174/0x1e0
 __kmem_cache_free+0xa4/0x1dc
 kfree+0x64/0x128
 irq_kobj_release+0x28/0x3c
 kobject_put+0xcc/0x1e0
 delayed_free_desc+0x14/0x2c
 rcu_do_batch+0x214/0x720
 rcu_core+0x1b0/0x408
 rcu_core_si+0x10/0x20
 __do_softirq+0x154/0x470

Signed-off-by: dicken.ding <dicken.ding@mediatek.com>
---
 kernel/irq/irqdesc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 88ac3652fcf2..14124e1bcb03 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -160,9 +160,15 @@ static int irq_find_free_area(unsigned int from, unsigned int cnt)
 static unsigned int irq_find_at_or_after(unsigned int offset)
 {
 	unsigned long index = offset;
+	unsigned int irq = nr_irqs;
+
+	rcu_read_lock();
 	struct irq_desc *desc = mt_find(&sparse_irqs, &index, nr_irqs);
+	if (desc)
+		irq = irq_desc_get_irq(desc);
+	rcu_read_unlock();
 
-	return desc ? irq_desc_get_irq(desc) : nr_irqs;
+	return irq;
 }
 
 static void irq_insert_desc(unsigned int irq, struct irq_desc *desc)
-- 
2.18.0


