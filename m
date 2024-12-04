Return-Path: <linux-kernel+bounces-432035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D18979E461F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D1DB67BFE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1196F23919E;
	Wed,  4 Dec 2024 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="eQrkpD6h"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70361A8F9C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339234; cv=none; b=UrjvGCmPSSqkiNmvPzCawXpnpamN644ChfdGaIw0zun8gjbpBXUzushicxbM1B+5NgVo+wjz0/Z902SmoBgwGTcvooaybanNuKak/Kz9k/FMOtNdNe3Gag9+Brs1J2Q+uoEBLBUcVkx4Y18/kKKOQzpR07ZQSQXV/tsE4x6lH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339234; c=relaxed/simple;
	bh=aQE1gmaRdLJ7mHFEJuV0eH30B18Gkbbass08/5idHG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MK72I486fNNJ6BecCIn+sRs0jZ4XS2iPWkhHqB+tjLJZRpc3Gc4LkJ7aRjWFEnVThaH22KKHwexGCn1gZrcRhmTdRb40Zq8kdvJyvOLBrOFqHlVjPPoBITT2weUGw5Mh7vt6FKWhLHJ7rupS3X7LTYIt4mPJMm16UG86Jc7ReIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=eQrkpD6h; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1733339231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lSfZLSwrFfKO4D+tL1HHWmCXCga7hprCT6tDTU5BJ4=;
	b=eQrkpD6hvWCLJmo0fgibWsvez7c+vM0S65jUKaHpvVUrSn0Q8GlqRUmwS4dtLeTCIRhXoc
	0L/2ohKwmjRH6aWARiXJLulyt2uW2pjWRE4mip+enrD7Iw2GL6ftKxZ4lABYeTGHNomu8F
	kuyyHirZ9VZnIg9MkTnYuG4b/u6XO4VRzmbQ5YTEzEy4Ppm0T6vFS7eNwoqlJ+588K1HGJ
	x3s61U8qk5vVHAt4elheQ4WX+U8ts76nKqA12wsSzG0Iy1ZZMTokOY70FxpRyHLK59P9j6
	Ac4J6LgR9KOcr8NkAj9q/NGW6fw0qH5jjJA6T7QPuarmYeJ+QxtOErVGwGcqNg==
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Fabien Parent <fparent@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/5] arm64: dts: mediatek: mt8516: fix wdt irq type
Date: Wed,  4 Dec 2024 16:05:05 -0300
Message-ID: <20241204190524.21862-3-val@packett.cool>
In-Reply-To: <20241204190524.21862-1-val@packett.cool>
References: <20241204190524.21862-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The GICv2 does not support EDGE_FALLING interrupts, so the watchdog
would refuse to attach due to a failing check coming from the GIC driver.

Fixes: 5236347bde42 ("arm64: dts: mediatek: add dtsi for MT8516")
Signed-off-by: Val Packett <val@packett.cool>
---
 arch/arm64/boot/dts/mediatek/mt8516.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index 444429341302..098c32ebf678 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
@@ -206,7 +206,7 @@ watchdog@10007000 {
 			compatible = "mediatek,mt8516-wdt",
 				     "mediatek,mt6589-wdt";
 			reg = <0 0x10007000 0 0x1000>;
-			interrupts = <GIC_SPI 198 IRQ_TYPE_EDGE_FALLING>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
 			#reset-cells = <1>;
 		};
 
-- 
2.47.1


