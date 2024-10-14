Return-Path: <linux-kernel+bounces-363490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E8999C311
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463DB1C226F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAC9176AD0;
	Mon, 14 Oct 2024 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DBulGqQq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3lxr/e1p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646315747D;
	Mon, 14 Oct 2024 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894173; cv=none; b=OuMmguqN+z85LqKnXCx0/QvZ0TXTojoq+7qd4EnOK/YZMf1hzePmtCh4YKGPnF2jjKdpkCwZ9GleDEYnb6vYQPiwvXRGdn7hbxi8MUrBPhCy0Qz7WCVrhE1eXtuSpI+zgbZhwkPTbq3nx/88In7TXbLe4rgZTaLO10PGqcqRxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894173; c=relaxed/simple;
	bh=qifAZvSDJ4oCKAVNUiGd2BZc1rUvRYb11jCH8W1tAvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DH6Es1JMY99TbuaTwWDmlDIakboAi2QSnmrs2MF50VRnVeMIhu6HE6rC551VDoDwuEYgyza+R61gcUjyWCGmpKra4q9AQGx5wWWsiZ4ehBZbyNEXhYAjUy00IC+x3AgdXiLuo5GAejR3KPzO6Mm/i//GVkYOHKL8Lx3i8ALPk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DBulGqQq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3lxr/e1p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joTkYfZuYDbUq+yir8wGSuEWOSrlObwkU2FwRn80vkM=;
	b=DBulGqQqivo+HovK0ZWzPaLAfqSi54oj8a/ajqV+NODU3T81A4UvR9G+3PGcGnr8QYePr1
	u+qEbqQorp4wld2ryheKfZFZ5okpBxhBU8/pSpUIBXV4v0Uc0dkK0CBLq8qznnWXObHmwB
	Z+z+ugP/WyxLa36tb1Bz9XsG8IWkRR0yAlVjTfPhF2z1jK4yepBEpyvlo0Tc64eIkFByNv
	lPG9rwh6ABJLelVeDa6yUAF/fx2XuTetyVM63wYoYJmIhu91QqZU8w+uIK34sMtwpjy5wi
	ACHL4Xs4oFcwk/rag0QPSA17e34YPL3PeKGp7TSr4FxUSjDD/NIjN1+pcxic5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joTkYfZuYDbUq+yir8wGSuEWOSrlObwkU2FwRn80vkM=;
	b=3lxr/e1pnS/X0qbMGdQ/8zMBUdws2K1T64ougHTi6Cb7SKyLSEJxZEdvp6X0bQeW/0yMFj
	Ci3sE5nPcdyDdwCg==
Date: Mon, 14 Oct 2024 10:22:30 +0200
Subject: [PATCH v3 13/16] powerpc/rtas: Use fsleep() to minimize additional
 sleep duration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-13-dc8b907cb62f@linutronix.de>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org

When commit 38f7b7067dae ("powerpc/rtas: rtas_busy_delay() improvements")
was introduced, documentation about proper usage of sleep related functions
was outdated.

The commit message references the usage of a HZ=100 system. When using a
20ms sleep duration on such a system and therefore using msleep(), the
possible additional slack will be +10ms.

When the system is configured with HZ=100 the granularity of a jiffy and of
a bucket of the lowest timer wheel level is 10ms. To make sure a timer will
not expire early (when queueing of the timer races with an concurrent
update of jiffies), timers are always queued into the next bucket. This is
the reason for the maximal possible slack of 10ms.

fsleep() limits the maximal possible slack to 25% by making threshold
between usleep_range() and msleep() HZ dependent. As soon as the accuracy
of msleep() is sufficient, the less expensive timer list timer based
sleeping function is used instead of the more expensive hrtimer based
usleep_range() function. The udelay() will not be used in this specific
usecase as the lowest sleep length is larger than 1 millisecond.

Use fsleep() directly instead of using an own heuristic for the best
sleeping mechanism to use.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v2: fix typos
---
 arch/powerpc/kernel/rtas.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index f7e86e09c49f..d31c9799cab2 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1390,21 +1390,14 @@ bool __ref rtas_busy_delay(int status)
 		 */
 		ms = clamp(ms, 1U, 1000U);
 		/*
-		 * The delay hint is an order-of-magnitude suggestion, not
-		 * a minimum. It is fine, possibly even advantageous, for
-		 * us to pause for less time than hinted. For small values,
-		 * use usleep_range() to ensure we don't sleep much longer
-		 * than actually needed.
-		 *
-		 * See Documentation/timers/timers-howto.rst for
-		 * explanation of the threshold used here. In effect we use
-		 * usleep_range() for 9900 and 9901, msleep() for
-		 * 9902-9905.
+		 * The delay hint is an order-of-magnitude suggestion, not a
+		 * minimum. It is fine, possibly even advantageous, for us to
+		 * pause for less time than hinted. To make sure pause time will
+		 * not be way longer than requested independent of HZ
+		 * configuration, use fsleep(). See fsleep() for details of
+		 * used sleeping functions.
 		 */
-		if (ms <= 20)
-			usleep_range(ms * 100, ms * 1000);
-		else
-			msleep(ms);
+		fsleep(ms * 1000);
 		break;
 	case RTAS_BUSY:
 		ret = true;

-- 
2.39.5


