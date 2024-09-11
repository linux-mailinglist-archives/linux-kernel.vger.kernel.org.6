Return-Path: <linux-kernel+bounces-324211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5352797498C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6D4285E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49854137C37;
	Wed, 11 Sep 2024 05:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nxeDVLn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0M+ZH50y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F81D5A117
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031636; cv=none; b=FZ0r2zrlPmLiAe5JHw4e+BdPFYG/MJPAM9M9zBCSkeNSGMeCvgsfaRo0r8JEjoCTF7Y7xj5dU75soXPihPGpYVtCxh6v1MEXseUwslZyeesPmSPTyYZjTaHvaNNwRhY2YyjGdesz3cE4Ed5xMmAIPmqSl9aM/IFlI6dyk169NS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031636; c=relaxed/simple;
	bh=LfK+R+ftP6sokQ0GJlGESgvoBcdHOQjPW0DWwh/C9AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PHen3joBceRAurM0DfnBsImwlT86ZbSdO5nlNQWi0DSRusmu5EWBjNOI90yb7fXCbtlN1BYsW0JSdWuDCeJVHhaccLrpegu9Y8ySvQg6b4RRjnHaCEJ5hBwsgsE4oz9zDqdkNHrOSvL4+esNosn2Y6QoFZ+5ZJJuXhY+AHOAawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nxeDVLn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0M+ZH50y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726031631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/qfn40Y/k109wQ4LtwO3H/8C6z24lcBDehQDK7V1Sj4=;
	b=1nxeDVLnHU+gFSNUEpCjBMcbigE191YYo1hVm/7vNthUtyhXyqyzWFXRL+m/DdMs6dNR0w
	RbOOm30VlPab92EwXSMye5u8tE1gtoSOpBJm2RFl2WJKf7JEt5ofRd1MbitIDXQt4pRBwm
	RrFG6Vf7mNLFwLbkdK3uwJPX1p7CrTGTbpuoCIrFKe0j8lAhZQAXunfqosMlq/n/44MIxX
	DUV8m1eTPSpnrqriKO+YsLr/DOQ6sOE4DiNTyxnjoq2pc3cmd0MYVYxvbUsL13VJxk1hQD
	SdYE8p3ytNsQXGTbppzJBWZt7okvDiB9mesYvr0v76v98sHsAQay3C49L3lB9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726031631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/qfn40Y/k109wQ4LtwO3H/8C6z24lcBDehQDK7V1Sj4=;
	b=0M+ZH50yw//HJTG8q9IdLUSDvkth/ozPO2TyySSGXJTqaBIKgSPIz8uv63Rzq2PA8umwvn
	2mntOTl1vFQnJbBg==
Date: Wed, 11 Sep 2024 07:13:30 +0200
Subject: [PATCH v2 04/15] timers: Rename usleep_idle_range() to
 usleep_range_idle()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-flseep-v2-4-b0d3f33ccfe0@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org, SeongJae Park <sj@kernel.org>

usleep_idle_range() is a variant of usleep_range(). Both are using
usleep_range_state() as a base. To be able to find all the related
functions in one go, rename it usleep_idle_range() to usleep_range_idle().

No functional change.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev
Cc: linux-mm@kvack.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
v2: Fix typos in commit message
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


