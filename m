Return-Path: <linux-kernel+bounces-268987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9497E942BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C81F23718
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CDD1AC430;
	Wed, 31 Jul 2024 10:29:41 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCE8801
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421781; cv=none; b=AzFQFgmhckpIms5TLkxsnsIBo5Ql7Ni+5RbBqThz5PnL0yOAFTQV0fKiQdUUV/XL2hwrzTS8V6YQU1WldJFz1z/Ey5imNESI7CcomWjbxSmiIsnLP59eqS944D4xtv2lKrvA0AJgoYuX2xK1rqUs9zMFdAUNiN7ug3zk57+PUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421781; c=relaxed/simple;
	bh=LbAfe5AmA3XqSu9jnUUTPl3N2+UpeR8agnvOzojsoIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CzaCJCX0PGmFCOguqSpdt51/Ze3/ZuyG04EpatfbLCISQST/1arKgRb4NSoZYb7FSJMLo29udsBp/m6yozeLiHkCYxAfpeas89SJs+NtUXd6YiuC0Ue8NenDrYurnlCO7co75ELvdkOjk1v5fnEVmsiYDKpfa+oJbvs0kGcVjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WYp9y2b4yzyPJc;
	Wed, 31 Jul 2024 18:24:38 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A81B7180101;
	Wed, 31 Jul 2024 18:29:36 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Jul
 2024 18:29:35 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kent.overstreet@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] sched: Remove unused extern ia64_set_curr_task()
Date: Wed, 31 Jul 2024 18:27:37 +0800
Message-ID: <20240731102737.1797655-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
remove the function but left this declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75138bf70da3..067b3a997299 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1852,7 +1852,6 @@ static __always_inline bool is_idle_task(const struct task_struct *p)
 }
 
 extern struct task_struct *curr_task(int cpu);
-extern void ia64_set_curr_task(int cpu, struct task_struct *p);
 
 void yield(void);
 
-- 
2.34.1


