Return-Path: <linux-kernel+bounces-183843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3D68C9ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FD71F21E03
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBB9136669;
	Mon, 20 May 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="jywbwGaz"
Received: from smtp-out.freemail.hu (fmfe14.freemail.hu [46.107.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057C535A6
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215578; cv=none; b=EJw0QBTOltx6tc1F6EqKYfyWWE6MpL11i7NmwDSZeX4noysPgIeZRi3q2J+IM6JN+CmOcFyECtx3SELfo6KuNMLwjMXPruxkpEyTxg0Zd6m/KZRsbACEv8jFfZ8h2kAkqAE64qI/yKB3Lq+lBmPwfz0acNHgv7gu77FyRx5BErk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215578; c=relaxed/simple;
	bh=wPkibPmvLKHWRqzFuD+KhOX8e2sjpkOkOk4aotVoSrA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lyTFX82Cxwntwip8N26PyeaRKkPfph6Twhq2EY25ZSnj/SoNYZGDPC9iVqERZmfNdPCwJUnkxPc4FjY8llF9+5R5C2OUvAmnYkb6RNSSgxd4u9Hx2tyVIEfzu1Ig1c0rHuQbNh3YttbKuz7YHmtumQ+9AYryc6hguR3jaEdy4WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=jywbwGaz reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from fizweb.elte.hu (fizweb.elte.hu [157.181.183.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4Vjfyr65TbzgX;
	Mon, 20 May 2024 16:27:00 +0200 (CEST)
From: egyszeregy@freemail.hu
To: vgupta@kernel.org,
	pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] arc: rename aux.h to arc_aux.h
Date: Mon, 20 May 2024 16:26:47 +0200
Message-Id: <20240520142647.70440-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1716215221;
	s=20181004; d=freemail.hu;
	h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
	l=2297; bh=9zxQy+6Bi08HDP4ghvGzDmmjLAAoSIfkUlTLTmqf+Co=;
	b=jywbwGazbNSiU9j+vnzoACV6BWbm+X2x9aOKn7BlgwjvH+L8nqey9n4Z3/tawXgn
	pVEOD68I+yV2XbEsrsf8UuJSUJZrxw0HSmRxuyaVRwSIUiLhj5za7RcfKzk4/zsx03t
	QZryEzN6imZJHOsuQojp0UvqNQahaHGvqDakQttFB54+5WhXWeokk0QyosZwtQmSOAX
	wqo/BYhp69Ss9vY/gVgqn9GuxeCKQ7bgNwdMeh/1+HppRwUxcLoFraP7v40G1u91hKJ
	wTCPP8uYFcm/lI3mNfIwyce8YRshhgol4HIDO3OvLIbLvWNaEFDC4OiHfST2jzjrLRj
	a9SjFVOMhA==

From: Benjamin Szőke <egyszeregy@freemail.hu>

The goal is to clean-up Linux repository from AUX file names, because
the use of such file names is prohibited on other operating systems
such as Windows, so the Linux repository cannot be cloned and
edited on them.

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 arch/arc/include/asm/arcregs.h       | 2 +-
 arch/arc/include/asm/mmu-arcv2.h     | 2 +-
 include/soc/arc/{aux.h => arc_aux.h} | 0
 include/soc/arc/mcip.h               | 2 +-
 include/soc/arc/timers.h             | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename include/soc/arc/{aux.h => arc_aux.h} (100%)

diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index 4b13f60fe7ca..005d9e4d187a 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -146,7 +146,7 @@
 
 #ifndef __ASSEMBLY__
 
-#include <soc/arc/aux.h>
+#include <soc/arc/arc_aux.h>
 
 /* Helpers */
 #define TO_KB(bytes)		((bytes) >> 10)
diff --git a/arch/arc/include/asm/mmu-arcv2.h b/arch/arc/include/asm/mmu-arcv2.h
index d85dc0721907..41412642f279 100644
--- a/arch/arc/include/asm/mmu-arcv2.h
+++ b/arch/arc/include/asm/mmu-arcv2.h
@@ -9,7 +9,7 @@
 #ifndef _ASM_ARC_MMU_ARCV2_H
 #define _ASM_ARC_MMU_ARCV2_H
 
-#include <soc/arc/aux.h>
+#include <soc/arc/arc_aux.h>
 
 /*
  * TLB Management regs
diff --git a/include/soc/arc/aux.h b/include/soc/arc/arc_aux.h
similarity index 100%
rename from include/soc/arc/aux.h
rename to include/soc/arc/arc_aux.h
diff --git a/include/soc/arc/mcip.h b/include/soc/arc/mcip.h
index d1a93c73f006..a78dacd149f1 100644
--- a/include/soc/arc/mcip.h
+++ b/include/soc/arc/mcip.h
@@ -8,7 +8,7 @@
 #ifndef __SOC_ARC_MCIP_H
 #define __SOC_ARC_MCIP_H
 
-#include <soc/arc/aux.h>
+#include <soc/arc/arc_aux.h>
 
 #define ARC_REG_MCIP_BCR	0x0d0
 #define ARC_REG_MCIP_IDU_BCR	0x0D5
diff --git a/include/soc/arc/timers.h b/include/soc/arc/timers.h
index ae99d3e855f1..51a74166296c 100644
--- a/include/soc/arc/timers.h
+++ b/include/soc/arc/timers.h
@@ -6,7 +6,7 @@
 #ifndef __SOC_ARC_TIMERS_H
 #define __SOC_ARC_TIMERS_H
 
-#include <soc/arc/aux.h>
+#include <soc/arc/arc_aux.h>
 
 /* Timer related Aux registers */
 #define ARC_REG_TIMER0_LIMIT	0x23	/* timer 0 limit */
-- 
2.39.3


