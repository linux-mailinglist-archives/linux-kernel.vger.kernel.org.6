Return-Path: <linux-kernel+bounces-564692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A28A65969
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C713B1230
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5061F5847;
	Mon, 17 Mar 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZzH3cY2W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IakDE8ek"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C8E1F4706
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230396; cv=none; b=MBYpqE/baWGsi+CCfnZQ2TyoawxUTc6AVJC+tMlmcUsRmu1y2XhT7s/Qd6UGZrfuu6yS6EYmgeTJlb/8z45tAfi6cvZp6uai3h3PCuDgPEYuGR2Q6cEhkQl3MWVPiu3guPT7T2iIErpyGi6zHXPx4rA5Z4qRQ4sDGXrBe/MYKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230396; c=relaxed/simple;
	bh=wEw51A1Z/Kflsa07gSPSJJT92gdgpGM02PW8kbXEZCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlY5vG8m5LqN64/TrcCe8HJOe0TTrNcMsBR02i9vegCHglWeGIDmGnXofFPkH+CtGkB8qeQgxkopHz4ehRM4og5FKYl+gNYo/ab3sXZa7gp6SBJ/nat6ySvUTEoS0CvzPkXhtvxsmrR7W7Gfpj/8SmR1qffwOLi3rt1IL7EHhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZzH3cY2W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IakDE8ek; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIM1/UO/olTqtQhk58W5MQceA/7wLYg5WiO97m4eSsc=;
	b=ZzH3cY2WxjJVEH3PujvYdgpQQhJygKMrHR2FkiPLEdA+A9Vhw8b11DacYz/m2z07qmMgFE
	boTJdOrleNntOx7uGBoMb/qxrbr/mAZcAwSBn5w5iCg43W2mQYBQYaz0pCLj7h0EHY5knq
	YAqjOyO++5HWZYNJQPq6g5yxDm2Y//iuflwGylrCe20SXdmcPZazHJRLDm0kRY8F1P3d81
	U6uqto3omlzzpbWfZPSazoa0/3F1SU5CzikSuhIgezpDh97OaGyC3uJaoY3mkxb1pWWQUL
	e7q0+Dc7lKbPOEC+JAI76X3Lw9D8bnt7qx02sAxSX6mpzE0X4gcfsoGEy88a3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIM1/UO/olTqtQhk58W5MQceA/7wLYg5WiO97m4eSsc=;
	b=IakDE8ekS5JRg0DgViI//USsZLVJN9iw/OyjuQA2anoUAI2j0VVBN9JNfGxvWY+ngWG1F7
	89N7oF3WOuo2lPAw==
To: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 14/29] x86/cacheinfo: Use sysfs_emit() for sysfs attributes show()
Date: Mon, 17 Mar 2025 17:47:30 +0100
Message-ID: <20250317164745.4754-15-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
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


