Return-Path: <linux-kernel+bounces-260362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F0E93A7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EFF1C22525
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA51428E7;
	Tue, 23 Jul 2024 19:55:50 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106261422C2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764550; cv=none; b=QDSM9T1aPFk1kONsbgZ7ThOoV2+HCDkc0xkXx+VA26TA3KclBdB6uoekV1IROKJf+EDSbKl9jMSX0qT8BzRE/WZ6ERK3y64Z51swuZKIT5PxUfYaDcpsBzYkOnVdIFA30tuUSDt1gKEVT0HEqxBiAB22sD6oIzGeqXpjCCUoirQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764550; c=relaxed/simple;
	bh=S3ho6SUmTBF2bE3IDyNrQVkY8d9GBQFzhD6s7sACLbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcb8/GxOQccuBjIBDzsUaKIG9c9L6CsJ+M5H8fVgT6mqznaUtav8BQ3C4mjvq7ZMmtOfLFeo9wTjtMljXr74syuVpGGku3SPKVCNUETjq4Qg8SmJDAd4kAyswPYbLBktNqqc8P+OXJrfcmsuOMKRs1+oC666JbpVDpRgvJWtaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sWLbt-0005iD-RD; Tue, 23 Jul 2024 21:55:45 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/14] arm64: dts: rockchip: add board-aliases for Qnap-TS433
Date: Tue, 23 Jul 2024 21:55:31 +0200
Message-Id: <20240723195538.1133436-8-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723195538.1133436-1-heiko@sntech.de>
References: <20240723195538.1133436-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the aliases for the internal network interface as well as the emmc
on the board and make sure the dedicated RTC is always the first one.

The TS433 actually has two rtc devices. One coming from the rk809 pmic
without added functionality and also a dedicated RTC from Mycrocrystal
that is battery backed to keep the time.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 40af4dd0e4158..8be36250aa13d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -13,6 +13,12 @@ / {
 	model = "Qnap TS-433-4G NAS System 4-Bay";
 	compatible = "qnap,ts433", "rockchip,rk3568";
 
+	aliases {
+		ethernet0 = &gmac0;
+		mmc0 = &sdhci;
+		rtc0 = &rtc_rv8263;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
@@ -120,7 +126,7 @@ pmic@20 {
 &i2c1 {
 	status = "okay";
 
-	rtc@51 {
+	rtc_rv8263: rtc@51 {
 		compatible = "microcrystal,rv8263";
 		reg = <0x51>;
 		wakeup-source;
-- 
2.39.2


