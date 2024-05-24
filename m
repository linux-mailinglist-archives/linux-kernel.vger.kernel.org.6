Return-Path: <linux-kernel+bounces-188543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D2C8CE33B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB7F1F22FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242F384FBF;
	Fri, 24 May 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eIWzjuYK"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5183CAE
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542274; cv=none; b=QVWKA37KxGmtmENa+61Zx24xTVHTDBTh27l4/MiM8sMwCQJYfgNrs7ey0rnz4hX/MjLDvt9T6tPsV/TzMB9EB+i5OzqQY9DghKt0Iotjyr4f12XOH9j2NeOs0jg2E/5DijK7ezrcIpuIB7SCFHYLL8Z7JJOkkfUVwMcM+RLIV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542274; c=relaxed/simple;
	bh=UwRfVdpWCbtRjtPoWY95BdnvqkdwOwqwbShm13Lan+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ivm+VokSGptwnYjG6SzYVcHd4CPsWjtGEYQBONxedE5TetXRo681d4M5uJUAX8Lx7G/k0acOe2Yhj/N40SJ3lZwnb0gfZs3CiLPamCLUIer/3ud67rne3hvSh0Yhr7aHmltilFY/3g3Dit2sskI+/wPtaW+th4PsUnfobVilox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eIWzjuYK; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7b6cce6819ae11ef8c37dd7afa272265-20240524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=o89Qlm7qaQESUOk/IhCGiECk1QT+JiBbm43PjjLXBXk=;
	b=eIWzjuYKkfS95itHDS03TA4xO9VYN6bWd+c3HciXPhNIx8ONG7zZqQlaTtuechpR/d/evY3O7VHQSnZgrdiRm52c3fWyCc5Z9p/2aw6Hk0JzIXodYoAP5ykUa3Hj1YtKlYImmNNirlDKZ0f0qtwiV5V+VeWdFPINmHUKLHpEl6c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:3b5be573-e5c0-4f4e-a3f7-a8e34e81a0c1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:cb942b93-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7b6cce6819ae11ef8c37dd7afa272265-20240524
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <dicken.ding@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 382393070; Fri, 24 May 2024 17:17:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 24 May 2024 17:17:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 24 May 2024 17:17:41 +0800
From: dicken.ding <dicken.ding@mediatek.com>
To: Thomas Gleixner <tglx@linutronix.de>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <hanks.chen@mediatek.com>,
	<ivan.tseng@mediatek.com>, <cheng-jui.wang@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, dicken.ding <dicken.ding@mediatek.com>
Subject: [PATCH v2] genirq: Fix uaf issue in irq_find_at_or_after
Date: Fri, 24 May 2024 17:17:39 +0800
Message-ID: <20240524091739.31611-1-dicken.ding@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.765600-8.000000
X-TMASE-MatchedRID: E9R+qDaxr1ctJMbDWD8p3s36paW7ZnFoShVPkKm2lvom8HVb/vaoaBjb
	R/XCsHXWZcp+cbcMclYprKt88L0dYRHdGMlurS25GVyS87Wb4lwEa8g1x8eqF004B0iWfKShoPP
	mGyJpwt+csAFBY7MGhmMyV758esm2dbriIxqwTjzYhNMNlv+0N23eqxoVjgMEAqhgvqvZVjrj6f
	SiVX5AvyFeLvGCnXirAbY5HH0TJqmR9GF2J2xqMxRFJJyf5BJerSFs54Y4wbX6C0ePs7A07fVTw
	0XgOy3aD7wXD1GnDwt3Bi3EmJ+ppptr4Hl7Wsk/0u3TjrxHFhhzcmzHPtSQ/6qSeetSSaOf61U+
	rWxzl6orZuODv9rCwDfSLz0+kBezdmtRsRmKkASJZPT2ZDPuzPD2QfzMDLjhIh26TkmSN3dVyvb
	Tg/runA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.765600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5C4EE66FCDD525C442DA716EA1562D25AED399B840A0DCAEB36B7E777895CD6D2000:8
X-MTK: N

irq_find_at_or_after() is at the risk of use-after-free due to lack of
any locks. irq_find_at_or_after() dereferences the interrupt descriptor
which is returned by mt_find() while neither holding sparse_irq_lock nor
RCU read lock, which means the descriptor can be freed between mt_find()
and the deference. Here is an example::

    CPU0                            CPU1
    mt_find()
                                    delayed_free_desc()
    irq_desc_get_irq()

The use-after-free issue is reported by KASAN, as shown in the following
log::

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

Guard the access with a RCU read lock section.

Fixes: 721255b9826b ("genirq: Use a maple tree for interrupt descriptor management")
Signed-off-by: dicken.ding <dicken.ding@mediatek.com>
---
Changes since v1:
- Use guard(rcu)() to guard the access based on Thomas Gleixner's suggestion.
- Modify the commit message.
---
 kernel/irq/irqdesc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 88ac3652fcf2..07e99c936ba5 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -160,7 +160,10 @@ static int irq_find_free_area(unsigned int from, unsigned int cnt)
 static unsigned int irq_find_at_or_after(unsigned int offset)
 {
 	unsigned long index = offset;
-	struct irq_desc *desc = mt_find(&sparse_irqs, &index, nr_irqs);
+	struct irq_desc *desc;
+
+	guard(rcu)();
+	desc = mt_find(&sparse_irqs, &index, nr_irqs);
 
 	return desc ? irq_desc_get_irq(desc) : nr_irqs;
 }
-- 
2.18.0


