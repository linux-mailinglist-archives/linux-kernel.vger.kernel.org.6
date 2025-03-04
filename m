Return-Path: <linux-kernel+bounces-543544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32007A4D6FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABD93A6E2B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4011FC119;
	Tue,  4 Mar 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ekKChPvA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IdU94Jse"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583051FCCE4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078343; cv=none; b=mMK04qBMXYnZRPhBOjM3cB/lcgIBj9aRYgiA5/An18Zm4aNM+A9aHsF2FD/K0f/ag601y7oVUolm0e9peASbsJO/aXgr2Qgy3zKRAXDtkT8IYyDKfQTnMc+YdLYww6ExN7ExQNbXAEs1b3et1QJwdgGdT5PQZ42KsmRWMhcNK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078343; c=relaxed/simple;
	bh=xoCoR4iPrwQyVQGckm5Vqfe5UKuVECUPdXQKBlWYyHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfREieV4iMIm5l0MRFByOs8suK68zRiw5uYfmC1gjTA54FPfe5bduSluwPv/BGbeFQr3pSoMcHHh2ywdWwxCsuzG7SwZRUco0R2un531Y0FKHZlA6ylCCC+mzXtzUzugNNE8mOIQqGsJG4M/NQWrhtEEkIx4yOyq9UJnaVqGGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ekKChPvA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IdU94Jse; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YtJrmgYZNvEEH6ObCih4a8AsX+g3T5HhHN+0iOuL38=;
	b=ekKChPvABa+AY28JUEM6KBebWYtYA3/0dWJWhIZVSAg/H4CoNobegnXz+Yaxg3LrHp+A0g
	+w8GbXoUe5oNd/gHIIVfBkfVeYgTrqUf2MNM4MYFX1hoC7GHQ+lFb/1z97Y0mZeItXeYLQ
	30GiWT/cYNduBbJkQ0m9xE7PY6Fyepez6vWc55eQtJJWBmr5B+kh9BjxQcsXCGTKT80yTN
	owWLs5yYVD4n31rNZ+u6oTBWwOjOg3RlB4+bzy7O5dcLtpkUXKUC0q62DKd5WjTLSJZc5o
	0WGNPsj3T989AgSALUxQe87nAkauVxD45Qv4RRCM/fJ/fHI/J4GvqYEgGWm8dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YtJrmgYZNvEEH6ObCih4a8AsX+g3T5HhHN+0iOuL38=;
	b=IdU94JseYg6XKF7DqvaQ5Xr1QsOoBG6k1eeq6vpEXmK41A9SMLrc5zRECc4rJN9h1tg5EC
	YtDYhVdT5rcCW8DQ==
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
Subject: [PATCH v1 02/40] x86/cpu: Validate cpuid leaf 0x2 EDX output
Date: Tue,  4 Mar 2025 09:51:13 +0100
Message-ID: <20250304085152.51092-3-darwi@linutronix.de>
In-Reply-To: <20250304085152.51092-1-darwi@linutronix.de>
References: <20250304085152.51092-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuid leaf 0x2 emits one-byte descriptors in its four output registers
EAX, EBX, ECX, and EDX.  For these descriptors to be valid, the most
significant bit (MSB) of each register must be clear.

Leaf 0x2 parsing at intel.c only validated the MSBs of EAX, EBX, and
ECX, but left EDX unchecked.

Validate EDX's most-significant bit as well.

Fixes: e0ba94f14f74 ("x86/tlb_info: get last level TLB entry number of CPU")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3dce22f00dc3..2a3716afee63 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -799,7 +799,7 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
 		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 		/* If bit 31 is set, this is an unknown format */
-		for (j = 0 ; j < 3 ; j++)
+		for (j = 0 ; j < 4 ; j++)
 			if (regs[j] & (1 << 31))
 				regs[j] = 0;
 
-- 
2.48.1


