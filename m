Return-Path: <linuxppc-dev+bounces-6707-lists+linuxppc-dev=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linuxppc-dev@lfdr.de
Delivered-To: lists+linuxppc-dev@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253A7A4E849
	for <lists+linuxppc-dev@lfdr.de>; Tue,  4 Mar 2025 18:18:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6j7J5d2Lz3bpx;
	Wed,  5 Mar 2025 04:18:04 +1100 (AEDT)
X-Original-To: linuxppc-dev@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=160.75.25.115
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741108684;
	cv=fail; b=HN9c+vAIqGq9T8+/A/jWjsWke16wHycEECQ/PTcAjOhfXxzNRcJ97gUCaYbCK+bV6eEtryYS9qZ0Oe5gltYRPbsHggxUnYd7otwSGrrt+zBPOd2YooJX92cLweBf6+smjemJJE30+DTOloRMeIiUpfJHsjFcAhc1pUANgGm0DhhMYjmuLRudhWUYVevpixcE9eVTlPhm0nET1P4WOKTGowCdk8Q1HGGgjY43T+vinFDtH8qLmF4HlDEsnlieRGoxKyfuTNtT+HRB7HAHsIMqSAiTunFlhNlQ3bBYQOnefHTW+b9ZSiBcYTq4/gpUSgUu6IXp4FyoxCVdwfcmzW15RQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741108684; c=relaxed/relaxed;
	bh=cFcK8uwOx3LoD1OaqkpKgKU80DUXPeMK97IAER5MOGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hJgWfq1Dw6ycsV7TODkWMAYyDSPrUrx02AZaAgzeSLZYyhZxIbQ26FCErhN+pHnDYdy5s9d4cD21ixyU93SiSZEgMwYAFqChcLMY/ahXnE9epx0Tph0Axzdn2DtPdXfEYAk+8yc5cdlVnFQguNqzZ9hi5uDQQ3ZzkdPspTEC6V3NiL3QgHp2r6q/Nn3zIC2qZk5wv1VMOKxWz9l43ZjEvQ84EKeXfxOe3l137RNW8J3QMc9EN0G+WoC2Z+Rz8pGXoPZcVGjyNjMljMmK2Fn96+kuqloOb2T2HcFgcgQivLLBtIuCxm77rWo57jBFmrZfXzosVj2CIFyi5+VurMI4mw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=linutronix.de; dkim=fail (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wLmUqqTw reason="signature verification failed"; dkim=fail header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FEFBlftn reason="signature verification failed"; dkim-atps=neutral; spf=none (client-ip=160.75.25.115; helo=beeline1.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org) smtp.mailfrom=cc.itu.edu.tr
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wLmUqqTw;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FEFBlftn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=cc.itu.edu.tr (client-ip=160.75.25.115; helo=beeline1.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org)
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6j7H6gyHz3bpL
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2025 04:18:03 +1100 (AEDT)
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id A719940CFB67
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2025 20:17:31 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dZy3y0RzFx5d
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2025 17:38:18 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 349D642722; Tue,  4 Mar 2025 17:38:05 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wLmUqqTw;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FEFBlftn
X-Envelope-From: <linux-kernel+bounces-541525-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wLmUqqTw;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FEFBlftn
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 2495341BE6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:17:51 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id CE2A0305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:17:50 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0393A172B9F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F981F7575;
	Mon,  3 Mar 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wLmUqqTw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FEFBlftn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637D137C37;
	Mon,  3 Mar 2025 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000272; cv=none; b=JVp2zHqfz2DIoueXS1gizTjSygzhGA2x4PjuEj816YAsd1XwSgWLFZ91FiemYGW0vIjxt0WKjYqfO+194IZ66ztdaaWZc0ek8G7jpaVwHh0bRDZoJ2mDjUvdbSq7wIbLm25rtkvVKVEwRa583RIjfx14cJUeDGqiE5FuMyjiOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000272; c=relaxed/simple;
	bh=JRTZEJBPOrhvUumVmufXGEQ++pbOss4FsXl+ME7xP/I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pk+LQWCpFgYtEMBIi2QvEFq2CmQrXVC5cUHBka2MSZNLkwN4ZrRf35cTAxNSD8cU4xqpltNruw18YKkjAgDDLsXmQ5onN3XRWUuxFSmU71VivMyrz0WhcxXG48T0PrH7WGj6eNM8++dEFU5OQ/YdPFv2tf+XLVHPwQCOx3jVZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wLmUqqTw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FEFBlftn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IQ622J09wSnJWNXssDApHCSJm6KRM8/tA7lFNZ5FTck=;
	b=wLmUqqTwTEyy8MN+fvUkhrzIqy6uOM6lVHR4jNdAeed/O8S0iqujK3aI4lGi+I3tqudxPw
	s2kIvGZ/MXyYVsQ2TqmdwnG18vmfKYSXzOhf5Aw9fndCMClBY7UvTjVWEXtE3xS5f7RqVn
	PQf7QcpBStHo1rBnCeWDhILSYYwI7qMGPTS0RviAt1Oy2cNEs180RPDVdtyda8W1ns7Iy9
	F6Vnmc2BDvBIXsbn8MLerHwdRVwBXudM4h3rwx+UXEWi/LSPZEzXXnHpFdlZzAcnAwiUAP
	5Lj2VkmHFVjYjg3fvs/gqFY0Ct2mskGOlUZKpYaitXChC2S6wwZYvOmvbnkzNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IQ622J09wSnJWNXssDApHCSJm6KRM8/tA7lFNZ5FTck=;
	b=FEFBlftntzm1vKKKD24mat2WNu3kCRIaYgAe0BZIAp5Y/dJrf3bIDUHH00UOGa0SCDwvKB
	I30YLz81uY0Z1kDA==
Subject: [PATCH 00/19] vdso: Rework struct vdso_time_data and introduce
 struct vdso_clock
Date: Mon, 03 Mar 2025 12:11:02 +0100
Message-Id: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAEaOxWcC/03M0QrCIBTG8VcZ5zpDZdrWVe8Ru1h6bIeGhi5ZD
 N89GwRd/j/4fhskjIQJzs0GETMlCr6GODRgptHfkZGtDZJLxaVsWbYpMDMH82BOcMfFybS3jkM
 9PCM6WnfsOtSeKC0hvnc7i+/6Y9Q/kwXjrNMC+1GrUffqMpN/LTF4Wo8WYSilfAAsE0v1qAAAA
 A==
X-Change-ID: 20250224-vdso-clock-f10f017c4b80
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=2911;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JRTZEJBPOrhvUumVmufXGEQ++pbOss4FsXl+ME7xP/I=;
 b=1QrxVPPkzlKNesg8VwMiDXqZyZeYfZHfZ0peP4IrutVSqOiCMC4+/wyQO3rgzJ5xf+SxSKr84
 +t7EqeEhu9OAio50sRM6KyHRpohlV/LcxVaombILHk3/QzfOiPs5F4E
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dZy3y0RzFx5d
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713360.68141@25DRDUQIBlgl/KKfqxKHRA
X-ITU-MailScanner-SpamCheck: not spam
X-Spam-Status: No, score=-0.8 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be an array of it.

This series is based on and intended to be merged through tip/timers/vdso=

