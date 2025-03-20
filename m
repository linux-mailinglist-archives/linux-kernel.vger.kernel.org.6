Return-Path: <linux-kernel+bounces-569275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D96AA6A0DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147A63B1014
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C4920A5D8;
	Thu, 20 Mar 2025 07:56:11 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3841EDA3C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457371; cv=none; b=Ggb9k9FIjEdeXW1DiKrng6Kf1PBx/vPoik+zCef8ybXUKDWDpITDXUNFd15P6iuvaAUsNDBua9mO5dMH35sejROWRP6+7/3vz3YQnXJQ75sRD2jxd30SSumFaMO8R/zNu7+rXwdmBZXgG5gYE6L7EQ8DFsdSFPe2zDPTCFkBSAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457371; c=relaxed/simple;
	bh=dM+/7XvmKkCH3ssjc2rsqZ9q3es9AbZ40cjN6d400vM=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=TNQxwQ+l3bMRMKt7bORHjo2qrq4nyee90e8/57kqOqCUaH5F5YfOUqBlO3gGHTIMlkrO+o78XGnyLNKA3qORpsu8zrVuVkuS2YlEZj0H7v3M7OsSbhLx8B30qJSl3o4a0riEXZPAl9rL3d1z6zJSqXj9Qcks3Zi6nk11BTquiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZJHvM28hfz4xxh6;
	Thu, 20 Mar 2025 15:55:59 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52K7toWh060651;
	Thu, 20 Mar 2025 15:55:50 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 20 Mar 2025 15:55:52 +0800 (CST)
Date: Thu, 20 Mar 2025 15:55:52 +0800 (CST)
X-Zmail-TransId: 2afb67dbca080d9-b119f
X-Mailer: Zmail v1.0
Message-ID: <20250320155552836BxTzConO0YrJHJ34CDDtl@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <andrzej.hajda@intel.com>
Cc: <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vYnJpZGdlOiBpdGUtaXQ2NTA1OiBVc2UgZGV2X2Vycl9wcm9iZSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52K7toWh060651
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67DBCA0F.000/4ZJHvM28hfz4xxh6

From: Zhang Enpei <zhang.enpei@zte.com.cn>

The function extcon_get_edev_by_phandle can return -EPROBE_DEFER, so
replace dev_err call with dev_err_probe. This also simplifies the code
sequence.

Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 8a607558ac89..1be1ffff505f 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3635,12 +3635,9 @@ static int it6505_i2c_probe(struct i2c_client *client)

 	/* get extcon device from DTS */
 	extcon = extcon_get_edev_by_phandle(dev, 0);
-	if (PTR_ERR(extcon) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-	if (IS_ERR(extcon)) {
-		dev_err(dev, "can not get extcon device!");
-		return PTR_ERR(extcon);
-	}
+	if (IS_ERR(extcon))
+		return dev_err_probe(dev, PTR_ERR(extcon),
+				     "can not get extcon device!");

 	it6505->extcon = extcon;

-- 
2.25.1

