Return-Path: <linux-kernel+bounces-353152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0F399296F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1EE284987
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC87B1CC14F;
	Mon,  7 Oct 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11WREbQr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uuaUDwkD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51314AD17
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297833; cv=none; b=jNMQix2/EamzSE99yqLXCEFz5V5WG/siNn62nZGNjXPah3F91yl2v6VJ4OYnKQtKhGFygOXpXiYWlzs3np+SJboxpw5yaE27cNs3U2t3SFA2tvqlrJoSfqes1WbDBCvGO81ykWElv9ixlXGBBVMRgKvIkQTm7cCHR7O9y7Tqg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297833; c=relaxed/simple;
	bh=QXW1iU6adpifctfmUvh0hIXb/JWupOeu1MdjsIy/J/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llG2lgBbDlcuU4EEUzGwYDhreZCEiDF2u11sCC/ELpwuL3aXb7BxAuAUpLSb/HxYUFpnuFA9ZRJHex2b1twOsJQV0LpPaLk+0xCB14MNN6JWy+NyY8bldOLLQfZbURt/KduYD2TUXhYgl6qBZ1lJOsw6y43HoIxMRephnZnmR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11WREbQr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uuaUDwkD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 7 Oct 2024 12:43:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728297829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+DqdrS6iCcxvyTC6yHwsLzPqdZ3ScxxXhmioABziL4=;
	b=11WREbQryZUB+6p/3Jnhtn2e+EGl3o06ZWfAXA1h0H1up/FJTI7o3WCEpby82DYhOEamIS
	SNo2GK1/pjwtMbvsFMlr0TeRU0EO2A+Fob5UolLo5fyZftXjxYAa7SO9WFuwezd7crzVt4
	V6loaNbJSNtaumAwHLxJ4CyXzfNeOOATPRyRwxdc3lBCyKZUeuMlrLoe4pat2v5sQn1Lf6
	qbdUi/sofYbeUxf/c5vZJ7x9ujrfqlksMvcuC4B3WSIwGV6H8RqiL+2iP5jD/cPyfo2H73
	7vHup3RTQ8ofFdfjsOAd2iXE8Qox2izdP8O3JcFXW8nnN1cVeg8hTEwitHVe4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728297829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+DqdrS6iCcxvyTC6yHwsLzPqdZ3ScxxXhmioABziL4=;
	b=uuaUDwkDAkRjg0n1+IyVHh3x7rt9v9AOYpm9kk/cF5bQzmwmEIfZ4jyBkZiosa1SZQpS9i
	zt/Bh/pYeLtUM0BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Hou Tao <houtao1@huawei.com>, Jan Kara <jack@suse.cz>,
	Jianhui Zhou <912460177@qq.com>, Yury Norov <yury.norov@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] preempt_rt: increase PERCPU_DYNAMIC_SIZE_SHIFT for slab
 randomization
Message-ID: <20241007104348.ImJPXDl9@linutronix.de>
References: <20241004095702.637528-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004095702.637528-1-arnd@kernel.org>

On 2024-10-04 09:56:56 [+0000], Arnd Bergmann wrote:
> The problem is the additional size overhead from local_lock in
> struct kmem_cache_cpu.  Avoid this by preallocating a larger area.

The worst case would be enabling additionally MEMCG so NR_KMALLOC_TYPES
increases by one. And then we have:
PERCPU_DYNAMIC_EARLY_SIZE < NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH * sizeof(struct kmem_cache_cpu));

There is more to it than just RANDOM_KMALLOC_CACHES and PREEMPT_RT.
There is additionally CONFIG_LOCKDEP which increases the size of
local_lock_t further. Plus CONFIG_LOCK_STAT. The last one a kind of bad
in terms of required pad area. Then we have CONFIG_PAGE_SIZE_64KB set
which is the culprit. But 16K_PAGES also fail in this full blown case.

PERCPU_DYNAMIC_EARLY_SIZE < NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH * sizeof(struct kmem_cache_cpu));
4KiB   20 << 12           <     19           *   (12 + 1)         * 288
         80KiB            <           69.46875
16KiB  20 << 12           <     19           *   (14 + 1)         * 288
         80KiB            <           80.15625
64KiB  20 << 12           <     19           *   (16 + 1)         * 288
         80KiB            <           90.84375
128KiB 20 << 12           <     19           *   (17 + 1)         * 288
         80KiB            <           96.1875

Just disabling CONFIG_LOCK_STAT the 16KiB PAGE_SIZE case works again
(75.703125), the 64KiB still fails (85.796875).

> There is a good chance that there is a better way to address this, this
> version was the first I came up with and I verified that it fixes all of
> the broken configs.

How bad is it, to have PERCPU_DYNAMIC_SIZE_SHIFT unconditionally set to
13? If it is bad could we restrict it with LOCKDEP and PAGE_SIZE > 4KiB?

So maybe something like this:

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index b6321fc491598..52b5ea663b9f0 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -41,7 +41,11 @@
 					 PCPU_MIN_ALLOC_SHIFT)
 
 #ifdef CONFIG_RANDOM_KMALLOC_CACHES
-#define PERCPU_DYNAMIC_SIZE_SHIFT      12
+# if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PAGE_SIZE_4KB)
+# define PERCPU_DYNAMIC_SIZE_SHIFT      13
+# else
+# define PERCPU_DYNAMIC_SIZE_SHIFT      12
+#endif /* LOCKDEP and PAGE_SIZE > 4KiB */
 #else
 #define PERCPU_DYNAMIC_SIZE_SHIFT      10
 #endif

Sebastian

