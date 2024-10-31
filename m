Return-Path: <linux-kernel+bounces-390461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D33C09B7A33
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D2D1C21E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489DA19CC05;
	Thu, 31 Oct 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x5dG4y+i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fl1iFoiX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008A187864
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376252; cv=none; b=YN3R6MH5+7muPFX/K4dYEFWe+DRJ6h8E1dlndPDz7Pg8XzjzdPGm2BF7R4Zrv62UzNykCDIKi8gRjIm4siWpnt1dYebOJRdaDGJQhVhhVS+htm7MsiGFZGQeMvYk66kOUz+IOmBsHCTpF3eR6Bwe47zr970Ah28jeUR3Z61cvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376252; c=relaxed/simple;
	bh=M1eA656eEJ8giqV6WMmEz6tHJn2jOoQrnrwnna6laKc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=u0SF4CTmEidW9q4k+1+YOQpQEJrz35mjbJ71w+VKYsv2y5HfEIqqpcJeRfmjwHKXjxR932XChWwXAiRdJvDjam/5IpUSH6VglESLVk0u+X14SA9IBk9MCnvH8MVYyP25sXBv+vL8RqoHxx8BYSoYO+UmSvpxueDBR0XmfjrjiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x5dG4y+i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fl1iFoiX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031120328.599430157@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730376249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=H0Ct+JGAdNC6UcNJLqKMgCSUbsdDOHXxBCiXizWGKOQ=;
	b=x5dG4y+idX0lxOlu/AlhnI6u/IbCUuXRUpGAs8S7LfqShEs3U4KuLEEymhG2A9EhSVTRtq
	oSoE//IkB+nHc7kcTdE4Xg2Bg+vyNsUbFwdZ4sRHE91o3CEWrz568snnX0RhnlVI7EbCxu
	nMS9/lUzknd1Y5UAfJdZEast63roShIBJbDRZWHau2vaO421JUFtTIpN1OHQfHReU/bcYl
	lrfA6LNkOfoEvdGQFS6HOA6mgr/4bXK+O8s6Egh0Gdr/01lgIykC32HeZk9/ZlVwv61Xoa
	ZwlBSyLHnGwuaG9KD/Mzo+vWrV4YMhhR3FBtH4n+rMVNcQILx5Bankkhy8YhoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730376249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=H0Ct+JGAdNC6UcNJLqKMgCSUbsdDOHXxBCiXizWGKOQ=;
	b=fl1iFoiXWpJigTbu3wyOFanr5dIv5NB8Qc3zFYYXSFiapN0tKysF8147D3GSOI0vhP6Cjk
	RXGs+SezWtBmV0CA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 2/2] timekeeping: Always check for negative motion
References: <20241031115448.978498636@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 13:04:08 +0100 (CET)

clocksource_delta() has two variants. One with a check for negative motion,
which is only selected by x86. This is a historic leftover as this function
was previously used in the time getter hot paths.

Since 135225a363ae timekeeping_cycles_to_ns() has unconditional protection
against this as a by-product of the protection against 64bit math overflow.

clocksource_delta() is only used in the clocksource watchdog and in
timekeeping_advance(). The extra conditional there is not hurting anyone.

Remove the config option and unconditionally prevent negative motion of the
readout.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig                   |    1 -
 kernel/time/Kconfig                |    5 -----
 kernel/time/timekeeping_internal.h |    7 -------
 3 files changed, 13 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -145,7 +145,6 @@ config X86
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
-	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
 	# Word-size accesses may read uninitialized data past the trailing \0
 	# in strings and cause false KMSAN reports.
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -17,11 +17,6 @@ config ARCH_CLOCKSOURCE_DATA
 config ARCH_CLOCKSOURCE_INIT
 	bool
 
-# Clocksources require validation of the clocksource against the last
-# cycle update - x86/TSC misfeature
-config CLOCKSOURCE_VALIDATE_LAST_CYCLE
-	bool
-
 # Timekeeping vsyscall support
 config GENERIC_TIME_VSYSCALL
 	bool
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -30,7 +30,6 @@ static inline void timekeeping_inc_mg_fl
 
 #endif
 
-#ifdef CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE
 static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 {
 	u64 ret = (now - last) & mask;
@@ -41,12 +40,6 @@ static inline u64 clocksource_delta(u64
 	 */
 	return ret & ~(mask >> 1) ? 0 : ret;
 }
-#else
-static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
-{
-	return (now - last) & mask;
-}
-#endif
 
 /* Semi public for serialization of non timekeeper VDSO updates. */
 unsigned long timekeeper_lock_irqsave(void);


