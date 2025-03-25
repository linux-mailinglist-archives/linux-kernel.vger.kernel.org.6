Return-Path: <linux-kernel+bounces-574867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162F2A6EAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F459188EA95
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12A5254843;
	Tue, 25 Mar 2025 07:55:16 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CDA1F03DC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889316; cv=none; b=MlqxlTeg60ejpUhtFxVdVlHcEWReg2cbKxKSEWH3n6eey+gEfsEFIvZncHUSzuFWONnNUjmVnzzAdPnPt8n/fH5C2BKWlu5+WQfnOaTq+P775lCLWkQbpVhnKpBgB9nCgSsqNlR2Du/j+VfoVqdYCyBFNkI0aI8D4AjpV6sVq+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889316; c=relaxed/simple;
	bh=Xnpvn3GB0yvJoLSlTxEHrnTkhA3BtP2tRDX7Q/arrZA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CKHw3fBnn4oruGcJG7KVL8Un7q1OlvToyokTpzsmO+11QE2l0q0IdUJOE+wesnn9RNWpkfeEA2OQ6qxuTevUW43bNNMdlLah111up3bVgvY8ArW2OqjUswEDQk07DkgQ1iujTe4G7lH0FBZFXDDJ1jHKuzv7tNyecZSok++Wiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201611.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202503251555056539;
        Tue, 25 Mar 2025 15:55:05 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201611.home.langchao.com (10.100.2.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Mar 2025 15:55:05 +0800
Received: from locahost.localdomain.com (10.94.16.22) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Mar 2025 15:55:05 +0800
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
Date: Tue, 25 Mar 2025 15:55:03 +0800
Message-ID: <20250325075503.3852-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 20253251555055fdb3c6ea51ffa8c946f4d24c6089682
X-CorpSPAM-Fhash: Yes
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


