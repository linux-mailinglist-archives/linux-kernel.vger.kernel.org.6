Return-Path: <linux-kernel+bounces-237675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0EA923C81
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 450A0B214D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11F215B12A;
	Tue,  2 Jul 2024 11:34:15 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929B82D7F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920055; cv=none; b=BvNUZl2hL9t+GA10MpD+SloNYxHOMEMKqNwobVImElMS4m74RBcAXJwzkVAscGDSGxiwO6Z6FhqPxwFR8v1UgVAQgHNqlnKNXUGOOmIYd2SiZ0soPm9jx1s/RjwvX4CZx3i95GtdzbwcHxkeCl3XnXRBDWelGU8E5dkkgB+q2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920055; c=relaxed/simple;
	bh=nfWjYsWXGgOjbGPo1gNRcIPQ7kDBdPTDLah8hIC0EUU=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=ZbV1iJ0d7WRPJz+la0B8lYYq5rlO3PxcFzGl6vrWGHFvCb3N9PGYP1EkmZrbiOCGwffvLyP8ihKcznpynzFVjg4OZRCX4le+l283bgIvDPvQZFXsFqRVDWaqH40WDNNsY7fWTo3pS9CrJd7C9kDL89HKSoFWhV7ZSuDquUOX2xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4WD15S5n5sz5B1J4;
	Tue,  2 Jul 2024 19:34:04 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 462BXvu2002423;
	Tue, 2 Jul 2024 19:33:57 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 2 Jul 2024 19:33:59 +0800 (CST)
Date: Tue, 2 Jul 2024 19:33:59 +0800 (CST)
X-Zmail-TransId: 2afa6683e5a7ffffffff92d-854bb
X-Mailer: Zmail v1.0
Message-ID: <20240702193359997GhKH_KNYXYGLV7TlNVtkq@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <ietmar.eggemann@arm.com>,
        <ostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>
Cc: <he.peilin@zte.com.cn>, <yang.yang29@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <jiang.kun2@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>, <liu.chun2@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?wqBbUEFUQ0ggbGludXgtbmV4dCBSRVNFTkRdIHNjaGVkL2NvcmU6IEFkZCBXQVJOKCkgdG8gY2hlY2tzIGluIG1pZ3JhdGVfZGlzYWJsZSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 462BXvu2002423
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6683E5AC.001/4WD15S5n5sz5B1J4

From: Peilin He <he.peilin@zte.com.cn>

Background
==========
When repeated migrate_disable() calls are made with missing the
corresponding migrate_enable() calls, there is a risk of
'migration_disabled' going upper overflow because
'migration_disabled' is a type of unsigned short whose max value is
65535.

In PREEMPT_RT kernel, if 'migration_disabled' goes upper overflow, it may
make the migrate_disable() ineffective within local_lock_irqsave(). This
is because, during the scheduling procedure, the value of
'migration_disabled' will be checked, which can trigger CPU migration.
Consequently, the count of 'rcu_read_lock_nesting' may leak due to 
local_lock_irqsave() and local_unlock_irqrestore() occurring on different
CPUs.

Usecase
========
For example, When I developed a driver, I encountered a warning like
"WARNING: CPU: 4 PID: 260 at kernel/rcu/tree_plugin.h:315
rcu_note_context_switch+0xa8/0x4e8" warning. It took me half a month
to locate this issue. Ultimately, I discovered that the lack of upper
overflow detection mechanism in migrate_disable() was the root cause,
leading to a significant amount of time spent on problem localization.

If the upper overflow detection mechanism was added to migrate_disable(),
the root cause could be very quickly and easily identified.

Effect
======
Using WARN() to check if 'migration_disabled' is upper overflow can help
developers identify the issue quickly.

Signed-off-by: Peilin He<he.peilin@zte.com.cn>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
Reviewed-by: Qiang Tu <tu.qiang35@zte.com.cn>
Reviewed-by: Kun Jiang <jiang.kun2@zte.com.cn>
Reviewed-by: Fan Yu <fan.yu9@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Liu Chun <liu.chun2@zte.com.cn>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8cc4975d6b2b..14671291564c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2259,6 +2259,8 @@ void migrate_disable(void)
 	struct task_struct *p = current;

 	if (p->migration_disabled) {
+		if (p->migration_disabled == USHRT_MAX)
+			WARN(1, "migration_disabled has encountered an overflow.\n");
 		p->migration_disabled++;
 		return;
 	}
-- 
2.17.1

