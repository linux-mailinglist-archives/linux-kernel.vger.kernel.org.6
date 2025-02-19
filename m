Return-Path: <linux-kernel+bounces-521842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0F5A3C300
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5637176DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1241F4619;
	Wed, 19 Feb 2025 15:03:43 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79501F30A4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977422; cv=none; b=kBew6h+Z/6ul9ElP+ICFsB1jIgFiF08jp15BMEO4yzJqnLnQmrakKwR+vLHHEKDXrAPXsO4HWIqYjG62WqmZc40UK920tSLH1ibsUTPYlni8QJ5Qp2w0Er3psH8MF+U0Q3nBr8+AqYsllIgSfYDavp8kIR5Gj8Wnt4UkBTYm8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977422; c=relaxed/simple;
	bh=2c/AWmO5i6aMpMjJu+qQZg9qk31xvfT1rHjn+iDPNOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaT6bAbiTAJmeZCQ5ODXzXAToV85rQJshSOxr0DvYJysuqcC2ZQn4XQ1ot1C0QhAb7uZWKoV2z2ozSuRDL9tsAl1mZ6PaStY0ujsD1cPQ///oE+/fjyV9xwnKhfnVDuBH+iGEH1J+geKJMlnQlunCvnnf0PYxVJE6fbKtndFIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:47f6:a1ad:ad8e:b945])
	by baptiste.telenet-ops.be with cmsmtp
	id FT3a2E00L57WCNj01T3apE; Wed, 19 Feb 2025 16:03:37 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tklbX-0000000B3WS-46QB;
	Wed, 19 Feb 2025 16:03:34 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tklbq-0000000BbJe-2PpY;
	Wed, 19 Feb 2025 16:03:34 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dragan Simic <dsimic@manjaro.org>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] hwrng: Fix indentation of HW_RANDOM_CN10K help text
Date: Wed, 19 Feb 2025 16:03:32 +0100
Message-ID: <54eae580e3ee5686db692dd6c0927b23134a1cec.1739977165.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the indentation of the help text of the HW_RANDOM_CN10K symbol
from one TAB plus one space to one TAB plus two spaces, as is customary.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
While commit 67b78a34e48b9810 ("hwrng: Kconfig - Use tabs as leading
whitespace consistently in Kconfig") fixed some indentation for the
HW_RANDOM_CN10K symbol, it did not fix everything...
---
 drivers/char/hw_random/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 1ec4cad1e210a2ac..c67de9579664c762 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -583,11 +583,11 @@ config HW_RANDOM_CN10K
 	depends on HW_RANDOM && PCI && (ARM64 || (64BIT && COMPILE_TEST))
 	default HW_RANDOM if ARCH_THUNDER
 	help
-	 This driver provides support for the True Random Number
-	 generator available in Marvell CN10K SoCs.
+	  This driver provides support for the True Random Number
+	  generator available in Marvell CN10K SoCs.
 
-	 To compile this driver as a module, choose M here.
-	 The module will be called cn10k_rng. If unsure, say Y.
+	  To compile this driver as a module, choose M here.
+	  The module will be called cn10k_rng. If unsure, say Y.
 
 config HW_RANDOM_JH7110
 	tristate "StarFive JH7110 Random Number Generator support"
-- 
2.43.0


