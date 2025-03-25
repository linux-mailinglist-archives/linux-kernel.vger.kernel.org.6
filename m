Return-Path: <linux-kernel+bounces-574859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E5DA6EAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7773716EAC0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8719D8A3;
	Tue, 25 Mar 2025 07:47:19 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D872F3B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888838; cv=none; b=PgpAOzKns74PRVsifo/iShARzA7zh1pWVqu3b4sv8Tctv2o1H4+WgwKToL0TaThAPE8FZhfrUd+Pq4WAHBgdQW2O9CL4aZhAQPE7Kw0nVEp8Ioi3iT8HeUCtI24yIVN1uYYehXmnSCFvDlKw6SkUgC0LKpXI8ckqIhvusJAU0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888838; c=relaxed/simple;
	bh=AWAy+MhAcRApNnHLYuwTVxFiaH4IigRguFa6qkwG8JI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H/F2nSSec8AM5mr8JSiAGOM9WcrNQSg5tHalTytWhpaoQJD1TNYHehqFScdSqqoiPonJmXw3PDf0/l5JCDNYsCEVWgPZg6v6HrZbOg0XdKhSCMYk0uFH5L4MdecDx6gJKQdpJS5tHgYyRu+/JQAghm1leSL35T+fGbWUrIXgC4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201621.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202503251546589330;
        Tue, 25 Mar 2025 15:46:58 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Mar 2025 15:46:57 +0800
Received: from locahost.localdomain.com (10.94.16.22) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Mar 2025 15:46:56 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	"Charles Han" <hanchunchao@inspur.com>
Subject: [PATCH] drm/bridge: dw-hdmi-cec: fix inconsistent indenting warning
Date: Tue, 25 Mar 2025 15:46:54 +0800
Message-ID: <20250325074654.3669-1-hanchunchao@inspur.com>
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
tUid: 20253251546589baccb332c493b841dce48370d458980
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


