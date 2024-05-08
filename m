Return-Path: <linux-kernel+bounces-172781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68B28BF6B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A83A284D95
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5DB23770;
	Wed,  8 May 2024 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="c26aNat1"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8D2030B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715151989; cv=none; b=T373kMrpMQAkOfOdtceJUfxuKUKNa0we8aAphwwWP/Ur0ZPD0v0+lgVZWFor0+ctfIujPVpOvCTZoDh+pJDuqE1aIF2AahpWkZ4lzL9aru2rtwjIA3GuK1XLQUEQn9lV/dqT4PiV7HW13ReYIsH3od32SkPFzfl3VJ4/b5rEUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715151989; c=relaxed/simple;
	bh=qeru5WQi3NikU8tXr0CLvujWJxGVYg4dmfb+Nmtp0o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NHqzG3i2chGaGAfBkUzXmZ7hiuYPO2dhjpF9SPtFPNYX1r3urLOKrseTEwEMg3ZTSsQgcOT3WTeGwLb/ocVTnroBqrn4koyw7GhGZcC5x/IC89NhynJLSTNrAWKQDT34Tu6LwUe4Jkud5QPkkr7M+K8ZZkFW+vNv+fI+Y9SYYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=c26aNat1; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1715151981;
 bh=4SBiHj3UaP8h4i4SKqdmJI+KpeU5a4XOxwcb5Gg0phs=;
 b=c26aNat1iwpw6RjewIhz+qWHNs+JRdSGgO2yYl3sGKESI+o0hm2YR1xkitEARc64wnKUdUjDL
 q8Uxgmewl0av0bnjgHeJs/oLQDTo/NAtV6d046j9R4V84uZNMem92up7tZ7wQn0eDBZI9H583cG
 D5dyFypnRiobUXUqNLEIZJz8dngNGPKisEE9BpAfQCjKVdczGrJi2CldRyaYD1zfa5XJMXcChtk
 hDAh/Bv/6x5HxUZUEN9FIkyp7833KL3PNA7jL6JDTWUrhkpmB2dANEpyjlPS9N/zkQ12N74IeQ/
 RsJhFrqxo5xFjb5Qo74euzN2CThAYochQZeDopTAuXVw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v5 0/2] arm64: dts: rockchip: Add Radxa ZERO 3W/3E
Date: Wed,  8 May 2024 07:06:03 +0000
Message-ID: <20240508070611.4153602-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 663b2469a86e8ee0e42ddc14

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

[1] https://lore.kernel.org/linux-rockchip/3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com/

Jonas Karlman (2):
  dt-bindings: arm: rockchip: Add Radxa ZERO 3W/3E
  arm64: dts: rockchip: Add Radxa ZERO 3W/3E

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../dts/rockchip/rk3566-radxa-zero-3.dtsi     | 464 ++++++++++++++++++
 .../dts/rockchip/rk3566-radxa-zero-3e.dts     |  41 ++
 .../dts/rockchip/rk3566-radxa-zero-3w.dts     |  87 ++++
 5 files changed, 601 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3e.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3w.dts

-- 
2.43.2


