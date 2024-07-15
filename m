Return-Path: <linux-kernel+bounces-252795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F363B931830
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACBB282E59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61681208A7;
	Mon, 15 Jul 2024 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qccw/SLA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA91CFB9;
	Mon, 15 Jul 2024 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059807; cv=none; b=AEezuYKnJ/Yx3pNT10V7sDc92aCUXfJ1zoqyBiIGiGQ66RuJx3njsdRKJ5cwxyKZqgTsTAch1vY9B7qNJUtphR2YPtQZoPdPEL7n4U+wGLylG9XXhk3bEcVPcfotHhBF25LLlBcf1bZs8qHQon1sWre+avMNpbFOflfcU/7PzlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059807; c=relaxed/simple;
	bh=TSg1Qn36aw8Oi8+lnfedWfNIgT3VJ099nZPKoyn36eA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KxQNwZn3+qRgoCJHzBj3y3STHP3T+GEY/KinF65/P44yBix2SJXczdZENjmUELzsV8vxGyB+IB0rKvSMqJgB+6jgh41PG4/JD3QeoTJUsUe1AaWpYGCk/+u+JRp8jE6uZig4T72IbOOed2QOz1NpUiJKRSKYD2TxIUq4zGm3DdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qccw/SLA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721059803;
	bh=TSg1Qn36aw8Oi8+lnfedWfNIgT3VJ099nZPKoyn36eA=;
	h=From:Date:Subject:To:Cc:From;
	b=qccw/SLAZwYlSe3zRD81SpyIe0tT0hHfZ+bkd1Q/ru0paghFBsCMcfR3Vo44HA6zC
	 q8oDkJNtdWs/3vKhAAXLq0NSlFHy3Yz+2AyD67CjFQqF5ekMOb5e0v6DIePIP9mU6H
	 O0z/XjFozyXI4k754D6SsfgnhKPfUPLmFejt02q+PvSytjIBSyUsh3F808RRh9wzvY
	 xu5gPnkfOrXSZgCVBJk5i8pjP3n/M1XplZPsGhbvsCscf0QH4uRd1c8pxGRZlzLt7j
	 rm7Bmyz3NHM6PKGYYW7pwGlNZY56oERfBybp0fqUxbKOK8N6ZlY6ykQ3UVksZi/6jD
	 ATZ2Wtv0LC/tw==
Received: from [192.168.1.62] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3F31A378020A;
	Mon, 15 Jul 2024 16:10:01 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 15 Jul 2024 12:09:34 -0400
Subject: [PATCH RFC] arm64: dts: mediatek: mt8195-cherry: Remove
 keyboard-backlight node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240715-cros-backlight-dt-probe-v1-1-0b5afe64c94b@collabora.com>
X-B4-Tracking: v=1; b=H4sIAL5JlWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0NT3eSi/GLdpMTk7JzM9IwS3ZQS3YKi/KRUXXNzU5NEC2OjxBQzAyW
 g7oKi1LTMCrDJ0UpBbs5KsbW1AGKIYd5uAAAA
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.0

Commit 970c3a6b7aa3 ("mfd: cros_ec: Register keyboard backlight
subdevice") introduced support for detecting keyboard backlight
fuctionality through communication with the ChromeOS EC. This means that
the DT node is no longer used. Remove the unneeded node.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Different CrosEC FW versions could potentially not support discovering
the keyboard backlight functionality, but I've tested both a recent

  tomato_v2.0.23149-099cd3e539 tomato_15699.72.0 2024-01-03

and an old

  tomato_v2.0.10686-234e646fd8 tomato_14268.0.0 2021-10-07

version on mt8195-cherry-tomato and on both relying only on the
discoverability works. I've tested on both tomato-r2 and tomato-r3. I
have not tested on dojo, however, as I don't have access to it.

My motivation to remove the node is because the DT kselftest expects DT
nodes that can match to a driver to be probed, and with the "breaking"
commit, the DT node goes unprobed which results in a failure:

  not ok 225 /soc/spi@1100a000/ec@0/keyboard-backlight

I can also solve this in a different way, by adding this driver to the
ignore list of the test. But this solution seemed better as the DT
isn't meant to describe devices that can be discovered at run time
anyway.
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index fe5400e17b0f..20dfa18c9dda 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1228,10 +1228,6 @@ cros_ec: ec@0 {
 		spi-max-frequency = <3000000>;
 		wakeup-source;
 
-		keyboard-backlight {
-			compatible = "google,cros-kbd-led-backlight";
-		};
-
 		i2c_tunnel: i2c-tunnel {
 			compatible = "google,cros-ec-i2c-tunnel";
 			google,remote-bus = <0>;

---
base-commit: 91e3b24eb7d297d9d99030800ed96944b8652eaf
change-id: 20240715-cros-backlight-dt-probe-7754a832ad60

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


