Return-Path: <linux-kernel+bounces-306325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F862963D59
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADE51F252EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E758189504;
	Thu, 29 Aug 2024 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x7CWTIh7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Br9yOemO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171B446D1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917308; cv=none; b=DOtjEIHR7WEXA4VYrmj8rLt1One7wxh/C2YN6IFYULEl9Biri8ZqNDEA5b27odC89wk4tktJYCb+bbvSYZgZkousYyTboTxeZMXSmBNtsw8VxIfYqeKmUKcci8LKC67WXGJ9FsozBptoV2ugZFHEjMhESh0WUXH7fUfyfMJoLMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917308; c=relaxed/simple;
	bh=uY/VteGP9ipU8Of83CZ+AzE3vIFIzhGCrgwoy35ahrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nAa/3qFQptSF9P29+0LE3EVoIyQcsKm4bw+sgL4m+okohi9/kTUiTr1fV36XLD+cRGY5DMPi0dzFtaQYy+v1eJKDxxpgAN8SpvrkGWBAgI6OTMavMKjICIxIM3P9drYJz8x7mp3NqY5mx4JALQpzfu0DDvnWP0ihHKGdncWnEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x7CWTIh7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Br9yOemO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724917304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=25s+Uvfukdz+Y9YSIJfLgk0umd2dO4jTo9ia3PBoNaM=;
	b=x7CWTIh72CWdHyGICpSSTvTaAdBqhtZVc/yEhnN9b9toWEfRElMYJJszmAggXCbF0vgAOU
	0zEJj5fY4maHyCfqqOkruenNVnTOzOqE4QZAf8FF3akHdpOcye0n/7huTu7bVRVGZ+lQTh
	Nhyv7LWbW5ZqDRDWz71qt6sU3Ukq7OninkwHc+v0C0mRry3o8R6ujn8U146ZsKwIZy4Lip
	3g3c4yhYZ/LaEn54rc3aol+ywJpSXre3rBAwUowLj+BmEKXNROutryMx3XrUSHJamGq4eX
	ATb9Ul2GDbw87b5dlMxX5Fb/ll2g35m496+G+KfUSE/002Um6MtdkJc5O5HByg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724917304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=25s+Uvfukdz+Y9YSIJfLgk0umd2dO4jTo9ia3PBoNaM=;
	b=Br9yOemOf4bJGWO57npFKT+s4ausse+jC8HHFi7HREqj1cIH02W5pyc34+LO299Mxa9OET
	tODK/zSlXcq6KyBw==
To: linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH] timers: Remove historical extra jiffie for timeout in msleep()
Date: Thu, 29 Aug 2024 09:41:33 +0200
Message-Id: <20240829074133.4547-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msleep() as well as msleep_interruptible() add a jiffie to the
timeout. This extra jiffie was introduced in former days to ensure timeout
will not happen earlier than specified. But the timer wheel already takes
care during enqueue that timers will not expire earlier than specified.

Remove this extra jiffie in msleep() and msleep_interruptible().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 64b0d8a0aa0f..18aa759c3cae 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2730,7 +2730,7 @@ void __init init_timers(void)
  */
 void msleep(unsigned int msecs)
 {
-	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
+	unsigned long timeout = msecs_to_jiffies(msecs);
 
 	while (timeout)
 		timeout = schedule_timeout_uninterruptible(timeout);
@@ -2744,7 +2744,7 @@ EXPORT_SYMBOL(msleep);
  */
 unsigned long msleep_interruptible(unsigned int msecs)
 {
-	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
+	unsigned long timeout = msecs_to_jiffies(msecs);
 
 	while (timeout && !signal_pending(current))
 		timeout = schedule_timeout_interruptible(timeout);
-- 
2.39.2


