Return-Path: <linux-kernel+bounces-177621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFD88C41B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA7C1C22F07
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060A015279D;
	Mon, 13 May 2024 13:21:06 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EFA59164
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606465; cv=none; b=NN6muK45NoYUEbcmtwNL6ktXoOzNEf2LjwR7ys2mDrT5+zwhlOSAnOzN6iWYCLpkPrrz4+1EWGFnB6DvqgIBioy/pEY6DYldIkOu0+dFr1Wnj+TpeeaHFMb+KvcAR73p1xFOh/RBqhQB4a/LFSY4imQT5mLanJ3oPg+3vqn0u70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606465; c=relaxed/simple;
	bh=RJCXdkLFskpSIxdK08El8C87yvPHTIuYVmWle4eyCy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n2BxtS1E3pwOdpeXh4elQiInbgQ4FUPi7CSjEd4unhI4tgMOcYxuBDxG/tD4AHJbszwSIQEQx+cpsR8qq7+DOrOxV7UBIJtlqju65qgow7LmnQPY8MqjvStHFCx8bRZzLidlG/csC9+8Y9HvUWcNZQIKt8Rp0UHcnHGD70dV/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c85e:4b6d:1f91:1410])
	by laurent.telenet-ops.be with bizsmtp
	id NdM02C0055V4kqY01dM0ZC; Mon, 13 May 2024 15:21:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Vb7-00399i-RK;
	Mon, 13 May 2024 15:21:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Vbv-008tqR-VC;
	Mon, 13 May 2024 15:20:59 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] sh: of-generic: Add missing #include <asm/clock.h>
Date: Mon, 13 May 2024 15:20:53 +0200
Message-Id: <942621553ed82e3331e2e91485b643892d2d08bc.1715606232.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715606232.git.geert+renesas@glider.be>
References: <cover.1715606232.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/sh/boards/of-generic.c:146:20: warning: no previous prototype for 'arch_init_clk_ops' [-Wmissing-prototypes]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boards/of-generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index f7f3e618e85b6a52..cc88cb8908cc1d2e 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -10,6 +10,8 @@
 #include <linux/of_fdt.h>
 #include <linux/clocksource.h>
 #include <linux/irqchip.h>
+
+#include <asm/clock.h>
 #include <asm/machvec.h>
 #include <asm/rtc.h>
 
-- 
2.34.1


