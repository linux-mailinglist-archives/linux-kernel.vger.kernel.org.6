Return-Path: <linux-kernel+bounces-567985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E5CA68CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1F17ABAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A18259C91;
	Wed, 19 Mar 2025 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1AqllIAc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L/4D+FMV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089832561BE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386950; cv=none; b=ilMnsHQfbGLUu0F6RN0QtAw8xT6+af1Z4OdCtFpb/9gliShtaGry+kDJ+VaCd0sK7z8+HVthjcGMLYJMsV+ud4zFXiOt9M9vjIFP/41nXpBuFfDHbAlEAjE362ph9aeqH69v7flW+Gj9pjWcBPzBHAg0xw74ziTdrGjtus73RrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386950; c=relaxed/simple;
	bh=wEw51A1Z/Kflsa07gSPSJJT92gdgpGM02PW8kbXEZCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YksMcjmeRpDjkklhPTzP8Um4BgkSeLVb1I2TMKsoMp2kvkZ6UPOs3RkppnMNp45E9G26Mz3VLi44Eb2cSeIXpNelYq6OYFP8ZweSMcOVU+EWLdSTqArvRvPUZkTuSSDjp5JxBLCr0MVVmShnW/hAkzzTcHROE1ig2vS+rnTgWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1AqllIAc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L/4D+FMV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIM1/UO/olTqtQhk58W5MQceA/7wLYg5WiO97m4eSsc=;
	b=1AqllIAcsCbesq3Wd/wJHiUQkqUbWtWRP90jFfFD4T2Ggt6G7PDtzdqEhnsOm8bnk4ABpU
	J2X+xYWSqwpTU22fPk3jqYxx8puo9cxZ1OO3/1wRwrOpzD+8LAaA8kjkDS/HCL5QxpqilV
	G3g7d+DfPvdxUGq+Y0JkCa2oODsRRyBHyrzOIM1E54g1f1O/rbsqcInbTpUJCiSULtVy3W
	l2Ua9xr6waVgmzLRvZtEQka29sUymH0olp7KtNl95lrYHXDooKmpoxQFFE9sWR0afFSmJN
	rwa5OW7WVubsF3nnJpIWgisCRdyo9PDiAT5Q9irjj01zANqdPTzlXZojES6SUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIM1/UO/olTqtQhk58W5MQceA/7wLYg5WiO97m4eSsc=;
	b=L/4D+FMV/qTZF1E7vlWMHcEmL9Uc4jAQXmVb3YRRY6ym0M3fOQkqksee0t7lCp/EiDt/0K
	al3E4xu2KWLEltAg==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v3 14/29] x86/cacheinfo: Use sysfs_emit() for sysfs attributes show()
Date: Wed, 19 Mar 2025 13:21:22 +0100
Message-ID: <20250319122137.4004-15-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
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


