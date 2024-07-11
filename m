Return-Path: <linux-kernel+bounces-249014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 742CA92E50C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853F51C21DED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C396D15884B;
	Thu, 11 Jul 2024 10:49:18 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E329CF0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694958; cv=none; b=jAWkSsDpVH+InDWgJYUP0Eyj14Jwh50fFaLm64Yi+qFsAUnba3p7eDrYnfhRFa2E8m8Xj9fCtyLYZFAdkfQpTYn9I2XXE6YDrRfHAYJ6JsaB3p+aLQHMPWjy3Pv5b+j36WOEYsnrH4LfUibaP0qNpwimBIkCH6f6vni6MOj91Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694958; c=relaxed/simple;
	bh=34zE3+s18qxDmJ/g6Sn4JXCB/W17u3pBk+nhOORmuxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjbX8WXEvHX9rY1MvIpfSgoPht7Hkt62aNasur7SEHSXZpaC2tXh5QT72rWeireTmFh3W8AUPtUl0KloPxQHJuYIwsOB/BpROq29Qv9Av/g4B3C9FRotGwGMqSyWdsOipAGeLyY5MVSSSsYgAjOy361SyNeUxxF/VYD9YVn5/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WKWgR6DKKz9sSd;
	Thu, 11 Jul 2024 12:49:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2RqFO7Mhyqy7; Thu, 11 Jul 2024 12:49:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WKWgR5VXDz9sSV;
	Thu, 11 Jul 2024 12:49:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AEB5C8B778;
	Thu, 11 Jul 2024 12:49:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id fChFF1nWQOWT; Thu, 11 Jul 2024 12:49:07 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.107])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 480138B764;
	Thu, 11 Jul 2024 12:49:07 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Remove 40x leftovers
Date: Thu, 11 Jul 2024 12:49:01 +0200
Message-ID: <ab30ae302783d8617d407864b92db1b926ab5ab9.1720694914.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720694942; l=1243; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=34zE3+s18qxDmJ/g6Sn4JXCB/W17u3pBk+nhOORmuxw=; b=Qf3m+E0r0EGY3uzEtzcwi8SiBmKgleoMjAp6HDSuD2TpYSHYw25CR2atNoFUOFg4lT+JtRkrM s698EtKtPb/B34tw5FD0kXoR3v7c4E7tSTLHYLeZCcq5ezBxDL19Yg5
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Fixes: e939da89d024 ("powerpc: Remove 40x from Kconfig and defconfig")
Fixes: 548f5244f106 ("powerpc/40x: Remove EP405")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/boot/wrapper              | 2 +-
 arch/powerpc/platforms/Kconfig.cputype | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 585c4ea27ab9..b1f5549a3c9c 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -337,7 +337,7 @@ ps3)
     make_space=n
     pie=
     ;;
-ep88xc|ep405|ep8248e)
+ep88xc|ep8248e)
     platformo="$object/fixed-head.o $object/$platform.o"
     binary=y
     ;;
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 1ec98688c915..4b0d7d4f88f6 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -250,7 +250,6 @@ config TARGET_CPU
 	default "e6500" if E6500_CPU
 	default "power4" if POWERPC64_CPU && !CPU_LITTLE_ENDIAN
 	default "power8" if POWERPC64_CPU && CPU_LITTLE_ENDIAN
-	default "405" if 405_CPU
 	default "440" if 440_CPU
 	default "464" if 464_CPU
 	default "476" if 476_CPU
-- 
2.44.0


