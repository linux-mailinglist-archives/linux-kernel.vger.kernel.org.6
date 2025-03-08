Return-Path: <linux-kernel+bounces-552623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A20A57C17
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A31188A2E2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2CB1EFF9C;
	Sat,  8 Mar 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mj93E3NG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VDEn1dcD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92451EB5DB
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452502; cv=none; b=l1eRj1e6fnUHjkMhis1bcJmHGsH/JHBSBzwxHWJAWx3s89EaTNJiMcrYMDv+VxVo2cQ4PtTZuXf4cyeOizcnm04LzctyShX/a1z1B3LKYnmC8wES6WvuphWSUW707NgGCo1Ei+dcCTV6g6QVNhI5m26p+TF3aesWNBYp5Gij6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452502; c=relaxed/simple;
	bh=iGrVt5SIWyWVVTmRnZN0SZwdfWGj6TN1Wpw5Fld7GzA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=NYJAyxLo0zNU+eODScQPRlLitr+jUXFvtUlV8HsDfsHX0rDTenOCzdq1H+H91GiK2U89UZqLnBLp79sifJ+MpK5EGkvyvmoBf0wRRaCHNL9OdHndb34bD2b2VCk1dV7hkDoLytizjBea1MrLJD9v4b+I3WZUfROaeEg8hALlvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mj93E3NG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VDEn1dcD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155623.635612865@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1ZUFUQNw1HQq98JJ1JeSBCsqtOh9o5uM2O8I/kYQj8M=;
	b=mj93E3NGtP1NTygp3gfmaZHhcTbOZ28gCZve4+jnAIy1ZZVY7nKwwg5qt1TwT1kZWZuy3/
	cJ+vOxYeZu/amSL82MUPe+PqMRq+MZMH+zutPJVeFxtNNhxTOg8R8tkn9UZwkQ9hMjB81J
	nDueegP9pWilpXwo4BzsphvELIwlpsa1FG6/NDiDG3caQ8HakOjV5ft5eSoSXH72Ae7MJI
	oiZm76miKpxUatsgvmC8PhsG00H6f1K3OT8Amfxjqj0mrmCz2HF1UGKjWmJgOtvaiezH+e
	HfQN1RmgTVZJx5yvwCf/kG1G05Rb/XAaV6YRKOBDc5tivEs6lfCyg3yS0S5QZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1ZUFUQNw1HQq98JJ1JeSBCsqtOh9o5uM2O8I/kYQj8M=;
	b=VDEn1dcDBUTG/ed4VFmeW9kpJ2rOFvBJVFrTwQfyqGVZqBjzboBKfXrN1sDgyA2WrhTPsW
	ObKQveB5UJo6NsDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [patch V3 03/18] posix-timers: Add cond_resched() to
 posix_timer_add() search loop
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:17 +0100 (CET)

From: Eric Dumazet <edumazet@google.com>

With a large number of POSIX timers the search for a valid ID might cause a
soft lockup on PREEMPT_NONE/VOLUNTARY kernels.

Add cond_resched() to the loop to prevent that.

[ tglx: Split out from Eric's series ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250214135911.2037402-2-edumazet@google.com

---
 kernel/time/posix-timers.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -144,6 +144,7 @@ static int posix_timer_add(struct k_itim
 			return id;
 		}
 		spin_unlock(&hash_lock);
+		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
 	return -EAGAIN;




