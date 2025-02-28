Return-Path: <linux-kernel+bounces-537671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637C3A48EF7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7330616D5AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71543180A80;
	Fri, 28 Feb 2025 03:10:26 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12BE17A2F4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712226; cv=none; b=Hl+BHbVGF4nmmZHKNXnNdU9/C/EsUmipQmc8zaZKfiq9TgNUK+FpjTjmjPYxLkKZ1GluUT27kOKEhBFBTl2flbb66++Mt/uAbBDR3hb/4iq9p5ZzTBq2OXAsku3ky+W1f7qt5HQ9g4P6tSd+wwhNVOKvo1MKuMfUUz8SNQe4ACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712226; c=relaxed/simple;
	bh=t8VfyHDZC4bVNk1Nn6fkD8LXrD8BV61swQ7pdkt9cR4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rdm9/f1VJEJNXcyrT2oJI52/uaasLt18wWlY/S4Pc4NWHGs+ioX1lKHoMnRUQzCE+r23p1jmnNcU2ED2ly/DV4UxBxVhOocjaNFcnEb4V8P8/3u4B55GgmH5WU2/u4CQzlSaIOZdNn0tj4gQyfFThwZRTabHdM36Yw9iYRzQG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201609.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202502281110147433;
        Fri, 28 Feb 2025 11:10:14 +0800
Received: from locahost.localdomain (10.94.18.73) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 28 Feb 2025 11:10:13 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] sched/fair: fix inconsistent indenting warning in task_numa_work()
Date: Fri, 28 Feb 2025 11:10:10 +0800
Message-ID: <20250228031011.6630-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20252281110142af601e5cfc9b9cb80ac93b880d3b907
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


