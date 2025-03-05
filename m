Return-Path: <linux-kernel+bounces-546563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF95A4FC3C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6637A370E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7769C207663;
	Wed,  5 Mar 2025 10:30:54 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6292E337F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170654; cv=none; b=L84k6ZiWM/NEUKMVbG/7ILFeMeYuDklRtWc/8romXZY3XTQT23BN0A9/BWQoUiaPCZp8bp8DjlqW6t/RxuYtHaegk3Xqmc/R24rAfZc8mg32FrzvypIio/ZOAOou6Q417gG9mpFwWbsOIXts1mrDgPdAeCK1DoocLkWUe10xUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170654; c=relaxed/simple;
	bh=Xnpvn3GB0yvJoLSlTxEHrnTkhA3BtP2tRDX7Q/arrZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SlvSwbKq5uHanuviSDr0YkXBjHpREJZaafp89Pq1B7QkhBPyuGfAuvFNcJVkPhxCSubmy/Tg/m5YBn1gn0YwxcdZ+DJx4bZN8KoPotqibwue1PbUfZG5f+2d3qlo5wPLJ1ORwipZiHFdDjnwmcHLeP4uR8e4Hthc19TjXtSeSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201622.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202503051830462016;
        Wed, 05 Mar 2025 18:30:46 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 18:30:45 +0800
Received: from locahost.localdomain (10.94.12.149) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 18:30:44 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <victor.liu@nxp.com>, <andrzej.hajda@intel.com>,
	<neil.armstrong@linaro.org>, <rfoss@kernel.org>,
	<Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
	<kernel@pengutronix.de>, <festevam@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] drm/imx: legacy-bridge: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 18:30:42 +0800
Message-ID: <20250305103042.3017-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2025305183046060fe9fadcf87c8f56f6a3c52dd092ef
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c:79 devm_imx_drm_legacy_bridge() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c b/drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c
index 3ebf0b9866de..55a763045812 100644
--- a/drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c
+++ b/drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c
@@ -76,9 +76,9 @@ struct drm_bridge *devm_imx_drm_legacy_bridge(struct device *dev,
 	imx_bridge->base.ops = DRM_BRIDGE_OP_MODES;
 	imx_bridge->base.type = type;
 
-       ret = devm_drm_bridge_add(dev, &imx_bridge->base);
-       if (ret)
-               return ERR_PTR(ret);
+	ret = devm_drm_bridge_add(dev, &imx_bridge->base);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return &imx_bridge->base;
 }
-- 
2.43.0


