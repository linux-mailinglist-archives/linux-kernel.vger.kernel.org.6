Return-Path: <linux-kernel+bounces-353890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76181993404
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D66A1C2392B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F5D1DE3B0;
	Mon,  7 Oct 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tetk/qHh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3aTLhbrQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C41DE2CA
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319817; cv=none; b=fxMIAJUKUu0NQJ20SKrIWq1RMkFN5UaYxhuP8S+bsw4CXKNhmIQx74bBIuUXvU4GqiP3ijNw2BEKmCWkmNJ2bUmm6eU3CmIdnhnpEqJaB8J5+uoYjePwawddF/Pj5M0UjcJeWRkPTY4fOl2xQroXKHb1FN6huR1y5rcM32cdilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319817; c=relaxed/simple;
	bh=TfE6+8mBkTEIhywmT4Bzq2nS1tp8WDshlGWqbEmSS/4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=GhUUSXRDSC84OF/OXgDPEjE9uB1hp6/0JCjadpzhnjrCg7LMkUjruwenZxAYZ1ezuvKNR5oEAJvWQ1uBWD60Ppv+759P6ZZVldHPHv1cSt6bUcw2QIG9g3lwHmMqmq8Id77KPgc8VXTfmMvxAdGoocfYbvgLpst6iyDAO9rXiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tetk/qHh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3aTLhbrQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164914.139204961@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NrMB7HiuGiz9Z3PezgOl5F9+0LPyymDMhrwUaKfLbFc=;
	b=tetk/qHhY1GEajgrfYN0MUKKeUyY4TpjVHv0bUXujXnFZfGtoOxyX9DdhIp4dud49CVOnn
	Nzkd3Q09wNNp/OYDkMpDRQM90nokp3nkJxTO0tR3XmxDV1scv61G3L8LliOIWSSLKVoR7p
	649RVFGuuSrzsy/r0hxOssbTq+iIUSKT7YbFh2N1BxuMTKxRZWBuGvYBM03G0iMod3o4k4
	fs2pO2TT4UtCggZ+6w0tkUQwDCA1cqUaLDLSrqw00qdAyS2v6GJHAD1V7XYCeO99MuivaK
	ka+auO2EblgQR7QnXckSp77u0sAyZ5YAOSEMXaxqTZeGtKF9tyuWnx7hQdmPRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NrMB7HiuGiz9Z3PezgOl5F9+0LPyymDMhrwUaKfLbFc=;
	b=3aTLhbrQ5pwcqUtfL8+rR3VZPY1CQbFYjtJlbdlAMcbG0EfOLi8XwivYAb23HxQYcFfae+
	AnhAfJ028AMBNtDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 19/25] debugobjects: Prepare for batching
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:14 +0200 (CEST)

Move the debug_obj::object pointer into a union and add a pointer to the
last node in a batch. That allows to implement batch processing efficiently
by utilizing the stack property of hlist:

When the first object of a batch is added to the list, then the batch
pointer is set to the hlist node of the object itself. Any subsequent add
retrieves the pointer to the last node from the first object in the list
and uses that for storing the last node pointer in the newly added object.

Add the pointer to the data structure and ensure that all relevant pool
sizes are strictly batch sized. The actual batching implementation follows
in subsequent changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/debugobjects.h |   12 ++++++++----
 lib/debugobjects.c           |   10 +++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

--- a/include/linux/debugobjects.h
+++ b/include/linux/debugobjects.h
@@ -23,13 +23,17 @@ struct debug_obj_descr;
  * @state:	tracked object state
  * @astate:	current active state
  * @object:	pointer to the real object
+ * @batch_last:	pointer to the last hlist node in a batch
  * @descr:	pointer to an object type specific debug description structure
  */
 struct debug_obj {
-	struct hlist_node	node;
-	enum debug_obj_state	state;
-	unsigned int		astate;
-	void			*object;
+	struct hlist_node		node;
+	enum debug_obj_state		state;
+	unsigned int			astate;
+	union {
+		void			*object;
+		struct hlist_node	*batch_last;
+	};
 	const struct debug_obj_descr *descr;
 };
 
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -21,11 +21,15 @@
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
 
-#define ODEBUG_POOL_SIZE	1024
-#define ODEBUG_POOL_MIN_LEVEL	256
-#define ODEBUG_POOL_PERCPU_SIZE	64
+/* Must be power of two */
 #define ODEBUG_BATCH_SIZE	16
 
+/* Initial values. Must all be a multiple of batch size */
+#define ODEBUG_POOL_SIZE	(64 * ODEBUG_BATCH_SIZE)
+#define ODEBUG_POOL_MIN_LEVEL	(ODEBUG_POOL_SIZE / 4)
+
+#define ODEBUG_POOL_PERCPU_SIZE	(4 * ODEBUG_BATCH_SIZE)
+
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
 #define ODEBUG_CHUNK_MASK	(~(ODEBUG_CHUNK_SIZE - 1))


