Return-Path: <linux-kernel+bounces-314857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F93596BA0C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C71B28493
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A474419F427;
	Wed,  4 Sep 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="qrZKaO/L"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9C218660E;
	Wed,  4 Sep 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448532; cv=none; b=sXSa/YPW7tFJ+CbjOn4U5kXyVZjYcAOSiZQIht9as7AOX9lq4R1ljZBH+OEtYLIKVZrqgZ2hLMB2OwH6EsrzWLm/Q3FZYz3h/bQIKXQHrUZ2gO24NuZRmxoC12sWm5OidRyH/y+zJrFXD38vVQ7DC9IW8dRq/D9wTHj9Y+hYjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448532; c=relaxed/simple;
	bh=aBC/G8GYZ7Mk0rDTstTWMMayGv4noS9fASwSQ3CEJQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drkweN2WyOV9sSTRkMJULkbb1858qIlb3h93rZY14uBeCaQ+uE0+4p1k8odhe8FfM4MFizv0ki0hkv0qPh6wqWekp93jIb09KQlvtnDSW6cxtlvc8lZ0ijIb9Ka9eKINCqiOLw2Zujwqv9J16Lq4YWVQCnEEeiDuLFDhk5MY8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=qrZKaO/L; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.162.211])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id EEC2478906;
	Wed,  4 Sep 2024 19:15:24 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn EEC2478906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725448526;
	bh=oDu0rx3ptdV2NHSJHD6e4BCpRovAxaXvbyquJY/zCiE=;
	h=From:To:Cc:Subject:Date:From;
	b=qrZKaO/LCzRWudZIO3yJgbCa+pL9QA6Arefta8hrqC4HO9JIV/FaB4wKibDONrdT1
	 Ygcw0jjyQ4zI8tH+2HN/lDYeCpgeGHSksyicdgmKPG4UHbFV60uWKioFNUJqUz2YDU
	 RMbrsbMZDYku/cAWDeCkBqumDFwFNsVg/9UU07Qw=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add support for Ariaboard Photonicat RK3568
Date: Wed,  4 Sep 2024 19:14:53 +0800
Message-ID: <20240904111456.87089-1-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dts for Ariaboard Photonicat RK3568.

This series bring support for:
* Debug UART
* SDIO QCA9377 WiFi and Bluetooth
* M.2 E-Key PCIe WiFi and Bluetooth
* M.2 B-Key USB Modem WWAN
* Ethernet WAN Port
* MicroSD Card slot
* eMMC
* HDMI Output
* Mali GPU
* USB Type-A


Junhao Xie (3):
  dt-bindings: vendor-prefixes: Add Shanghai Novotech Ariaboard
  dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
  arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rockchip/rk3568-ariaboard-photonicat.dts  | 598 ++++++++++++++++++
 4 files changed, 606 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-ariaboard-photonicat.dts

-- 
2.46.0


