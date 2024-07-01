Return-Path: <linux-kernel+bounces-235721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC6791D8E6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4879FB22273
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4167174F;
	Mon,  1 Jul 2024 07:27:50 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E11B809
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818870; cv=none; b=pew7PjiE1OtAGkkx1WtfiMbA6T4MU7SUG2FnnB4JZpJIwx0BnDOLKVdzCv/adx0VCAP2M5WVgEYxNkPykQnto3Bch/USUgA9HGJqJTvnuhen36tfVClPZea4eu0WqXjXCLgegpHiOOuA5G93RLuYbQJfB61nteYz0FgZNjYXOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818870; c=relaxed/simple;
	bh=l9TPGLgKua1vM/W31z/6qhz5xeaXxr3iCx1dHQsV63k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qZ/ASqNlGB5OB1vtOdoU4sf7IKncNzwK7QLcqTWN/VtPN2zcurP7cQH52G0GZOtq+SUOxGfTTU1Fp3ju1HLkIdbsiHk5QF7eo5nww1IBSwBsY6SbtMQixK+SnMakgG56x84/cJt9Fh6BE+empL5feR9+sKuFgOQaJ8MX/j3U+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAD3_7drWoJmhzHwAA--.62668S2;
	Mon, 01 Jul 2024 15:27:39 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: pjones@redhat.com,
	konrad@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] iscsi_ibft: Remove unneeded semicolon
Date: Mon,  1 Jul 2024 15:27:14 +0800
Message-Id: <20240701072714.846388-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3_7drWoJmhzHwAA--.62668S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFW7Gr1rGFyrur4ftw1DJrb_yoWxAwb_C3
	45ZF4xKay0k3yjgF15WFyfZr90k3yjga1I9FnF9ayakry2q34DXr4jvr47AwnrXrWUuF17
	Jry5Kr1UArnrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbc8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF4l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0OJeDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unneeded semicolon.
This is detected by coccinelle.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/firmware/iscsi_ibft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index 6e9788324fea..3c52fde713ce 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -800,7 +800,7 @@ static void ibft_unregister(void)
 		ibft_kobj = boot_kobj->data;
 		if (ibft_kobj->hdr && ibft_kobj->hdr->id == id_nic)
 			sysfs_remove_link(&boot_kobj->kobj, "device");
-	};
+	}
 }
 
 static void ibft_cleanup(void)
-- 
2.25.1


