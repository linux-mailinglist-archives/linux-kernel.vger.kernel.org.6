Return-Path: <linux-kernel+bounces-553920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6573FA5909D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221573A63EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DBA224AE0;
	Mon, 10 Mar 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="IQxgjB9l"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75B29A2;
	Mon, 10 Mar 2025 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600874; cv=pass; b=NJF1+NciMSJrHQB/UTCTURTZwJ1R+nSVhEi2bisj51f9pQiPaiXnaVHB0hn9NDDt1SRneHpNiiT6xtqVex3Z3I5mkauCH01j66jyEjmNKxh4vVRNiFKEsZbuScmOWb+heZhMxKfW9pR4UuRaVVLNnkcZltPfuJs9RNiEd/pcDME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600874; c=relaxed/simple;
	bh=b76qrhBUBBQgOxNEP24/iaezZ47DqFJATqoAHC9PA6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rofkw5F97fyJ05StyiCFyXusbPk5IK5wKXVW1iN6y3qtbPKKuM8zursQsIEoo2aC9TfjXimFEYAw0M55E3q9CFFzgviV8CptM2neN1IEkIGQJpN7hmGjmXuYwoR63Ma7ea9dBYwe/YaJ14F7i4TwyqAANtroiwpjcD9dA2PT0WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=IQxgjB9l; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741600844; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LUAZ4AB574FF/KkzPzySh74VUqaKk7Up4geZssi+tUWNoVBPmbOXaAB0X2kT4+3Wbwj1fV/MKAEB7dANewJ33AqC8P4Oss8Iipj6Y97OwfM4KJ/c+VSRs1O1gLlaE9xuzeOnE90bxczUP5GDESSsbObyinaN12NBVrqijYEffFQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741600844; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sG0ZptlmWh6usz+6gYzu3av5prS4D953FeG+EZTRlmE=; 
	b=Fyv59Hi6jM+QmMMz4EVYjOWDyqSx9Tdyog8JkvORFtntRG92twzxE0N61oF1iAv7x8o4qbhLsFLqKux87Hwt7QYYOlnQ4LFMYVFMLuXhhrCucZR8+ZZWZZWFS2WthKQfmqwC4VzPjrC/HclcCnESvi9XePFtgQ1mv5zh+rcgpYQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741600844;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=sG0ZptlmWh6usz+6gYzu3av5prS4D953FeG+EZTRlmE=;
	b=IQxgjB9lLAHcZuF00S0hPyH4P/moK4+Fc+IszQagDcah2y50VQSL1g435V4GGsjF
	V2PW5GMQwJNtc/Xrg2fZ9rdxCtoJVRjFBeGPmQu2AdYVtZuO+U6SD0ms2XPVGWgkpwZ
	6YCFoC8OeRm6qM5vLsMZvOGvmwcK+dGLvtsEqN6E=
Received: by mx.zohomail.com with SMTPS id 174160084194050.598305390263135;
	Mon, 10 Mar 2025 03:00:41 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 10 Mar 2025 10:59:57 +0100
Subject: [PATCH 2/2] arm64: dts: rockchip: fix RK3576 SCMI clock IDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-rk3576-scmi-clocks-v1-2-e165deb034e8@collabora.com>
References: <20250310-rk3576-scmi-clocks-v1-0-e165deb034e8@collabora.com>
In-Reply-To: <20250310-rk3576-scmi-clocks-v1-0-e165deb034e8@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Chen <cl@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Downstream Linux, and consequently both downstream and mainline TF-A,
all use a different set of clock IDs from mainline Linux. If we want to
fiddle with these clocks through SCMI, we'll need to use the right IDs.
If we don't do this we'll end up changing unrelated clocks all over the
place.

Change the clock IDs to the newly added SCMI clock IDs for the CPU and
GPU nodes, which are currently the only ones using SCMI clocks. This
fixes the terrible GPU performance, as we weren't reclocking it
properly.

Fixes: 57b1ce903966 ("arm64: dts: rockchip: Add rk3576 SoC base DT")
Reported-by: Jonas Karlman <jonas@kwiboo.se>
Closes: https://libera.irclog.whitequark.org/linux-rockchip/2025-03-09#1741542223-1741542875;
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 8591065b575223a5eb2da70f723f16969aa2ecf7..1fddf298795e5c914a76d9779b6f8563ee15c8e3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -111,7 +111,7 @@ cpu_l0: cpu@0 {
 			reg = <0x0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <485>;
-			clocks = <&scmi_clk ARMCLK_L>;
+			clocks = <&scmi_clk SCMI_ARMCLK_L>;
 			operating-points-v2 = <&cluster0_opp_table>;
 			#cooling-cells = <2>;
 			dynamic-power-coefficient = <120>;
@@ -124,7 +124,7 @@ cpu_l1: cpu@1 {
 			reg = <0x1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <485>;
-			clocks = <&scmi_clk ARMCLK_L>;
+			clocks = <&scmi_clk SCMI_ARMCLK_L>;
 			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 		};
@@ -135,7 +135,7 @@ cpu_l2: cpu@2 {
 			reg = <0x2>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <485>;
-			clocks = <&scmi_clk ARMCLK_L>;
+			clocks = <&scmi_clk SCMI_ARMCLK_L>;
 			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 		};
@@ -146,7 +146,7 @@ cpu_l3: cpu@3 {
 			reg = <0x3>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <485>;
-			clocks = <&scmi_clk ARMCLK_L>;
+			clocks = <&scmi_clk SCMI_ARMCLK_L>;
 			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 		};
@@ -157,7 +157,7 @@ cpu_b0: cpu@100 {
 			reg = <0x100>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			clocks = <&scmi_clk ARMCLK_B>;
+			clocks = <&scmi_clk SCMI_ARMCLK_B>;
 			operating-points-v2 = <&cluster1_opp_table>;
 			#cooling-cells = <2>;
 			dynamic-power-coefficient = <320>;
@@ -170,7 +170,7 @@ cpu_b1: cpu@101 {
 			reg = <0x101>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			clocks = <&scmi_clk ARMCLK_B>;
+			clocks = <&scmi_clk SCMI_ARMCLK_B>;
 			operating-points-v2 = <&cluster1_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 		};
@@ -181,7 +181,7 @@ cpu_b2: cpu@102 {
 			reg = <0x102>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			clocks = <&scmi_clk ARMCLK_B>;
+			clocks = <&scmi_clk SCMI_ARMCLK_B>;
 			operating-points-v2 = <&cluster1_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 		};
@@ -192,7 +192,7 @@ cpu_b3: cpu@103 {
 			reg = <0x103>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			clocks = <&scmi_clk ARMCLK_B>;
+			clocks = <&scmi_clk SCMI_ARMCLK_B>;
 			operating-points-v2 = <&cluster1_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
 		};
@@ -932,7 +932,7 @@ power-domain@RK3576_PD_VO1 {
 		gpu: gpu@27800000 {
 			compatible = "rockchip,rk3576-mali", "arm,mali-bifrost";
 			reg = <0x0 0x27800000 0x0 0x200000>;
-			assigned-clocks = <&scmi_clk CLK_GPU>;
+			assigned-clocks = <&scmi_clk SCMI_CLK_GPU>;
 			assigned-clock-rates = <198000000>;
 			clocks = <&cru CLK_GPU>;
 			clock-names = "core";

-- 
2.48.1


