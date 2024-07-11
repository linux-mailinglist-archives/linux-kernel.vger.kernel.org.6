Return-Path: <linux-kernel+bounces-249016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8573092E510
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49AD1C21DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85271158D7B;
	Thu, 11 Jul 2024 10:50:29 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EECD12F365;
	Thu, 11 Jul 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695029; cv=none; b=lO+uCycttCNydUfDs5TwHUCOXlyyPkLDp9uokNBxrozxFrap6VCHaFH7YZLzPy1flZBgQXBwsfR9x0Plqo3n5ohCh3/MuqMWxayUZBe1fnzYaCKTDmD7QE4/hb+A8g02WxsAYkBZXn1lfGrPDIulpOtPfESshrjTIbaRwiQ/lao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695029; c=relaxed/simple;
	bh=j3LRkam5HWHIbp7v5gKW1hLYjKVtdjDe5VGZuKDG4jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSPulTBMutQ6ONbWFF128MG8vMmwJ0ZUN7B/Dh8RbUX0UweP2zhgR+RYv42c6NZdPteUFi6tmIGzmD0Cm1Hj7KNSvR3qegGDwtXOFtteuia4jsTuK6DCPTW4KDJdQNuGZeo/pYmSs+hT38jdOWLrIwqrKj7hTiv0aCP/9cRi6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WKWhx1TF9z9sSd;
	Thu, 11 Jul 2024 12:50:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o0b594mVLDho; Thu, 11 Jul 2024 12:50:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WKWhx0n6Nz9sSV;
	Thu, 11 Jul 2024 12:50:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 097478B778;
	Thu, 11 Jul 2024 12:50:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Xq-Gfk8HJ7XO; Thu, 11 Jul 2024 12:50:24 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.107])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 83A168B764;
	Thu, 11 Jul 2024 12:50:24 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] Documentation/powerpc: Mention 40x is removed
Date: Thu, 11 Jul 2024 12:50:21 +0200
Message-ID: <c2d64bebc514ca892a12e51a68821a6317048d3a.1720694954.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720695022; l=1613; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=j3LRkam5HWHIbp7v5gKW1hLYjKVtdjDe5VGZuKDG4jo=; b=Wq8oiOcpAfRUrVsYCRB5hx2gY5s2R68t8KTD0mC8TZXhf7eg3/5jbxnTvXLZahghqUG4faej2 Gt07yMKtSZSDeQQvbE19Y3iuroPTXViBAibEH/HleUPcnPeugm/3A6Q
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 732b32daef80 ("powerpc: Remove core support for 40x") removed 40x.

Update documentation accordingly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 Documentation/arch/powerpc/cpu_families.rst | 18 ------------------
 Documentation/arch/powerpc/elf_hwcaps.rst   |  1 +
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/Documentation/arch/powerpc/cpu_families.rst b/Documentation/arch/powerpc/cpu_families.rst
index eb7e60649b43..f55433c6b8f3 100644
--- a/Documentation/arch/powerpc/cpu_families.rst
+++ b/Documentation/arch/powerpc/cpu_families.rst
@@ -128,24 +128,6 @@ IBM BookE
 - All 32 bit::
 
    +--------------+
-   |     401      |
-   +--------------+
-          |
-          |
-          v
-   +--------------+
-   |     403      |
-   +--------------+
-          |
-          |
-          v
-   +--------------+
-   |     405      |
-   +--------------+
-          |
-          |
-          v
-   +--------------+
    |     440      |
    +--------------+
           |
diff --git a/Documentation/arch/powerpc/elf_hwcaps.rst b/Documentation/arch/powerpc/elf_hwcaps.rst
index 4c896cf077c2..fce7489877b5 100644
--- a/Documentation/arch/powerpc/elf_hwcaps.rst
+++ b/Documentation/arch/powerpc/elf_hwcaps.rst
@@ -91,6 +91,7 @@ PPC_FEATURE_HAS_MMU
 
 PPC_FEATURE_HAS_4xxMAC
     The processor is 40x or 44x family.
+    Unused in the kernel since 732b32daef80 ("powerpc: Remove core support for 40x")
 
 PPC_FEATURE_UNIFIED_CACHE
     The processor has a unified L1 cache for instructions and data, as
-- 
2.44.0


