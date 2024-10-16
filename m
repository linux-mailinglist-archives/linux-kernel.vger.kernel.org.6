Return-Path: <linux-kernel+bounces-367773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB359A0692
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CB7286B20
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5F5206E9D;
	Wed, 16 Oct 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yRRozjYP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7+kNwenw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE2206063;
	Wed, 16 Oct 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073139; cv=none; b=FMX1KNLa1KORALLw081sv8NXft/l1TZG7Uk0ysEgNTyu2CxAXfO+aMzo20QHOLzhG4k/ar4dTDO5614dSy4Ik1O2wHAUhIGnfBzjawgXqC4jeZEK/tk4bO7gj03bc99GpHaShxdPcLwJVrJ0PBBC5R/Ngs+ymAYXPT7h8iS7TgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073139; c=relaxed/simple;
	bh=AWin4VhQwINzThkWcp7BVVysM1zQU7iLYJyR2hQUJ8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bM6Y21Uawor4LO/0srUoQpAAizEczwlve+BK50z8Nvk2Xssq0KVZ3RaEmTZk6pG5NjQLv9DidgyHgFrNOphr/KN+0WsaqjQjn5UjL01tiEU0f/yvMVXc8ls7TcLinxLd+dtnjfk66byVB2nn3Q9UW1T0K5c20ICRjG5kbTu3yqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yRRozjYP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7+kNwenw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729073136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lgnbgw8Artt36t8a7HJj4/CoQ6kpH5chYU5V2Ss32ok=;
	b=yRRozjYPZjV2dX3heyNajAO4nSPQWQzJyAyR4wr7YYv2vhMOSPhXaYudKmp3RLTY/Z5rBD
	RduYtsJp5y1Pv4/dedRtXaH1H8YNh1NBY72PRDMVe03ecXD1rVVsU26caYgvimaAobrjXw
	h/WGlHySANBLx9g8ZpLNeewVrB6Blp/Qk1HrLkdhV58Tgz7DtzGo+k5LBGt6jbSCrcLIvp
	ymnLuHq0ZhDzPrbFQIvGRv3pMuKxFDkjh7DbFVG/XzUykG13M5MPptG2OeplhQuee3g07w
	yJCZclGcC90IaDaKsjNLl3S2kKX70NRBUMnykCn62GnAlBB2rdaGCS7rFLAjmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729073136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lgnbgw8Artt36t8a7HJj4/CoQ6kpH5chYU5V2Ss32ok=;
	b=7+kNwenwc8GkHwvBB1h7qnquwDDrWeoo6PrZ35g442+gqRqGKttlLr5Ho/Zrm3Syip+1+G
	KnHupgTUGt03qMBw==
To: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v4] checkpatch: Remove broken sleep/delay related checks
Date: Wed, 16 Oct 2024 12:05:31 +0200
Message-Id: <20241016100531.7153-1-anna-maria@linutronix.de>
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-16-dc8b907cb62f@linutronix.de>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-16-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch.pl checks for several things related to sleep and delay
functions. In all warnings the outdated documentation is referenced. All
broken parts are listed one by one in the following with an explanation why
this check is broken. For a basic background of those functions please also
refere to the updated function descriptions of udelay(), nsleep_range() and
msleep().

Be aware: The change is done with a perl knowledge of the level "I'm able
to spell perl".

The following checks are broken:

- Check: (! ($delay < 10) )
  Message: "usleep_range is preferred over udelay;
            see Documentation/timers/timers-howto.rst\n"
  Why is the check broken: When it is an atomic context, udelay() is
                           mandatory.

- Check: ($min eq $max)
  Message:  "usleep_range should not use min == max args;
             see Documentation/timers/timers-howto.rst\n"
  Why is the check broken: When the requested accuracy for the sleep
                           duration requires it, it is also valid to use
                           min == max.

- Check: ($delay > 2000)
  Message: "long udelay - prefer mdelay;
            see arch/arm/include/asm/delay.h\n"
  Why is the check broken: The threshold when to start using mdelay() to
                           prevent an overflow depends on
                           MAX_UDELAY_MS. This value is architecture
                           dependent. The used value for the check and
                           reference is arm specific. Generic would be 5ms,
                           but this would "break" arm, loongarch and mips
                           and also the arm value might "break" mips and
                           loongarch in some configurations.

- Check: ($1 < 20)
  Message: "msleep < 20ms can sleep for up to 20ms;
            see Documentation/timers/timers-howto.rst\n"
  Why is the check broken: msleep(1) might sleep up to 20ms but only on a
                           HZ=100 system. On a HZ=1000 system this will be
                           2ms. This means, the threshold cannot be hard
                           coded as it depends on HZ (jiffy granularity and
                           timer wheel bucket/level granularity) and also
                           on the required accuracy of the callsite. See
                           msleep() and also the USLEEP_RANGE_UPPER_BOUND
                           value.

Remove all broken checks. Update checkpatch documentation accordingly.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 Documentation/dev-tools/checkpatch.rst |  3 +--
 scripts/checkpatch.pl                  | 27 +-------------------------
 2 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index abb3ff682076..d29ead254353 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -467,8 +467,7 @@ API usage
     No #include statements in include/uapi should use a uapi/ path.
 
   **USLEEP_RANGE**
-    usleep_range() should be preferred over udelay(). The proper way of
-    using usleep_range() is mentioned in the kernel docs.
+    The proper way of using usleep_range() is mentioned in the kernel docs.
 
 
 Comments
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 98790fe5115d..2d7cf7d4fc5b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6591,28 +6591,6 @@ sub process {
 			}
 		}
 
-# prefer usleep_range over udelay
-		if ($line =~ /\budelay\s*\(\s*(\d+)\s*\)/) {
-			my $delay = $1;
-			# ignore udelay's < 10, however
-			if (! ($delay < 10) ) {
-				CHK("USLEEP_RANGE",
-				    "usleep_range is preferred over udelay; see function description of usleep_range() and udelay().\n" . $herecurr);
-			}
-			if ($delay > 2000) {
-				WARN("LONG_UDELAY",
-				     "long udelay - prefer mdelay; see function description of mdelay().\n" . $herecurr);
-			}
-		}
-
-# warn about unexpectedly long msleep's
-		if ($line =~ /\bmsleep\s*\((\d+)\);/) {
-			if ($1 < 20) {
-				WARN("MSLEEP",
-				     "msleep < 20ms can sleep for up to 20ms; see function description of msleep().\n" . $herecurr);
-			}
-		}
-
 # check for comparisons of jiffies
 		if ($line =~ /\bjiffies\s*$Compare|$Compare\s*jiffies\b/) {
 			WARN("JIFFIES_COMPARISON",
@@ -7075,10 +7053,7 @@ sub process {
 		    $stat =~ /^\+(?:.*?)\busleep_range\s*\(\s*($FuncArg)\s*,\s*($FuncArg)\s*\)/) {
 			my $min = $1;
 			my $max = $7;
-			if ($min eq $max) {
-				WARN("USLEEP_RANGE",
-				     "usleep_range should not use min == max args;  see function description of usleep_range().\n" . "$here\n$stat\n");
-			} elsif ($min =~ /^\d+$/ && $max =~ /^\d+$/ &&
+			if ($min =~ /^\d+$/ && $max =~ /^\d+$/ &&
 				 $min > $max) {
 				WARN("USLEEP_RANGE",
 				     "usleep_range args reversed, use min then max;  see function description of usleep_range().\n" . "$here\n$stat\n");
-- 
2.39.5


