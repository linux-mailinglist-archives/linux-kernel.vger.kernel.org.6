Return-Path: <linux-kernel+bounces-546971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B132BA50154
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8838218861BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A1024BD14;
	Wed,  5 Mar 2025 14:05:33 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F181E24BC19;
	Wed,  5 Mar 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183533; cv=none; b=kSXj2zV0LBCo/Aq98BZRzgbg0xwTKoALnawS7xNQF2S3iM/Sdpntxo59Kex/OMxyTFk7ZfiksLDtD2U3q8NMqMhXe7t9tvo4W0osJptay62hgXynuEF7UoLHUWzNbFdbRiViIy+YHGEFSYZcosi+t0Pe8vlS5SPyH3iMq+CsIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183533; c=relaxed/simple;
	bh=qLgQ7hqXvB84rjpiCvPUIb5zzLPY1fnebfK09uf2liI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3+vVHqLmUOZ2XirKtlU/ZxI+k0LG5oAWNRmKgGMZw/rgtwR4eK7gXYZjEG4VWpSi7xN2hXrEaka26kT+rpNxfNRyG47eBNltBPn3qVKCHdFVY2VGGhzUGC0xBAHfjPtOMG8cCWoM8vC0npxeE82VF2ARlE/2TyUEsKqKYsfqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c02:1dd0:e727:1623:c5c6:9622])
	by smtp.qiye.163.com (Hmail) with ESMTP id d0a1b692;
	Wed, 5 Mar 2025 22:00:17 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Yao Zi <ziyao@disroot.org>
Cc: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 2/2] arm64: dts: rockchip: Add rk3528 QoS register node
Date: Wed,  5 Mar 2025 22:00:09 +0800
Message-Id: <20250305140009.2485859-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305140009.2485859-1-amadeus@jmu.edu.cn>
References: <20250305140009.2485859-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTksZVk1DGktKGRpIHUhPS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtJQUofH0tBHkxJTEFKTUlIQRhOGE1BQk1JSVlXWRYaDx
	IVHRRZQVlPS0hVSktJQkNDTVVKS0tVS1kG
X-HM-Tid: 0a95669b70b503a2kunmd0a1b692
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCo6SCo4CDJRTT8CFCsJFiEi
	STEwC09VSlVKTE9KSkNISUpDTkNPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0lBSh8fS0EeTElMQUpNSUhBGE4YTUFCTUlJWVdZCAFZQU9DTEM3Bg++

Copy QoS nodes and add rk3528 compatible from bsp kernel,
these can be used for power-domain.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 160 +++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 5b334690356a..794f35654975 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -122,6 +122,166 @@ gic: interrupt-controller@fed01000 {
 			#interrupt-cells = <3>;
 		};
 
+		qos_crypto_a: qos@ff200000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200000 0x0 0x20>;
+		};
+
+		qos_crypto_p: qos@ff200080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200080 0x0 0x20>;
+		};
+
+		qos_dcf: qos@ff200100 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200100 0x0 0x20>;
+		};
+
+		qos_dft2apb: qos@ff200200 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200200 0x0 0x20>;
+		};
+
+		qos_dma2ddr: qos@ff200280 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200280 0x0 0x20>;
+		};
+
+		qos_dmac: qos@ff200300 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200300 0x0 0x20>;
+		};
+
+		qos_keyreader: qos@ff200380 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff200380 0x0 0x20>;
+		};
+
+		qos_cpu: qos@ff210000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff210000 0x0 0x20>;
+		};
+
+		qos_debug: qos@ff210080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff210080 0x0 0x20>;
+		};
+
+		qos_gpu_m0: qos@ff220000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff220000 0x0 0x20>;
+		};
+
+		qos_gpu_m1: qos@ff220080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff220080 0x0 0x20>;
+		};
+
+		qos_pmu_mcu: qos@ff240000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff240000 0x0 0x20>;
+		};
+
+		qos_rkvdec: qos@ff250000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff250000 0x0 0x20>;
+		};
+
+		qos_rkvenc: qos@ff260000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff260000 0x0 0x20>;
+		};
+
+		qos_gmac0: qos@ff270000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270000 0x0 0x20>;
+		};
+
+		qos_hdcp: qos@ff270080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270080 0x0 0x20>;
+		};
+
+		qos_jpegdec: qos@ff270100 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270100 0x0 0x20>;
+		};
+
+		qos_rga2_m0ro: qos@ff270200 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270200 0x0 0x20>;
+		};
+
+		qos_rga2_m0wo: qos@ff270280 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270280 0x0 0x20>;
+		};
+
+		qos_sdmmc0: qos@ff270300 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270300 0x0 0x20>;
+		};
+
+		qos_usb2host: qos@ff270380 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270380 0x0 0x20>;
+		};
+
+		qos_vdpp: qos@ff270480 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270480 0x0 0x20>;
+		};
+
+		qos_vop: qos@ff270500 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff270500 0x0 0x20>;
+		};
+
+		qos_emmc: qos@ff280000 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280000 0x0 0x20>;
+		};
+
+		qos_fspi: qos@ff280080 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280080 0x0 0x20>;
+		};
+
+		qos_gmac1: qos@ff280100 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280100 0x0 0x20>;
+		};
+
+		qos_pcie: qos@ff280180 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280180 0x0 0x20>;
+		};
+
+		qos_sdio0: qos@ff280200 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280200 0x0 0x20>;
+		};
+
+		qos_sdio1: qos@ff280280 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280280 0x0 0x20>;
+		};
+
+		qos_tsp: qos@ff280300 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280300 0x0 0x20>;
+		};
+
+		qos_usb3otg: qos@ff280380 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280380 0x0 0x20>;
+		};
+
+		qos_vpu: qos@ff280400 {
+			compatible = "rockchip,rk3528-qos", "syscon";
+			reg = <0x0 0xff280400 0x0 0x20>;
+		};
+
 		cru: clock-controller@ff4a0000 {
 			compatible = "rockchip,rk3528-cru";
 			reg = <0x0 0xff4a0000 0x0 0x30000>;
-- 
2.25.1


