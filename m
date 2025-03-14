Return-Path: <linux-kernel+bounces-561145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EDFA60E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4B71890C75
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AF61F2369;
	Fri, 14 Mar 2025 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="beB/NC+Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lXnd1jSy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38E1C861D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946377; cv=none; b=ZF0CcUU2lYL/qwhvadb5vJmdxe3H6uSt3PqYr7eTqz0HKBKutsPdp03nM5/dRGHAX4ZNGXUI7/7HA4Z8ZgRevk0WAxSPSEt2sgLthYHOmvbAkCriNtj44wM+39HgBXL/Jnsl1Pwe5Nw8NTYGrklTPyh8uGvVdm7vudACtrPgDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946377; c=relaxed/simple;
	bh=O3Dv8WZcnaqiTzbzhsDvUyoBF7/PMRPtOwcJ9qqfS5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaFr3uWzN9iGZZWWsVfmZZ0ub3pnRFX4o5m7xAW+smtGkvtkZiZm98IBCj4hqU37Bg2Htsgtw4GYF2xkdHpnlZOSgS0SRRWpC4jJZ6H2MveBmomR3nUzLzCN71gUQs/QiRXxiLgyzjbImjnWnM5ZRwM71xDP5KGRrDERPdh01Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=beB/NC+Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lXnd1jSy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 10:59:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741946372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3w0MmSw2EI1lWC8on8nI8XdOLasgjBRwmZM16KiFX9g=;
	b=beB/NC+Zp0PqJM69Y3IBBHjSEPlFKMv75ENTddz3f8ysWJxLxQ6LpxZTB+7m2mXgEcYV2b
	kQmrNrm0Gm8yCPvEdLgvi7G8+cOQmVUOlUM2zWvdcfhPtVlhTvximG4FX3QokOPbEVbcz5
	R3mQ67WeaGqHTPqt7jXsPaeP6xEf2XbiZYCSEZw8upr6mMGCXY4D99CUMHMZOr0uGLMBwb
	Hy9Pde/GT9PM2bJy+hEyPhyVIe/A4n3zKVIU5WU5dYzsr25bkw0PueMwhZUX1ly0YQFHi4
	ySSBDHYlWX7vxeFJM2kDF9KuK3RuCOCetgAAXXWR2cUvRLVWIxLF+8uckpO15g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741946372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3w0MmSw2EI1lWC8on8nI8XdOLasgjBRwmZM16KiFX9g=;
	b=lXnd1jSyfuLo9otMvLVHsBt1RUcyya5vhaKl4f0FmkNtP0JtBX6KdLo4V4GcdmWo7MjoC4
	H+65ZbqEe/pWV3AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v10 19/21] mm: Add vmalloc_huge_node()
Message-ID: <20250314095931.825Pdmvi@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-20-bigeasy@linutronix.de>
 <20250312150206.54afabcf993bbc55f0066886@linux-foundation.org>
 <20250313075924.qulV64zL@linutronix.de>
 <20250313150814.075d1cd993a84005d4cd22c2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313150814.075d1cd993a84005d4cd22c2@linux-foundation.org>

On 2025-03-13 15:08:14 [-0700], Andrew Morton wrote:
> That would be nice, if you think it makes sense.  There is some
> duplication here.

As you wish. That would be the following patch below. This is now
somehow unique compared to the other interfaces (like vmalloc() vs
vmalloc_node()).

-------------------->8-------------
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 14 Jul 2023 12:45:01 +0200
Subject: [PATCH] mm: Add vmalloc_huge_node()

To enable node specific hash-tables using huge pages if possible.

[bigeasy: use __vmalloc_node_range_noprof(), add nommu bits, inline
vmalloc_huge]

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/vmalloc.h |  9 +++++++--
 mm/nommu.c              | 18 +++++++++++++++++-
 mm/vmalloc.c            | 11 ++++++-----
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 31e9ffd936e39..de95794777ad6 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -168,8 +168,13 @@ void *__vmalloc_node_noprof(unsigned long size, unsigned long align, gfp_t gfp_m
 		int node, const void *caller) __alloc_size(1);
 #define __vmalloc_node(...)	alloc_hooks(__vmalloc_node_noprof(__VA_ARGS__))
 
-void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
-#define vmalloc_huge(...)	alloc_hooks(vmalloc_huge_noprof(__VA_ARGS__))
+void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node) __alloc_size(1);
+#define vmalloc_huge_node(...)	alloc_hooks(vmalloc_huge_node_noprof(__VA_ARGS__))
+
+static inline void *vmalloc_huge(unsigned long size, gfp_t gfp_mask)
+{
+	return vmalloc_huge_node(size, gfp_mask, NUMA_NO_NODE);
+}
 
 extern void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
 #define __vmalloc_array(...)	alloc_hooks(__vmalloc_array_noprof(__VA_ARGS__))
diff --git a/mm/nommu.c b/mm/nommu.c
index baa79abdaf037..aed58ea7398db 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -207,7 +207,23 @@ void *vmalloc_noprof(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc_noprof);
 
-void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __weak __alias(__vmalloc_noprof);
+/*
+ *	vmalloc_huge_node  -  allocate virtually contiguous memory, on a node
+ *
+ *	@size:		allocation size
+ *	@gfp_mask:	flags for the page level allocator
+ *	@node:          node to use for allocation or NUMA_NO_NODE
+ *
+ *	Allocate enough pages to cover @size from the page level
+ *	allocator and map them into contiguous kernel virtual space.
+ *
+ *	Due to NOMMU implications the node argument and HUGE page attribute is
+ *	ignored.
+ */
+void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
+{
+	return __vmalloc_noprof(size, gfp_mask);
+}
 
 /*
  *	vzalloc - allocate virtually contiguous memory with zero fill
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a6e7acebe9adf..0e2c49aaf84f1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3947,9 +3947,10 @@ void *vmalloc_noprof(unsigned long size)
 EXPORT_SYMBOL(vmalloc_noprof);
 
 /**
- * vmalloc_huge - allocate virtually contiguous memory, allow huge pages
+ * vmalloc_huge_node - allocate virtually contiguous memory, allow huge pages
  * @size:      allocation size
  * @gfp_mask:  flags for the page level allocator
+ * @node:	    node to use for allocation or NUMA_NO_NODE
  *
  * Allocate enough pages to cover @size from the page level
  * allocator and map them into contiguous kernel virtual space.
@@ -3958,13 +3959,13 @@ EXPORT_SYMBOL(vmalloc_noprof);
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask)
+void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
 {
 	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
-				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
-				    NUMA_NO_NODE, __builtin_return_address(0));
+					   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+					   node, __builtin_return_address(0));
 }
-EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
+EXPORT_SYMBOL_GPL(vmalloc_huge_node_noprof);
 
 /**
  * vzalloc - allocate virtually contiguous memory with zero fill
-- 
2.47.2


