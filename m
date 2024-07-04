Return-Path: <linux-kernel+bounces-240837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B758892736B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4596EB221BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2161AB90D;
	Thu,  4 Jul 2024 09:55:36 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551F146A99;
	Thu,  4 Jul 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086936; cv=none; b=S0nhXIbF5M6O8F+zWiU+rfpXluiitWl9Pgz8YAhAF/Da522y+76k1UDgIvFTL6lCCkBPI3/LNEPvZpj11mYKdn7PDjtwTdyqcKBxy9hIOIMcENsNWTkEF7o4c+dsicSMSnvet+eW8Tf9CmLsv5UgMCRzHuNeKs5mJLqkg7kFazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086936; c=relaxed/simple;
	bh=B36r15eLblaw9PPJJ/xghiWCVfByGfZOJ+XELQtt32E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQZbg+HwuoOFVT/eDuK49sUgogcCshORou/Hon/0P/i/6ESweOFeWBikL7QPreVwGpFuHcF7FndLfGv31o/0C54LTxU3hIAagHxVA9X5ZYjZTClTZib4SO3rXpW5e+baQq1YPVBVgEH3FGCSCOnI4urD4j/vOmMwICpoRK9+soE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPJBX-0007Vl-Ss; Thu, 04 Jul 2024 11:55:27 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dsimic@manjaro.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add ROCK 5 ITX board
Date: Thu,  4 Jul 2024 11:55:23 +0200
Message-Id: <20240704095524.788607-2-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704095524.788607-1-heiko@sntech.de>
References: <20240704095524.788607-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding for the ROCK 5 ITX board, built around the rk3588.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index d2e887415d5dc..bd5c1ae2487ce 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -816,6 +816,11 @@ properties:
           - const: radxa,rock-3c
           - const: rockchip,rk3566
 
+      - description: Radxa ROCK 5 ITX
+        items:
+          - const: radxa,rock-5-itx
+          - const: rockchip,rk3588
+
       - description: Radxa ROCK 5A
         items:
           - const: radxa,rock-5a
-- 
2.39.2


