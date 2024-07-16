Return-Path: <linux-kernel+bounces-253878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E7E93282A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F785B22E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630D519DF58;
	Tue, 16 Jul 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ARirUWM0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9VgawH57"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C934219CCE1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139607; cv=none; b=WKc83Qv0kNWt1QlDLu6qnUSaHpu+cBD2w+7gPr0xOzMveJ3OOa0WhOukWAQpyecHb03PwgJkzGOsauyRPJdoFTQnKSr4t7n+WayjhtKyekUpyHAxmXimFRu7n7UBcceytmeQRn/SuAFng3n5ZAwRi6BSvGjOLMPQG6cxCpxYgIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139607; c=relaxed/simple;
	bh=tYg/Me37CIgoQbkB8S9j8PD8i1f5IIOS6POIpLb4Ab0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psAgxrUJcdTKAnt27T9cVHcYbp8RfF5uxFKQ/DRDEb9M3yIoMjzWvr9fE996I9i27w2L1RuJmBz0aTSBcc4Tg/DiQDUg/1m6lZnSUyzbf+BDbBeg00GYc65AYWCuF3SucMyG9+dV/b1Ak//CHsT7K8qj4bvw2KFgr7NG+5+0GpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ARirUWM0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9VgawH57; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721139600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wqz3C7gjfOi/YQFVyoMWEuJBw6mP/cgJ4QCattfraVI=;
	b=ARirUWM03XmUfdFSXk8ahtr8O6anZHaGcBonglK6jTNGYozwjZ33sraGH1ScTiA0ZixzHl
	39Pvjz4mzXbuFocdG1ODp2e7MirfeaK9NZHp4FBqKV58HaZHbiBofxFo/tP3vgXoDy38wz
	aIlJRAHkW2Vl3uSWtSq9wRRyvBsq4XEvoIBZA/5noyNX3PdSpG70vUMSGIjiWhekHvUhlS
	+jf46VTf82tEi6tJYhaAab7vQNEl/A3b9MSuzkHqmMC422mg1PPZ1We4guCjCaNCSH3gC1
	5hb8/WjPt/hXowkXGyJw+34OEu8sSJ4J3mmlRMw5iYmnVEvuA3HylpK1GXV4EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721139600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wqz3C7gjfOi/YQFVyoMWEuJBw6mP/cgJ4QCattfraVI=;
	b=9VgawH57IUNLlySjI3ADBtSfXmZtPjVg+hiJ+GjkUYDxuv64KI/ULkLojgZqC7lGLdyXdA
	mZWu68Y260EvgNAA==
Date: Tue, 16 Jul 2024 16:19:26 +0200
Subject: [PATCH v4 8/8] timers/migration: Fix grammar in comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-tmigr-fixes-v4-8-757baa7803fe@linutronix.de>
References: <20240716-tmigr-fixes-v4-0-757baa7803fe@linutronix.de>
In-Reply-To: <20240716-tmigr-fixes-v4-0-757baa7803fe@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer_migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index d9f7e9b77f11..a373a7ac1243 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1368,7 +1368,7 @@ u64 tmigr_cpu_deactivate(u64 nextexp)
  *			  the only one in the level 0 group; and if it is the
  *			  only one in level 0 group, but there are more than a
  *			  single group active on the way to top level)
- * * nextevt		- when CPU is offline and has to handle timer on his own
+ * * nextevt		- when CPU is offline and has to handle timer on its own
  *			  or when on the way to top in every group only a single
  *			  child is active but @nextevt is before the lowest
  *			  next_expiry encountered while walking up to top level.

-- 
2.39.2


