Return-Path: <linuxppc-dev+bounces-6705-lists+linuxppc-dev=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linuxppc-dev@lfdr.de
Delivered-To: lists+linuxppc-dev@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEFAA4E71A
	for <lists+linuxppc-dev@lfdr.de>; Tue,  4 Mar 2025 17:57:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6hgQ2Xy7z3bp7;
	Wed,  5 Mar 2025 03:57:22 +1100 (AEDT)
X-Original-To: linuxppc-dev@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=160.75.25.116
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107442;
	cv=fail; b=mCHVdIZTJ4Hv5ftRxkUB2BVEtLU0GOfJJJ8ZPJPQ0TUrZ0EQ7+2N4F3ILM0bwHMF/hI9TR5MBmWBZckYvk+lUKS/yY6J4k+2Z/tVTXUPBAIBHCdI+QbwV9R8ksfznvslnp+qHMKYI6f7dwqKYdlqDOWvwB1q9IMq6yvWHQBupz8Z6kEIeIvdrAHrC8s/tfhsoJ6aC+ofLVBvUaFfnpg1sJUaASjMVEQlWRlJnUYTwX5fGsmL3iJaU7KMcNOPHlmLTcaaI7M5KiLe8qFFVpeJrGiEX+SFrlbOCa7rEGWOH8WxhZ4kxNtZ0ZgN7AUOLO40lhlUfsOpI3ag1dq6GBp/pw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107442; c=relaxed/relaxed;
	bh=U6BAzAiKouDBEHcO1F8UJQWyazpluDOjZyK79CO8PDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CkusZ1Ctk81wIJfeic7XKszepTWVJi75qvPsoEWE5YvVLcn+ZAw1wP59pent7DLIzM4KLzz2uU4xV2/wwhBK/l2IvdwHqmkyOLwzoiXGTroZnoiwBOdwR4f18C/iibnzzkA0Izw0mck7lIxsHFdAIgEy2covTmoNvDsaEivh+qtwV5MP4DNPjhBprRKWOFyd62kuy6Z9TsxbhdM6mgpzeW4N/EZvqnDavn7YePlJa8e25u387UHlwKLjLGvBvfvQRkEiS9Z2hS2fLY4FbwoJXVfevvSeaCSM0x+WHJEebHwoqyHdNqBph/hxAd9Ekjl13B65vHmALJwROASqZxXT6w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=linutronix.de; dkim=fail (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=U8h6FqKr reason="signature verification failed"; dkim=fail header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=tS2XBU9U reason="signature verification failed"; dkim-atps=neutral; spf=none (client-ip=160.75.25.116; helo=beeline2.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org) smtp.mailfrom=cc.itu.edu.tr
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=U8h6FqKr;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=tS2XBU9U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=cc.itu.edu.tr (client-ip=160.75.25.116; helo=beeline2.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org)
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hgP1Rcdz2yTy
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2025 03:57:20 +1100 (AEDT)
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 3F75940CECDB
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2025 19:56:48 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=U8h6FqKr;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=tS2XBU9U
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fCs5lc8zFyXB
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2025 18:06:49 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id C103242743; Tue,  4 Mar 2025 18:06:38 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U8h6FqKr;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tS2XBU9U
X-Envelope-From: <linux-kernel+bounces-541532-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U8h6FqKr;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tS2XBU9U
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 522CC420BC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:19:33 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 05A3B305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:19:32 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAE11685AC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C05F1F4618;
	Mon,  3 Mar 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U8h6FqKr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tS2XBU9U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706E1F461A;
	Mon,  3 Mar 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000276; cv=none; b=SR292Wpg4z/IYofOly4dBxN3Vn+8rODZxp7nPOMmg+mI6uFl94ECZpbex2kg6/iIhNCslKI41n4kAQLK10SULCOJk/1Zpd78/CD8nCdDanMq7vEdSLTJaJLtFpCay9C6nHhseC5KX1dmjpjo/19kILMcs/nik9EUyZxxJ+7QMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000276; c=relaxed/simple;
	bh=dfn7qP0Q31T2FoiNWzhAe9RxMKPrVC1jd/7ud8KMI80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZQgmfiVkcFhWB96g5CIt2CACz+RsYtWlsZFy27ZZUWUMOej/n5uKt6fyZu6P4dEg8LTCMRalTZV2MzZSngeRn//J1bhMZobTQbnkTbBvJyCh8IT7nfcvRFpLnZq85srAfUfYQkfHyYMLsQMHw5TYzLnzh8BG/sT8nEHU0iGtdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U8h6FqKr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tS2XBU9U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jG2bn98M7V4f+hOWi1NHgDCW5X40AnWZfEe8oDNZp3Y=;
	b=U8h6FqKr+M+oVHHmL+y3d5540HR+juwZWf8bEoV1jJlEMIqawkMEWU/iNUuzvRTkjmh+aI
	iNmQQrZU/vZCq7kuNuEA6LbVXexXpwJWG29/ET8W+vpy65AqesarXKq33MKdAo38NezJ8K
	laQ34Z4wxscjoXuoZaDQWQjQs1Y4N9L8MsaDJZWHQO2jvrKqf73cApG/RedcQcQV4MgGVP
	NCVDII535xaeQQxbikXlcy5maeQUovIyYF0yOjvL2BPGetO1lGRrOu02HF8lr9ua8zDHEk
	OvW3B/0DfjEWJUt31TCQ8nORZq86CAKfQD6EDsCDz1mCT76eC0YI4GpzoFTU6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jG2bn98M7V4f+hOWi1NHgDCW5X40AnWZfEe8oDNZp3Y=;
	b=tS2XBU9UfoHBU+e0pSmX9YE/vQIlfr9Y1Mqd3osc7/yyxfOn4vAeYE8q2gPW/4WtCWML8P
	/W7Y8y52Q97MoEAw==
Date: Mon, 03 Mar 2025 12:11:09 +0100
Subject: [PATCH 07/19] vdso/gettimeofday: Prepare do_hres() for
 introduction of struct vdso_clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20250303-vdso-clock-v1-7-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
In-Reply-To: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=4072;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=zltz3UBFxKKFej6pHHfCaU7dwefjLrlFKPgV+biXvzU=;
 b=0Wzsjfi+ab7PugcoS9LutaLWDTPWs3eh8GpYU1iA/VqEBa19aTOZQhdD0fr4DrT1eqnmu83Lv
 1Z9AaTUx8i/DW3/EXookZODwCkiMveFR1T613O4hgEbbRiN0SJpF9ho
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fCs5lc8zFyXB
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712135.17045@fWxSbfc2aBK0VtVEEa67xw
X-ITU-MailScanner-SpamCheck: not spam
X-Spam-Status: No, score=-0.8 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

Prepare for the rework of these structures by adding struct vdso_clock
pointer argument to do_hres(), and replace the struct vdso_time_data
pointer with the new pointer arugment whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 59369a4e9f25f937eb8d9aed3201ebd340097a9d..15611ab650232f2e847b7de80=
c7293c4fb7f84f2 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -139,10 +139,11 @@ static __always_inline int do_hres_timens(const str=
uct vdso_time_data *vdns, clo
 }
 #endif
=20
-static __always_inline int do_hres(const struct vdso_time_data *vd, cloc=
kid_t clk,
-				   struct __kernel_timespec *ts)
+static __always_inline
+int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc=
,
+	    clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct vdso_timestamp *vdso_ts =3D &vd->basetime[clk];
+	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clk];
 	u64 cycles, sec, ns;
 	u32 seq;
