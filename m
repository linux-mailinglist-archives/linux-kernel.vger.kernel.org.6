Return-Path: <linux-kernel+bounces-324887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4921975223
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3861F2332B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE0F18EFE1;
	Wed, 11 Sep 2024 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="PnqRqeQT"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C9F185B7A;
	Wed, 11 Sep 2024 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057733; cv=none; b=CRdGgtX6mJQYmp2RQx/PkCx6IM6zZam/g51g63v+Jd1uvjSUcTA7iCZw5ufhXpLSIDHvxiTLaxk7icVvDtE4z34plDDZHXQcSWPUernt1AKByP9t/B7YlmcEUPrekKHqnpG/e2QS0rIhHNuvv3I0XBhJkBvb2AHPy1k30U2jXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057733; c=relaxed/simple;
	bh=TGse2xgHyrJ86lk+geFp8JWO8clvO33za4oO/yaOSzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3TwDcAb6/DBayHv8r814Sv/voecIrra8bbDeWoPoDbq193xtqfnwG0wLsJXu351tiWneZXf8JObds1P4J4PMKSLij4NRbWqsbrJ1Sf34xyOucS1pVN1LE0mI+mhSBPoZIqt+jAoY8ImLp7/EhPRJ0nOkjvxF6Wn3oQuOnX2GtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=PnqRqeQT; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.173])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 5DE7D7890F;
	Wed, 11 Sep 2024 20:28:48 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 5DE7D7890F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1726057729;
	bh=lRER49IU2r+IDAkeANEnbgPaU7VQG0ThpFJyDhD3UTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PnqRqeQT/v5rOs3iAV7HYfGeevEPY97wc4GLRvb5FEg0C/ka4TQcMudR1ubawucPw
	 itrJ7Dpjx8X9W9HN6ShKNgDLIv5Eek0VO2rweE4XrzKkf01G6TN454QyxkDtyNTtBJ
	 ybb2syV4k0sRqYBierEcHb9ppv5wvgoG8tyLGExw=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
Date: Wed, 11 Sep 2024 20:28:09 +0800
Message-ID: <20240911122809.1789778-4-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911122809.1789778-2-bigfoot@classfun.cn>
References: <20240911122809.1789778-2-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents Ariaboard Photonicat which is a router based on RK3568 SoC.

Link: https://ariaboard.com/
Link: https://photonicat.com/

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..c35541b56175 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -49,6 +49,11 @@ properties:
               - anbernic,rg-arc-s
           - const: rockchip,rk3566
 
+      - description: Ariaboard Photonicat
+        items:
+          - const: ariaboard,photonicat
+          - const: rockchip,rk3568
+
       - description: ArmSoM Sige7 board
         items:
           - const: armsom,sige7
-- 
2.46.0


