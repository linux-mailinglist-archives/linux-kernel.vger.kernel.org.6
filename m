Return-Path: <linux-kernel+bounces-543568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAC6A4D715
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB923B0519
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4220101E;
	Tue,  4 Mar 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lPip/Dkm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NGDaIqpQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76148200BAA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078409; cv=none; b=t+oUkWULHV9r4Yd0Ap0MoXGcIG3SaHKSvN7+uysXYC3VZeoHVUEHLbjy3IwKMOMVWbUHw5nH/0Tp1Wx5S+LzsQ1q3Ow3gK4PjAHM7awoEmXIHvTc94GRq51diw5XXMBWzGHqBqCqoDO/k7kbacyNhZ04b3TQL+/gFgwc0h1K69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078409; c=relaxed/simple;
	bh=wEw51A1Z/Kflsa07gSPSJJT92gdgpGM02PW8kbXEZCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0QGgibqJq5QkpixhSCS74TfVjLpfJkd9669M5teZKT5NCcsakSs8ySF2Cz+LGFfqrggpFkRPaARkrvz2UNlnVv3/1KIuS/GeCvAwlhRieCIY1H08TquazpMphrBHJhsTmCP+l88PFiwdh2OWvWIFiq6QYGEu6PF8rV5UxijnIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lPip/Dkm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NGDaIqpQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIM1/UO/olTqtQhk58W5MQceA/7wLYg5WiO97m4eSsc=;
	b=lPip/DkmB/92v94JErAiQC8uoeqSeACnN0hnnmFf/NjeSvpyu3JqGZLRP6IZnqrk+9vmu8
	3YrsWd2YHkEzmbPzzxTiWjPR04qWXYz2rIYLjWogwjcPrqfRUboM7ne5qOZpd8/cwMFHuw
	q8OX9UMAJAH6xxhKuJA82cZ1L8WBPbLZU/f2lmo7pY75KyIo7XDHpXp5BbYOWYWczMqmQT
	HA5SoKjZoUR0uFWcGz95grWMyunQKUkXNsqBKcHmJyZSzwPn6APIcDNZjZBXhMpblJZnYg
	KbqcG1vIn5eV2z/fTiQsWKJ+9UC4dpmMgVxuKXIVkMi3FvyUsZvoVH/UFQoPNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIM1/UO/olTqtQhk58W5MQceA/7wLYg5WiO97m4eSsc=;
	b=NGDaIqpQoulPol6XwoMZ+RfcrywgcdCTrVTSr31eYie65gsHTkoc6CpPulQqLJn0h1IEyL
	p+H239vMB5hS0oDQ==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 24/40] x86/cacheinfo: Use sysfs_emit() for sysfs attributes show()
Date: Tue,  4 Mar 2025 09:51:35 +0100
Message-ID: <20250304085152.51092-25-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per Documentation/filesystems/sysfs.rst, a sysfs attribute's show()
method should only use sysfs_emit() or sysfs_emit_at() when returning
values to user space.

Use sysfs_emit() for the AMD L3 cache sysfs attributes cache_disable_0,
cache_disable_1, and subcaches.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/amd_cache_disable.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd_cache_disable.c b/arch/x86/kernel/cpu/amd_cache_disable.c
index 6d53aee0d869..d860ad3f8a5a 100644
--- a/arch/x86/kernel/cpu/amd_cache_disable.c
+++ b/arch/x86/kernel/cpu/amd_cache_disable.c
@@ -66,9 +66,9 @@ static ssize_t show_cache_disable(struct cacheinfo *ci, char *buf, unsigned int
 
 	index = amd_get_l3_disable_slot(nb, slot);
 	if (index >= 0)
-		return sprintf(buf, "%d\n", index);
+		return sysfs_emit(buf, "%d\n", index);
 
-	return sprintf(buf, "FREE\n");
+	return sysfs_emit(buf, "FREE\n");
 }
 
 #define SHOW_CACHE_DISABLE(slot)					\
@@ -189,7 +189,7 @@ static ssize_t subcaches_show(struct device *dev, struct device_attribute *attr,
 	struct cacheinfo *ci = dev_get_drvdata(dev);
 	int cpu = cpumask_first(&ci->shared_cpu_map);
 
-	return sprintf(buf, "%x\n", amd_get_subcaches(cpu));
+	return sysfs_emit(buf, "%x\n", amd_get_subcaches(cpu));
 }
 
 static ssize_t subcaches_store(struct device *dev,
-- 
2.48.1


