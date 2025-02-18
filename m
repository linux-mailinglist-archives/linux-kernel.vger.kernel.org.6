Return-Path: <linux-kernel+bounces-518982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F7FA396AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B1F162848
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB8922FADE;
	Tue, 18 Feb 2025 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="df2vx1Jk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jhw1uHf2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203622E3E6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870060; cv=none; b=T+uvp6JDCwF/Un7/F5VPtAvYX84LgYGXCe8lVuY/yWnqW+wZ8hcLVMkFa/sphzTPQWgOGgjF/AYJCWz/IAFv1c9oasrVeIBXYpq+POYzeo0CIZPnkRK9JZroaPNGlC5ezcyEsSyc30mH1h98IBSajel23jzkKBDSGaproYwvn3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870060; c=relaxed/simple;
	bh=lYEEJ11WKQ1RuT6GwkjTPXTRlBbW23RX47OY/QzK5u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmaStLU5bzQm8kjFpXwp3GSahghjuSHwUcEe1oTer1Dt8GdpJ1gPoN2GJK/Pwg1CGwRLXw+UHFn0ILObFso81I7zZqNi8HXjO6OCm07gGoiQLWflFaT7CEmLu1JbOEOtqF9i7HClLNQxjCl8KH7hUwTj6lrSub6VB4TnuNS14s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=df2vx1Jk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jhw1uHf2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:14:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739870053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YejFzVVvTbx480WIGNfaPb/xj9++hESGctXXz431OO8=;
	b=df2vx1JkD4DEQPrt/BPuCV077kmd75tiRcFvMzE875wych5ZkiYvfUnB77HbsiVkMnOqdI
	W95svi4Km54nuUdd0hlyMGE9SyV3Nj9857rz+BwQa65QzYZEyMvhbZtB794tRYM/iPQg/i
	8qVq1IZpvGrjauUgwIxOa3HAYd2CsldbiufQb8MDUwGAcKV3w0nNBbVkJoU9CQdO8KzWCS
	CQ0MyFRk+G7Ol0P38gm0TM47tCyVVaBJpASDgBt2il6VOJ3nitxvGIuyB0K4EUOC+S6nap
	oWh7v4coIpp08Nr96FH86ik7dcdKDQr3/A0CGo3GV8m+vNXdR5UK1lcBv+hT9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739870053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YejFzVVvTbx480WIGNfaPb/xj9++hESGctXXz431OO8=;
	b=jhw1uHf2SjZc1BZRWONmncC870CHsJ+CyLTWwsRXBC3L9hGrUyLK7u5rmLvZMcp5rS6sPS
	qsLRkvzg49YagtAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kasan-dev@googlegroups.com, linux-mm@kvack.org
Cc: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel test robot <lkp@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] dma: kmsan: Export kmsan_handle_dma() for modules.
Message-ID: <20250218091411.MMS3wBN9@linutronix.de>
References: <202502150634.qjxwSeJR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202502150634.qjxwSeJR-lkp@intel.com>

kmsan_handle_dma() is used by virtio_ring() which can be built as a
module. kmsan_handle_dma() needs to be exported otherwise building the
virtio_ring fails.

Export kmsan_handle_dma for modules.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502150634.qjxwSeJR-lkp@intel.com/
Fixes: 7ade4f10779cb ("dma: kmsan: unpoison DMA mappings")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/kmsan/hooks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 3ea50f09311fd..3df45c25c1f62 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -357,6 +357,7 @@ void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
 		size -= to_go;
 	}
 }
+EXPORT_SYMBOL_GPL(kmsan_handle_dma);
 
 void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir)
-- 
2.47.2

