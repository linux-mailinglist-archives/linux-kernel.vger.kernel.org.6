Return-Path: <linux-kernel+bounces-546573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8053EA4FC56
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303A916E023
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C2920AF97;
	Wed,  5 Mar 2025 10:35:50 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42426207A2B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170950; cv=none; b=sYpg+DFqh5NAjNB8HLCDbdkSh5MBLZT4R4YoX9+InwS1U4pGJxFE4kFovzI7ni5wGL2jEF7Tbd5dVWR9xCqq35vm0Mx+0livebaRmR+wYPLQ7bJt82Mjg/HfvtqcqtZuwl70KA3BUfNmrChdXaJpz7WQ0biHodVEFtG/2I4hPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170950; c=relaxed/simple;
	bh=AWAy+MhAcRApNnHLYuwTVxFiaH4IigRguFa6qkwG8JI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VnEnEE0Dg8p6XVKZt4orRbwCeEZOZzr850cJxSYvG1U7QUsOHX4PICQJ8YSP46Koldrg9UJUlPh+QiDJ00jAW4uxmtunt8Fe/6xCyJddPAZ4m78ravmBIrHwX0FVNmPjr0J4JjBoe40Ynk1MurUhNnoiPtVcCzSD5nYBPATAXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201617.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202503051835434057;
        Wed, 05 Mar 2025 18:35:43 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 Jtjnmail201617.home.langchao.com (10.100.2.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 18:35:43 +0800
Received: from locahost.localdomain (10.94.12.149) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 18:35:42 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <festevam@denx.de>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	"Charles Han" <hanchunchao@inspur.com>
Subject: [PATCH] drm/bridge: dw-hdmi-cec: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 18:35:41 +0800
Message-ID: <20250305103541.3207-1-hanchunchao@inspur.com>
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
tUid: 2025305183544ad7ba2d202250f4e9f518ab2a1c59f09
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c:336 dw_hdmi_cec_suspend() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
index 9549dabde941..9d5bded54e8b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
@@ -333,9 +333,9 @@ static int dw_hdmi_cec_suspend(struct device *dev)
 	struct dw_hdmi_cec *cec = dev_get_drvdata(dev);
 
 	/* store interrupt status/mask registers */
-	 cec->regs_polarity = dw_hdmi_read(cec, HDMI_CEC_POLARITY);
-	 cec->regs_mask = dw_hdmi_read(cec, HDMI_CEC_MASK);
-	 cec->regs_mute_stat0 = dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT0);
+	cec->regs_polarity = dw_hdmi_read(cec, HDMI_CEC_POLARITY);
+	cec->regs_mask = dw_hdmi_read(cec, HDMI_CEC_MASK);
+	cec->regs_mute_stat0 = dw_hdmi_read(cec, HDMI_IH_MUTE_CEC_STAT0);
 
 	return 0;
 }
-- 
2.43.0


