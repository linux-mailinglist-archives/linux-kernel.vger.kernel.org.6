Return-Path: <linux-kernel+bounces-412350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5659F9D07F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B00E3B21CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BE03BBEA;
	Mon, 18 Nov 2024 02:48:34 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821731BC3F;
	Mon, 18 Nov 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731898114; cv=none; b=USeHhDQD783wmjNg2dN0IuHdw3ymz1OkktJvInp5pzpikBYuH04WtzjCsyX9ommaxgsqDhNB+SY9VMdQ9pqG8iTYPO+uK28mJgIoTikNhKFQgu0wqym7RpYVHL9xkD7zjVJ9lcPWkCLbVmzit64r+x+xoUi846viH/Z2T0Arsyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731898114; c=relaxed/simple;
	bh=6b2QM9tQXlO3MVw1sCoo3AlSE4Yz2dUla0SqscY7Dl0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=a5Ymh7oYbggPMM1HNL4gEEhUaG5pYJhOYA48vfsbiC+ic4gRrDtTDZx+Y+JBJHYxtnwIoO+nhgRUT8RT4GCsDTSn3HD0iFCv581LQdAvUb6ON/My+LPUHGVhvzCzEK3PmYVI5sljPUSmkrboNOv6UDFL+a8urmRWqjcS4kiRQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7673aaaf4086-3c0a3;
	Mon, 18 Nov 2024 10:48:20 +0800 (CST)
X-RM-TRANSID:2ee7673aaaf4086-3c0a3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1673aaaf3ab5-a7bab;
	Mon, 18 Nov 2024 10:48:20 +0800 (CST)
X-RM-TRANSID:2ee1673aaaf3ab5-a7bab
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: corbet@lwn.net
Cc: andrea.righi@linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] sched_ext: Documentation: Fix typo in sched-ext.rst
Date: Sun, 17 Nov 2024 18:48:18 -0800
Message-Id: <20241118024818.11590-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The word 'tranfers' is wrong, so fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 Documentation/scheduler/sched-ext.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 7b59bbd2e564..aff1304d2637 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -265,7 +265,7 @@ The following briefly shows how a waking task is scheduled and executed.
      rather than performing them immediately. There can be up to
      ``ops.dispatch_max_batch`` pending tasks.
 
-   * ``scx_bpf_consume()`` tranfers a task from the specified non-local DSQ
+   * ``scx_bpf_consume()`` transfer a task from the specified non-local DSQ
      to the dispatching DSQ. This function cannot be called with any BPF
      locks held. ``scx_bpf_consume()`` flushes the pending dispatched tasks
      before trying to consume the specified DSQ.
-- 
2.17.1




