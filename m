Return-Path: <linux-kernel+bounces-562360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D37BA6249D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572061899D81
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE64217B505;
	Sat, 15 Mar 2025 02:26:30 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F253BE;
	Sat, 15 Mar 2025 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742005590; cv=none; b=hqALVipB++de/Yye00YkxxW9DhfKCRDJUcaPcfKeovKc4yXbB9MCIHt5s1etFfeDbyZX/0Za5zJmHxiAINV8uvp6AJaFoZnUpWsU+D7vKHC7qYktiHFEO0KmLtZe7Mq6uqarfwNVRsvXkTxHm7DL7nDLp1qq1IXwEOkzVkDexqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742005590; c=relaxed/simple;
	bh=yWfJU6HiUiPNc61XsJevE5RFjgaBAeGIb7etxvoFyTM=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=Auqsj1p8TSyeWJPQkH3Op6ykA1lBBZa6K9Ltp2jXwiuGbtD7aqe4rx0BfzEPyju0OYBGrNjuUjeF2dEaAPRCua1zBdHhqC1zb8pCgMLgf13fUcRWJdk6yRM2NG+zxX64XFGhYkZ6zMgraefVK9I5NOtQNfrXj8lOxn4FkfOJPfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZF4qF0GdXz501gV;
	Sat, 15 Mar 2025 10:26:17 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 52F2Pw5S018668;
	Sat, 15 Mar 2025 10:25:58 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Sat, 15 Mar 2025 10:26:00 +0800 (CST)
Date: Sat, 15 Mar 2025 10:26:00 +0800 (CST)
X-Zmail-TransId: 2afa67d4e53836a-81244
X-Mailer: Zmail v1.0
Message-ID: <20250315102600136tIj0LVzjTQjRLKNzNwVj2@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <lgirdwood@gmail.com>
Cc: <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <jiang.peng9@zte.com.cn>, <zhoubinbin@loongson.cn>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpMnM6IFNpbXBsaWZ5IHJlc291cmNlIHJldHJpZXZhbCBhbmQgbWFwcGluZyBieSB1c2luZwogZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2U=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52F2Pw5S018668
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D4E549.000/4ZF4qF0GdXz501gV

From: Peng Jiang <jiang.peng9@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single call
to devm_platform_get_and_ioremap_resource().

By making this change, we improve code readability and reduce redundancy
without affecting the functionality of the driver.

Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
---
 sound/soc/loongson/loongson_i2s_plat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/loongson/loongson_i2s_plat.c b/sound/soc/loongson/loongson_i2s_plat.c
index fa2e450ff618..1378abca520b 100644
--- a/sound/soc/loongson/loongson_i2s_plat.c
+++ b/sound/soc/loongson/loongson_i2s_plat.c
@@ -126,8 +126,7 @@ static int loongson_i2s_plat_probe(struct platform_device *pdev)
        if (ret)
                return ret;

-       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-       i2s->reg_base = devm_ioremap_resource(&pdev->dev, res);
+       i2s->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
        if (IS_ERR(i2s->reg_base))
                return dev_err_probe(dev, PTR_ERR(i2s->reg_base),
                                     "devm_ioremap_resource failed\n");
-- 
2.25.1

