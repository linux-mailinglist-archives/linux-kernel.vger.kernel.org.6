Return-Path: <linux-kernel+bounces-185424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 281748CB4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6806B225FE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832EB14883E;
	Tue, 21 May 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="kZC2fsXs"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D71149016
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716323929; cv=none; b=C7RubzoyniHOBsRjbxBlKxia2ELwp4+Wbhqw+ddU2nJwqdT7HQ7V+zljEFzbIcwByWdnWulQLli+TakWYYk670ygXBCL/8Bw7GzBr4/ekfwWwO6tkwP551RB5U3pQETxjkJScc1cuy/ysYIkJAbifWv80RVuHlxffpZ8eoNrpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716323929; c=relaxed/simple;
	bh=kL+AiRs4MPmPF4sXVMGvvpFfAdaVHq7HuYZNorSYnec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIwtczNZaR9DOJfgIRj0Z1mkB2NaGUN9IRRhEktaPA2k2femtfRT6TDJjHR4M2UXWH8rMJNJSW5n60mocmlk5U2pIZtMntFM/3lCD1Vv48nusDVfd411+JCBzoskr7QVHL5gmRUTuRyLIuGwApiGNi4RJSp1wOHt/dBMLZu/zP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=kZC2fsXs; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1716323917;
 bh=7w1YK0PAlX2rnVkpWCKz2KPIKlOShCuH6VsJyB17muk=;
 b=kZC2fsXspWSpKsXzUd6uxxDiIvGjwAhNPStAKcza/hAtbb8TPjzlEfNGq1Od92lPV2t+vhQtt
 sNmSPemi7KlhAr+vKSB6WrVWMOfDWHcqjajBRQ+UCKk83YuQrTuzn1aEmcFKyXrCjbOIS6Wb7hJ
 xnmZZ6arFLl7UkbLG9DKlF0qnmTZgJSDFl80D9Trk3n+MbCh6UPJO+C0liAm+xF23DnMlmtOa6k
 t1pJ8R+Q9sU716473bAx6x6TNCtqSPbepHLWZlAct1NC61KoQcy8UjmiNuejBNiuKbgi36GJkBv
 Q9gJtOz3f0zh2VHUTblX2P447HQ2UdtFbLGKqb2J2Npw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v6 0/2] arm64: dts: rockchip: Add Radxa ZERO 3W/3E
Date: Tue, 21 May 2024 20:28:03 +0000
Message-ID: <20240521202810.1225636-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 664d03e0f0b0d6a40951746e

This series adds initial support for the Radxa ZERO 3W/3E boards.

The Radxa ZERO 3W/3E is an ultra-small, high-performance single board
computer based on the Rockchip RK3566, with a compact form factor and
rich interfaces.

Schematic for ZERO 3W and ZERO 3E can be found at:
https://dl.radxa.com/zero3/docs/hw/3w/radxa_zero_3w_v1110_schematic.pdf
https://dl.radxa.com/zero3/docs/hw/3e/radxa_zero_3e_v1200_schematic.pdf

Changes in v2:
- Collect acked-by tag
- Add to Makefile
- Add patch to fix #sound-dai-cells warning

Changes in v3:
- Fix devicetree spelling
- Sort hdmi-con, leds, pmic@20 and regulator@40 nodes
- Change to regulator-off-in-suspend for vdd_logic
- Drop patch to fix #sound-dai-cells warning, similar patch [1] already
  exists

Changes in v4:
- Change compatible of vdd_logic
- Add vcc5v_midu and vbus regulator and related vcc8/vcc9-supply prop
- Adjust clock_in_out prop for gmac1
- Add cap-mmc-highspeed prop to sdhci
- Add sdmmc1 and uart1 nodes used for wifi/bt on 3W
- Rename rk3566-radxa-zero3.dtsi to rk3566-radxa-zero-3.dtsi
- Rebase on latest mmind/for-next tree

Changes in v5:
- Rename regulator-fixed nodes
- Add keep-power-in-suspend to sdmmc1 node
- Add uart-has-rtscts to uart1 node

Changes in v6:
- Use imperative wording in commit message 
- Move led-green pinctrl props to gpio-leds node
- Add pinctrl props to ethernet-phy node
- Add no-mmc/no-sd/no-sdio props to sdhci/sdmmc0 nodes

[1] https://lore.kernel.org/linux-rockchip/3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com/

Jonas Karlman (2):
  dt-bindings: arm: rockchip: Add Radxa ZERO 3W/3E
  arm64: dts: rockchip: Add Radxa ZERO 3W/3E

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../dts/rockchip/rk3566-radxa-zero-3.dtsi     | 463 ++++++++++++++++++
 .../dts/rockchip/rk3566-radxa-zero-3e.dts     |  51 ++
 .../dts/rockchip/rk3566-radxa-zero-3w.dts     |  91 ++++
 5 files changed, 614 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3e.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3w.dts

-- 
2.43.2


