Return-Path: <linux-kernel+bounces-292001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767F79569F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9F51F22480
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB7B167296;
	Mon, 19 Aug 2024 11:53:27 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982CA15B119
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068407; cv=none; b=FBvhvR4Q3nia8Hb1FGfdiSWPhhadgvBRROgcDMqMV6inooAKxBv+fmho3Z776ndUTdwmI7nSfg2iKLDwtFikOdX71kyK1w9OcEMKSN/tyluiVP7LtI/LJ7ELB4lLKwOcrwdSbGEQFGa0dpx/ATlbSqUMx3q49+hV3UMsixmYy04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068407; c=relaxed/simple;
	bh=brPrPahyZfyAaV9IrNEVoWg6VF8ELZbuudBMWIg/kcI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GKoEiK3UUhI9jdXtFbmLH8l4RTsY4TletAuVIbPE+h89RofIaIaqCoPdS5Br7PqLBuXGAQVO/ZwCkp0yOD3Pg2cVJe+RGUSSHidb72GqlLeAlOF5/RT2F9P/cnz2NPC7Jh62gXxeCGea7/iDcpqc47yVCByjrUUZd1moJZHaL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnWCH6yt6zfbZt;
	Mon, 19 Aug 2024 19:51:23 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 93A12180101;
	Mon, 19 Aug 2024 19:53:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 19:53:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <neil.armstrong@linaro.org>, <quic_jesszhan@quicinc.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 6/8] drm/panel: khadas-ts050: Make ts050_panel_data and ts050v2_panel_data static
Date: Mon, 19 Aug 2024 20:00:43 +0800
Message-ID: <20240819120043.3884933-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The sparse tool complains as follows:

drivers/gpu/drm/panel/panel-khadas-ts050.c:620:32: warning:
	symbol 'ts050_panel_data' was not declared. Should it be static?

drivers/gpu/drm/panel/panel-khadas-ts050.c:625:32: warning:
	symbol 'ts050v2_panel_data' was not declared. Should it be static?

These symbols are not used outside panel-khadas-ts050.c, so marks them static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/panel/panel-khadas-ts050.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
index 14932cb3defc..0e5e8e57bd1e 100644
--- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
+++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
@@ -617,12 +617,12 @@ static const struct khadas_ts050_panel_cmd ts050_init_code[] = {
 	{0xd4, {0x04}, 0x01}, /* RGBMIPICTRL: VSYNC front porch = 4 */
 };
 
-struct khadas_ts050_panel_data ts050_panel_data = {
+static struct khadas_ts050_panel_data ts050_panel_data = {
 	.init_code = (struct khadas_ts050_panel_cmd *)ts050_init_code,
 	.len = ARRAY_SIZE(ts050_init_code)
 };
 
-struct khadas_ts050_panel_data ts050v2_panel_data = {
+static struct khadas_ts050_panel_data ts050v2_panel_data = {
 	.init_code = (struct khadas_ts050_panel_cmd *)ts050v2_init_code,
 	.len = ARRAY_SIZE(ts050v2_init_code)
 };
-- 
2.34.1


