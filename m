Return-Path: <linux-kernel+bounces-339236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07C9986193
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837D1288648
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EFC18BBB6;
	Wed, 25 Sep 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nWxD/yez";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DmMdUp7g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E18A18BB8B;
	Wed, 25 Sep 2024 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274371; cv=none; b=jtfRd7sQJPufePE0Y/7yUeMTMvxcwGkBKb+MOmbOuXSSctNAQGIGB6bsLZ/JPoOLA0ypZxhVY45HUILuk5sn5viNoLz2uqN0sbUu/7YTAsfXzb8miM99CCn6qDCDwkvaEJW0OGsKzpY7UlP6rnyrZlYL3JJRKpU2CNRyt0MM0to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274371; c=relaxed/simple;
	bh=vC/Rq8r3/8cKZyBF37iSUN4iBfXBtD8ewZqW61qZkZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XVjfBvThV3NBu3/AogU7aefppsn4/rXsYvdVJG4HaDMJvlMltEl7tqFqBilWR5rZ8IcnrUuj1NqzgsOtjftkLQzsTpsr7+nznuxm/TOFB/8B2wldIBhFkr2MT2fGRd5PQP0KhpmGWx7GCmaabgo3RYpejubrGnqJ4Y0ymt9F4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nWxD/yez; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DmMdUp7g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727274368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=py9zJhLKb6mfsbhyVeGc9zy4/v0ahaxaP57U7i4tzLk=;
	b=nWxD/yez0EBhgfgMJTePjaiFjF/SvuK6EDSugtPEnzo4ubEyw2uGIjjO6h5s4ZclQdvB9e
	WovUiQOlC1B2tDcoyRr0SK9tqRAhR/jv/xZNvnye2CQVTqJXGPYM4wzz4U7Y7J3+7F+z0y
	oYl1GN53GRmdVsr4+jqFMULsSfzibb+E90RGeyR/1HHna5144soGImnlNQMrEfayUc0t4l
	dUxmNfu2sxAkNKBIJvMm+6ljf2irnFU8d4L6R82Iv7JrjdVFoZmTZcMIQhgqxuNXRCDsGa
	4vqx/Q3BlNSNRygFwsNK2WXPXEdrrxaCXnQ0Jor4mKRAnkX9NMpY0o09bqPuzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727274368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=py9zJhLKb6mfsbhyVeGc9zy4/v0ahaxaP57U7i4tzLk=;
	b=DmMdUp7g3qZJeIzI+T2Jst17gcvXwcBOpoG9vWUjMH0+Q27U0V/M2dMRj+G5yWmknGViGC
	lbncjjJTZpWIAFDg==
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH] Documentation: riscv: Fix typo MIMPLID -> MIMPID
Date: Wed, 25 Sep 2024 16:25:32 +0200
Message-Id: <20240925142532.31808-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The macro that is really defined is RISCV_HWPROBE_KEY_MIMPID, not
RISCV_HWPROBE_KEY_MIMPLID (difference is the 'L').

Also, the riscv privileged specification names the register "mimpid", not
"mimplid".

Correct these typos.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
ask me how I found out..

 Documentation/arch/riscv/hwprobe.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/risc=
v/hwprobe.rst
index 85b709257918..fb0affa61eb9 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -51,7 +51,7 @@ The following keys are defined:
 * :c:macro:`RISCV_HWPROBE_KEY_MARCHID`: Contains the value of ``marchid``,=
 as
   defined by the RISC-V privileged architecture specification.
=20
-* :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid``,=
 as
+* :c:macro:`RISCV_HWPROBE_KEY_MIMPID`: Contains the value of ``mimpid``, as
   defined by the RISC-V privileged architecture specification.
=20
 * :c:macro:`RISCV_HWPROBE_KEY_BASE_BEHAVIOR`: A bitmask containing the base
--=20
2.39.2


