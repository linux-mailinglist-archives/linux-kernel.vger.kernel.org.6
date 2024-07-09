Return-Path: <linux-kernel+bounces-245116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264E892AE87
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33D61F23062
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1020A43AC0;
	Tue,  9 Jul 2024 03:18:41 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE807381BE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495120; cv=none; b=aCsYoFwPqU4QWr8iw0JZCrgbFuREuxWlhtTaWELYaQRjZbKjIeQpweJo6O15ZtMVgswjoS7FLST3B4iIR8T4aPJh31sAkC64qxjkIiEHp+3wBNDeCz64peiHapogxqyH6vHHCveD/KMlkbP0CQR+RmTmBv9wR3Hr/kupgqgtWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495120; c=relaxed/simple;
	bh=QX0vFj80lpfdK97iQwsFFIZs5Aol6PIQ93/VQdyFZsg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tolmdSdcwrBQ1DkQ36lWHs8dzwroLB+bZqJ8uOdFDAqbK+UMY5qMu6d+YTxfmTv2p1M6cMyAnjNpbSdc8d3zm6z5yt3Hqku/gyz1xskhd8aVGO6VOPvsjJ1aT85U4xj5G3US9vjhWaLstfeywV7lE5Sr/v21BkGgfvSlBcDh0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowACniU4JrIxm90VcAg--.203S2;
	Tue, 09 Jul 2024 11:18:33 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lee@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] mfd: 88pm860x-core: Convert comma to semicolon
Date: Tue,  9 Jul 2024 11:18:24 +0800
Message-Id: <20240709031824.585922-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACniU4JrIxm90VcAg--.203S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWrKr1fCF1UJFy5Zr4fZrb_yoW5XryDp3
	srCa9rA34rJ3W7Grs5GrsrCFs7ua42y3yfKFWrt343ua1Yy3s8Kr4Utry8ta4UCrWIvFyF
	vrWYy3y8AF9rJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK
	6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjC385UUUU
	U==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/mfd/88pm860x-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 7f003f71e1af..8e68b64bd7f8 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -916,7 +916,7 @@ static void device_power_init(struct pm860x_chip *chip,
 	power_devs[0].platform_data = pdata->power;
 	power_devs[0].pdata_size = sizeof(struct pm860x_power_pdata);
 	power_devs[0].num_resources = ARRAY_SIZE(battery_resources);
-	power_devs[0].resources = &battery_resources[0],
+	power_devs[0].resources = &battery_resources[0];
 	ret = mfd_add_devices(chip->dev, 0, &power_devs[0], 1,
 			      &battery_resources[0], chip->irq_base, NULL);
 	if (ret < 0)
@@ -925,7 +925,7 @@ static void device_power_init(struct pm860x_chip *chip,
 	power_devs[1].platform_data = pdata->power;
 	power_devs[1].pdata_size = sizeof(struct pm860x_power_pdata);
 	power_devs[1].num_resources = ARRAY_SIZE(charger_resources);
-	power_devs[1].resources = &charger_resources[0],
+	power_devs[1].resources = &charger_resources[0];
 	ret = mfd_add_devices(chip->dev, 0, &power_devs[1], 1,
 			      &charger_resources[0], chip->irq_base, NULL);
 	if (ret < 0)
@@ -942,7 +942,7 @@ static void device_power_init(struct pm860x_chip *chip,
 		pdata->chg_desc->charger_regulators =
 			&chg_desc_regulator_data[0];
 		pdata->chg_desc->num_charger_regulators	=
-			ARRAY_SIZE(chg_desc_regulator_data),
+			ARRAY_SIZE(chg_desc_regulator_data);
 		power_devs[3].platform_data = pdata->chg_desc;
 		power_devs[3].pdata_size = sizeof(*pdata->chg_desc);
 		ret = mfd_add_devices(chip->dev, 0, &power_devs[3], 1,
@@ -958,7 +958,7 @@ static void device_onkey_init(struct pm860x_chip *chip,
 	int ret;
 
 	onkey_devs[0].num_resources = ARRAY_SIZE(onkey_resources);
-	onkey_devs[0].resources = &onkey_resources[0],
+	onkey_devs[0].resources = &onkey_resources[0];
 	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
 			      ARRAY_SIZE(onkey_devs), &onkey_resources[0],
 			      chip->irq_base, NULL);
@@ -972,7 +972,7 @@ static void device_codec_init(struct pm860x_chip *chip,
 	int ret;
 
 	codec_devs[0].num_resources = ARRAY_SIZE(codec_resources);
-	codec_devs[0].resources = &codec_resources[0],
+	codec_devs[0].resources = &codec_resources[0];
 	ret = mfd_add_devices(chip->dev, 0, &codec_devs[0],
 			      ARRAY_SIZE(codec_devs), &codec_resources[0], 0,
 			      NULL);
-- 
2.25.1


