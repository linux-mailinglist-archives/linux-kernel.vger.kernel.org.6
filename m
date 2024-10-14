Return-Path: <linux-kernel+bounces-363477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB64399C2FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76231C226F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EC715531A;
	Mon, 14 Oct 2024 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i0lSOyid";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jtKDHSGP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8D153812;
	Mon, 14 Oct 2024 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894167; cv=none; b=WbZZdZJ4ozfqswM9dactVVXZxxkw4RaWFMu470rkI4iKJfrdUXQF++7fBKKR76LE0KaKxJznrGnRhJguJs7hw2pwlG3rxnYpe76XsWiN18/xdK13tWyT8OwHb2103lDqDnBIpbPZsdNxu/phQsmXeBexCMFLsuzELfnIWixsR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894167; c=relaxed/simple;
	bh=R59ISuQU6UNetpyfr/6njAfFarMxn1kdLytWjpw5p0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scHGMaFFU5waZ7mNM3SVF3tgIZOXexeCumXe6YReKd/wJC19JqhTVRjRKWvsVmw+UfGBvkns7IYveUJNhmyz7SB4VCQTo3duSQ8WJ5UnF5mu74QN0Bd36+sAggrz8oFXjPK0MnIiAlZoPU4/vLS/Z9RllaZsBvUdFEQW/J+YFAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i0lSOyid; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jtKDHSGP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSfli7o6o9K/Eh4c9OZZevk/KHj0m2P7q6V2eNSLExs=;
	b=i0lSOyidAIK2a1QA0nL8qwP6AR2tRF81HBoq21UrszRxARIOEyGpR1bGHEh48sewtTR0ZG
	vPKzGypJaZxse9TTsDoRmfWIBy024YgGaCFeFYvubAx6NkWsB0pN9NkkJ3d4F6DMG15uPK
	8DsKWlYm+zixZlosbArwle2ElB9qv9DU1VL6zLcVRLTaZuuKu05sdsNp+bt3z1xaMhBj/k
	kQeeZVHc02dBtrQN5oZu8tNNdQ9WKkQ0eJ39Tqm6LeFat2wg9bjk+35Bc+31I/PUGVYeXe
	QYwINUz+hCG7nTsvwXMLJcwh1O7SZfKz4hBEihBEMVEdI7vT8Jfkndu8WlEB1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSfli7o6o9K/Eh4c9OZZevk/KHj0m2P7q6V2eNSLExs=;
	b=jtKDHSGPeWtTFWKbHYP4Avh9gmNB5ErrkPI7BReihfJgmmvw6esm4HIf/Uvcxi2C5laJMy
	7exp0NwGobZzM3AQ==
Date: Mon, 14 Oct 2024 10:22:18 +0200
Subject: [PATCH v3 01/16] MAINTAINERS: Add missing file
 include/linux/delay.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-1-dc8b907cb62f@linutronix.de>
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

include/linux/delay.h is not covered by MAINTAINERS file. Add it to the
"HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS" section.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
---
v2: New (splitted as requested by Frederic)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f49324..91c3e79c69cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10165,6 +10165,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 F:	Documentation/timers/
 F:	include/linux/clockchips.h
+F:	include/linux/delay.h
 F:	include/linux/hrtimer.h
 F:	include/linux/timer.h
 F:	kernel/time/clockevents.c

-- 
2.39.5


