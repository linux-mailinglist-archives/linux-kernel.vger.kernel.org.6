Return-Path: <linux-kernel+bounces-315236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12DD96BFAE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87205283554
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0FD1DA635;
	Wed,  4 Sep 2024 14:08:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208111EBFF7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458897; cv=none; b=nQXBn1w0oCNU6PtcVOfVVaSvszQ3SEOgcbGL91KjIob3+axGoUM5b7mlfzl/xnQGmI7rMYhZcvFOlXRFmoHFtuoBe3uGYQPULviQxxJJ19+a/+/58fcss/aOUKGoPOIn5XUOhYJ3bG0eXJS7Oib4pErSmRukBejaQ89ZLtVzGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458897; c=relaxed/simple;
	bh=7h20NiA2RjbPlzvyhjm49e/blF1Q+9FoIQzWeMoze9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5Ma82SQdhxlWkIkp3FU/pb9uzkZup5HGoSFLoqNYyjz07q8qsFSt9f1wNB9KSVYj4ELVjz9IIdOrD+T7akYdDAja0VTrUzHIp5yPWTagiWb0kgSovIlP7eeyoCGDGKBxwu92SM3HUAK5Scdedyv6/ijxqwcFMpmu39YdUlw2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slqgA-00038w-GD
	for linux-kernel@vger.kernel.org; Wed, 04 Sep 2024 16:08:14 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slqg9-005TSR-WF
	for linux-kernel@vger.kernel.org; Wed, 04 Sep 2024 16:08:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A78E3332981
	for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:08:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A7EA933295D;
	Wed, 04 Sep 2024 14:08:10 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1e6a27be;
	Wed, 4 Sep 2024 14:08:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 04 Sep 2024 16:07:57 +0200
Subject: [PATCH 2/2] arm64: dts: rockchip: mecsbc: add CAN0 and CAN1
 interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-rk3568-canfd-v1-2-73bda5fb4e03@pengutronix.de>
References: <20240904-rk3568-canfd-v1-0-73bda5fb4e03@pengutronix.de>
In-Reply-To: <20240904-rk3568-canfd-v1-0-73bda5fb4e03@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@pengutronix.de, David Jander <david@protonic.nl>, 
 Alibek Omarov <a1ba.omarov@gmail.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=pMMh1iYT1i7kfPjgyW+cGCg/UsvcCa4MNFYWjKqRFy0=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm2GnIOpnFl/4kfFstVZ3sze7MoUgHwe4CnRxw0
 o8slRuAh9iJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZthpyAAKCRAoOKI+ei28
 b3FyCACT+06yyJN/ZPA+t5k9U1P8uGZO5XH4VYBrwgv0Fc+vzKZxn8dK0J+qVO3HDRGEFMyFv8l
 FQ6YkO/KBmcygFUbnS22rISAzLkpJy3zCWzb6tG+DCuMwlF+Nj5abDxsi0SmaCbpcHWhxWy6Bcd
 2oZi5UZWP+C01cp7Q1VyXFcs8Ps58/FM7+M36UuoqmhJuZp2wrWAV+TyVUwwq/7qGDo0RxMiEVf
 khSmsnQrROqL6WD4O1BbJ6Kwe7G/Y6oUGdo4/PA5fF0O80FeYEC2vaWkwkVfeqOycIQq8aq1T7x
 beu5URWsepa+POeBzu7bt8FszLkGFZDj9EWzIt9jeWrNRKRj
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: David Jander <david@protonic.nl>

This patch adds support for the CAN0 and CAN1 interfaces to the board.

Signed-off-by: David Jander <david@protonic.nl>
Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
index c2dfffc638d1..c491dc4d4947 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-mecsbc.dts
@@ -89,6 +89,20 @@ vdd_npu: regulator-vdd-npu {
 	};
 };
 
+&can0 {
+	compatible = "rockchip,rk3568v3-canfd", "rockchip,rk3568v2-canfd";
+	pinctrl-names = "default";
+	pinctrl-0 = <&can0m0_pins>;
+	status = "okay";
+};
+
+&can1 {
+	compatible = "rockchip,rk3568v3-canfd", "rockchip,rk3568v2-canfd";
+	pinctrl-names = "default";
+	pinctrl-0 = <&can1m1_pins>;
+	status = "okay";
+};
+
 &combphy0 {
 	status = "okay";
 };

-- 
2.45.2



