Return-Path: <linux-kernel+bounces-332214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F8397B6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 04:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F551C219FC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 02:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1399154279;
	Wed, 18 Sep 2024 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mYrzoEgk"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1122AE6A
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 02:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726626846; cv=none; b=tMol24em1rA5qwbSuiQY7hX5KOw1e9tEpeRXiF4FF6T6+RdBPiM+HgjZaYn3w9dgo0RrpmLt9hIvpr5LaNPtQQDSoy03ozfiLverwYBS9GXUO9AI+TTNV1bwM9GKCnDsr2Ol2wNCu1a47H+pX9bF94J65UEZyLOCAFKxzQJOjQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726626846; c=relaxed/simple;
	bh=h3YDbuKLoWvCJMBwiFTdUnD0PbLI0ekv27nCxoAdbCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PqlSdGMwSKIzJ6bHnDy4j/o0/ptZJPLe0RVg052y4OEV/5h3lSdbuf0lnfcC/Jh9b+xO0TmYE0kymb9xhuxZE6XnJ+52TwYUyNZXo8FKvhJ0aGzMLp7fRPCpPVfpyP+z4fPPd9ay9IeQOzN1VxMLbAMMum+ZrNiZ5PUfUnC3l4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mYrzoEgk; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726626840; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3qLw/Od5UmDZ19I6DykV+eKlxsisqhpJH2+/epwDaQo=;
	b=mYrzoEgkmCaMzmGwspJs7GXbxKcJbCeBTN9F9uRci+MxTvI+PwoEsRA1BEp+OpikWBz+u3FUSIxDTKCICeeoLuFN3wOIwFF7NuBQ6kTsmL57vxTvFu0sJD8egb3BeZSuTUh04Lpc42FdSE9gpHUseyo7q2FFK/AEBj2HQ2tfSmQ=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WFCLPA4_1726626839)
          by smtp.aliyun-inc.com;
          Wed, 18 Sep 2024 10:34:00 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: quic_abhinavk@quicinc.com,
	robdclark@gmail.com,
	dmitry.baryshkov@linaro.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] drm/msm: Remove unneeded semicolon
Date: Wed, 18 Sep 2024 10:33:57 +0800
Message-Id: <20240918023357.59399-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c:282:2-3: Unneeded semicolon

This patch removes an unneeded semicolon after a switch statement in the 
pll_get_post_div function. Adding a semicolon after a switch statement is 
unnecessary and can lead to confusion in the code structure.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9852
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
index 0e3a2b16a2ce..65cf237c6b4e 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
@@ -279,7 +279,7 @@ static int pll_get_post_div(struct hdmi_8998_post_divider *pd, u64 bclk)
 	case 25:
 		found_hsclk_divsel = 14;
 		break;
-	};
+	}
 
 	pd->vco_freq = found_vco_freq;
 	pd->tx_band_sel = found_tx_band_sel;
-- 
2.32.0.3.g01195cf9f


