Return-Path: <linux-kernel+bounces-403533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6729C36EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5491528231F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01693347C7;
	Mon, 11 Nov 2024 03:17:06 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB2C2C18C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731295025; cv=none; b=RNpSGpr1sl8i463kHB996poHn10EtkSv9DL1NVeBxli5XpW5yHX1mKCs4iqQ62zZqMS78prhciOgYYrtRuKVAHVfSQEfpYwokjEdsgEwwfw+07+LvTedgKLhMuxyATZV+gsF/ncX1K4ysTK8O2z16VQrTLQAXAUr+lx2H5kRPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731295025; c=relaxed/simple;
	bh=xDqVRo2PDw/QX+tbzBDO7190Rfw5PQjOdYxwHpOWhgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OZJ4tsH0QuNseCeAHhcM+8jhXHMH9amAXu2Z9KQt7o9wDxIVa647AQUjUafUbJzBpjf2qSkQhSs0+0XfN6cyXKgOlYndqHkaUD67Ey5DTroZU3eqZ3bBD/LDdfcj6Rk79onmkcoDmwPKAn+UimNt/1I/KRqP1yQX0t9KW5IAWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee367317729572-cfd94;
	Mon, 11 Nov 2024 11:16:57 +0800 (CST)
X-RM-TRANSID:2ee367317729572-cfd94
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea67317728afb-105e6;
	Mon, 11 Nov 2024 11:16:57 +0800 (CST)
X-RM-TRANSID:2eea67317728afb-105e6
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: robdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	dmitry.baryshkov@linaro.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] drm/msm: Correct typo in adreno_pm4.xml
Date: Mon, 11 Nov 2024 11:16:55 +0800
Message-Id: <20241111031655.273475-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in adreno_pm4.xml where the word "swtich" was incorrectly
used. Update it to "switch" for improved readability and accuracy.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml b/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml
index cab01af55..d28fac3fb 100644
--- a/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml
@@ -563,7 +563,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<value name="IN_IB_END" value="0x0a" variants="A6XX-"/>
 	<!-- handles IFPC save/restore -->
 	<value name="IN_GMU_INTERRUPT" value="0x0b" variants="A6XX-"/>
-	<!-- preemption/context-swtich routine -->
+	<!-- preemption/context-switch routine -->
 	<value name="IN_PREEMPT" value="0x0f" variants="A6XX-"/>
 
 	<!-- TODO do these exist on A5xx? -->
-- 
2.27.0




