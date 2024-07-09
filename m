Return-Path: <linux-kernel+bounces-246173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F83792BE83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B83A1F24969
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38319D8A3;
	Tue,  9 Jul 2024 15:34:40 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC62319D06D;
	Tue,  9 Jul 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539279; cv=none; b=nHIeL00xVhHv9pqv/EVJwZI558ND2gKBMBOdbJJlIGo41tH9IBPFMygQw/B9ld/kPuhuy6iTdsJSpLFtFaDZmTFHY3HH5qFyhBx7pI5QHjmaTdz+v0pYGi92FYXn7xwxT2EmYn5/tvGDdFhd6UzGC/lAGorLJKs9fUJXZqPGIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539279; c=relaxed/simple;
	bh=g2TeahJZO7npPyW42OA1MqX8NHOBTRgERAWE4Igw29M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkWDrVD9/TfRA00xj5Y/nXeM8tPiDalCm3W77uBdkL2ONaoxRmEnksha1O0imDapAOnHrb+ZZ5KOW8x3QpJ6HAwnhLvlr4Sgtm+AA2r7o9hBAg+I2xMPZ6psSktSCBxsnIAuCaQ7nBj23Q43oXPD8HMlIMZk42iucXboVgBRl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WJQ5f4LDqz9sSq;
	Tue,  9 Jul 2024 17:34:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZmxSbZ-bi7i5; Tue,  9 Jul 2024 17:34:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WJQ5f3VCQz9sSp;
	Tue,  9 Jul 2024 17:34:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 654A68B778;
	Tue,  9 Jul 2024 17:34:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id gluke2XNulId; Tue,  9 Jul 2024 17:34:30 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.9])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3079C8B773;
	Tue,  9 Jul 2024 17:34:30 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/powerpc: Remove retired CPUs from list of supported CPUs
Date: Tue,  9 Jul 2024 17:34:27 +0200
Message-ID: <e33ba7b242a104259fbcf1a4d4bdb0f1d1db6882.1720539170.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720539267; l=3729; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=g2TeahJZO7npPyW42OA1MqX8NHOBTRgERAWE4Igw29M=; b=5TIs567xNQZ7AzoBPcbZ9jugS2tqaQnuPfBfdj3T0d+pd1+P1cxAqe6KDqoXJrR3a5cXlTwWi avPRafFhOgLApUgIeYDoGkN7e/w9/yiASdMp2XCzTzLeWyHg2d+vVfb
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

601, power4, 401, 403, 405, e200 and IBM-A2 support was removed by
by following commits:
- Commit 8b14e1dff067 ("powerpc: Remove support for PowerPC 601")
- Commit 471d7ff8b51b ("powerpc/64s: Remove POWER4 support")
- Commit 1b5c0967ab8a ("powerpc/40x: Remove support for IBM 403GCX")
- Commit 39c8bf2b3cc1 ("powerpc: Retire e200 core (mpc555x processor)")
- Commit fb5a515704d7 ("powerpc: Remove platforms/wsp and associated
pieces")

Remove them from the list of supported CPUs.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 Documentation/arch/powerpc/cpu_families.rst | 56 +++------------------
 1 file changed, 8 insertions(+), 48 deletions(-)

diff --git a/Documentation/arch/powerpc/cpu_families.rst b/Documentation/arch/powerpc/cpu_families.rst
index eb7e60649b43..713806eb14bd 100644
--- a/Documentation/arch/powerpc/cpu_families.rst
+++ b/Documentation/arch/powerpc/cpu_families.rst
@@ -20,10 +20,10 @@ Book3S (aka sPAPR)
    +--------------+                 +----------------+
           |
           |
-          v
-   +--------------+                 +----------------+      +------+
-   |     601      | --------------> |      603       | ---> | e300 |
-   +--------------+                 +----------------+      +------+
+          |
+          |                         +----------------+      +------+
+          |-----------------------> |      603       | ---> | e300 |
+          |                         +----------------+      +------+
           |                                 |
           |                                 |
           v                                 v
@@ -50,10 +50,10 @@ Book3S (aka sPAPR)
    +--------------+                 +----------------+
           |                                 |
           |                                 |
-          v                                 v
-   +--------------+                 +----------------+
-   |    POWER4    |                 |      7455      |
-   +--------------+                 +----------------+
+          |                                 v
+          |                         +----------------+
+          |                         |      7455      |
+          |                         +----------------+
           |                                 |
           |                                 |
           v                                 v
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
@@ -186,11 +168,6 @@ Freescale BookE
 - e6500 adds HW loaded indirect TLB entries.
 - Mix of 32 & 64 bit::
 
-   +--------------+
-   |     e200     |
-   +--------------+
-
-
    +--------------------------------+
    |              e500              |
    +--------------------------------+
@@ -218,20 +195,3 @@ Freescale BookE
    +--------------------------------+
    | e6500 (HW TLB) (Multithreaded) |
    +--------------------------------+
-
-
-IBM A2 core
------------
-
-- Book3E, software loaded TLB + HW loaded indirect TLB entries.
-- 64 bit::
-
-   +--------------+     +----------------+
-   |   A2 core    | --> |      WSP       |
-   +--------------+     +----------------+
-           |
-           |
-           v
-   +--------------+
-   |     BG/Q     |
-   +--------------+
-- 
2.44.0


