Return-Path: <linux-kernel+bounces-312374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B82B9695BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7D5B2528B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96C31D6DDA;
	Tue,  3 Sep 2024 07:36:16 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923271CEAC0;
	Tue,  3 Sep 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348976; cv=none; b=s/lW/FF/aRcMb5lfXpwXYt+kt8PlHcFwm/lb9GaoN7vvZiHQmW1hxgzbdFf0qs1s8I4lo7hTvpFbxwHQa2byJNKpqdrt1YLkThnxzKwag9e+KFOmK/hA89Gz+T7hi0PEVIFPtZ953jlcf6x99uxnBevk9tqyGwgkpzOfmqtT7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348976; c=relaxed/simple;
	bh=yDQAXnhVnW8wj7phpHobU2rc9zmsYx8be2VbzR4TVgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L43c2MfXbG5ncMvh+vUpCTsxLdSeF+6OkniqQYbToEs5CpRDpAJP5+Sm9k9Q92KOBxP2TssGhTs3C1ro0d6g0QV4IT29ow3xfi8dWfaSB4lMW/oYnW72NsE12MBpdlftmKknFBD9qyZwZGL7TgEXGXYUBGp4FoWN+dVCdYaZPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABXLI9mvNZmBhXAAA--.45022S2;
	Tue, 03 Sep 2024 15:36:06 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: pawell@cadence.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] usb: cdns2: Convert comma to semicolon
Date: Tue,  3 Sep 2024 15:35:38 +0800
Message-Id: <20240903073538.780996-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXLI9mvNZmBhXAAA--.45022S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47Grykuw45Jrb_yoWftFgE9w
	409347CF17uwnF9w1xA34Y934UGas7Xan7XFsrKr98AryDuryrZ348XrykGry5ZFW7GFn3
	Cws7tFsrKrZ3WjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU1CJPDUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
index 0eed0e03842c..aca89730f065 100644
--- a/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.c
@@ -2033,8 +2033,8 @@ static void cdns2_quiesce(struct cdns2_device *pdev)
 	set_reg_bit_8(&pdev->usb_regs->usbcs, USBCS_DISCON);
 
 	/* Disable interrupt. */
-	writeb(0, &pdev->interrupt_regs->extien),
-	writeb(0, &pdev->interrupt_regs->usbien),
+	writeb(0, &pdev->interrupt_regs->extien);
+	writeb(0, &pdev->interrupt_regs->usbien);
 	writew(0, &pdev->adma_regs->ep_ien);
 
 	/* Clear interrupt line. */
-- 
2.25.1


