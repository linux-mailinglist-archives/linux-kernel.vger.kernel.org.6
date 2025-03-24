Return-Path: <linux-kernel+bounces-573743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB72DA6DBB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93B83A9334
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FF22620CA;
	Mon, 24 Mar 2025 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iodmci6j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y+zbpVoo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D6B2620C0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823258; cv=none; b=SoqYDFFrkClR+v23fEtpcgVSTGszvK6YshN+XHAA1xfK5oNChVrGWk9WUtmokXu7S7KKFoztjdvI2mBGKDNpoGv3HFDaq5pU7geV82YbozlxCom6xqULwKhCPpmlN/gXb2guOPEFrxYFZ0dzitdn+bf2bm7JL8WkUD9OFheIBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823258; c=relaxed/simple;
	bh=wEw51A1Z/Kflsa07gSPSJJT92gdgpGM02PW8kbXEZCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9/qXq0fTaaMuWNr9VD9yZwGKclg3PLlqzV4nEKUX4YefL8axznkU4pdkUIfYW7CepQoLUoqqCXVExJIqbpJ55q1rFC2fsjo7lVEqo3xSNaQ90/bQWq6B3Hdw0LG32/2UdcZ3NLNN0k/7PAD+1fTtaXzYZJ4J7Ry5zdPcTHy+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iodmci6j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y+zbpVoo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742823253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIM1/UO/olTqtQhk58W5MQceA/7wLYg5WiO97m4eSsc=;
	b=Iodmci6jVXo4y1R7i82PzWX+5Yhq3xRmUKjc8Pj+k81u6LljfExesn6YjhHU8SbanHIWIf
	gbhO+qCu/UUz2QRv/UANxr+sBKp3kR+1TmzOU6f1M0K39G+a/b1Q33xbdBgDDY/SpdD4g+
	24EW6iEM87zFU8Yb6YlG9mIYXL21ALLmFEe3UiUac4vYzj8KekbRhyUYlt1T52t8pMf+Ow
	LMGRIBmdqM+a+fwtYyE0kEddY1FOZt5dIX3NXqCBhpVUhmmMNJzssl3V1G++X6+PlRG8UB
	239hzGdIOCzcHmir0mxpqq0+nA+1g2cSBHIgEsj4P2tbC1mgss4XVESGv/gfgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742823253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIM1/UO/olTqtQhk58W5MQceA/7wLYg5WiO97m4eSsc=;
	b=Y+zbpVooOk5oxehUpv9EURrmkNQ5g5prG/+JgKM1oRsBeeiIx5UjTVvXBxY+0ieQmaEQs+
	TlL1zSx5pXKkEOAg==
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
Subject: [PATCH v4 14/29] x86/cacheinfo: Use sysfs_emit() for sysfs attributes show()
Date: Mon, 24 Mar 2025 14:33:09 +0100
Message-ID: <20250324133324.23458-15-darwi@linutronix.de>
In-Reply-To: <20250324133324.23458-1-darwi@linutronix.de>
References: <20250324133324.23458-1-darwi@linutronix.de>
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


