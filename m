Return-Path: <linux-kernel+bounces-429865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139129E2BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E38B65E83
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AC21FA82C;
	Tue,  3 Dec 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TnH6AdTQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u++tDink"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E861F8AE0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244222; cv=none; b=Ury+dDQDRogSSj6HglCQgJO/5vxQu30VnrUinxAIpFgrEUSn+lI/822jr/hnZcuV51ku/b6hG7jx5MRs6supqwA2tz9ovjaMYNbGvtJNG/VoBsRXo19VgE6MsFyfka4GA/ZV5dDuatlKim3vtw78pc5q8FllxGIXMB/q7W0Jmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244222; c=relaxed/simple;
	bh=LTsqdft1dPcv0xHP6p0o7VD6AxpWCX4fuSvJY4j9o+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVxa97Fq9wgoc5ZpdYUJbL9/u00LhBt8HC74iQxhUSPYbIVnZJ/90A/YX8plwiaFuqP7AUb//01x2acEZPRx1ZKxHuLQ7DorAoi8c0Docz6CyG7eK0G0IvtFMIQ0Gc0qbpdWjZP9J6Dd1kA3WohsqCITbNHz0z6vDIfAz++dowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TnH6AdTQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u++tDink; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733244218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hRl2vndQY+cEadOVbdMCgzj5162VGAvi0uAXVn0fM8=;
	b=TnH6AdTQNUk66+aJZ3tCzIMTdAirn/b6inUMFWNvRG7X2CN7eLmmE0jDwQjeoRSGZvy51A
	GXEc1w9kFkqoNrG/wb6Wmi1qj3ufWOb/SU4m9+m+gHaNx7Xpz5DACPvWY+KDvnVAVVvwOl
	KR7BMtbEQuFDc2xuut0l6aQg3erFnaSz68DGwq1M73i5KHFyMWELOvr7J6l1Zv4nuq+XtJ
	xee+LMyVrjMvFNV/fK6qz8+bi4hLBnUsounHRVQGV9xvdQGSN+9DoEHVfTztUluF4Wnw42
	Vg4+G3DNArUE2rs+4539DLLwGJlaokKZPKjfNQu8+O3X1qhWBkD+q1BxxUk9iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733244218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hRl2vndQY+cEadOVbdMCgzj5162VGAvi0uAXVn0fM8=;
	b=u++tDinkaLpDMb532QuRHwaT5xQsLd5Ldr6axlVz5SZfU4y4sBX3l+c+cv/rldWYS6lP8O
	Z3eOamhD82+MRxAA==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 04/11] futex: Hash only the address for private futexes.
Date: Tue,  3 Dec 2024 17:42:12 +0100
Message-ID: <20241203164335.1125381-5-bigeasy@linutronix.de>
In-Reply-To: <20241203164335.1125381-1-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

futex_hash() passes the whole futex_key to jhash2. The first two member
are passed as the first argument and the offset as the "initial value".

For private futexes, the mm-part is always the same and it is used only
within the process. By excluding the mm part from the hash, we reduce
the length passed to jhash2 from 4 (16 / 4) to 2 (8 / 2). This avoids
the __jhash_mix() part of jhash.

The resulting code is smaller and based on testing this variant performs
as good as the original or slightly better.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index fbfe1f1e94505..14251bbafaffb 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -134,8 +134,8 @@ struct futex_hash_bucket *futex_hash(union futex_key *k=
ey)
 	if (fhb && futex_key_is_private(key)) {
 		u32 hash_mask =3D current->mm->futex_hash_mask;
=20
-		hash =3D jhash2((u32 *)key,
-			      offsetof(typeof(*key), both.offset) / 4,
+		hash =3D jhash2((void *)&key->private.address,
+			      sizeof(key->private.address) / 4,
 			      key->both.offset);
 		return &fhb[hash & hash_mask];
 	}
--=20
2.45.2


