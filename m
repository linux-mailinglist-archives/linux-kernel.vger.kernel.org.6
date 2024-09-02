Return-Path: <linux-kernel+bounces-310878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CE7968264
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E57280DA6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7864178388;
	Mon,  2 Sep 2024 08:50:53 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C221E48A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267053; cv=none; b=j1A8Xy6kr1xFQDDzmOh0zxTwn4DveVa/EqynjcaPiEjnb2Wme+ZXbugbX+8/pnM+Ia3i+l5NdtLkgHouaEBhr27z9od2dwSbNj0CAC8tKB98E57WgDAnE/h6lQmelwmdWgoNds390JfyMkzLRrTduZ9isDYWbosZXmBq2F27gDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267053; c=relaxed/simple;
	bh=8Lp8HM6kUMSbgINsNVhbc6uTml2Xu6hkkvEefCN9YlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f/fwYFGVpYATe68Jalvyvl+QgMlAB46sY07HZkFkgOUmlGiWMSurhN7yZZMDlfraTjs2iB/FHOvVCV9A91GqlQLq2+oVQPcfRokF7kcoKrRUz7JJGpL44SMZodXn7qeg9vJaGKdqKgDesWvvh2KLN5mv+9HC+HNyke0ooExubfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAC3vn5kfNVmL12HAA--.23090S2;
	Mon, 02 Sep 2024 16:50:44 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: manivannan.sadhasivam@linaro.org,
	cristian.ciocaltea@gmail.com,
	lee@kernel.org
Cc: linux-actions@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] mfd: atc260x: Convert comma to semicolon
Date: Mon,  2 Sep 2024 16:50:19 +0800
Message-Id: <20240902085019.4111445-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3vn5kfNVmL12HAA--.23090S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47GrWUJrWfuFg_yoW3Zwb_C3
	s8uFn7JF15CwnxKr1kGFyrCryvyFW8WrWxAF1av39Iy3sxJ3WrZrZ8Zr1fXw4kCayru3s0
	gF43Wr4xZF17CjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU1vtCDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/mfd/atc260x-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/atc260x-core.c b/drivers/mfd/atc260x-core.c
index 67473b58b03d..6b6d5f1b9d76 100644
--- a/drivers/mfd/atc260x-core.c
+++ b/drivers/mfd/atc260x-core.c
@@ -235,8 +235,8 @@ int atc260x_match_device(struct atc260x *atc260x, struct regmap_config *regmap_c
 
 	mutex_init(atc260x->regmap_mutex);
 
-	regmap_cfg->lock = regmap_lock_mutex,
-	regmap_cfg->unlock = regmap_unlock_mutex,
+	regmap_cfg->lock = regmap_lock_mutex;
+	regmap_cfg->unlock = regmap_unlock_mutex;
 	regmap_cfg->lock_arg = atc260x->regmap_mutex;
 
 	return 0;
-- 
2.25.1


