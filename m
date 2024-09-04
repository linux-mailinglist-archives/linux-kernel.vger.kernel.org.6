Return-Path: <linux-kernel+bounces-315091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ABD96BDDE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C10E1F24300
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01181DEFC9;
	Wed,  4 Sep 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mojNKCYU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KmKpN5yL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A81DC74D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455140; cv=none; b=QY3Aq/azo+iUP3qZnD3tYtm4yETx8DHexP/Yewim5Li9m4x3J0bVP5+35xrUKdX2QkprnilKC0Vh1X53mBbAF2SRxC2XOB8l5oQsUegpWECx5S9kj4H1FOCouYFa7qd8Uye3EWmHAmP4XRf6vUCUmRRkAslKOKKZeWPMjAkePlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455140; c=relaxed/simple;
	bh=BkjqhbzOsTIK6A0jTcSXL5z177Nm8EkKpKlLKrux6IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+IZFDHzroWbOQeXJdOhYFQVCNI3GFRKiSSh2tXKWZFhn5Tg0P5mpyBeUi1eILy8LJ8hdhJ+uJtRCT4tNTYwq2tV7HVotwy9sbmlxnLjNDlkxmNJMNfWNByDZyWrTJwKj9MmNQqJCJkiMdg42KHUsl4sTdxVt5cjfZHNRKcmc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mojNKCYU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KmKpN5yL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9FelinSIqbGgcRPJNr21DeiIIYCh7RT2oX01854/V04=;
	b=mojNKCYU/DYy8ZqwXWcIS76oqTLVdKQwNiPvNi/ledLV2y6AHvaVFutmmqowQMs1uZpGTj
	hPFrv5V0ogmRnYNyRg8yJd2gysAxbdhGVNDxxPLX1V3um1NXf3e3JJBuAeKW/vAqUlsf8y
	sRMhVBsGndynT5dveLorT2AH8vTJi8PdOrBewY74w5ILf0bpo4a3hV5pZ+XLHyJtPDSaCZ
	lwfYwbz/IU7B1DOBUCQNwcxLR8jUfTErVdQ2n92gdI9GW6qPmsJ157VIRRfJWo0qLgPCvs
	TDwYC3oUdpQG1HNb8f3IqiBoc4qxsE9eOv+sYhpVMZvmBBoWeVH7gvp+QYyySw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9FelinSIqbGgcRPJNr21DeiIIYCh7RT2oX01854/V04=;
	b=KmKpN5yLITjGPmyVGJwksVDFKwYMeCKKXoaj8lPgkKeEW0jDDNwB4SpKAMEsCxA4UPcU2H
	YKO5+IYEQibT0pCA==
Date: Wed, 04 Sep 2024 15:04:59 +0200
Subject: [PATCH 09/15] timers: Add a warning to usleep_range_state() for
 wrong order of arguments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-9-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>

There is a warning in checkpatch script that triggers, when min and max
arguments of usleep_range_state() are in reverse order. This check does
only cover callsites which uses constants. Move this check into the code as
a WARN_ON_ONCE() to also cover callsites not using constants and get rid of
it in checkpatch.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/sleep_timeout.c | 2 ++
 scripts/checkpatch.pl       | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index 1ebd8429a64a..e028e9b4b113 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -351,6 +351,8 @@ void __sched usleep_range_state(unsigned long min, unsigned long max,
 	ktime_t exp = ktime_add_us(ktime_get(), min);
 	u64 delta = (u64)(max - min) * NSEC_PER_USEC;
 
+	WARN_ON_ONCE(max < min);
+
 	for (;;) {
 		__set_current_state(state);
 		/* Do not return before the requested sleep time has elapsed */
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..ba3359bdd1fa 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7088,10 +7088,6 @@ sub process {
 			if ($min eq $max) {
 				WARN("USLEEP_RANGE",
 				     "usleep_range should not use min == max args; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
-			} elsif ($min =~ /^\d+$/ && $max =~ /^\d+$/ &&
-				 $min > $max) {
-				WARN("USLEEP_RANGE",
-				     "usleep_range args reversed, use min then max; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
 			}
 		}
 

-- 
2.39.2


