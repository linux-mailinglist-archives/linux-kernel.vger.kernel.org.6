Return-Path: <linux-kernel+bounces-220926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674E90E948
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2E52860D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED113B79B;
	Wed, 19 Jun 2024 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g3y6PpqO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C313A279;
	Wed, 19 Jun 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796246; cv=none; b=nM0rjpEeQiS0Ip9lIl/dcxB7xZDR22RxCJrWXP6VHexkBM2C6xsle47Yy6Bw5wux3w/f3CWTowsxbvvG1f8TlBI7fyRXzSxgs+BL78HTFqN/TBGXnnkpchWaUfzVRR2JYAyAJlxVYKRuGj9ujy8QQDBp1zsOf9CbQmNQJSuCWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796246; c=relaxed/simple;
	bh=usplT3anrO8gUnCYhFFAGJCvwDOsIVmI2af1ckkghmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jb0MOWOZnrhYV+1aI81QmTpygmVvEsTHopj1tKHShPEAXP/a+UoveVbhB8iikpkFFetvZrXQFUS5wrttuJ8aADVA+yW1oAjjGte9owXHiWOANUpLuRWmBsp+4foLCmLBeUakNZyDsbGiV9ke+JT6eF8LJNA/riLN4tu+qYQnwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g3y6PpqO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718796243;
	bh=usplT3anrO8gUnCYhFFAGJCvwDOsIVmI2af1ckkghmY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g3y6PpqO7mV9YAqLbbBVE8VRMUz7/uqhgzAeNq0L9Ht/L4iQg8pLe5TKBaPbZFg9r
	 fX1dBAFJ54l4dTUBKL8Amn1dBBWh3KE5KTWpkj5gJMT2qdRvrtiT8oppOkOl3/uQdx
	 Gl0Qawv70ePGOKZxtnJ/IpYCGz4jiRKlgurHuhl6DUuHo5D+geMyPfu3PXHXd2PER1
	 p840e6Vq0aoqbwk3OOucy8KNvY6+QDsDJCMimGGCaYjwuBUSw+DqteO3en5P0hLD4s
	 wNh8paAZFElAUXoWT82H+woE4/Mtbb6XgcRWs5vr71wKxepFaG28FRxhcpVC4BxiGP
	 MJBcB32l9T6bw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 539B537821C7;
	Wed, 19 Jun 2024 11:24:03 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 19 Jun 2024 14:23:30 +0300
Subject: [PATCH 1/5] dt-bindings: mfd: rk809: Use correct compatible in the
 example
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-rk809-fixes-v1-1-fa93bc5313f4@collabora.com>
References: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
In-Reply-To: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Furkan Kardame <f.kardame@manjaro.org>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

The example is not able to actually test the schema since it uses a
wrong compatible 'rockchip,rk808' instead of 'rockchip,rk809'.

Use the correct compatible and drop the wrong properties in the
example section so that dt_binding_check passes.

Fixes: 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to yaml")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
index 839c0521f1e5..a327d73f3c43 100644
--- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
@@ -126,11 +126,10 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        rk808: pmic@1b {
-            compatible = "rockchip,rk808";
+        pmic@1b {
+            compatible = "rockchip,rk809";
             reg = <0x1b>;
             #clock-cells = <1>;
-            clock-output-names = "xin32k", "rk808-clkout2";
             interrupt-parent = <&gpio3>;
             interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
             pinctrl-names = "default";
@@ -146,9 +145,6 @@ examples:
             vcc7-supply = <&vcc_sysin>;
             vcc8-supply = <&vcc3v3_sys>;
             vcc9-supply = <&vcc_sysin>;
-            vcc10-supply = <&vcc_sysin>;
-            vcc11-supply = <&vcc_sysin>;
-            vcc12-supply = <&vcc3v3_sys>;
 
             regulators {
                 vdd_center: DCDC_REG1 {

-- 
2.45.2


