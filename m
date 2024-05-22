Return-Path: <linux-kernel+bounces-186009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35CE8CBE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11E01C21C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DF78172E;
	Wed, 22 May 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aTn6/8sl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3snz6aGS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aTn6/8sl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3snz6aGS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523A81721
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371415; cv=none; b=PQ1oBtShcKoaU6K77vFdTLLYVdeMOiQ2yPW8/bzE2fLS71Hdw5AxCldCNZ2jC8OufM8GyML8q9j0qDVqiYigihjSBap5FSmAtC/y8vG52PsJqIQ8hMis0x+jD4/rL+1e+pZcVzPoo4c6ht3h4U/dxN75fAuQ2TgMmLCODnhsnyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371415; c=relaxed/simple;
	bh=T4zfwfnwVEW2QxwI1rPFP7I9WdOAnI1Bm2yQVcWb6hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8SXA04wPXaFeXZ1eDcxYz4pyuk3pFYR1y2oTwUVl1bsLIFvsTfwZ8s5LFsK5BCJcB/1tOdZofZOfS8eGgHpevxlUPfKPsDGw6CS0ovTBTs4Exg1T7ZhMb1PxWPZR5RrKK7zW8JfleCP/gasUlQOsgWqWriK4wf5NK7uI9+S5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aTn6/8sl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3snz6aGS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aTn6/8sl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3snz6aGS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A097A5C766;
	Wed, 22 May 2024 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716371411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y5seN7yenBgxcqGC98g7sKIA9LM4LrCJZY6xmIjA2EE=;
	b=aTn6/8sleM0ONztO4Unqpxd+uynjWz3urX78jlz4ob4A9pmacA4e9fn7384PkRcYCjYf5R
	PxiTGQV0QRUIenlmXLZl2huVcDb3p6j8g81KbR3TYWl5JuQyul88i6d1IX96XYQuGhbZ+z
	43DPZszmIkW/PU/E4HazfSptPDexj2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716371411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y5seN7yenBgxcqGC98g7sKIA9LM4LrCJZY6xmIjA2EE=;
	b=3snz6aGS+9BRVPXLvnvmTvVZ9CDdUumRJ2bBPLF2+YgozUn1Xmarkel22uavtoFbXPCiZm
	RLCmz7LLypAFsdCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716371411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y5seN7yenBgxcqGC98g7sKIA9LM4LrCJZY6xmIjA2EE=;
	b=aTn6/8sleM0ONztO4Unqpxd+uynjWz3urX78jlz4ob4A9pmacA4e9fn7384PkRcYCjYf5R
	PxiTGQV0QRUIenlmXLZl2huVcDb3p6j8g81KbR3TYWl5JuQyul88i6d1IX96XYQuGhbZ+z
	43DPZszmIkW/PU/E4HazfSptPDexj2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716371411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y5seN7yenBgxcqGC98g7sKIA9LM4LrCJZY6xmIjA2EE=;
	b=3snz6aGS+9BRVPXLvnvmTvVZ9CDdUumRJ2bBPLF2+YgozUn1Xmarkel22uavtoFbXPCiZm
	RLCmz7LLypAFsdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EA5A13A6B;
	Wed, 22 May 2024 09:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dwKlItO/TWbzWgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 22 May 2024 09:50:11 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH] mm, slab: don't wrap internal functions with alloc_hooks()
Date: Wed, 22 May 2024 11:50:37 +0200
Message-ID: <20240522095037.13958-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kvack.org,vger.kernel.org,suse.cz,google.com,chromium.org];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.30
X-Spam-Flag: NO

The functions __kmalloc_noprof(), kmalloc_large_noprof(),
kmalloc_trace_noprof() and their _node variants are all internal to the
implementations of kmalloc_noprof() and kmalloc_node_noprof() and are
only declared in the "public" slab.h and exported so that those
implementations can be static inline and distinguish the build-time
constant size variants. The only other users for some of the internal
functions are slub_kunit and fortify_kunit tests which make very
short-lived allocations.

