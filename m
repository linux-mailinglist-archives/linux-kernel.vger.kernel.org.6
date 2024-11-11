Return-Path: <linux-kernel+bounces-403477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533BA9C363B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F7E1F21080
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583891E481;
	Mon, 11 Nov 2024 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="laVPXmMX"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087EE191
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731289651; cv=none; b=FCZHqYraF5Bmgr/zWKIDHGjKF/JMu66Rm6zdxEEN6NmALNGsNM9G9XsKM06NS+nd/gjZvPVZURZ1yfXdkFXzcoVIeKBW7OXjwC+V3OlpN9zrOdJnjW5n6IlTGCnQ0OTUS6831MGO7ppBrcVt6VDdgKJxiPwPtCf6PUbJ47U94Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731289651; c=relaxed/simple;
	bh=7wV9Zr8XBvwSsULJhsN1XxuOyFIgSzyb9FMHFRglGWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mFZni7ju1hupXcoNu1yD8u4aSA7L6VoFNnCQqDqTkkQa7y8ZdUMoRwG4oyyjJ/PMCBKD7UBvA5nTKOZMEXtQXgGKaTun4wJ+wIr0dFiEXAmfpdKDquutO0xoYL+2F/5iF/G6NtHrsOUBvdfBa/bp2gW2+KbyklmNSCnZrHWg384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=laVPXmMX; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731289645; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7nYu/zf/Hgjlcyv/67Jx00L9KGYZtgYj4zxfaqbKgZg=;
	b=laVPXmMXl02YG/cRgUnPDUOS5kqASbIa6He3XtUHvv69WOkn1cjV2aIAG2wnkVSdcMRiZxAGXqS3QJlusBck46OhccIvfyq547Jp2Q1O1qBI56FxRGDSfUJIA7P6A0hAMn/tMBqFHrXg1xzx1V11MhhgkEOWNYdjgs63iewEHfI=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WJ3wdyF_1731289644 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 09:47:25 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: matthias.bgg@gmail.com,
	simona@ffwll.ch,
	airlied@gmail.com
Cc: linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/mediatek: Remove unneeded semicolon
Date: Mon, 11 Nov 2024 09:47:23 +0800
Message-Id: <20241111014723.73769-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes an redundant semicolon.

./drivers/gpu/drm/mediatek/mtk_drm_drv.c:1092:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11790
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 9a8ef8558da9..9d8286424e98 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -1089,7 +1089,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 		/* No devicetree graphs support: go with hardcoded paths if present */
 		dev_dbg(dev, "Using hardcoded paths for MMSYS %u\n", mtk_drm_data->mmsys_id);
 		private->data = mtk_drm_data;
-	};
+	}
 
 	private->all_drm_private = devm_kmalloc_array(dev, private->data->mmsys_dev_num,
 						      sizeof(*private->all_drm_private),
-- 
2.32.0.3.g01195cf9f


