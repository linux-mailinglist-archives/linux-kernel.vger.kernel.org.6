Return-Path: <linux-kernel+bounces-363492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F399C314
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F7D1C2293A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E6A197A8A;
	Mon, 14 Oct 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="29TnFL8+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kkSO+aIp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F6158A13;
	Mon, 14 Oct 2024 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894174; cv=none; b=moXU8fdcK7VcX3tjK+d19vuwWhTZ3zVKw3orTlBlEi8+wXt8i30fgM9Kh//dQf/FxRU5Qd/wDbikJZ7U4MZYvRr7FrW9PvSlEwZ7EYuVygvvn0RanXb5HRmbvx4MC9N3i9lXMDiqHZ0nf09det5Vu4GlU0+SM+9Rs+lOZv+gH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894174; c=relaxed/simple;
	bh=xqAviz1yKAsmHoh5se7gRuA7GtjuV7HmRGx3G4wcIbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8Da1lQhOTJ+mw3zfd5IVgLKYj5vXPhFkN5KSWLak9hxFD1xcOnyzEkuFbmqmFqVpY9tpgmpf6SQyuWZ3ttN4bEDb6tOnr3oDnpW6fDgDFn3/H8OnA4xvH7mxnEK/O/beru40QaNUdOSa7cwLopBphh9j7m9fBgTtTsVY791TZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=29TnFL8+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kkSO+aIp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wODdgjku5JfjriO9kL1m2ZaFUZK+6PTrhP3Cq+020Qc=;
	b=29TnFL8+G0QlUT07r9L892yuG/RwhZA4VI/5y7EeVlxMfbYHgCKHbwe7/MkcyBCUFmGfKY
	oEPmHG/SItqbUOCKOcf+AESoRZYy5ddOJJj4tAqzVvArivXfnJ5q2nJmPKO8Tx8Aq84L0U
	4gLX5VfSAC/418xlZEtxbs22OT9zIH1B3IL670jKmCSoJZb+9LUA39GsciA8VvpUoDCefQ
	lV3ZVU42qeNK2Z9Ca2ysRWwyKt+DTfceUMZIIl2vskzeoioJeot1UStbGll9z/DemMJgL0
	nAb6nKYb5UVVy84tntRqYJ0DtnqHvDgH/LCrW4p0YPqvHmWHUl6Ut/0dc4lDyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wODdgjku5JfjriO9kL1m2ZaFUZK+6PTrhP3Cq+020Qc=;
	b=kkSO+aIphjh5eZRw/u89nqWbps1prElRs40uxlHVadU6yHJMV7FrnbC7mAf23UOthbCaMH
	fjdYqYyjYDfkhdAg==
Date: Mon, 14 Oct 2024 10:22:33 +0200
Subject: [PATCH v3 16/16] checkpatch: Remove broken sleep/delay related
 checks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-16-dc8b907cb62f@linutronix.de>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Andy Whitcroft <apw@canonical.com>, 
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>

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
v3: Move it to the end of the queue and adapt it to the new patch which
    removes the link to the outdated documentation before.
v2: Rephrase commit message
---
 Documentation/dev-tools/checkpatch.rst |  4 ----
 scripts/checkpatch.pl                  | 38 ----------------------------------
 2 files changed, 42 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index abb3ff682076..f5c27be9e673 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -466,10 +466,6 @@ API usage
   **UAPI_INCLUDE**
     No #include statements in include/uapi should use a uapi/ path.
 
-  **USLEEP_RANGE**
-    usleep_range() should be preferred over udelay(). The proper way of
-    using usleep_range() is mentioned in the kernel docs.
-
 
 Comments
 --------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 98790fe5115d..34d4b5beda29 100755
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
@@ -7069,22 +7047,6 @@ sub process {
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
-				     "usleep_range should not use min == max args;  see function description of usleep_range().\n" . "$here\n$stat\n");
-			} elsif ($min =~ /^\d+$/ && $max =~ /^\d+$/ &&
-				 $min > $max) {
-				WARN("USLEEP_RANGE",
-				     "usleep_range args reversed, use min then max;  see function description of usleep_range().\n" . "$here\n$stat\n");
-			}
-		}
-
 # check for naked sscanf
 		if ($perl_version_ok &&
 		    defined $stat &&

-- 
2.39.5


