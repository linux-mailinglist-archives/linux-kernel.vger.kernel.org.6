Return-Path: <linux-kernel+bounces-575425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBB0A70256
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC9437A883F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE90258CC9;
	Tue, 25 Mar 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lSMIlPKB"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CE82566EA;
	Tue, 25 Mar 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909433; cv=none; b=N4z99fntGXg3eJKRrE+gTzZ/gZVpXvjqcOThopWgEM+SYGNZdJhxo6Rp2dtxX+lfh9JA9IDBBPK9T/AlDhnyhWjweEoHiSlXh/BNYhqqBc0XCmCBLTbvOS/G2dsCM9BPODrVJQ9oQvt8Vn9UiQomMW79nD1f4MqncBP7LGlOHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909433; c=relaxed/simple;
	bh=J/FkQ+SkHYYoPQcELkb+tIcpNOe26kLfqD3rb2wWEoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNDx+RZTIQQc9y8ygp2eLjiTAu0kqKl4TnJKDUAWiyqp0GAhDOdZYZRTJZL0n+L8v/D8VdJf9MGA1BFvH2zUFsqeTvPyNdUujAagCpP+OTxDwpV74VPpzqVTlRnpiv0+ngNqnsyfjXWr59ZzEmfeJOSos+YV6ieVpCkl2FYvrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lSMIlPKB; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=XjB5C
	GDy56iSBUj/onMIQC1Fw0WRXap96Du59NyDvPE=; b=lSMIlPKBaavnVZ2+ML+uR
	sMEo+rGV5CvITGeiAufzj/GX2TxZ0m94rvlK8Bu6zxgsIx1vLIbpeNJanvOFLON5
	CRJFXKa50V+dEkyR2P3t34H985oSIW/pOeznLZguap7Q/WcDmkOpu/m2Z6xwg4/f
	wySlR1QbqSEbJB0LDkzvSA=
Received: from ProDesk.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnc2bLr+JnWNnrAA--.35530S7;
	Tue, 25 Mar 2025 21:29:55 +0800 (CST)
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
Subject: [PATCH v2 5/6] ARM: dts: rockchip: Add ref clk for hdmi
Date: Tue, 25 Mar 2025 21:29:39 +0800
Message-ID: <20250325132944.171111-6-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325132944.171111-1-andyshrk@163.com>
References: <20250325132944.171111-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnc2bLr+JnWNnrAA--.35530S7
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1xJw4kAFWfZry3tw4xWFg_yoWDWFX_t3
	WIgw15GF4fGrZIq34Dtr4UW39F9w4fC397XrnYqr4UJF9aqr4UXF4kGayIyry5Jay2g3sx
	CFZ5Xw4aya1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Jrc3UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkB4bXmfirygTGgABsB

From: Andy Yan <andy.yan@rock-chips.com>

The RK3036 HDMI DDC bus requires it's PHY's reference clock to be
enabled first before normal DDC communication can be carried out.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

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


