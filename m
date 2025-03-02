Return-Path: <linux-kernel+bounces-540596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E114FA4B2AC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8D17A7033
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1A81E98EA;
	Sun,  2 Mar 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SRlaBSre"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CB11D63F0;
	Sun,  2 Mar 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740930151; cv=none; b=cgqljVuFbDWp54jeIcmTlaqOkJk9v5MjVwklE6cH7s7aKS+FwXJD/Q/BsNSBFkQnCRkUQrAHbkr68PGDugtZzhte2UBk2/El3WI0e36o9OzMNbr2fzTZ+BATCxTUusm6sa6FOaM+Zs9ZYpyl8tHN8gFBBpkCsjHI6b2QMzxAbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740930151; c=relaxed/simple;
	bh=wp0DfXoN3xZJsHX4C8ETiHPjv4lfphorcMUjRpsDWfM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lHg/EwPacoI6VQwGRE6eybMHWKZYeulnKBm1pVeBWGxuD0LqcGAUtOcyfL8ooZyKqV8Gps9fuHKS4QqxHJW2kcjLSJ6F037Oge5Sn7gifTuj0uLgsaWRL6LJZO6vmVWtX9PNxY1RBnkGovCtRPvFTqNXGKE85GmH5Udq8i+hJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SRlaBSre; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B48544415;
	Sun,  2 Mar 2025 15:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740930141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8JYVCrH6PJ04XLrRJrXnDDg8JCjURxqYx8cEKCB0S1w=;
	b=SRlaBSrepmvU2U4DVnbIS5Wzq+OxNoIBSgU2SXAZEDSIGfXYlmUJ37KaCYnI2awcDiIYOD
	kPYfWZmTqiL8jQLK83vRaP1inoZc1Y992PWYSz8f15eRHmXtvL3iLaLrBvO4n1FOrrDmCD
	I/DOiqaS4vSMmhw+29Uxv1La7Hjmeb9tcYLaNapbV1XEMaG2YXyoyGp71w1DPzmMb6jEyz
	P54vxU3O+wCfocsTD+mO8otOvAuTqko0SQxXv3PQSEaUx6N78RoLseifBf9KtGKSzVYge4
	nK+IC8z6kFidrMGQ+F31F+SVbBCNjPVZH2OYgM9mq/MVOeUPReXVw9/UFf8E6g==
From: Olivier Benjamin <olivier.benjamin@bootlin.com>
Subject: [PATCH v2 0/2] Describe the cameras in the PinePhone Pro dts
Date: Sun, 02 Mar 2025 16:41:01 +0100
Message-Id: <20250302-camera-v2-0-312b44b4a89c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA18xGcC/2XMQQ7CIBCF4as0sxYDpBVw5T1MFxQHO4mFBhqia
 bi72K3L/+Xl2yFjIsxw7XZIWChTDC3kqQM32/BERo/WILkcuJSaObtgskxZbfoJvfVWQTuvCT2
 9D+g+tp4pbzF9DreI3/pHFME4c4PQF+NNj0bdphi3F4WziwuMtdYvtGkOSZ4AAAA=
X-Change-ID: 20250228-camera-7a894befafa7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Olivier Benjamin <olivier.benjamin@bootlin.com>, oren@taumoda.com, 
 Dragan Simic <dsimic@manjaro.org>, Ondrej Jirman <megi@xff.cz>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelieeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefqlhhivhhivghruceuvghnjhgrmhhinhcuoeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdduheefuedtffejveeigfejteeiueelfeekfefgveefvdelgfeihfehjeeujedvnecuffhomhgrihhnpegtohguvggsvghrghdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehiedphhgvlhhopegludelvddrudeikedruddrvddtngdpmhgrihhlfhhrohhmpeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheplhhinhhugidqrhhotghktghhihhpsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheptghonhhorhdou
 ghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvghgihesgihffhdrtgiipdhrtghpthhtohepughsihhmihgtsehmrghnjhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepohhrvghnsehtrghumhhouggrrdgtohhmpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: olivier.benjamin@bootlin.com

This series adds support for the Pine64 PinePhone Pro's rear and front
cameras in Device Tree.
This is based on some of Ondrej Jirman's patches hosted in his tree at
https://codeberg.org/megi/linux, but I have also fully reviewed and
re-written the code from the RK3399 datasheet, the PinePhone Pro
schematic, and the IMX258-0AQH5 software reference manual.

I have tested these changes on my PinePhone Pro and am able to take
photos from both cameras using libcamera's cam.

Signed-off-by: Olivier Benjamin <olivier.benjamin@bootlin.com>
---
Changes in v2:
- Rebase on mainline
- Change patch subject to arm64: dts: rockchip
- Rename new regulators to fit preferred form for fixed regulators
- Link to v1: https://lore.kernel.org/r/20250228-camera-v1-0-c51869f94e97@bootlin.com

---
Olivier Benjamin (2):
      arm64: dts: rockchip: describe I2c Bus 1 and IMX258 world camera on PinePhone Pro
      arm64: dts: rockchip: describe the OV8858 user camera on PinePhone Pro

 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 138 +++++++++++++++++++++
 1 file changed, 138 insertions(+)
---
-- 
Olivier Benjamin <olivier.benjamin@bootlin.com>


