Return-Path: <linux-kernel+bounces-221907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C249090FA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC4F1F22447
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBED11720;
	Thu, 20 Jun 2024 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XSsDeqRu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EEF6FB9;
	Thu, 20 Jun 2024 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843911; cv=none; b=as2tLm4fuSIKd74cAULMMGzPzPquQbjg/XImerVU9xAOQGAQTCTK7hnc60MYwTZ8LvIuU9WjkhfXHngLk7eIBW5tNHTUOOoMi5W5rwOqonkeM54JbZAMoC+riRhm0nYIENkqiEzApGoipPvfQu02KQckRSv6Mwb/62h9ffe1kqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843911; c=relaxed/simple;
	bh=DUumqL7rzqsTDAUT3dMeqFEijCCpD7CQ16OMA3dYjVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvBvwYnL0BpMqCP+uTpFretY6X/Ix8UzV8l0n9txiYncq68p2zAKOqTfP19Yc1Xm2aRGE+7qbuzzeqxEVi6oE58A/H7kyESlXZ0ZoWPazvTYb1gFZwiQCNVZSxiojuVrk4aXuHVARWoThVCzfamE0D/M9kpznrq0St0Dz5fmhOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XSsDeqRu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718843909;
	bh=DUumqL7rzqsTDAUT3dMeqFEijCCpD7CQ16OMA3dYjVs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XSsDeqRunlR93PFTbpTPXm/iozbO4yoGjEuufg/HJyQOjNp27pQOp9uM0wdaDCfG2
	 xWOpP0SvDfwaVRqDFuqh9wG8kW+M7XGK/DVDGRYrkMZ2iJPkiSKvCMLoOSlBLrlyrq
	 GKVfkZv/cqoN2PprrygWT8yRfcBBUzdDxGtK2jate1UvC98Tzf1kgDlpLzHGlUHYih
	 cAwwFDj6n8L5RLjfOTJPhW1iD7R4oHde5CCGSjJnyDZK9whRDF+e9gZd9S6LxVkc0Y
	 8xibo3/2u3tXtURYBnpQN2IBGI88+q2mwtQroipm/sP9thM9vg9QWM37eqEbrWd86x
	 KqtnUA+j1TJbA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B912037821B2;
	Thu, 20 Jun 2024 00:38:28 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 20 Jun 2024 03:36:24 +0300
Subject: [PATCH v2 3/4] dt-bindings: phy: rockchip,rk3588-hdptx-phy: Add
 #clock-cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-rk3588-hdmiphy-clkprov-v2-3-6a2d2164e508@collabora.com>
References: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
In-Reply-To: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0

The HDMI PHY can be used as a clock provider on RK3588 SoC, hence add
the necessary '#clock-cells' property.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
index 54e822c715f3..84fe59dbcf48 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
@@ -27,6 +27,9 @@ properties:
       - const: ref
       - const: apb
 
+  "#clock-cells":
+    const: 0
+
   "#phy-cells":
     const: 0
 

-- 
2.45.2


