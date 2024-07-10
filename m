Return-Path: <linux-kernel+bounces-246853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF88092C805
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56407B218D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E755CB8;
	Wed, 10 Jul 2024 01:44:22 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F323A0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720575862; cv=none; b=dffTUrzQpGwrkiQDL9Wy/2lootG+H9aYxoxAJoIfU5RsxjacMV6yyd35pjMmGavDGEkVpbFTM6NkZNOHjL6NSjnp2qP2s6VNnjldWZJJX4yq0clYTKC7Fvbjkfl0abLKFZmGhyf0x7ZQAQ9k6d2lBxD5ziZj4jrvZSI6obuyr34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720575862; c=relaxed/simple;
	bh=ahcSyejnRy1OAhrblLQBgatSI/B6wYywQgkxiHGVjNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oN0lZiMIJN/JNnbytExlk3gX9YasijuPFdfLTzU41V6HJIqCjevT5wUBtbNVHULZV3OQFxxy9zfg22AvPP1Jd+jNVHtCzgMbP59sl6fI4tXvKWfrhAQ3cfmECOBepvyEnwlUUAhh13NxQly0WqUWahLbJJdA20d/rfw2HyH+hiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAB3f7dr541mhEF7Ag--.45535S2;
	Wed, 10 Jul 2024 09:44:11 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: brgl@bgdev.pl,
	linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ARM: davinci: Convert comma to semicolon
Date: Wed, 10 Jul 2024 09:44:01 +0800
Message-Id: <20240710014401.1719716-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3f7dr541mhEF7Ag--.45535S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47JryruF48Zwb_yoW3Jrg_Kr
	1ft3yxJrnYkrWj9w1UW3yrGF40ywn8WFnrZry0vFnYkFWaqr4a9rZYqF1IqrW5W3W5GrW3
	K3yDGryrC3ZakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
	KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHWlgUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
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


