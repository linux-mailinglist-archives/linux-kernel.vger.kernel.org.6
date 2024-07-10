Return-Path: <linux-kernel+bounces-247220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D400892CCB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6C62812DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE2B8526A;
	Wed, 10 Jul 2024 08:17:59 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171F2B9DD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599479; cv=none; b=lT861+6P9OJoi7L55jPyID83POC22vu4v8pUzX1X8mYXfNoYQ3HtztL3ZtMxxxV2S4BL62pbiP1G2pX1qN7ey60jTcRWUjBFL6v1h8kf3lIJZeZxqPtFq8XQBLO39/PjrP2wegHIFr6wSeF68nJvSULbPE3xU7bzaihSlUm/n2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599479; c=relaxed/simple;
	bh=vMTCO084NzNSlWMkSv2H0Px1AmWGV2K4ZrGqgram07o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O6ULTYMJ5S3oy+451zTV6UgiYDHuWHtiC1i7PXtKTbZL5BQcpNtOxzHmek8bfRNdeZiacL+wwM/3TWayOyMCeYsBzM7+k3dPDXSdRbHL59yddRRpk2PdMW9Osmut4/UJ06oM5AIS175sW1+eWhvzfFkcSB1+1Tl0cU2hjsddaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABXX1ugQ45mFtIBFQ--.48772S2;
	Wed, 10 Jul 2024 16:17:36 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: brgl@bgdev.pl,
	linux@armlinux.org.uk,
	khilman@deeprootsystems.com,
	nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v2] ARM: davinci: Convert comma to semicolon
Date: Wed, 10 Jul 2024 16:16:48 +0800
Message-Id: <20240710081648.2286573-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXX1ugQ45mFtIBFQ--.48772S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZrWfXF1ftrW8Xr47Jwb_yoW3Krc_Kw
	1ft3y7ArnakrWj9w1UX3yrGr40ywn8WFnrZryvvFnYyrW3Xr4a939YqF1IvrW5W3W5GrW3
	KrWUGryrGwnakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1oq2tUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Fixes: efc1bb8a6fd5 ("davinci: add power management support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Add Fixes tag.
---
 arch/arm/mach-davinci/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index 8aa39db095d7..2c5155bd376b 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -61,7 +61,7 @@ static void davinci_pm_suspend(void)
 
 	/* Configure sleep count in deep sleep register */
 	val = __raw_readl(pm_config.deepsleep_reg);
-	val &= ~DEEPSLEEP_SLEEPCOUNT_MASK,
+	val &= ~DEEPSLEEP_SLEEPCOUNT_MASK;
 	val |= pm_config.sleepcount;
 	__raw_writel(val, pm_config.deepsleep_reg);
 
-- 
2.25.1


