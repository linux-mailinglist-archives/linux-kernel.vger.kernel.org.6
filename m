Return-Path: <linux-kernel+bounces-527664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC0BA40DF7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631B53BA6E2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA22045BC;
	Sun, 23 Feb 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Sx0V7dpm"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99291E871;
	Sun, 23 Feb 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740305318; cv=none; b=rC+QCyPomM7XZdeeC2LJZuvHqxkgLXbwyIWmtCv01QX9ixWsC6U2vxLufa92Rn3cBLmvnYz+GF4UBy+i4tfM+WtI1JRhH0btRxq2iSVyXDWPJLO64cORT9pgoz9u9AlVW/mkgxrvNRLFi7vJ12DpWI+8eT76kKmBe54HPBazCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740305318; c=relaxed/simple;
	bh=+00dd9r5ABncamWfY/yQJjKxVGD54H6NzQckhYmCPqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDd0zLJ4QPvygO03m8odCIR/4P0iho7dIy3opXwv9PKfbVkD5oz4RRBPRSKvVyQ4CNLfHLcjIHRIo+C0Ka4fHxKW+ucKyxXkRT1QVz8zOHJZqT/wlIgtavgyQfDlhXNH35hNKRqZ3j33Czk82cYVpSWljOdrd3SMgmeDZN3DCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Sx0V7dpm; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=qjFPs
	7F+XO2HKOCjLIfMrNdfI+E1rn21TAwcThQVHuY=; b=Sx0V7dpmMVrZUXv0rakZC
	zIjXW0B/u+sl4ab7/wRyY0E+JnewWZ9IHAjKHMth5x5pw41DM2iEbSvmgfgamvar
	srJxuEXRvzGGY8c7yocIc5e2ZiiYsFtPi3c+08riuylQIDzkFZ1pisAftAy7dmkz
	KMi+uoOquINEinH7G2tfq4=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnX7t+87pn0ncQOA--.33463S2;
	Sun, 23 Feb 2025 18:08:02 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH] arm64: dts: rockchip: Enable USB3 OTG on rk3588s Cool Pi 4B
Date: Sun, 23 Feb 2025 18:07:46 +0800
Message-ID: <20250223100757.73531-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnX7t+87pn0ncQOA--.33463S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtryrKr47KF1rZryUtFy3CFg_yoW8JF1fp3
	srCrW3Jrs3Wr4rAas8tr1Skrs3Aws5JFWfArn3A3ZIyF42g34kZr1rG3s3Zr4YqrW3Gayr
	CF1vgFy2gF4DtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi7KIdUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBj8Xme65IDlCwABsE

Enable USB3 OTG and it's related PHY node. And the PHY will
also be shared with the upcoming DisplayPort controller.

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index 9c394f733bbf..7faf189c4776 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -803,6 +803,14 @@ &tsadc {
 	status = "okay";
 };
 
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
@@ -832,6 +840,16 @@ &uart9 {
 	pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn>;
 };
 
+&usbdp_phy0 {
+	/*
+	 * USBDP PHY0 is wired to a USB3 Type-A OTG connector. Additionally
+	 * the differential pairs 0+1 and the aux channel are wired to a
+	 * mini DP connector.
+	 */
+	rockchip,dp-lane-mux = <0 1>;
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
@@ -840,6 +858,11 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	extcon = <&u2phy0>;
+	status = "okay";
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
-- 
2.43.0


