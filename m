Return-Path: <linux-kernel+bounces-175325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEFE8C1E14
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168A51C213B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F86115EFB7;
	Fri, 10 May 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pJH6m5nr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Lo9Nf1I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2431527B2
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322535; cv=none; b=g6T9LPT0HOZ4cz3e1diAY3ZzD/ebOXNVKtq33NyjV06oNncMQVJ8mh6TbhG3apgDy8FVLMjib0YBg6AjPm5Yy6AfrKqJyGgsagAlV/wlbM2/lE33NNLxrF1wpiXsQzyBqJL7NJK3r5vJ2dPc7K5I7kFd4G/5OypSg3j7f7eCIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322535; c=relaxed/simple;
	bh=jpWzwYfxDhgX9lTfHrYOKEauu3510cZvHENSGgR/BGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=psRebgazij0xww237yhiMC8tdmVpYQONr68Ko4ETcNQHC+Ou3fpE/Xx/gNvYuKLvZrfYkgQM8dUiecPhM1HD1X4SnBAN34X1VHCSq0fGmJF2FNRGa0noEYIcZNuoVdcNbwcw0PnbAP+kBOpEixQP1zEcSz/a6N2U6kVJvudekzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pJH6m5nr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Lo9Nf1I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHH4si6HFtRU8b7XLsqZ3Kjry/eLFHCUpKXqXT+XYYE=;
	b=pJH6m5nrkDt3+jD3PIkIMz8VBpZ/9+k99dffmckcKtKwiuuaD+8TsfYWRZfXVAcQNG2nt5
	NlUFIBbQQWT8F6Zrx71jV7YqKNmTFF/+PUDWuecv/Viz5S5KWlM3+QE8vQOTtHPibmOZPS
	wLzc7GWC8GRQc3z3773AWuVSSsFE120Fk/Xm8A/7WgCmp+5kJlHayekS0/K4t2qDk5BCst
	+kNj3l8Dn1yE30RRbxhU8W/inDJj5FjgsJpLGBfhxo1g0dgzVXIn1h0N08S8DoVxncnR0g
	NpkkcsH1IHedk8aPfOnloFWRjlhKtUKYz59QFj0zzmRzztVuly1wtc9uf7URhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHH4si6HFtRU8b7XLsqZ3Kjry/eLFHCUpKXqXT+XYYE=;
	b=2Lo9Nf1Ifnp4bxdW9nkeaSAmtEmKy9Oi9r3EaIijAJh2luo9NqMhHCeyyYg22CUMqEjmY2
	mKXahnaTxjw4PoCA==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 4/7] riscv: drop the use of XIP_OFFSET in XIP_FIXUP_FLASH_OFFSET
Date: Fri, 10 May 2024 08:28:42 +0200
Message-Id: <a49044c3833e40546f35dd1f821a683e6f4dfc1f.1715286093.git.namcao@linutronix.de>
In-Reply-To: <cover.1715286093.git.namcao@linutronix.de>
References: <cover.1715286093.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XIP_OFFSET is the hard-coded offset of writable data section within the
kernel.

By hard-coding this value, the read-only section of the kernel (which is
placed before the writable data section) is restricted in size.

As a preparation to remove this hard-coded macro XIP_OFFSET entirely, stop
using XIP_OFFSET in XIP_FIXUP_FLASH_OFFSET. Instead, use __data_loc and
_sdata to do the same thing.

While at it, also add a description for XIP_FIXUP_FLASH_OFFSET.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/include/asm/xip_fixup.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/xip_fixup.h b/arch/riscv/include/asm/xip_fixup.h
index 9ed2cfae09e0..f3d56299bc22 100644
--- a/arch/riscv/include/asm/xip_fixup.h
+++ b/arch/riscv/include/asm/xip_fixup.h
@@ -24,13 +24,21 @@
 	sub \reg, \reg, t0
 .endm
 .macro XIP_FIXUP_FLASH_OFFSET reg
+	/* In linker script, at the transition from read-only section to
+	 * writable section, the VMA is increased while LMA remains the same.
+	 * (See in linker script how _sdata, __data_loc and LOAD_OFFSET is
+	 * changed)
+	 *
+	 * Consequently, early during boot before MMU is up, the generated code
+	 * reads the "writable" section at wrong addresses, because VMA is used
+	 * by compiler to generate code, but the data is located in Flash using
+	 * LMA.
+	 */
+	la t0, _sdata
+	sub \reg, \reg, t0
 	la t0, __data_loc
-	REG_L t1, _xip_phys_offset
-	sub \reg, \reg, t1
 	add \reg, \reg, t0
 .endm
-
-_xip_phys_offset: .dword CONFIG_XIP_PHYS_ADDR + XIP_OFFSET
 #else
 .macro XIP_FIXUP_OFFSET reg
 .endm
-- 
2.39.2


