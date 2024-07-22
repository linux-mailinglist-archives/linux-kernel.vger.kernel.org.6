Return-Path: <linux-kernel+bounces-259147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A706B9391E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B6A4B20A00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE4D16E86B;
	Mon, 22 Jul 2024 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Hq5af8zE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8F16CD18;
	Mon, 22 Jul 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662487; cv=none; b=Crw6dtbSL4dlOIcIAjHAEmRN9Oj1U0b7tCvMQIRaNbn5+vZZ2Dtm6ihWSwWLyizUwHio9GTguPrYpaYeA/NYJZ0MorBDiVcdesclYDrslHMeeqoKA1m5ysS9br8DzCfOoolgY80eVmXtP/b5zpDoVPrJLFNIssrr2KCSPI2k8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662487; c=relaxed/simple;
	bh=pqX/1pKn6IJcxlRJ+2ycKGD17KperRGQRzjRVL8ZRBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B1ZoHFojxkO8CJJSv4qjLEk+VldmjW3JALvtMRtQraT2L8eLxMZQALDCz5iRXxU7Poj+NRYq/gc7njlw2gw8v8UxpBDZzP+VijGeWA02IN5/XjRRlp9XWhdq0iJRSChYtEuKjFBWxumbThOkXP51Bpk5R+AyZ9BpBi1PEfo0MJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Hq5af8zE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721662484;
	bh=pqX/1pKn6IJcxlRJ+2ycKGD17KperRGQRzjRVL8ZRBc=;
	h=From:Date:Subject:To:Cc:From;
	b=Hq5af8zEoSqr9BQxGsL/7brCE3yfykI4+XK0q0X/R2RTPrNlxfUMRyp0ZXHbcLyfv
	 zt4fIaJ5B4QTqkxlfDYzQdDtAcmmfXYsOvr1ctqEUYAHBe2pFP9e4+od0Z7QeI0/3N
	 XV3pcA7uQ6jtx5g4mQRZ57AvsLeTg0ML3rZG8Qc6gpCEmIZZF5e8IcQq6wiqXM9qsc
	 12/GDvGY6slpMcxRxmPCONHW1cGkaBdRr4qhjf+OpdvEabHAqMtPf7eWPNvyLHPP0o
	 2SKiGqM3QgF009rWvYEhULM5hm70BaleDcdbDKrJj1P5jTu0yTM/dVd+qP+jQIjuWP
	 rPCm9Bw9JnJRg==
Received: from [192.168.1.217] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0CD603780613;
	Mon, 22 Jul 2024 15:34:40 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 22 Jul 2024 11:34:25 -0400
Subject: [PATCH v2] arm64: dts: mediatek: mt8195-cherry: Remove
 keyboard-backlight node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240722-cros-backlight-dt-probe-v2-1-d77cdf7018ec@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAB8nmYC/4WMQQ7CIBAAv9Ls2TWAtNWe/IfxsFAsROwaICSm6
 d8lfsDTZA4zG2SXgsswdRskV0MOvDZRhw6sp3VxGObmoITSYpQ92sQZDdlnDIsvOBd8JzYOx7H
 XdD4pmgcBrfYhF06f37jKhtv/R5UoUZieHm7Q9qLN1XKMZDjR0fIL7vu+fwHK543ysgAAAA==
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.0

Commit 970c3a6b7aa3 ("mfd: cros_ec: Register keyboard backlight
subdevice") introduced support for detecting keyboard backlight
fuctionality through communication with the ChromeOS EC. This means that
the DT node is no longer used. Remove the unneeded node.

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Removed RFC tag
- Link to v1: https://lore.kernel.org/r/20240715-cros-backlight-dt-probe-v1-1-0b5afe64c94b@collabora.com
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


