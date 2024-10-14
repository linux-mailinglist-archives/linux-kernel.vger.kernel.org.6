Return-Path: <linux-kernel+bounces-363486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261D299C30B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FC0284753
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B42F15A85A;
	Mon, 14 Oct 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wHZEPcaB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UDMmwHg3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19708156C52;
	Mon, 14 Oct 2024 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894171; cv=none; b=X8CxElObljbuqRUhjbY9tXdZqAwxKUqIjlTIMNgOw3tfS4SvH5k2aN4ZK/EovjEV74sMivNaITIsey2c/WuBm23Qxh4Xn4rvqiS+tutqXSpQWqPCdJS/jTVW4N197Q5Od5UtItwJYynub6mxW2S2imty58FfOfTNMBxopujKEHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894171; c=relaxed/simple;
	bh=4pR4v9VxzJjaDU9XI6f650AWP+UIWqKOfbpkl7I5tIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IRd4Hp3HEbf8buOHj3wo9AEDkUL8kHkTMu3BE68hUUc95NURINflmSAyPjKl/XRaW3tjdwiqDTrN4zwUR3SDLTbQoETGs4PjS6bh4t2BTaufP6QJGYT6IASritssCzJGgoV7282qib1QkjQExulo3aydFl44uad+U9dU76TRjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wHZEPcaB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UDMmwHg3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nqpCkfMkESKp04+U621Yd1HCLdCwf1cAFfQf1SS6sw=;
	b=wHZEPcaBqHrRVpB8SbfhvRioL52wOH5cY7cXiwlTRnf+NEjgmOZkqoF4TNFfVTHJAZA2mY
	2tQGtbaAasUpaGhJvDxImzIid/vvjC47d/SMU2P0CgVq7a9175nE5ZadxujZ9pON6PlNIu
	j//F9zvLuUclJij8AU1g0RFihTBsqsC2JbBehnYgdhytDcsVbyKd1N6UQ0DSUQrW0f27KA
	lhXN/fhalFZA0w64244iCc8bTbgob4yhjcP7+Y5pEEiXROfH2PSbHrH9TeFc9Fn3QxMHEQ
	5YKaQWBEcsf0WQxpEGbIfMDV1fhwmchYLH9S88m/jIzOVry1JiS5PK8IviglMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nqpCkfMkESKp04+U621Yd1HCLdCwf1cAFfQf1SS6sw=;
	b=UDMmwHg3V2JzZXAI7hppK/+oR/CfnMW52xzqtpSYmbHQSPFpMzzQr7DKXKRYlxYkXyQHol
	wlfwZjoGES7tEmAw==
Date: Mon, 14 Oct 2024 10:22:26 +0200
Subject: [PATCH v3 09/16] timers: Add a warning to usleep_range_state() for
 wrong order of arguments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-9-dc8b907cb62f@linutronix.de>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miguel Ojeda <ojeda@kernel.org>

There is a warning in checkpatch script that triggers, when min and max
arguments of usleep_range_state() are in reverse order. This check does
only cover callsites which uses constants. Add this check into the code as
a WARN_ON_ONCE() to also cover callsites not using constants and fix the
miss usage by resetting the delta to 0.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v3: Drop removal of checkpatch check, fix delta value
---
 kernel/time/sleep_timeout.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index f3f246e4c8d1..3054e5232d20 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -364,6 +364,9 @@ void __sched usleep_range_state(unsigned long min, unsigned long max, unsigned i
 	ktime_t exp = ktime_add_us(ktime_get(), min);
 	u64 delta = (u64)(max - min) * NSEC_PER_USEC;
 
+	if (WARN_ON_ONCE(max < min))
+		delta = 0;
+
 	for (;;) {
 		__set_current_state(state);
 		/* Do not return before the requested sleep time has elapsed */

-- 
2.39.5


