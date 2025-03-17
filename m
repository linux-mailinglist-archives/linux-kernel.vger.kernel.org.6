Return-Path: <linux-kernel+bounces-563386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D40A6409F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6791E1890DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9943F218591;
	Mon, 17 Mar 2025 06:05:09 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E15D7E0E4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191509; cv=none; b=ouvJh562ucSP+xlKRLrOXiWtz8T1kZyeRv7xTOGdds5P8YUcnmQ1VP4Dgx+UaqXzO3Rc7SNtxL2w+byHm5qBEH1G8F9NB5lTODM273XxNpxhmkmd2yQIdu5qRwc12uUiWRtHH5nP/9UUAG0aXvh8ZzEoVBuNJRfE8BpW1PkhvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191509; c=relaxed/simple;
	bh=2LWTQNeECopO34E3fIsxYZkJA/bUEgmrPLYqmrPa7Lk=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=h1onuDa5syQPfzIL2UbMhZGEr/9QPOAhrmqvW34t+tna7xLeb1z1BL2yPlvWWjfaDZB6OpCdj1KX1VvzZe605PNwK/j7YLvS/F8+kXzPd/jYYi/fuHd31NEHZHnhNHgt3s20tPncJIPHG4T0MWiwwbBjPk8LnXtxgNntYKAP0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGPZk0nj2z5B1Jb;
	Mon, 17 Mar 2025 14:05:02 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52H64sMZ055367;
	Mon, 17 Mar 2025 14:04:54 +0800 (+08)
	(envelope-from zhang.enpei@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 14:04:56 +0800 (CST)
Date: Mon, 17 Mar 2025 14:04:56 +0800 (CST)
X-Zmail-TransId: 2af967d7bb88223-d96ae
X-Mailer: Zmail v1.0
Message-ID: <202503171404563447jAdJlVvoFXDvBoj0sAx6@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <zhang.enpei@zte.com.cn>
To: <neil.armstrong@linaro.org>
Cc: <andrzej.hajda@intel.com>, <rfoss@kernel.org>,
        <laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vYnJpZGdlOiBzaWwtc2lpODYyMDogVXNlIGRldl9lcnJfcHJvYmUoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52H64sMZ055367
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7BB8E.001/4ZGPZk0nj2z5B1Jb

From: ZhangEnpei <zhang.enpei@zte.com.cn>

Replace the open-code with dev_err_probe() to simplify the code.

Signed-off-by: ZhangEnpei <zhang.enpei@zte.com.cn>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 28a2e1ee04b2..1d0ee9c8d5b2 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2178,12 +2178,9 @@ static int sii8620_extcon_init(struct sii8620 *ctx)

 	edev = extcon_find_edev_by_node(muic);
 	of_node_put(muic);
-	if (IS_ERR(edev)) {
-		if (PTR_ERR(edev) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		dev_err(ctx->dev, "Invalid or missing extcon\n");
-		return PTR_ERR(edev);
-	}
+	if (IS_ERR(edev))
+		return dev_err_probe(ctx->dev, PTR_ERR(edev),
+				     "Invalid or missing extcon\n");

 	ctx->extcon = edev;
 	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
-- 
2.25.1

