Return-Path: <linux-kernel+bounces-236472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB4B91E2BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A520286C92
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B316C86B;
	Mon,  1 Jul 2024 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gbErqakn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fr+NpGOn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13216B750
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845298; cv=none; b=HVKTJ1YOPElkR7woyZ9Dwg2AJmLPWVWzDQ237GBT+WoaHpENkRs8r65DLyjxMp2YPspSBs7M6p1JP/Lfwa6zuOYNb9zluKpbX5KW8v8tq5tlbDi9bpMXmpeo6RSD2+UrGR7s36BlsUSxH8ah7lAwuMLHEUIMUOyS8i3Xsb620N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845298; c=relaxed/simple;
	bh=KMdlSbyb4NsNI3rTiPG8oevCTZZnhbc+Qzk1ZrF8c5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xmv/v3npEyl6eigOIjm0VKc4BM8rlwk8ek7XIymzqwXgPN0yTCjgc8JHDo/ha0Z235IC8F9LzEfyE/u9CdJwWZQEttw5HyfNWMv1Su9u8x50YyoxEUVd5cHAJ+Cuhg1JS/dYcibGZAryj5xs49pRr0BzgKJD7GzuHWx9pHTIlas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gbErqakn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fr+NpGOn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719845291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkCuPWfmz0qjDDzuugfXpfeVLTD6IIY8TxeqYLTW/y8=;
	b=gbErqaknThVvaNjZvsj7OM47AWDkC7d2WlM3TRDP/vxN+magmuWTTkbsVMx6uXL73pzWYZ
	wraMC1Wsz5nrUTq9trvH2CXhvYF1PeW0/rqL1PV/wYXcckqNUzFWzhSN2NCc+wU1mfTqBy
	zNzqZ2KCo+FeOL+jESfRnKwgk3fAkuSpwn7KhnPHxvn6SY8auoNk4HYNrVHsSLbpXYCP1A
	nERrsaY23CIalsrUN2gP4EnkLRdsQXc4GOMC9bdICCkk/Yi0yMRbkHqVM2r4JgGOobnB5z
	5dCLECmGHPtiULfSSaM69IK9Z4rpwcdKzLmY32Nq2u++q0wGCnD7cyrWeBgEdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719845291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkCuPWfmz0qjDDzuugfXpfeVLTD6IIY8TxeqYLTW/y8=;
	b=fr+NpGOn+XuIqJCQumAaEnA45kxcXRrvvbBgUKpK49YHyFTRtWBKBnAcF+k9bNxl5uI1F+
	iLyORSO3PZMOWhCw==
Date: Mon, 01 Jul 2024 16:47:56 +0200
Subject: [PATCH 3/5] x86/vdso: Fix function reference in comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-vdso-cleanup-v1-3-36eb64e7ece2@linutronix.de>
References: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
In-Reply-To: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

Replace the reference to the non-existent function arch_vdso_cycles_valid()
by the proper function arch_vdso_cycles_ok().

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 arch/x86/include/asm/vdso/gettimeofday.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 0ef36190abe6..b2d2df026f6e 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -328,9 +328,8 @@ static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles,
 	 * due to unsigned comparison.
 	 *
 	 * Due to the MSB/Sign-bit being used as invalid marker (see
-	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX,
-	 * but that case is also unlikely and will also take the unlikely path
-	 * here.
+	 * arch_vdso_cycles_ok() above), the effective mask is S64_MAX, but that
+	 * case is also unlikely and will also take the unlikely path here.
 	 */
 	if (unlikely(delta > vd->max_cycles)) {
 		/*

-- 
2.39.2


