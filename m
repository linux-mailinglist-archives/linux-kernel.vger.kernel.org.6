Return-Path: <linux-kernel+bounces-559866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0171A5FAA8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD61420435
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2108A26B2BF;
	Thu, 13 Mar 2025 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GFGMK7ja";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d6gwj5V4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62326B08D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881602; cv=none; b=S9RsJm38+FnRhCHS9/uUWmayfd9KNYtB0ZiUCe2MthtnaaUJJiuLB3PmSowZd9j1jwTITZ2BCFKQYYGFpEnZ+BoN+quduUpI8GGK+sinx0dWCW1Yroe6t7H1OgVXsRvAvbuYrOMCL0BZCyHLJw53Hd+gUbSMMo0tjczg55/IEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881602; c=relaxed/simple;
	bh=8nc0Udtrh3p0WdZlunXEF/3qKBirL0LzIUuWvtLbWIk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=mLunYX5t2z85C8dn7RonUKp/GlTyO7gAk7p7ax9e8Vqt4qXbaRGnxCeO4aVE2Nz+OQJQnDnSirN7ssZCsLDSAI2qPW4QNfDn1ratCUZMw23xJ+ZWLOQ+zYv867rCmKJpYNHrBjHUm2wN/XOkUHWQv7imBgFdKLxjTkw55N564jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GFGMK7ja; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d6gwj5V4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313155914.542595506@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741881599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BaBDaqHlzc8qnLL0P0eR5zS1rCHI9lEMLIjAmMGd1QI=;
	b=GFGMK7jaA8oafcP5sXIcCJIU9eS9daOnQ3/971//I2wFek6GYly1lTSHEB3TrkhhOwfP6T
	nfOclbPCPlm1tMj1uzW4I3AVvrYVfhVwFIBDvR8bM7MmdkSW17Ll9fgsfZ6MaNLCzQcC+k
	UTZ/wUiRBa1TfW3JheGs36NbfolFmDEJXNoriMkFN7OBsr66jv8W0g44K4IkhoeKOpKmCl
	/U3UsrGqB3+QXjVToF538L8nBla66xKLtbHxKEsZmuKMvBIt9FanYQ3v8tBLluoV4gPbJC
	S4xgdR37ZFcFzYunuzM5DZx7urlWVqfnOWP+zm4YUR71ozx5G9FI2S/YAFe8zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741881599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BaBDaqHlzc8qnLL0P0eR5zS1rCHI9lEMLIjAmMGd1QI=;
	b=d6gwj5V4lYz2PN5Mmj/DLx1yvbJ9+V2Z1W4LcOzQkgD50P/HkNupkxn0r3htxL+qMeK1ZP
	u4wWBGsOY/tWpVDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: [patch 10/46] genirq/debugfs: Convert to lock guards
References: <20250313154615.860723120@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 16:59:59 +0100 (CET)

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/debugfs.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -160,7 +160,7 @@ static int irq_debug_show(struct seq_fil
 	struct irq_desc *desc = m->private;
 	struct irq_data *data;
 
-	raw_spin_lock_irq(&desc->lock);
+	guard(raw_spinlock_irq)(&desc->lock);
 	data = irq_desc_get_irq_data(desc);
 	seq_printf(m, "handler:  %ps\n", desc->handle_irq);
 	seq_printf(m, "device:   %s\n", desc->dev_name);
@@ -178,7 +178,6 @@ static int irq_debug_show(struct seq_fil
 	seq_printf(m, "node:     %d\n", irq_data_get_node(data));
 	irq_debug_show_masks(m, desc);
 	irq_debug_show_data(m, data, 0);
-	raw_spin_unlock_irq(&desc->lock);
 	return 0;
 }
 


