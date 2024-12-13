Return-Path: <linux-kernel+bounces-444202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D299F02C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D49284FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66E7502B1;
	Fri, 13 Dec 2024 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RJXijTrp"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0281A22071
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734058363; cv=none; b=Dqv0aATj/X1UQTQi1304tJS8FHTL0SRlKBCQP8g9iymui8BduEaKMliHIeMwVyIfl+pIL2g2mmmLjHn+5y4oJ3csdnckXMXIk8edaL3rLpE0OFEiKMsAOjgj745tQfaItWw7kVopjnAfT34kLatmvTl/gfIKPJCxG+8cxoL1C3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734058363; c=relaxed/simple;
	bh=exClpigfPfIIrI1kZEyC16EKlnWhgMxhgbry8sy63SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XhvWst3xcrO5iht7DXvR+CC00qDdMqxejEulYsWFsMJvLO8/MzrKfhVGD5ww2EqlOp5u0sSFFgyaar1OgWrxT+cfYv8sriCU4PfN3IOsZPoiE0c/4Jrvl+hPb1/u1/IxuuDT25rQFlM+fOQrdjKRVKL0+gVZvQaigP8PMP3DODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RJXijTrp; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734058357; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SblZ8XyRVUvaYco4AsuKXu2C2gvZSzI5y7mFRPl2zfI=;
	b=RJXijTrp0RLevVSJFquvMPEr1PPMnu6MUEmnKJv1jLxv03Qnp8avYORu1Hgv3+lfaAzetee9DaB6aEq6DlS6WOLF0bqjeb2NATIaqs+SQ1lEbCr/xP5d/xxU4ldvUzaSkyVWcJ/8NjMKFybI3FN86d4nE6M6neFkJAfjRDZJu6c=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WLNPugh_1734058347 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Dec 2024 10:52:37 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] kthread: Modify mismatched function name
Date: Fri, 13 Dec 2024 10:52:26 +0800
Message-Id: <20241213025226.121901-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

kernel/kthread.c:1072: warning: expecting prototype for kthread_create_worker(). Prototype was for kthread_create_worker_on_node() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=12367
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/kthread.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 83bf73d2355c..5d14ee046c80 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1058,7 +1058,7 @@ __kthread_create_worker_on_node(unsigned int flags, int node,
 }
 
 /**
- * kthread_create_worker - create a kthread worker
+ * kthread_create_worker_on_node - create a kthread worker
  * @flags: flags modifying the default behavior of the worker
  * @node: task structure for the thread is allocated on this node
  * @namefmt: printf-style name for the kthread worker (task).
-- 
2.32.0.3.g01195cf9f


