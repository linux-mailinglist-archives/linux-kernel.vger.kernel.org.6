Return-Path: <linux-kernel+bounces-256433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948F934E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30CFB22B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78314290E;
	Thu, 18 Jul 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1thGcdOs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hMmbL945"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1801422BC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310497; cv=none; b=PdhBjlCoe2tUivgYsgPMAyzGtUZ/D+hPHpNRrtme6nmQvi7eaomusGmGiD78S07HJmkJMWtrCCsjXJaKxqoFAe5zAZpQzKLEl8iA3bzzNsZcmOnb1tqi19GvZ75UcC/Visnbac7iUlsD+bhAgp7yHzCeeC1Xhs9lxMqsoOgU+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310497; c=relaxed/simple;
	bh=ieb26+HvROHpjrBlsfNQn3VahOfpbPTOekx+lC0dgHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFYHdXtvGn7YEd09flKLGY3kboMd+PSoFiDQpcgCMjLScdrMLpK5YNagi/wA5OnyAlrO3rKsTnubGgW//Lt/kKPw5Y+AwMOKmcoS4tfjqxCpV/HamzjbvkRS+nVp3umY68wobWko5ps6GbMMVVgWzXqBREu43mW184tcMQbbdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1thGcdOs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hMmbL945; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721310494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oagI1ZvAvl/8BfIhwHwIeoOuLdM4WCcZAE/REEIdwdg=;
	b=1thGcdOs/VdvYeBwwq7xCa23ulBmKB3rh6P33jrHMIAobUQ8escmcOg45+jP1nqNfFB/4t
	RdN615Vmfcp/MrSfCcHNpWTnY6sI2kTZqMVrzJeOQ9/Z2ATqXA1wyWxyTEPsMmfq6LQH9l
	1jhARy+xF+g9JClmpeQJgdfVUlMvjHVT4xlersVhar7mf2m0OkkhjOewAZyzdcxgw0OnMf
	4birSjtFXiMjX4L69+X6SL4HO+dyQVVS2ciLITLPhBrSQilv0oENmrh2vFc22S8uduHdPu
	2cL21cvX556HDouF0vkYyj3TPo+3fYUwWpc6rf9Cg2iWBi4i7GakDgITPwuI7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721310494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oagI1ZvAvl/8BfIhwHwIeoOuLdM4WCcZAE/REEIdwdg=;
	b=hMmbL945sOxTmDcKXCKZjdxURyhCUbtJbLaHD4W2UhhTiI5EupPsllcNkeHgKosUB0WhmW
	VbUVp96d3WEb7gCA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 3/9] tools/x86/kcpuid: Set max possible subleaves count to 64
Date: Thu, 18 Jul 2024 15:47:43 +0200
Message-ID: <20240718134755.378115-4-darwi@linutronix.de>
In-Reply-To: <20240718134755.378115-1-darwi@linutronix.de>
References: <ZpkckA2SHa1r3Bor@lx-t490>
 <20240718134755.378115-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuid.csv will be extended in further commits with all-publicly-known
CPUID leaves and bitfields.  One of the new leaves is 0xd for extended
CPU state enumeration.  Depending on XCR0 dword bits, it can export up to
64 subleaves.

Set kcpuid.c MAX_SUBLEAF_NUM to 64.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 08f64d9ecb40..a87cddc19554 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -203,7 +203,7 @@ static void raw_dump_range(struct cpuid_range *range)
 	}
 }
 
-#define MAX_SUBLEAF_NUM		32
+#define MAX_SUBLEAF_NUM		64
 struct cpuid_range *setup_cpuid_range(u32 input_eax)
 {
 	u32 max_func, idx_func;
-- 
2.45.2


