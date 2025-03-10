Return-Path: <linux-kernel+bounces-553514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE38CA58ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 04:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B683A3ABECA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19591B0F1E;
	Mon, 10 Mar 2025 03:12:10 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868A374FF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741576330; cv=none; b=WK/l3O7x/8NcuIVdyEk/JxAm5gdea4O2/JpAMk9rLtfhj3IBjajiy7yhLoCEbUOszOEB7Dws4MyQrsSl4muUfaS0rd006J63ykbY/tE3OdC0bQLiaBPjChPEuyNDZKkaox1ce8coE3+1ShVdlhI2sufy4FjhbZHpriaeTgfsHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741576330; c=relaxed/simple;
	bh=yL38p2pVu6poYXl/FgV04uz3zNzYLNdxOaJF8oDPs+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ajjLS2QjeT6OCeYrI8aWq82Etxas6obANthebP0j/9SPRnhRMN5fWx2kxMuT71LOV8ihahJT1KLsewVnjf+jlFvbYirhIoT7yiRmTAmm1ys7OXrg4Hp4NmQUp6mqs+KgdGG9NiOkxzrtF6o5ensa7tnvyQ7VH1YMvVxvOB8wiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowACHD_l7WM5n8N7eEw--.59339S2;
	Mon, 10 Mar 2025 11:11:56 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: heiko@sntech.de,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] mfd: Convert comma to semicolon
Date: Mon, 10 Mar 2025 11:11:45 +0800
Message-Id: <20250310031145.650950-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHD_l7WM5n8N7eEw--.59339S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4rCw4kuw4kuw1xGrW3ZFb_yoWfZFX_u3
	4Sgrsakr1jkrnrKF1vk3yFyF90gayv9a10v342qFWayr4qyrs5uFs3Xr4Fvry3Aa1jkFn8
	Cr45AryFvaya9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
	73UjIFyTuYvjfU889NDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/mfd/qnap-mcu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index 4be39d8b2905..89a8a1913d42 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -158,9 +158,9 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 
 	mutex_lock(&mcu->bus_lock);
 
-	reply->data = rx,
-	reply->length = length,
-	reply->received = 0,
+	reply->data = rx;
+	reply->length = length;
+	reply->received = 0;
 	reinit_completion(&reply->done);
 
 	qnap_mcu_write(mcu, cmd_data, cmd_data_size);
-- 
2.25.1


