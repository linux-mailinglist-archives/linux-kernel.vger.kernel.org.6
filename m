Return-Path: <linux-kernel+bounces-315087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 987D896BDD8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8261F26A7A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2D51DCB1C;
	Wed,  4 Sep 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K1fHHPDD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VmFDXr0l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE871DC1AA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455139; cv=none; b=B9JgfuoR9/5/6gXteoV1FjIT4W3yJQzTRHsYjJxSd32gcjvB94+l7zI1BOLMNhqVWAGKhsu12O+wTWIJKsoD1ztsOBrYGtUt1Q0MnEHdgH+N1Yb/NVM8IwVMBVE7H8WhCayfbNQxFHSzMGgjjoFp4hNdN/Ey1fXIlplbQnd3eJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455139; c=relaxed/simple;
	bh=xONkljkqAACvrhcLR/IpmJ9rZkgqlFfHZySmfYcCH4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIKHosn32Bh6+MEyQqlhGJv2/4H/X+kIzzJN8t0I8p1JUu77HMaHllEIkkT5Pg65EY7QCQQcZGgVYsXLeiIEfxVwBPNDtCeKQRw8gtRl/YHyNz1OD65PsWzp8SlDtnalGUXvin2prasMlwjMiZoy14ftujf9g2KKXWekeeBxhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K1fHHPDD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VmFDXr0l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6JzfinROxb0cF6NxXq0JcmrJuw7pVBPvlFaejLfwHs=;
	b=K1fHHPDD27YunAkdxRxKlxq7v0mgwE/YXfmGTccsLisSDbEUJP5ilOZ/AOSa8xlcm5JLZE
	ZLWQ2TfNLuirTGa9IWwYtePyYKOwoh++7/zmmWgD9ivb5c6RTvf0wOlpX/GKY13Kyl0seU
	BImyKU9xR37tQ82WpC1Zow2CrcJo9KJL+z4IGxHDGV8G2w/NdFm3/qMJ1UGSvJR679MCTo
	7uGRz3apBsEUNJlIXVAWnn5SbZqusjwabJCNmzHHcguNXR0AJ0mYyMzbZujKiKu1gne04r
	z8YFjvYcwCf2Qn2DLHU6hIqDJis0IaNf+iV5b2HHROWjLZmmKN+TEFlDvjQeLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R6JzfinROxb0cF6NxXq0JcmrJuw7pVBPvlFaejLfwHs=;
	b=VmFDXr0lbLciL542cJmYJCDZ6Oumihap+7q+8O9BQBdroT1ZJJulw0rGnYOb5gGnS5egov
	SD8iMVd4PfPjvBBQ==
Date: Wed, 04 Sep 2024 15:04:55 +0200
Subject: [PATCH 05/15] timers: Rename sleep_idle_range() to
 sleep_range_idle()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-5-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 damon@lists.linux.dev, linux-mm@kvack.org

sleep_idle_range() is a variant of sleep_range(). Both are using
sleep_range_state() as a base. To be able to find all the related functions
in one go, rename it sleep_idle_range() to sleep_range_idle().

No functional change.

Cc: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev
Cc: linux-mm@kvack.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/linux/delay.h | 2 +-
 mm/damon/core.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index ff9cda975e30..2bc586aa2068 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -68,7 +68,7 @@ static inline void usleep_range(unsigned long min, unsigned long max)
 	usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
 }
 
-static inline void usleep_idle_range(unsigned long min, unsigned long max)
+static inline void usleep_range_idle(unsigned long min, unsigned long max)
 {
 	usleep_range_state(min, max, TASK_IDLE);
 }
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7a87628b76ab..94fe2f1f9b0e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1887,7 +1887,7 @@ static void kdamond_usleep(unsigned long usecs)
 	if (usecs > 20 * USEC_PER_MSEC)
 		schedule_timeout_idle(usecs_to_jiffies(usecs));
 	else
-		usleep_idle_range(usecs, usecs + 1);
+		usleep_range_idle(usecs, usecs + 1);
 }
 
 /* Returns negative error code if it's not activated but should return */

-- 
2.39.2


