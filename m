Return-Path: <linux-kernel+bounces-576794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D0EA7148C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968B63B3B72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA97DDF59;
	Wed, 26 Mar 2025 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wi+fRXn0"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98D187FFA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984114; cv=none; b=G4yKHdYzBaL71q4iUr4n/XDSDG+qy5lCWmSiSUVq3ZojXbHW2n5YzDLZH+E4khkuIXPWqhEEKipEYTqDuhxCk8xSqgXpRPjBEQDvFtcayUK8CPUsyN60Dj0b5yebPhsbSKjIO/P27SLmKrfSo1XNCZQ0Ajv4WC98gY9+QxBWHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984114; c=relaxed/simple;
	bh=CdInnaW2IoMquTqrJ0EaLqunLOWjgUx9zTs/KAhtqgA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kOzUnkz96t/zDqQCU255/TfRc6MLYksdlwn8H7iiQEYp+80txx53QZ54O5bcFBqCFeA+pcUApxpbTQZS/degJGqx20PkElA/LQDkBuA5MjW3WAfe4RhHMyTrbcgWbIgTbIyiFHdfCZK5vuau6pBJ1pO4guikYBsIJDtizOdV7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wi+fRXn0; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742984107; bh=PjXUOGWXY+dEUkurv+VbTf8nEAUGXROEdkAf6TL7DIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wi+fRXn0vlqTGbsDsCqCf/OO72c4cxz78MqWCvsFE+t6RrunMMW4Tc3FunG61vZEQ
	 nC40zRQiEYYX5y4ErIKodiSsGmbWe19vMOHZJFNHpqu4v8WCR9KQ2uJCMuvrXrgR6g
	 I59Ja6KE17RNjDYRzWaqgX01j9jirawEr0xpUL0U=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 3C53A2C6; Wed, 26 Mar 2025 18:15:05 +0800
X-QQ-mid: xmsmtpt1742984105tcv5o0dar
Message-ID: <tencent_0E548E922D6CA7EC6F5789C998AF10CE0806@qq.com>
X-QQ-XMAILINFO: OakVxA/3u/8RmOETleq5qSYaxMMIZGSFHnTuqvXwD+wdwhyhxE3ajGIfwmEmYX
	 7rN/G8ggiWvIGXiq6qzeqkhu19z285WgraWDfHA2xlH0Xij4AfdR0uOulp46tASOUrcvkDyuf3Mk
	 +p+hc9sVa/+eXR9mKZ82HvCnI+MVxlSDLwOl+m3zWxcGJ5XjQD75SvFVHPj0axcafhq0+20woQwT
	 BwdNvBObmKGj5JfPHlbNlmooaZDiy9sAoPtYpoYXs5l1spBbspPdHxFDvwr6jZM1iDmJoF2vr6/i
	 v4kPWgYJnwkInJ8hG3wxJirJixPpkFxTVSQOLhBSwpWM8909p4xgMhAdT2+MJplO0lH9tgJwoZi5
	 4u352/QJmWSYgevQ3L3TY599RxTybjgtsaxchGyzpXZQNhfUEk0Q5OoMZbr7j4k5+/vQCNWiZ1Op
	 o+QPEC76E0KBQwZfc4SB58ppb7jPV0vDizTbh3sovw1NUEw1CIGiRJZ1FcdxHxeQe0YEu0aZ0qsV
	 0umS5y2RtZxQtXdg3sotFBmaZLaqJeYHfN1VfqMHa+QoXcacsf/hC4HobN/kT3jUppWZYEqYBwc/
	 X4jvW/9GMenGGTowETfGPKb2pBVsozHUD8rehlFIw9jtBui+K+6n5c0japyFVzdEsD9opXmpETsW
	 pvOBSydFZj19ky8u2WbyDJ7yaT0qP+on9wAYO5TSgCrxgSt0x3NwQkYVnscvVqGrHXUrQWieZbDp
	 /lRXUjHQGzBBCjxp86VcZOt0HeWl1p7QBM43NAcfvaOaDsy1jLtC78DeljYLiS+JZVxw/wIbz1jj
	 mpgtCI8qv8unColQed8KJlqpV/QfwFap3GeV7Dt9q01oTE4+74juLPPCbJUg+lLurDEPq9ER7r30
	 KCOLBs6O0zwcOGKEmwuKotwUGj390MJJQuXCccQoE3hGdax7tvHkS+siLxQl0PYeEAtcj5G2/QVs
	 P9nDz0yz0=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 1/3] nvme: Add warning for PST table memory allocation failure in nvme_configure_apst
Date: Wed, 26 Mar 2025 18:15:02 +0800
X-OQ-MSGID: <20250326101502.1348301-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_FD614E97ED4F67FE2F74C9C158AB50E7C806@qq.com>
References: <tencent_FD614E97ED4F67FE2F74C9C158AB50E7C806@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

Currently the function fails silently on PST table memory allocation failure.
Add warning messages to improve error visibility.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2d89fac86c5..fb0404fee551 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2678,8 +2678,10 @@ static int nvme_configure_apst(struct nvme_ctrl *ctrl)
 	}
 
 	table = kzalloc(sizeof(*table), GFP_KERNEL);
-	if (!table)
+	if (!table) {
+		dev_warn(ctrl->device, "Failed to allocate pst table; not using APST\n");
 		return 0;
+	}
 
 	if (!ctrl->apst_enabled || ctrl->ps_max_latency_us == 0) {
 		/* Turn off APST. */
-- 
2.25.1


