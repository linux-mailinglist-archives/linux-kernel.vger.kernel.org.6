Return-Path: <linux-kernel+bounces-574093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA68CA6E084
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5583ABEAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749E2641EA;
	Mon, 24 Mar 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FUnEuuvf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3DF263F49;
	Mon, 24 Mar 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835867; cv=none; b=i8dsvouxC59YM9Ux5QuVxGTpSI4odTnrbOfKpO8uGnwfjMwrPF+iqqBRcwFeLtNhhkhHylCGvqHXLHRXxt68NCKbTLwGbW03x9ZHxeIBxlgDRpa5Qy1NnO6b/OCsWUaAlB+Z7kXZ02po0LyePsZm/JUpx7KzhlHUj2/VjI7RYyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835867; c=relaxed/simple;
	bh=5kYi8rB59tsd+qkVDJfncnPdyMyZuWc5phF2+nfbC5U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hb9FU9+IijHazbsMboJLZjXAgbnhkKIYpGfMr7XjFnq0MEu4hKn+Z45HhQn90FU/8LFKCUX4ldM/lFo4UDX14iXW0ps6lCmHy+wucqz5S9WBtbQ4G2V5zvCZ/YCKULJD9BbH9TZ3Rgy4hTYK0tKCqzovS7kQLRQskICcUAm1xPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FUnEuuvf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742835863;
	bh=5kYi8rB59tsd+qkVDJfncnPdyMyZuWc5phF2+nfbC5U=;
	h=From:Subject:Date:To:Cc:From;
	b=FUnEuuvf9PXpYxGtocUa5dPFGqWiX6wXhfsjHqqlHELLRlbkX0Bk/CaO9sP8uuTs+
	 2rgdcprIcB0wT/SbMlAtyEnkOSo2vhlL19gwliqoKoSVSAIz7/KJkujLNPslfHV9CK
	 PWg/Nf+eUgA07r234Q5lq6PJMyJiPWKHmfrNIkS9MOZZuHNAVyrwtpV1tiOHKYVvCW
	 YdaoHW6HayYfsjgzXkZQ6INiuP6lzkyONlIJEL7MtGjyXISMLuvZo7TbKdZLGA2Qq7
	 uKHJILJ2JiV6XMvBQ31FCPq2RSi9j8/JhPWJ7B6Brhh8Cx/3yYDwVKBqoar8PEmpiV
	 dYnuv0xcvlkSA==
Received: from jupiter.universe (dyndsl-091-248-188-184.ewe-ip-backbone.de [91.248.188.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 33C3217E0C4F;
	Mon, 24 Mar 2025 18:04:23 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id D5B3D480034; Mon, 24 Mar 2025 18:04:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 0/5] arm64: dts: rockchip: add ROCK 5B+ support
Date: Mon, 24 Mar 2025 18:04:21 +0100
Message-Id: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJWQ4WcC/x3MQQ5AMBBA0avIrE1SpQmuIhbKlInQZopIxN01l
 m/x/wORhClCmz0gdHFkvycUeQbjMuwzIU/JoJU2qtQVih9XYwM6L3iGeAgNG7qpNlYpa5rSQkq
 DkOP733b9+35EzsIKZgAAAA==
X-Change-ID: 20250324-rock5bp-for-upstream-fd85b00b593b
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=sre@kernel.org;
 h=from:subject:message-id; bh=5kYi8rB59tsd+qkVDJfncnPdyMyZuWc5phF2+nfbC5U=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGfhkJawCQI4XLraZ32+UGUEQ8dIBGyHdv77y
 hKcblymMCyUIIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJn4ZCWAAoJENju1/PI
 O/qaSogQAIWUmw/Vgp0mj/l/Py2GuQ8gsfM8Y+aJdjYhhJG6c3vwZTJmsowhngtQKuKmDc84OGM
 v1AApCEiJh+omnn2uPRiG20091Bxj4b5udgG8qxyXAxxLNxOgLaiSXfiCAxKGNoUWdWueEbOwJK
 y5jrJ44cJNDYNNFeZVOiayrpVQ1AhV34iZmE3/ZyR5za8EZNSZrZXxiazJdzijFxKIQlZkFWQ1C
 RMfBEdADPpB/oFjPWA/Wv5730P6BPvbHYa5WCEuWT5NaZgcCrfXIdKM0LtePRAofjfNmZerFcqA
 waup3lgOX8tTLsvypbCiG9eAHLLRksELk98rsawaO32TohdL9TMO/4j5qohUdhW5N8j2+I+hNbq
 INEFfHqTgAu4inG9/BV1r6ef+d5OHz3B1TnBn8uVmoagPmcKNqxvZPPc7k71YhBdzvPHn0ksBNI
 pMGJe23nQQ5nYl2weM+Z4/2M5mbvdbBlbpBFB2fqbeespmo+PrM6e70OifK7IqEZDeGp6VoGs+z
 72k82Cx8Mn1UOVs3uRPcPCqVIFyJbN5rgJGAkn1eUMdoo4IpsLZcZNTQT4OCAUDR5fgGpOQmyO5
 r+jMdgmqYMFXRrFoHQEnh9gCi3U9LPz1J4d3WiQspFKf9xoDoBMiRgMddBmaRN3hbf5vZS+P2ZR
 OxOBhQGarglwyjs7jYmoi6w==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

This series adds support for the ROCK 5B+, which (as the name suggests)
is an improved version of the ROCK 5B. It also adds initial USB-C
support for both the ROCK 5B and the 5B+.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Sebastian Reichel (5):
      arm64: dts: rockchip: move rock 5b to include file
      arm64: dts: rockchip: move rock 5b to include file
      dt-bindings: arm: rockchip: Add Radxa ROCK 5B+
      arm64: dts: rockchip: add Rock 5B+
      arm64: dts: rockchip: add USB-C support for ROCK 5B and 5B+

 .../devicetree/bindings/arm/rockchip.yaml          |    5 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 .../boot/dts/rockchip/rk3588-rock-5b-plus.dts      |  117 +++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  952 +----------------
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi   | 1087 ++++++++++++++++++++
 5 files changed, 1220 insertions(+), 942 deletions(-)
---
base-commit: 76728fe54f547950f73c9dc446beb2e31604abd7
change-id: 20250324-rock5bp-for-upstream-fd85b00b593b

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


