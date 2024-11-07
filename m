Return-Path: <linux-kernel+bounces-399968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106959C0731
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99A22821F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DBE20FA9D;
	Thu,  7 Nov 2024 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TjlUqm7U"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880451CC8BD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730985872; cv=none; b=nt8dfC4K6pgOGWKvhTDVWozI1EIR7/tVrlj4CCWL3luxrVn/yizpvUYf2nucdcR5/8+0xUSysgI9T63uwRoSx7LGYmy9RjcSJmyG+4VwXTN/FjEoi3bQxGYzw/mm8qSgtPw6CnM4Q8j8EhN9xd3iUaXY9p1KWKBq6uVWxczx6Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730985872; c=relaxed/simple;
	bh=2ZXCubxBnCI/h3GvMMEbx+dV9SHu5QdxGiI4NyxA1g4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O23r6bIjuvvFoHdhzYKKQStIf32QhhgyCXK07F+0nhSEpPqlyQGRwD8ZSr7VLwqlvuFHQ4qREd7aBo6uLOq2CQMsb6JRX6F98N+alWpYQ0i0o0Yh8aI01Z+Y0h2qAoV67Seamh/aBGtSrzGJbhx8t4phNRZ7gt6/GsfsB0UvkMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TjlUqm7U; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9b15e6f69d0b11efb88477ffae1fc7a5-20241107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=elFJl+rbTb0Do7/D6G39zaxYl0uHkUAO5Bjqs23Hdr0=;
	b=TjlUqm7UCCnJODixreuwqyJGIt5LeSd5oqfyxprqLfiZHQrM++/P+5pqjVqYQ3BSxyz/BtlaUNhYk9cjYeWw0wNa8wsnERsE1koYOS+LMKRJUJ24b4fatOi/AmTRk24mDs/XYZ+aKETPb5M2bNs1LPpEGI6KDfmyEXWhrKL3yV4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:08cd1dd3-9c2e-4f56-95af-f52a7a1c9868,IP:0,U
	RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:b0fcdc3,CLOUDID:716aaeca-91e6-4060-9516-6ba489b4e2dc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9b15e6f69d0b11efb88477ffae1fc7a5-20241107
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <defa.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 992231371; Thu, 07 Nov 2024 21:24:24 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Nov 2024 05:24:22 -0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Nov 2024 21:24:22 +0800
From: mtk25126 <defa.li@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<wsd_upstream@mediatek.com>, <mingchang.jia@mediatek.com>,
	<yuhan.wei@mediatek.com>, <hao.lin@mediatek.com>, Defa Li
	<defa.li@mediatek.com>
Subject: [PATCH v2] i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock
Date: Thu, 7 Nov 2024 21:25:39 +0800
Message-ID: <20241107132549.25439-1-defa.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Defa Li <defa.li@mediatek.com>

A deadlock may happen since the i3c_master_register() acquires
&i3cbus->lock twice. See the log below.
Use i3cdev->desc->info instead of calling i3c_device_info() to
avoid acquiring the lock twice.

v2:
  - Modified the title and commit message

============================================
WARNING: possible recursive locking detected
6.11.0-mainline
--------------------------------------------
init/1 is trying to acquire lock:
f1ffff80a6a40dc0 (&i3cbus->lock){++++}-{3:3}, at: i3c_bus_normaluse_lock

but task is already holding lock:
f1ffff80a6a40dc0 (&i3cbus->lock){++++}-{3:3}, at: i3c_master_register

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&i3cbus->lock);
  lock(&i3cbus->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by init/1:
 #0: fcffff809b6798f8 (&dev->mutex){....}-{3:3}, at: __driver_attach
 #1: f1ffff80a6a40dc0 (&i3cbus->lock){++++}-{3:3}, at: i3c_master_register

stack backtrace:
CPU: 6 UID: 0 PID: 1 Comm: init
Call trace:
 dump_backtrace+0xfc/0x17c
 show_stack+0x18/0x28
 dump_stack_lvl+0x40/0xc0
 dump_stack+0x18/0x24
 print_deadlock_bug+0x388/0x390
 __lock_acquire+0x18bc/0x32ec
 lock_acquire+0x134/0x2b0
 down_read+0x50/0x19c
 i3c_bus_normaluse_lock+0x14/0x24
 i3c_device_get_info+0x24/0x58
 i3c_device_uevent+0x34/0xa4
 dev_uevent+0x310/0x384
 kobject_uevent_env+0x244/0x414
 kobject_uevent+0x14/0x20
 device_add+0x278/0x460
 device_register+0x20/0x34
 i3c_master_register_new_i3c_devs+0x78/0x154
 i3c_master_register+0x6a0/0x6d4
 mtk_i3c_master_probe+0x3b8/0x4d8
 platform_probe+0xa0/0xe0
 really_probe+0x114/0x454
 __driver_probe_device+0xa0/0x15c
 driver_probe_device+0x3c/0x1ac
 __driver_attach+0xc4/0x1f0
 bus_for_each_dev+0x104/0x160
 driver_attach+0x24/0x34
 bus_add_driver+0x14c/0x294
 driver_register+0x68/0x104
 __platform_driver_register+0x20/0x30
 init_module+0x20/0xfe4
 do_one_initcall+0x184/0x464
 do_init_module+0x58/0x1ec
 load_module+0xefc/0x10c8
 __arm64_sys_finit_module+0x238/0x33c
 invoke_syscall+0x58/0x10c
 el0_svc_common+0xa8/0xdc
 do_el0_svc+0x1c/0x28
 el0_svc+0x50/0xac
 el0t_64_sync_handler+0x70/0xbc
 el0t_64_sync+0x1a8/0x1ac

Signed-off-by: Defa Li <defa.li@mediatek.com>
---
 drivers/i3c/master.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 6f3eb710a75d..bb8a8bf0c4c7 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -282,7 +282,8 @@ static int i3c_device_uevent(const struct device *dev, struct kobj_uevent_env *e
 	struct i3c_device_info devinfo;
 	u16 manuf, part, ext;
 
-	i3c_device_get_info(i3cdev, &devinfo);
+	if (i3cdev->desc)
+		devinfo = i3cdev->desc->info;
 	manuf = I3C_PID_MANUF_ID(devinfo.pid);
 	part = I3C_PID_PART_ID(devinfo.pid);
 	ext = I3C_PID_EXTRA_INFO(devinfo.pid);
-- 
2.46.0


