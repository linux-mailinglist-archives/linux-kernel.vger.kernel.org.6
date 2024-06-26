Return-Path: <linux-kernel+bounces-231447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF39198D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20BF0B2225F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E43192B69;
	Wed, 26 Jun 2024 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="iSaWmHtv"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D218FDCF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433000; cv=none; b=IRShGNZf4/qQqND759yl/kELyvgFh2wsMjWXE8YUO32nWqT+AfUIvP3QrfBHBttQqvYjt31bU8wpdwXVoP3DyY8mTaADFN0jvEluQ7Zd9K45/te/qrYhmF+6PuphTyi4fhXcisxK6NIPpi7P80n84byapGrZkuQ8zV6irqM4xdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433000; c=relaxed/simple;
	bh=rJwiQyjOtPvEurh808UzSR0t54AzxHt83Wub/QYiGq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGkze3v+eshL/0cLy7B/T/s262L5qTBGlK0I0lQ8jE++OFtLHriByfeVOvZJxsawGbPw0KCiKVE4kZ1icG9Qd4ZclF+MTUtmYh0mlCFZCSSCop9WbrIogp0gj/Lwnyx8/D4xNht91YS7keVfnyKsQo1cGiI8v9vyJB3my2aiSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=iSaWmHtv; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1719432984;
 bh=gisa5XIJQgj4fIi9thWyQwlkICVF+Giwy1GfZU8KFFs=;
 b=iSaWmHtv5d+YZb4ZcN1YPw4d/f/p6mTfFzqyflHBaeMyIg2pGirlt5CrYmIPF1G8MQhsEIUb1
 3f8zxsw0eFZPr8W+sfL9yPEh9OOlCbpTvI/9vJEx8bhUtcnCijfvf9VBPQ7fG8BQ6r16VoazRjA
 xllg8PDE8h7Pk2DzAfAi+Bv+RSrL6M7ViPg+IjiYCrKk/9Wfw7nXo0IWixlxRgjH74Yrvg2JlpA
 2pIKgwu6PxqV11XX3Qec0LC2ABN5iZOFt3HnUmGTPbHx3B/hcl09O7IPgv24U8V0npMqzDfYBwt
 NQxYDV95Y1tI/BXkYNcuk1PKlTJqd4CaetBeBecVDV8Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/2] arm64: dts: rockchip: Add Radxa ROCK 3B
Date: Wed, 26 Jun 2024 20:14:53 +0000
Message-ID: <20240626201502.1384123-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
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
X-ForwardEmail-ID: 667c7716c7901497dbde75c2

This series adds initial support for the Radxa ROCK 3B board.

The Radxa ROCK 3B is a single-board computer based on the Pico-ITX form
factor (100mm x 75mm). Two versions of the ROCK 3B exists, a community
version based on the RK3568 SoC and an industrial version based on the
RK3568J SoC.

Schematic for ROCK 3B can be found at:
https://dl.radxa.com/rock3/docs/hw/3b/Radxa_ROCK_3B_V1.51_SCH.pdf

Changes in v2:
- Drop rk809 dt-bindings patches, replaced by series at [1]
- Use regulator-.* nodename for fixed regulators
- Drop rockchip,mic-in-differential prop
- Shorten Ethernet phy reset-deassert-us to 50 ms
- Fix pcie pinctrl
- Add keep-power-in-suspend to sdmmc2
- Collect a-b tag

[1] https://lore.kernel.org/all/20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com/

Jonas Karlman (2):
  dt-bindings: arm: rockchip: Add Radxa ROCK 3B
  arm64: dts: rockchip: Add Radxa ROCK 3B

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-rock-3b.dts      | 780 ++++++++++++++++++
 3 files changed, 786 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts

-- 
2.45.2


