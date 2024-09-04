Return-Path: <linux-kernel+bounces-315093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DD396BDE2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429961F21AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F771DC1AA;
	Wed,  4 Sep 2024 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MQMEHC9u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IOTUgeRj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D11DCB1A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455141; cv=none; b=QPSUM8WE8EEWut1Z55N/e5ocXhsffbn4AsJPslzc28EvK7je4rF5jDiSo+mgEtr4qBScII0KTk+JIBSw6D0Q5IovvRg7P6PXqYDz8cpDy/tDbRlsS2jbjI3u4iiVNE+ZM3AZypqHhBnEOVunkVoAkc+7XNwHXnoCwqc+npga8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455141; c=relaxed/simple;
	bh=jj7sdFDyKXAj1zaKWm870qpEcJ4teMl2gx7a6e3vtT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nidFngNa0PIi9V/qn8Yz62AIv/cRnF/UvySKhsteHfDqr6+HgR7zOw71rHZF+JH/HVhpwSgkamlHjUDufaAXziaTmclNY98I+SYiW9hIjwqchprY9ifXzyLFF2vRuL+BXiLEbXakbNSs0Q5wzhK4EKtEDMq8e/uYnEAfVJrhfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MQMEHC9u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IOTUgeRj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hfd1PxbozLQzK7m8fWFTIzSCte8OkQB0IfjqNg3wQU=;
	b=MQMEHC9uCgO9Bu8eRUkgM1VzwCAACJRoARdehKzGkOywApNjtMFfd8yrdI3lK64hW5PGOZ
	vB0ot85XSEBikxeByrtltiqb/ZSci+9cNVYrfVLOXZ/AGB/x1uqJJGRR3dDfRlOplT8wfx
	ZxWE4wa6CvTJxtdwaBWYDQlXTD6RP+Q1rgJNRtf+xPqUVZZomPgJqx/mXfT2vhvZEMDbzI
	gpxRHmdmkalyokVeEclc/mo8/M9u3T69yAEFcTin4gWBWBhK6+yvkrvNFX1SgWjiU6MGDN
	vGG5aoLJBPZUSJ1uMWdEvwQKo/ecrOsCxtpn5FyIN+nIyXvGCNmF4zHoB4xkcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hfd1PxbozLQzK7m8fWFTIzSCte8OkQB0IfjqNg3wQU=;
	b=IOTUgeRjgq0Isv5szLcOo/E7OM5kxEXgCJ1hzVrV7fBBu1PVtxCT2Ebl5K+Ce1CddlP0aC
	e5wmO2jK1/NonsAw==
Date: Wed, 04 Sep 2024 15:05:00 +0200
Subject: [PATCH 10/15] checkpatch: Remove broken sleep/delay related checks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-10-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>

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
  Why is the check broken: The message is simply wrong. msleep() will not
                           sleep (and never did it before) for at least
                           20ms. This threshold cannot be hard coded as it
                           depends on the required accuracy and also on HZ
                           (jiffie granularity and timer wheel bucket/level
                           granularity). See msleep() and also the
                           USLEEP_RANGE_UPPER_BOUND value.

Remove all broken checks. Remove also no longer required checkpatch
documentation section about USLEEP_RANGE.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 Documentation/dev-tools/checkpatch.rst |  6 ------
 scripts/checkpatch.pl                  | 34 ----------------------------------
 2 files changed, 40 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index a9fac978a525..f5c27be9e673 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -466,12 +466,6 @@ API usage
   **UAPI_INCLUDE**
     No #include statements in include/uapi should use a uapi/ path.
 
-  **USLEEP_RANGE**
-    usleep_range() should be preferred over udelay(). The proper way of
-    using usleep_range() is mentioned in the kernel docs.
-
-    See: https://www.kernel.org/doc/html/latest/timers/timers-howto.html#delays-information-on-the-various-kernel-delay-sleep-mechanisms
-
 
 Comments
 --------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ba3359bdd1fa..80497da4aaac 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6601,28 +6601,6 @@ sub process {
 			}
 		}
 
-# prefer usleep_range over udelay
-		if ($line =~ /\budelay\s*\(\s*(\d+)\s*\)/) {
-			my $delay = $1;
-			# ignore udelay's < 10, however
-			if (! ($delay < 10) ) {
-				CHK("USLEEP_RANGE",
-				    "usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst\n" . $herecurr);
-			}
-			if ($delay > 2000) {
-				WARN("LONG_UDELAY",
-				     "long udelay - prefer mdelay; see arch/arm/include/asm/delay.h\n" . $herecurr);
-			}
-		}
-
-# warn about unexpectedly long msleep's
-		if ($line =~ /\bmsleep\s*\((\d+)\);/) {
-			if ($1 < 20) {
-				WARN("MSLEEP",
-				     "msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst\n" . $herecurr);
-			}
-		}
-
 # check for comparisons of jiffies
 		if ($line =~ /\bjiffies\s*$Compare|$Compare\s*jiffies\b/) {
 			WARN("JIFFIES_COMPARISON",
@@ -7079,18 +7057,6 @@ sub process {
 			}
 		}
 
-# check usleep_range arguments
-		if ($perl_version_ok &&
-		    defined $stat &&
-		    $stat =~ /^\+(?:.*?)\busleep_range\s*\(\s*($FuncArg)\s*,\s*($FuncArg)\s*\)/) {
-			my $min = $1;
-			my $max = $7;
-			if ($min eq $max) {
-				WARN("USLEEP_RANGE",
-				     "usleep_range should not use min == max args; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
-			}
-		}
-
 # check for naked sscanf
 		if ($perl_version_ok &&
 		    defined $stat &&

-- 
2.39.2


