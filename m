Return-Path: <linux-kernel+bounces-318142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DE96E8EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A761F21F73
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5E7132122;
	Fri,  6 Sep 2024 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="U9P52Qem"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6598E22083;
	Fri,  6 Sep 2024 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725598669; cv=none; b=MJCs1SG8wu9/SzSCeJks1i7raTGCkHOpNN9k074C4/hIUAmnN3IoPQI7ojLGyHzSg/Ycoo2K3bu5c3/RpKmAdKoK0tepcfk4oB4IIfoFIZ1nyAvyvQoAuEQD5Jb+HFjLsqQWrG1DoRlJNxrjYcmJclhickkTd1+2GJzIbjrhQJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725598669; c=relaxed/simple;
	bh=FioZbFsqKSkS/Sy1RvfYGlpHb595eLr0VdZ/M+Xi57U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHfpapYfKpST0sYXLRmwue/6T4LQnNVBS++Db4a+t+4E8AcDj7BKrex1VQlVXOr8bD1UzGyFCXdtunjfo1Iba8dDbju0hL4bffOMoXOaVrHAzc7NrsG2m8Fk8hXwgpDfAZK8+JngAbqDXy82Vtenkqpsk0vIBsVLiFHJwzh6S0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=U9P52Qem; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.35])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id ABDD9789F8;
	Fri,  6 Sep 2024 12:57:44 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn ABDD9789F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725598665;
	bh=sOBPTuPF4zmIgVmwMf5d2zudagfmiya2aemwjU2TiLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U9P52QemA2xfP7pkxhc7GyoUL+JR9x75npQbkzDZzYl+WcHwl3HEzz+jEn112Tm2E
	 HHEylRMf4rm7qJVp4sXr97dOW+RuT0+AlCkZ930F2C9rDEwtD6JDPPL0Jl1XX4jq+z
	 gOBExygmSDrWGTBHEdzssLtS6eL9pGrUidSZ6ICQ=
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
Subject: [PATCH v2 2/3] dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
Date: Fri,  6 Sep 2024 12:57:05 +0800
Message-ID: <20240906045706.1004813-3-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906045706.1004813-1-bigfoot@classfun.cn>
References: <20240906045706.1004813-1-bigfoot@classfun.cn>
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
index 1ef09fbfdfaf..b2c83c9b287a 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -49,6 +49,11 @@ properties:
               - anbernic,rg-arc-s
           - const: rockchip,rk3566
 
+      - description: Ariaboard Photonicat RK3568
+        items:
+          - const: ariaboard,photonicat
+          - const: rockchip,rk3568
+
       - description: ArmSoM Sige7 board
         items:
           - const: armsom,sige7
-- 
2.46.0


