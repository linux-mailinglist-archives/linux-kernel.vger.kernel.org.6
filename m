Return-Path: <linux-kernel+bounces-561983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BFCA619C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C645E462A64
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70F92046BB;
	Fri, 14 Mar 2025 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armadeus.com header.i=@armadeus.com header.b="mOL+L/T8"
Received: from 2.mo561.mail-out.ovh.net (2.mo561.mail-out.ovh.net [46.105.75.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2052155747
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.75.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978118; cv=none; b=exXizrbnQ97ps+S5cJmjQJfudV5GjSm01oN/4NU6zPMROxR+OHJI+itHBlhf9A5EqRGIgwm2pDmS9yspOqppnG5eu4fz5PgQG1NrahEjdnrMJ8WMxC51JLMHlAKRGbkbJnuva0x8MZU/CTnZ848ufdKIl2YzFh9Bb8moMnn25Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978118; c=relaxed/simple;
	bh=avDv4tK1ONJ/syhJq1AofSk0EdiOHAWN41qKHhjMiEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j/nr2YOez61ELY+iVLXL9qgqnK8mdcCrO6Ipr7wavKh09VlXW51nycG1amedosG571+7ruB8s1Y+ayavceszu3cGGkacOgIUnEQ0W9YuGiDhBNlF/4BoVk7f9o+PSJ/lHt05mu41S5Oxhfb5y6mKUEGr1wXn8jnC6kpQ4DVNqqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com; spf=pass smtp.mailfrom=armadeus.com; dkim=pass (2048-bit key) header.d=armadeus.com header.i=@armadeus.com header.b=mOL+L/T8; arc=none smtp.client-ip=46.105.75.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armadeus.com
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.17.88])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4ZDqNl0L0mz1Xm8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:20:54 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-zj8mb (unknown [10.110.96.7])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3EFC21FE97;
	Fri, 14 Mar 2025 16:20:53 +0000 (UTC)
Received: from armadeus.com ([37.59.142.100])
	by ghost-submission-5b5ff79f4f-zj8mb with ESMTPSA
	id ks6EBmVX1GfALgEAEG6nww
	(envelope-from <sebastien.szymanski@armadeus.com>); Fri, 14 Mar 2025 16:20:53 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-100R003ae709b19-23ae-4007-881d-73b92853cf78,
                    A221DEE5FCFF6DF9682F22B3F1BEC7AEAAD40A3F) smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp:92.148.253.243
From: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Date: Fri, 14 Mar 2025 17:20:38 +0100
Subject: [PATCH] ARM: dts: opos6ul: add ksz8081 phy properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250314-opos6ul-fix-ethernet-v1-1-1c0172949b40@armadeus.com>
X-B4-Tracking: v=1; b=H4sIAFZX1GcC/x2MWwqAIBAArxL73YJmSnWV6KPHWguhoRZBdPekz
 2GYeSBSYIrQFQ8EujiydxlkWcC8jW4l5CUzVKLSQska/eGjOXe0fCOljYKjhFK1YtbaWDU1kNM
 jUPb/th/e9wObJ8NoZgAAAA==
X-Change-ID: 20250314-opos6ul-fix-ethernet-1390c556f3b8
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Julien Boibessot <julien.boibessot@armadeus.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
X-Mailer: b4 0.14.2
X-Ovh-Tracer-Id: 6297721129035754449
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeduvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtkeertdertdejnecuhfhrohhmpefurogsrghsthhivghnucfuiiihmhgrnhhskhhiuceoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeetudffuedugeffuddvhfefjedufeejleekgefhjeeuuedtvdegheeikefhleehgeenucfkphepuddvjedrtddrtddruddpledvrddugeekrddvheefrddvgeefpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiudgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=n+IF7ozOuHRbo7rwX765zhLKBt2dCvj0KZ4Df+uvM94=;
 c=relaxed/relaxed; d=armadeus.com; h=From; s=ovhmo103079-selector1;
 t=1741969255; v=1;
 b=mOL+L/T8DYvSoFyvIIJidGZU/d7OjCIh4pn74qmxxp0p7sZf0C2Q9c+hqV7D3DyX8zfJ7Bq2
 3j9gY53vF3fK5u927AfbHLuzHomAYz/NEU/iCq/V1cs/mdc2YF8meUS2fYIhTHZVG/YQm+cOrGj
 d03aQFJpMPALNpC/yiQ/QckiZHS8knJ5+uyiW3kLkHs+Jopc74ge0W9YaUZJTQCbyzX45XvCPxx
 nMoI1hfrFdWQcme3k3L7mqtRjoKY13mIAWhRuXQ21bNM0UGMnnfoX8HAIhqc8Kvx/1Pjf1pOOZw
 YO0rJp+Dawi7Oy9OySNxDE2xy8QWqpRDBH7ET8oGPfBug==

Commit c7e73b5051d6 ("ARM: imx: mach-imx6ul: remove 14x14 EVK specific
PHY fixup") removed a PHY fixup that setted the clock mode and the LED
mode.
Make the Ethernet interface work again by doing as advised in the
commit's log, set clock mode and the LED mode in the device tree.

Fixes: c7e73b5051d6 ("ARM: imx: mach-imx6ul: remove 14x14 EVK specific PHY fixup")
Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi
index f2386dcb9ff2c0c11e00069b81689c81af7f5446..dda4fa91b2f2cc28ef59e2d6513dc1732982feea 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi
@@ -40,6 +40,9 @@ ethphy1: ethernet-phy@1 {
 			reg = <1>;
 			interrupt-parent = <&gpio4>;
 			interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+			micrel,led-mode = <1>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
 			status = "okay";
 		};
 	};

---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250314-opos6ul-fix-ethernet-1390c556f3b8

Best regards,
-- 
Sébastien Szymanski <sebastien.szymanski@armadeus.com>


