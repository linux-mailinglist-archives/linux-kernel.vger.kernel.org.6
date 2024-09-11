Return-Path: <linux-kernel+bounces-324207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8FE974985
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FB71C2234A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26DB7580C;
	Wed, 11 Sep 2024 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oW/2gyk0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yHBtkjZ4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9553E15
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031634; cv=none; b=uiP+lnyghcZoxcONFmu1xkAG7B4GMeFErq87ZPHkOjn8xMDaT59szwJoCx4zkFMPkOp8TKw8jZBXHY12Ze5VhIvXIanMWGM2Ho6JIpjkh8fOdnPy+mwInGZSneehpRA2GYDu3bKNyV8vgC25NL+am1kS4snuYqgqyK326abAD1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031634; c=relaxed/simple;
	bh=5e6eNv5ryoge/gb2rmpIFFM9vycX3OtF//kUGJokz3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OArFYWUd79Nu6JoHdRbxxrsNXyYx9quiyzG0fpjyF/spzQ2gi7XePZAuNBgqi+BVVf1QIsC6fI7oalckU8VYPocQgi+XXoLs4lW4bmjd7Obib1e+8yTffKZUk6e24881aaSvo3qea83GJSmc6BrZ7OP2Z8QayvQQaEhPQesay+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oW/2gyk0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yHBtkjZ4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726031630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+OokvN1l+gdCyN4uvEIpHtTR19aqjU/bCRqWUh13ys=;
	b=oW/2gyk0upSbrkLBKtincnlEmbY6aMgx3x9eKMA2rMDkXI+9ucB4PgIt7nvrCmkd319J9l
	eTTQ1aC02zViwnrryRa6jjYm+hgz3CZpFOqBb3wtftJAN2WddG45XS1mUUZdpJN7hXP5M8
	602h4AlTQ3vUPGaInInaTFRs6s5gLsVaPEIJi1iaOtUoTTeY6yntTdumY4w+0QMGl6BG3l
	6Rj8EV5a8kFks7b3rNuvuKNh/lQr8FjsqrXNC4QN5kWGxgO/hwFYJ2mp4FjqfyAn9gxoWR
	s+Wbjs0qsWWsL1s2ftEDySdB2pt8zO5Ee54FuhJ3aLymJMeaoeVPraxP6p7RMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726031630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+OokvN1l+gdCyN4uvEIpHtTR19aqjU/bCRqWUh13ys=;
	b=yHBtkjZ4Jm45gLyVODQU3NBASvE8x/2u7j0vLScripvkiZgIPC7gJJvLApbyaIRDxHfkcm
	r7zjcZWoKJ9rRSAQ==
Date: Wed, 11 Sep 2024 07:13:27 +0200
Subject: [PATCH v2 01/15] MAINTAINERS: Add missing file
 include/linux/delay.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-flseep-v2-1-b0d3f33ccfe0@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

include/linux/delay.h is not covered by MAINTAINERS file. Add it to the
"HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS" section.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v2: New (splitted as requested by Frederic)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..d9135d8ece99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10010,6 +10010,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 F:	Documentation/timers/
 F:	include/linux/clockchips.h
+F:	include/linux/delay.h
 F:	include/linux/hrtimer.h
 F:	include/linux/timer.h
 F:	kernel/time/clockevents.c

-- 
2.39.2


