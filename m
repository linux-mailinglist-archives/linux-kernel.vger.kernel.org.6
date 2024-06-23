Return-Path: <linux-kernel+bounces-226009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF16913909
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 10:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7416A2822F8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146475B683;
	Sun, 23 Jun 2024 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LeyFSiA+"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C66BE6F;
	Sun, 23 Jun 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719131700; cv=none; b=jYaZZf6BOpyrWva7lfVvx3gADFOA5+gxTInVGIhRTzmms7aOF2AZtd4+m3yEo5ZGDoB8byWKewRpRwxbsDRTzAH6hyT4y1fDK0tBTMfA+mJVYonp+haZE1wLFLN2f1hRrrfS/dWMAkN2+jKYZKlPWTUR+rCwAHvzhki1R7ck3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719131700; c=relaxed/simple;
	bh=BhIkfRTetisfAaTZramypcPdzr3QZINiGgPlhDXYUO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AF9lD7+d7RS8JkUr3skZ8qkBM6kzx3kM+rDq0d5UIR1JQtNnXbt8rrfKRIIFo8G3yaioweF/+TMue83rzKv1nas70cxNFl5AScqM0ULuqRj335akLpKCxtNQ4C6Wtbky2O6sF1eD7yERYJTpBl2RbfXnpI/N8++yri5uHtR+XUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LeyFSiA+; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Pl0j2
	zhZ4/LwcqBnPNf0V3io50xd+ejg631E0UIKQMo=; b=LeyFSiA+Bijt+UJpCmBdh
	5w99jB+5mL6X0pbXyyn4wIs2pZ88kCPaANwJZXQifO60045hWV3B+jv0vdSaD9ne
	h4e0cZeQKC9IdFxFHjQpBCai3MgrNAw6k3XcOuD/JyJ6LSMCmRS23k82miPFspQA
	JwJHrE0N6HHUSpVHa2ybAA=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3X+oG3ndm3x2cAA--.62882S2;
	Sun, 23 Jun 2024 16:34:18 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH] arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi 4B
Date: Sun, 23 Jun 2024 16:34:13 +0800
Message-Id: <20240623083413.2051412-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X+oG3ndm3x2cAA--.62882S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary8JFy3GFyfXw4kCrWxWFg_yoW8GFy5pa
	15u39xJr109r4FqayqqanxXrsrCrsI9F48Cw17Gasayr47X34vqr17XryfCryjgF13Zan5
	ur15Jr1DK3WDZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziVHqxUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMw0HXmXAmBQZZAAAsz

According to the hardware design, the i2c address of audio codec es8316
on Cool Pi 4B is 0x10.

This fix the read/write error like bellow:
es8316 7-0011: ASoC: error at soc_component_write_no_lock on es8316.7-0011 for register: [0x0000000c] -6
es8316 7-0011: ASoC: error at soc_component_write_no_lock on es8316.7-0011 for register: [0x00000003] -6
es8316 7-0011: ASoC: error at soc_component_read_no_lock on es8316.7-0011 for register: [0x00000016] -6
es8316 7-0011: ASoC: error at soc_component_read_no_lock on es8316.7-0011 for register: [0x00000016] -6

Fixes: 3f5d336d64d6 ("arm64: dts: rockchip: Add support for rk3588s based board Cool Pi 4B")
Signed-off-by: Andy Yan <andyshrk@163.com>
---

 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index 20a0a60acd16..091dee37d068 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -302,7 +302,7 @@ &i2c7 {
 
 	es8316: audio-codec@11 {
 		compatible = "everest,es8316";
-		reg = <0x11>;
+		reg = <0x10>;
 		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
 		assigned-clock-rates = <12288000>;
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
-- 
2.34.1


