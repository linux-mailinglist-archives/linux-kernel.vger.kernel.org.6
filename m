Return-Path: <linux-kernel+bounces-168984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E468BC095
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 15:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B891F2133B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71320B0E;
	Sun,  5 May 2024 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="WVlyONFz"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188021D556
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714916507; cv=none; b=FnNcXR82+aO3N3S6vr/5nHHsdkTEps7osvByAqjR0glprqBwcjoiR4xOmNBAIzH8zBnyovlWwbCMkjbmrqrZrQB94TuVUv7oIAa5OQOZwnhMIzvdsZO7asfz7hbRomWrY9spg8loZsJUP9MQ+QGpnI/OLRq5QKxX0PyRwt+L0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714916507; c=relaxed/simple;
	bh=83BBrwSimdG6Fk9wlVw1bStQpSIfPYtsY1/+H+sH/J4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7AHdMrU2kwUFPtp2MEeqZDT41xzf+RGlyOwzxcmTfIkHuGaZl4Yz7LoGrYoSONw4EevNwtNPCup1t8Ucb67CeMqmuiH8dTnpCPUYcF++n7m8NQsBW5f+itoy1iMwyfTc190fzdaLV5SPsJIDXXaSNsLpJiIyPjlhZyuFnevI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=WVlyONFz; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1714916491;
 bh=cFWoK42/fttVz2IFs0+OcGwVbbqJtzaS5XuzCvgXLbA=;
 b=WVlyONFzx13tUno124kyswXdI2Hkm1xrVdP9maDQGwE/RigzU39N1Gk8qDLH6sI6cAEyNTRRb
 EOHdw+tOlUxfUuwWtD/tt3q4QHn1yCgRN5CQAxWj34mHrQPVrYI/Kz4G+uXK/YanQXpKpRhAFg9
 r2gymM0RazU/5+L5Tjk0iQ9+1lxkyLUh1WGUdn3gHI7Sw6eJkXNdlS/EeqNhbzK2UYQHQRyPwfJ
 FISYs1NLSgOd1sx3hvqLoxgv53qGNsXf190ZE02Rn7GlcXNiSSqx3xP4un0ZGFLG7MAcYaU5Xmv
 brg2XViYKM/3RYTg2ownL5lWInvmIQkn6V3Jpou4h7yg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/4] arm64: dts: rockchip: Add Radxa ROCK 3B
Date: Sun,  5 May 2024 13:41:10 +0000
Message-ID: <20240505134120.2828885-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66378c8657f92010457d6867

This series adds initial support for the Radxa ROCK 3B board.

The Radxa ROCK 3B is a single-board computer based on the Pico-ITX form
factor (100mm x 75mm). Two versions of the ROCK 3B exists, a community
version based on the RK3568 SoC and an industrial version based on the
RK3568J SoC.

Schematic for ROCK 3B can be found at:
https://dl.radxa.com/rock3/docs/hw/3b/Radxa_ROCK_3B_V1.51_SCH.pdf

Jonas Karlman (4):
  dt-bindings: mfd: rk809: Fix vcc8 and vcc9-supply description
  dt-bindings: mfd: rk809: Add audio codec properties
  dt-bindings: arm: rockchip: Add Radxa ROCK 3B
  arm64: dts: rockchip: Add Radxa ROCK 3B

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../bindings/mfd/rockchip,rk809.yaml          |  38 +-
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-rock-3b.dts      | 773 ++++++++++++++++++
 4 files changed, 814 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts

-- 
2.43.2