Therefore we can stop wrapping them with the alloc_hooks() macro and
drop the _noprof suffix. Instead add a __prefix where missing and a
comment documenting these are internal. Also rename __kmalloc_trace() to
__kmalloc_cache() which is more descriptive - it is a variant of
__kmalloc() where the exact kmalloc cache has been already determined.

Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
The intention is to use the slab tree after rc1 if no big conflicts with
mm.

 include/linux/slab.h | 53 ++++++++++++++++++++++----------------------
 lib/slub_kunit.c     |  2 +-
 mm/slub.c            | 32 +++++++++++++-------------
 3 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7247e217e21b..5ce84ffd0423 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -528,9 +528,6 @@ static_assert(PAGE_SHIFT <= 20);
 
 #include <linux/alloc_tag.h>
 
-void *__kmalloc_noprof(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
-#define __kmalloc(...)				alloc_hooks(__kmalloc_noprof(__VA_ARGS__))
-
 /**
  * kmem_cache_alloc - Allocate an object
  * @cachep: The cache to allocate from.
@@ -568,31 +565,33 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
-							 __alloc_size(1);
-#define __kmalloc_node(...)			alloc_hooks(__kmalloc_node_noprof(__VA_ARGS__))
-
 void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
 				   int node) __assume_slab_alignment __malloc;
 #define kmem_cache_alloc_node(...)	alloc_hooks(kmem_cache_alloc_node_noprof(__VA_ARGS__))
 
-void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
-		    __assume_kmalloc_alignment __alloc_size(3);
+/*
+ * The following functions are not to be used directly and are intended only for
+ * internal use from kmalloc() and kmalloc_node(), with the exception of kunit
+ * tests.
+ */
+void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment
+					  __alloc_size(1);
+
+void *__kmalloc_node(size_t size, gfp_t flags, int node)
+			__assume_kmalloc_alignment __alloc_size(1);
 
-void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
-		int node, size_t size) __assume_kmalloc_alignment
-						__alloc_size(4);
-#define kmalloc_trace(...)			alloc_hooks(kmalloc_trace_noprof(__VA_ARGS__))
+void *__kmalloc_cache(struct kmem_cache *s, gfp_t flags, size_t size)
+			__assume_kmalloc_alignment __alloc_size(3);
 
-#define kmalloc_node_trace(...)			alloc_hooks(kmalloc_node_trace_noprof(__VA_ARGS__))
+void *__kmalloc_cache_node(struct kmem_cache *s, gfp_t gfpflags, int node,
+			   size_t size)	__assume_kmalloc_alignment
+				__alloc_size(4);
 
-void *kmalloc_large_noprof(size_t size, gfp_t flags) __assume_page_alignment
-					      __alloc_size(1);
-#define kmalloc_large(...)			alloc_hooks(kmalloc_large_noprof(__VA_ARGS__))
+void *__kmalloc_large(size_t size, gfp_t flags)	__assume_page_alignment
+			__alloc_size(1);
 
