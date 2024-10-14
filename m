Return-Path: <linux-kernel+bounces-363487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DEA99C30D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AA91F261DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D4115AAC1;
	Mon, 14 Oct 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E4YoHwOL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KbVSJdPa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7DC156C5E;
	Mon, 14 Oct 2024 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894172; cv=none; b=As5D6CLVkt5pu7RP6U+MWGgNCKI2X+4T6ymKcmMwd58TdyIcok/cYmWSuqg2KogHOIv9aFN/tn6pzPOYdDFmyoCZiW7hSBWDygPZLd8rbQT0HWIgfCeNbsLZCDiACqoC5c2xI68AJjBIyHc6F0jeeMLkR3sTutpBnCntffwJtWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894172; c=relaxed/simple;
	bh=JaL91nwnDzK572vfekANud1US2XICU3EGwgQ0/S3wgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rD+cI+++3ZlKgRc11KOaLP+yAM57jqEUcV1RVXpMoGbDWDcAA0r2xe4xcP0VVQezt2czqtDYG1an3pO77AEgqGoAK/dVJvMX+bdktMDEpi/ZqZYWzSK1Hm7/8OzokB2CKMsNmq3jY6ThTme5cQQYfyKqQijeGvgZkHxuCdFOYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E4YoHwOL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KbVSJdPa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/FQYp1WsHM0Ea/f1W/sKkPBQrz2BmxxCOt6NVM353k=;
	b=E4YoHwOLb1B3ZAaCdnr6R95ME1AbGI+/GSYZ7c+XqpCFKmyNgR9wf0msWiFE+aSU8b3oIx
	Bi4NgRn8SKqQx5X9n8lQ9wjJA/2xikZAnL1NbGPvIhH59lTM3Io/Z3XsgzSAJQsFNkaKcT
	QVxoZbAifS/+U1Y8xSFL619WbmOXJbTlvEB3yDYVe/UvKVCOemwXOkd4WAj+jreU8oCvpj
	v5FKl1YiIIKzZZVSJgElAbBs6UhbXxr7s4y18XEXUmtqc2cr+OkqytxDMuLBinpUElvRl1
	S0V+S4OaYVtNI7giWhFJyo7UlZ3vBtoTvlh1PJD1xQHlTmZGbUjC9BoZFxpJWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/FQYp1WsHM0Ea/f1W/sKkPBQrz2BmxxCOt6NVM353k=;
	b=KbVSJdPaprvvNNQ9A0lLzdXJ5QdgKrThBtv2FolWvO6tgQSnxJ1A44cOcP9GxTbyfvmePm
	T29kX26KkLnj3HAw==
Date: Mon, 14 Oct 2024 10:22:27 +0200
Subject: [PATCH v3 10/16] checkpatch: Remove links to outdated
 documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-10-dc8b907cb62f@linutronix.de>
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
functions. In all warnings the outdated documentation is referenced. Also
in checkpatch kernel documentation the outdated documentation is
referenced.

Replace the links to the outdated documentation with links to the function
description.

Note: Update of the outdated checkpatch checks is done in a second step.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v3: new in v3, replace only the links to the outdated documentation
---
 Documentation/dev-tools/checkpatch.rst |  2 --
 scripts/checkpatch.pl                  | 10 +++++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index a9fac978a525..abb3ff682076 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -470,8 +470,6 @@ API usage
     usleep_range() should be preferred over udelay(). The proper way of
     using usleep_range() is mentioned in the kernel docs.
 
-    See: https://www.kernel.org/doc/html/latest/timers/timers-howto.html#delays-information-on-the-various-kernel-delay-sleep-mechanisms
-
 
 Comments
 --------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..98790fe5115d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6597,11 +6597,11 @@ sub process {
 			# ignore udelay's < 10, however
 			if (! ($delay < 10) ) {
 				CHK("USLEEP_RANGE",
-				    "usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst\n" . $herecurr);
+				    "usleep_range is preferred over udelay; see function description of usleep_range() and udelay().\n" . $herecurr);
 			}
 			if ($delay > 2000) {
 				WARN("LONG_UDELAY",
-				     "long udelay - prefer mdelay; see arch/arm/include/asm/delay.h\n" . $herecurr);
+				     "long udelay - prefer mdelay; see function description of mdelay().\n" . $herecurr);
 			}
 		}
 
@@ -6609,7 +6609,7 @@ sub process {
 		if ($line =~ /\bmsleep\s*\((\d+)\);/) {
 			if ($1 < 20) {
 				WARN("MSLEEP",
-				     "msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.rst\n" . $herecurr);
+				     "msleep < 20ms can sleep for up to 20ms; see function description of msleep().\n" . $herecurr);
 			}
 		}
 
@@ -7077,11 +7077,11 @@ sub process {
 			my $max = $7;
 			if ($min eq $max) {
 				WARN("USLEEP_RANGE",
-				     "usleep_range should not use min == max args; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
+				     "usleep_range should not use min == max args;  see function description of usleep_range().\n" . "$here\n$stat\n");
 			} elsif ($min =~ /^\d+$/ && $max =~ /^\d+$/ &&
 				 $min > $max) {
 				WARN("USLEEP_RANGE",
-				     "usleep_range args reversed, use min then max; see Documentation/timers/timers-howto.rst\n" . "$here\n$stat\n");
+				     "usleep_range args reversed, use min then max;  see function description of usleep_range().\n" . "$here\n$stat\n");
 			}
 		}
 

-- 
2.39.5


