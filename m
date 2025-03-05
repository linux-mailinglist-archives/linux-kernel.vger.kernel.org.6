Return-Path: <linux-kernel+bounces-546184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79859A4F770
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99E816E439
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121DE1E0DB3;
	Wed,  5 Mar 2025 06:47:52 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D541CAA62
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741157271; cv=none; b=KxgFlqbag+mXEIlSEbrZH6jNfydu+Nm6CcD34ueQ+Adia5spgzcJdjLq5FEQghQtQVumYj6vwu4iC8icqf7Ne8QjDWFM+ugZaBlWg16HudlvOgE68G0q+RppnD/6rxan3Jz/hBzEq3KJzW/Ta5196DfS1OzalLRPf9FxQWwlXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741157271; c=relaxed/simple;
	bh=t8VfyHDZC4bVNk1Nn6fkD8LXrD8BV61swQ7pdkt9cR4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SeUH23UMeyyozvqQFHNrx8W7DiI5o8ZOu6AoizA1n45XVerhjdRFY3a1DZBMkPQbgRUpoRkuycQp+YqFbDDfaqADrt58eA7hmfd8R5C8A0Tb7BmRDfAMijnVZaDuY2ToQHAg7/EdmSFXvcs0vo1xncL3IrT2+dC9Rv1uOzqetJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201615.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202503051447413826;
        Wed, 05 Mar 2025 14:47:41 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 Jtjnmail201615.home.langchao.com (10.100.2.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 14:47:42 +0800
Received: from locahost.localdomain (10.94.3.63) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 14:47:41 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>
CC: <linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] sched/fair: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 14:47:40 +0800
Message-ID: <20250305064740.4206-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2025305144741f31dba94903055772951cb9b1fa1699e
X-CorpSPAM-Fhash: Yes
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
kernel/sched/fair.c:3444 task_numa_work() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d042e94a79c3..df13a4fd8f09 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3441,7 +3441,7 @@ static void task_numa_work(struct callback_head *work)
 			 * to prevent VMAs being skipped prematurely on the
 			 * first scan:
 			 */
-			 vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
+			vma->numab_state->prev_scan_seq = mm->numa_scan_seq - 1;
 		}
 
 		/*
-- 
2.43.0


