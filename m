Return-Path: <linux-kernel+bounces-306267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15091963C46
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1045286C34
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46B516D314;
	Thu, 29 Aug 2024 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nk1AU2E3"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9231662F1;
	Thu, 29 Aug 2024 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915435; cv=none; b=HK+WcyTeNSTCyBKvIukq1Bec8DeRBEh8JewJwzEqrx7XOtqm7GI/62pmSgppn14TvulUc2TeOlGlvlvsclGLZ8d69rbalfrICtxXma8QDbo54rYbt4KffwoZlzE6e34X/5RTrCNp4iKlymtulsNCEfwj8sioRXKZoxRfkDf75n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915435; c=relaxed/simple;
	bh=/1bk6ig0mZ2705NmSEsskvxa1wm0Q7AbWkHZpTCnT+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCr3NyUGxb7QMC16uhojltfRj+bkwC3hYd5yz2EqmLHCfhIf/dxJBCJDp0PcIydeRv6eUMnePLhOGWMbPLeno+bhP1q8pjNH+N32Gt0PvJcfUTqK4YMbGOdNrltsYmwj5RuGenLM5qF34vYScSeSbCMjdpw5p7jRcKZSvQk0GqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nk1AU2E3; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1724915386;
	bh=G17wUqI7B2rO5FwmR3peN5s0wZnDhY7baRdIUk2Im3g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=nk1AU2E3SoGFnV7LLpyBwPgXOffUP1U59w2xh0wGVUlIJPmxCy1U+fcKCl+rsMg3O
	 Z2Oewv9XIY7M9kIZoNblciWy67tv2Kqzxsm50djZdE5nfyLJGAKY6SUE2mSrClj/Wc
	 Vt9rHacWAAtoX0aEMsuot+CcwcRtQiqmauFpQIqE=
X-QQ-mid: bizesmtpsz8t1724915381ti2q6gw
X-QQ-Originating-IP: FEiZ5/rk3EQZaeYu2X7p/2vmMIAYN04RGP6hu/xvM1A=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Aug 2024 15:09:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8785992708543308915
From: WangYuli <wangyuli@uniontech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	shuaijiakun1288@phytium.com.cn,
	davidwronek@gmail.com,
	andre.przywara@arm.com,
	chenbaozi@phytium.com.cn,
	quic_rjendra@quicinc.com,
	lpieralisi@kernel.org,
	neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de,
	rafal@milecki.pl,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] dt-bindings: arm: cpus: Add Phytium FTC series cpu compatible
Date: Thu, 29 Aug 2024 15:09:33 +0800
Message-ID: <234DC989E49C885B+20240829070933.299723-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Chen Baozi <chenbaozi@phytium.com.cn>

Document the compatible string for the FTC series cpus found in Phytium
SoCs.

Co-developed-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Co-developed-by: Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
Signed-off-by: Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml        | 6 ++++++
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index f308ff6c3532..75feb8007370 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -188,6 +188,12 @@ properties:
       - nvidia,tegra132-denver
       - nvidia,tegra186-denver
       - nvidia,tegra194-carmel
+      - phytium,ftc310
+      - phytium,ftc660
+      - phytium,ftc661
+      - phytium,ftc662
+      - phytium,ftc663
+      - phytium,ftc664
       - qcom,krait
       - qcom,kryo
       - qcom,kryo240
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a70ce43b3dc0..2f974964e6b1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1136,6 +1136,8 @@ patternProperties:
     description: PHICOMM Co., Ltd.
   "^phytec,.*":
     description: PHYTEC Messtechnik GmbH
+  "^phytium,.*":
+    description: Phytium Technology Co., Ltd.
   "^picochip,.*":
     description: Picochip Ltd
   "^pine64,.*":
-- 
2.43.4


