Return-Path: <linux-kernel+bounces-226103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0D4913A34
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 13:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86566280D76
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF31117FAAA;
	Sun, 23 Jun 2024 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IRT8AZsN"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E4E13D8B0;
	Sun, 23 Jun 2024 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719143819; cv=none; b=k0/bC33PpvuC4DMy5Me2oOVBbVAbP/0QAqrV0/odXnrnF3EYCV1+0XnlmNkLaJmUm60b5p4sYFNeSDAMqGSkQlrXZXgHfkD/hu2FxMjrs5ln/zMBuakgbyWfZ4W2Dy3/PxbOh9GmiZJTzmOo1Ku3//F2tSdRBY8uVBCwUUIee5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719143819; c=relaxed/simple;
	bh=5/zHGnLi6HtSuAHDMiRrXIcpjy+pX6Bnuzv5Wt4fcAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jyceU5XwSX1sE2T9cp7AzFaZPF4TOYtzANYqUPS1yD07QBTxTl8yN4fjBWl/AZwNw4QzJ03rAYmEuFL1tC9oAFN7EpfFZ3a6Eb3EJv4MwOL7u+T4PtR+aEVEqcDvyIN9ut07mGdKazPzzhYVo5nFx1BUkANbaWSi5EGbQuGScjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IRT8AZsN; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Oigqm
	upiGhc0+bR7xGBbesPJ+Gm/pnkDnghE2ytQOPQ=; b=IRT8AZsNfjRu+rKE7ouv8
	bWZUx0gt6dqGnBSGFLcgAqcukSaQYiABKFPSbtB7X5IIpwIbOEaHr+N/jLQwhw1y
	+gNUfE9ONku8N6y9sqKiTEf1xpF41iIf38lxpVo3ryqtQtxHep+gzDx90NKwL42d
	sajtXw6UupC8s04qlGlmzw=
Received: from ProDesk.. (unknown [103.29.142.67])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wDnL_AxDXhmbhirAA--.3562S2;
	Sun, 23 Jun 2024 19:55:33 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	didi.debian@cknow.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v2] arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi 4B
Date: Sun, 23 Jun 2024 19:55:26 +0800
Message-Id: <20240623115526.2154645-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL_AxDXhmbhirAA--.3562S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary8JFy3GFyfXw4kCrWxWFg_yoW8XFW7pa
	15ua9xJr1I9rWFgayqqanrXrsrCFs3tF4xCw17Gasayr47X34vqr17Xry3CFyjgF13Za1r
	ur15Jr1DKa1DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMD73UUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hsHXmWXyjN4YAAAsD

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

Changes in v2:
- Also change the address after @ to 0x10

 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index 20a0a60acd16..b0259b0d5021 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -300,9 +300,9 @@ &i2c7 {
 	pinctrl-0 = <&i2c7m0_xfer>;
 	status = "okay";
 
-	es8316: audio-codec@11 {
+	es8316: audio-codec@10 {
 		compatible = "everest,es8316";
-		reg = <0x11>;
+		reg = <0x10>;
 		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
 		assigned-clock-rates = <12288000>;
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
-- 
2.34.1


