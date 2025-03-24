Return-Path: <linux-kernel+bounces-573499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD3AA6D85D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D469516C4C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFE025DCEB;
	Mon, 24 Mar 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="elvWNwM4"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2CE433A8;
	Mon, 24 Mar 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812456; cv=none; b=CJ2ccspcMNHhCbebyzATNXc2KEOHWKTs+mdBe4dIOyv/Z/+3vCQgnDSUcA7RoY4Rdflvr7K+S0UMg5ykzFCvDL45ax2+qFYF0KHR1zIKzU5tOfI4nxGIz6ko3IpMs8bZP5DZbVWUYHOgNAu5tlsAIjGARVvaU8SZf4/aumfCH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812456; c=relaxed/simple;
	bh=x/mD0bTH0CXdm70PWBi5rV+ZYD4VicWiXzaJVf4gyZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nl00TOjzhBlCwaOdjEPThvXFP57/AQgXv9kjAZVLc3NsKv3jT3CpxozA38aaW1OHvR7g3VTc6rTFflrVvg13ZrO6OSCcq+AYtIA6w39yYqsFawx5KuvVJiRdow6pmbgACYCZUibv7e1ltvZBcYjdvx6xSi64vgzRjZhK4pvWe2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=elvWNwM4; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=j+x/s
	crjOmcuG4u3tqntsDdabnal7byUoT1fHHBPuh8=; b=elvWNwM461rRXqkfAgtBB
	ppjW2/HxLzWcp1fUSO8y1uExIIoAlL4lk8VdwPK5yhsazfU3ON/fYB7n2yyMAV2p
	7P356nkCF9njBeTSfxPGu9rU005zTiTxyZGAgdx/yYFenRlTExApGinSpyASf9we
	+QX4TlUhcwAP398vVeYM9E=
Received: from ProDesk.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3TEH9NOFnDTbjAg--.63654S3;
	Mon, 24 Mar 2025 18:33:38 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	hjc@rock-chips.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 2/2] ARM: dts: rockchip: Add ref clk for hdmi
Date: Mon, 24 Mar 2025 18:33:28 +0800
Message-ID: <20250324103332.159682-2-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324103332.159682-1-andyshrk@163.com>
References: <20250324103332.159682-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3TEH9NOFnDTbjAg--.63654S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1xJw4kAFWfZry3tw4xWFg_yoWDGwc_t3
	WIgw15GF4fGrZIq34Dtw45W39Fvw4fC393XwnYqr4UJF9aqr4UXF4kJayIyFy5GFW2gasx
	CFWfZF4aya1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Wq2JUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBkaXmfhNMYG2AAAsf

From: Andy Yan <andy.yan@rock-chips.com>

The RK3036 HDMI DDC bus requires it's PHY's reference clock to be
enabled first before normal DDC communication can be carried out.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 arch/arm/boot/dts/rockchip/rk3036.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
index 6039a0908af1c..22685cd23a708 100644
--- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
@@ -403,8 +403,8 @@ hdmi: hdmi@20034000 {
 		compatible = "rockchip,rk3036-inno-hdmi";
 		reg = <0x20034000 0x4000>;
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru  PCLK_HDMI>;
-		clock-names = "pclk";
+		clocks = <&cru PCLK_HDMI>, <&cru SCLK_LCDC>;
+		clock-names = "pclk", "ref";
 		pinctrl-names = "default";
 		pinctrl-0 = <&hdmi_ctl>;
 		#sound-dai-cells = <0>;
-- 
2.43.0