-void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node) __assume_page_alignment
-							     __alloc_size(1);
-#define kmalloc_large_node(...)			alloc_hooks(kmalloc_large_node_noprof(__VA_ARGS__))
+void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
+				__assume_page_alignment __alloc_size(1);
 
 /**
  * kmalloc - allocate kernel memory
@@ -654,14 +653,14 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 		unsigned int index;
 
 		if (size > KMALLOC_MAX_CACHE_SIZE)
-			return kmalloc_large_noprof(size, flags);
+			return __kmalloc_large(size, flags);
 
 		index = kmalloc_index(size);
-		return kmalloc_trace_noprof(
+		return __kmalloc_cache(
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, size);
 	}
-	return __kmalloc_noprof(size, flags);
+	return __kmalloc(size, flags);
 }
 #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
 
@@ -671,14 +670,14 @@ static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gf
 		unsigned int index;
 
 		if (size > KMALLOC_MAX_CACHE_SIZE)
-			return kmalloc_large_node_noprof(size, flags, node);
+			return __kmalloc_large_node(size, flags, node);
 
 		index = kmalloc_index(size);
-		return kmalloc_node_trace_noprof(
+		return __kmalloc_cache_node(
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, node, size);
 	}
-	return __kmalloc_node_noprof(size, flags, node);
+	return __kmalloc_node(size, flags, node);
 }
 #define kmalloc_node(...)			alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))
 
@@ -756,7 +755,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_
 		return NULL;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
 		return kmalloc_node_noprof(bytes, flags, node);
-	return __kmalloc_node_noprof(bytes, flags, node);
+	return __kmalloc_node(bytes, flags, node);
 }
 #define kmalloc_array_node(...)			alloc_hooks(kmalloc_array_node_noprof(__VA_ARGS__))
 
diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 4ce960438806..3b5fea45b8fe 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -140,7 +140,7 @@ static void test_kmalloc_redzone_access(struct kunit *test)
 {
 	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
 				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
-	u8 *p = kmalloc_trace(s, GFP_KERNEL, 18);
+	u8 *p = __kmalloc_cache(s, GFP_KERNEL, 18);
 
 	kasan_disable_current();
 
diff --git a/mm/slub.c b/mm/slub.c
index 0809760cf789..31c25e0ebed8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4053,7 +4053,7 @@ EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
  * directly to the page allocator. We use __GFP_COMP, because we will need to
  * know the allocation order to free the pages properly in kfree.
  */
-static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
+static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
 	struct folio *folio;
 	void *ptr = NULL;
@@ -4078,25 +4078,25 @@ static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
 	return ptr;
 }
 
-void *kmalloc_large_noprof(size_t size, gfp_t flags)
+void *__kmalloc_large(size_t size, gfp_t flags)
 {
-	void *ret = __kmalloc_large_node(size, flags, NUMA_NO_NODE);
+	void *ret = ___kmalloc_large_node(size, flags, NUMA_NO_NODE);
 
 	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
 		      flags, NUMA_NO_NODE);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_large_noprof);
+EXPORT_SYMBOL(__kmalloc_large);
 
-void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
+void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
 {
-	void *ret = __kmalloc_large_node(size, flags, node);
+	void *ret = ___kmalloc_large_node(size, flags, node);
 
 	trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << get_order(size),
 		      flags, node);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_large_node_noprof);
+EXPORT_SYMBOL(__kmalloc_large_node);
 
 static __always_inline
 void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
@@ -4123,17 +4123,17 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
 	return ret;
 }
 
-void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
+void *__kmalloc_node(size_t size, gfp_t flags, int node)
 {
 	return __do_kmalloc_node(size, flags, node, _RET_IP_);
 }
-EXPORT_SYMBOL(__kmalloc_node_noprof);
+EXPORT_SYMBOL(__kmalloc_node);
 
-void *__kmalloc_noprof(size_t size, gfp_t flags)
+void *__kmalloc(size_t size, gfp_t flags)
 {
 	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
 }
-EXPORT_SYMBOL(__kmalloc_noprof);
+EXPORT_SYMBOL(__kmalloc);
 
 void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
 				       int node, unsigned long caller)
@@ -4142,7 +4142,7 @@ void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
 }
 EXPORT_SYMBOL(kmalloc_node_track_caller_noprof);
 
-void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
+void *__kmalloc_cache(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, NUMA_NO_NODE,
 					    _RET_IP_, size);
@@ -4152,10 +4152,10 @@ void *kmalloc_trace_noprof(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_trace_noprof);
+EXPORT_SYMBOL(__kmalloc_cache);
 
-void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
-			 int node, size_t size)
+void *__kmalloc_cache_node(struct kmem_cache *s, gfp_t gfpflags, int node,
+			   size_t size)
 {
 	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, size);
 
@@ -4164,7 +4164,7 @@ void *kmalloc_node_trace_noprof(struct kmem_cache *s, gfp_t gfpflags,
 	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
-EXPORT_SYMBOL(kmalloc_node_trace_noprof);
+EXPORT_SYMBOL(__kmalloc_cache_node);
 
 static noinline void free_to_partial_list(
 	struct kmem_cache *s, struct slab *slab,
-- 
2.45.1


