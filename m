Return-Path: <linux-kernel+bounces-169489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD97A8BC977
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F49284C8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D111411EA;
	Mon,  6 May 2024 08:21:59 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E94140E46
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983718; cv=none; b=XP6DU5f8CsMKKJ146lCJ+y9Mlk4tXhPBR0HoqBehYZpfAnM3Cx1R72nZuY5QPyP3ZjiX+mPddynt3L6hIZ9JovCNacCxB5TI9GSMM713BuIT4fsC/aglBk1xFWl5pCvkIBIzqSxoUz4dHDDPfYPNYpVtDY1N+xYAej/FB+eAAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983718; c=relaxed/simple;
	bh=hhwKMXUzrQ0uPvH/7RhpW1I9RGs7lrXrlwA5/jOYygE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s3SzIRO0MxgOlLvTIKqWq1tsQl9YzSh4K4K9IQELLJjVQqSxGYBCY0R+y8zXmwrAILKoN3n9OnddVkwJqN8tIPkt+RB3lNQZJCPH2tvSjGGF0aEmBP7l3PnxfltttoULLAF8+zutgNsqiQGG+mwLf5kCxyHOzvXRpXKW6oAgGKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:e8fd:353d:bf09:e9f2])
	by michel.telenet-ops.be with bizsmtp
	id KkMm2C0051j6xkh06kMmeg; Mon, 06 May 2024 10:21:48 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s3tak-009xSO-NL;
	Mon, 06 May 2024 10:21:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s3sQt-005qJJ-74;
	Mon, 06 May 2024 09:06:43 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: Move ARCH_HAS_CPU_CACHE_ALIASING
Date: Mon,  6 May 2024 09:06:41 +0200
Message-Id: <4574ad6cc1117e4b5d29812c165bf7f6e5b60773.1714978406.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the recently added ARCH_HAS_CPU_CACHE_ALIASING to restore
alphabetical sort order.

Fixes: 8690bbcf3b7010b3 ("Introduce cpu_dcache_is_aliasing() across all architectures")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k tree for v6.10.

 arch/m68k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index c68fbc59787ab59d..e0b4f6e9fe4ce1f4 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -3,8 +3,8 @@ config M68K
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
-	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DMA_PREP_COHERENT if M68K_NONCOHERENT_DMA && !COLDFIRE
-- 
2.34.1


