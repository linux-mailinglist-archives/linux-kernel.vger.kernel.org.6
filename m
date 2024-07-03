Return-Path: <linux-kernel+bounces-239497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ED29260EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34BD1F22A88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9085A178CEA;
	Wed,  3 Jul 2024 12:54:00 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BC61E4A9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011240; cv=none; b=M1QXXG35uEDIvZzkvkuSWGR2XvVfI/cjbdb+tWkgC+uHzy0ypXqY7b8kcFfGa/flTL4u1CJX6u9W/IKESu7po5PQPV3LOjeTg/gn5NIS8wC5tl5GFTm/O2ter1SGfTzssEfFx+CXhEr3Y6LaZovRRVd7GeBRM93yPL7ryEcSEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011240; c=relaxed/simple;
	bh=n1cEwfR8I7CRyZ+5H3Xv/AAmOTFiTl3HAZE4oztJFHM=;
	h=Date:Message-ID:Mime-Version:From:To:Subject:Content-Type; b=MtJ/INcLfQOH5wVCHMLvx42UZ9XkY7A+/NstGBLTPhH+BjZGQFv5QoNrPDqx2ZoaVi65O48/1NmdbDacopoh4/v6/el/FEUWDxZ1p6son8gqFfi0ljgfnTRzebHbv1TET+OvbDpRrxyneEz8QXUHQMLrEFH0uUXsyAJ3/mK89Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4WDfpw2t34z1DyM
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:53:44 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4WDfpq6cY4z54hQs
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:53:39 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4WDfpZ5hRhz8XrS6;
	Wed,  3 Jul 2024 20:53:26 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 463CrLBx081404;
	Wed, 3 Jul 2024 20:53:22 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 3 Jul 2024 20:53:25 +0800 (CST)
Date: Wed, 3 Jul 2024 20:53:25 +0800 (CST)
X-Zmail-TransId: 2af9668549c5ffffffff869-a44e6
X-Mailer: Zmail v1.0
Message-ID: <202407032053257877vuVsFfB1hh0DKSowPd8p@zte.com.cn>
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
        <bristot@redhat.com>, <he.peilin@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <tu.qiang35@zte.com.cn>, <jiang.kun2@zte.com.cn>,
        <zhang.yunkai@zte.com.cn>, <liu.chun2@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIHNjaGVkL2NvcmU6IEFkZCBXQVJOKCkgdG8gY2hlY2sgb3ZlcmZsb3cgaW4gbWlncmF0ZV9kaXNhYmxlKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 463CrLBx081404
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 668549D7.000/4WDfpw2t34z1DyM

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
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
Reviewed-by: Qiang Tu <tu.qiang35@zte.com.cn>
Reviewed-by: Kun Jiang <jiang.kun2@zte.com.cn>
Reviewed-by: Fan Yu <fan.yu9@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Liu Chun <liu.chun2@zte.com.cn>
---
v1->v2:
Some fixes according to:
https://lore.kernel.org/all/20240702124334.762dbd5a@rorschach.local.home/
1.Merge if conditions into WARN().
2.Remove the newline character '\n'. Right, we don't need the redundant \n.

 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8cc4975d6b2b..327010af6ce9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2259,6 +2259,7 @@ void migrate_disable(void)
 	struct task_struct *p = current;

 	if (p->migration_disabled) {
+		WARN(p->migration_disabled == USHRT_MAX, "migration_disabled has encountered an overflow.");
 		p->migration_disabled++;
 		return;
 	}
-- 
2.17.1

