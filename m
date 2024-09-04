Return-Path: <linux-kernel+bounces-315082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480B196BDD3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4BDB2133B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE81DC06C;
	Wed,  4 Sep 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ENSxVrQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q2jEhvSx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E351DB93D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455136; cv=none; b=KsakX50tdgUuf5sHHCWybGBpSm9VcldfpareDnh/OFgTIeQPcpsZzzBCAuGG2H32H8nTpfTze77i8PqBMj5bVxQOW/c/U6EiYTS9vMk+I2rz/5ks8nq823uKVv+czga+GHAJnNcf8xPFxkbkyc7EqKjbTISLsMYizip9uHm3qZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455136; c=relaxed/simple;
	bh=7R+bkza0AYRIpqcsoHtjn9cM4+pcPUpfwS2tZjfPbx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QqknMj5dDK2LtZXF6v79ax735nqISCi8vzAdGev1nTQ4CPuBfBpaVvtPeY4pmILcqSAD41I11MgIKZIERoZ6XMLWEZHMAOtC+/bRUCbixmyaoJpbx+LO6SlpJStVCH3ZMd1Co5+hLE65/FjfbS6SNYemUT077vWp4AvE9N1NYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ENSxVrQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q2jEhvSx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2WqQGDvcfGVZJkLVoW0Q8qCwVWbSPkBmha+bcsdPYw=;
	b=4ENSxVrQD7qCW7OoarRfzNQYHWngWjSYrWrReAfZMMa4F4fSMgRxod9GWhCAahYoLiY/bL
	i5y8Q+h93ZIeqVMmwFNlueRwg45ztON7OyMkKxc+HKmGJ6w4BSjXYc3p6rylOWtf6bXoc1
	P6HQkEyjGtQ6SWcdnZgBAAo3CI+7bUfOMVOnMLKv6a/OoSba7i4SlbE5JWQe3wKBt0b3BI
	loXvm17eXh94T/YlJovyv7aI77/NgXjfkILnyZX1t3Xu9WEGnH1yYhNcS9Lel7LFT+WhsP
	PeU41WaZ3aZZFjpp4HdRlswD/GjFZfM9et0AdrwV3xp/uOQYAE5OuPTgd2Pqbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2WqQGDvcfGVZJkLVoW0Q8qCwVWbSPkBmha+bcsdPYw=;
	b=q2jEhvSx0Wd8wcE99qqkT9yBormEb1Lup42V1W27Mw+g5XNsLiHPObP70/nTuTnUeH6H3p
	4ZpLR+JWoaWqtjDw==
Date: Wed, 04 Sep 2024 15:04:52 +0200
Subject: [PATCH 02/15] cpu: Use already existing usleep_range()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-2-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>

usleep_range() is a wrapper arount usleep_range_state() which hands in
TASK_UNTINTERRUPTIBLE as state argument.

Use already exising wrapper usleep_range(). No functional change.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1209ddaec026..031a2c15481b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -330,7 +330,7 @@ static bool cpuhp_wait_for_sync_state(unsigned int cpu, enum cpuhp_sync_state st
 			/* Poll for one millisecond */
 			arch_cpuhp_sync_state_poll();
 		} else {
-			usleep_range_state(USEC_PER_MSEC, 2 * USEC_PER_MSEC, TASK_UNINTERRUPTIBLE);
+			usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
 		}
 		sync = atomic_read(st);
 	}

-- 
2.39.2