=20
@@ -154,31 +155,31 @@ static __always_inline int do_hres(const struct vds=
o_time_data *vd, clockid_t cl
 		/*
 		 * Open coded function vdso_read_begin() to handle
 		 * VDSO_CLOCKMODE_TIMENS. Time namespace enabled tasks have a
-		 * special VVAR page installed which has vd->seq set to 1 and
-		 * vd->clock_mode set to VDSO_CLOCKMODE_TIMENS. For non time
+		 * special VVAR page installed which has vc->seq set to 1 and
+		 * vc->clock_mode set to VDSO_CLOCKMODE_TIMENS. For non time
 		 * namespace affected tasks this does not affect performance
-		 * because if vd->seq is odd, i.e. a concurrent update is in
-		 * progress the extra check for vd->clock_mode is just a few
-		 * extra instructions while spin waiting for vd->seq to become
+		 * because if vc->seq is odd, i.e. a concurrent update is in
+		 * progress the extra check for vc->clock_mode is just a few
+		 * extra instructions while spin waiting for vc->seq to become
 		 * even again.
 		 */
-		while (unlikely((seq =3D READ_ONCE(vd->seq)) & 1)) {
+		while (unlikely((seq =3D READ_ONCE(vc->seq)) & 1)) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
-			    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
+			    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
 				return do_hres_timens(vd, clk, ts);
 			cpu_relax();
 		}
 		smp_rmb();
=20
-		if (unlikely(!vdso_clocksource_ok(vd)))
+		if (unlikely(!vdso_clocksource_ok(vc)))
 			return -1;
=20
-		cycles =3D __arch_get_hw_counter(vd->clock_mode, vd);
+		cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
-		ns =3D vdso_calc_ns(vd, cycles, vdso_ts->nsec);
+		ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
 		sec =3D vdso_ts->sec;
-	} while (unlikely(vdso_read_retry(vd, seq)));
+	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	/*
 	 * Do this outside the loop: a race inside the loop could result
@@ -278,7 +279,7 @@ __cvdso_clock_gettime_common(const struct vdso_time_d=
ata *vd, clockid_t clock,
 	else
 		return -1;
=20
-	return do_hres(vc, clock, ts);
+	return do_hres(vd, vc, clock, ts);
 }
=20
 static __maybe_unused int
@@ -334,7 +335,7 @@ __cvdso_gettimeofday_data(const struct vdso_time_data=
 *vd,
 	if (likely(tv !=3D NULL)) {
 		struct __kernel_timespec ts;
=20
-		if (do_hres(&vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
+		if (do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
 			return gettimeofday_fallback(tv, tz);
=20
 		tv->tv_sec =3D ts.tv_sec;

--=20
2.48.1



