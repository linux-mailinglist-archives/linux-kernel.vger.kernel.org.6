Return-Path: <linux-kernel+bounces-538804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3980A49D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D183118986A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F416D27604B;
	Fri, 28 Feb 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bJiCRjWH"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBE275616;
	Fri, 28 Feb 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756018; cv=none; b=HEOAEGC74ODNpHLVWjAA86CVSwbIogQ/RaX2BF9JR/FzCcGrgzJ1muTVowx/ovzJAIgRH4/B5cn81oOmiQWP/NO3bBz4OvRsehXcMMZZXgdPw3Ny+pzLIehFb9PyMU+knqbFCY21AKe1Mg3zz4qSWoWiOGK5fmjTDNj+LwQAPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756018; c=relaxed/simple;
	bh=FTlFHu4Ch9a58ygW9hXtWFQaX9Y+dzUSxzWtBGK6kHc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WKF5W3FxnVyDEZYh8P6C6x5SSXhwU+hsa9axD7egMZQhdlpg+8RWxr0LralQjWLzYasiLm9CEwA8Ca+giSDEYcMsyLIoztk8VD21wCYTE2tSACCDXtHHWEZG2hTgqpM2m9xOjY2ShUAJ6MB4SwuKIU+/9j3X9j2HRE98qfSAKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bJiCRjWH; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3989842E77;
	Fri, 28 Feb 2025 15:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740756013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QZu5jeody6oxpz4x8MYrbb46BHii47kNRlyxqpDsps4=;
	b=bJiCRjWHZaWuUlBYSiq0+u2M0Z5xY07jCE2o+h06fGeLVT/KsWyS2TADB8ycuM2dmyDtPg
	7iVkMAmvQgajkEa79ecSw8hdMFuKKJtszx9CAwhN9CDtfHQB7HvuDj8UOOHIfeE6topG6V
	5gXQWLbEowc+E6BkPkYJwNTf1dvP/a9E7DN6ps6OuVuHPSlVj3Z1Jg6eDj4BMOHqvWo9jm
	NG1qZs4S42NAKRjv1xSp6yF10nY3SCf7WkJsGsGkq6NqNE5guiUAnIo6/hJ1IOgIDR0hbK
	W0sKiprwmDsz5kdl13CONymdvpNQnh7qJ+lgce5SGGKa2ArnPXCjh5o5thhGdg==
From: Olivier Benjamin <olivier.benjamin@bootlin.com>
Subject: [PATCH 0/2] Describe the cameras in the PinePhone Pro dts
Date: Fri, 28 Feb 2025 16:19:49 +0100
Message-Id: <20250228-camera-v1-0-c51869f94e97@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABXUwWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyML3eTE3NSiRF3zRAtLk6TUtMS0RHMloOKCotS0zAqwQdGxtbUAQP/
 KrlgAAAA=
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefqlhhivhhivghruceuvghnjhgrmhhinhcuoeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjeevgfduhefhhfekheeileejieehueevkeffieeiteeluddtheelkeffhffhiefgnecuffhomhgrihhnpegtohguvggsvghrghdrohhrghenucfkphepvdgrtddumegvfeegmegvtgefkeemvdegvgdtmehfhegtvgemfhefgedvmeeiheekjeemfheiheeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgefkeemvdegvgdtmehfhegtvgemfhefgedvmeeiheekjeemfheiheeipdhhvghloheplgduledvrdduieekrddurddvtdgnpdhmrghilhhfrhhomhepohhlihhvihgvrhdrsggvnhhjrghmihhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhin
 hhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhotghktghhihhpsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepughsihhmihgtsehmrghnjhgrrhhordhorhhgpdhrtghpthhtohepmhgvghhiseigfhhfrdgtii
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
Olivier Benjamin (2):
      arm64: dts: PinePhone Pro: describe I2c Bus 1 and IMX258 world camera
      arm64: dts: PinePhone Pro: describe the OV8858 user camera

 .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 138 +++++++++++++++++++++
 1 file changed, 138 insertions(+)
---
-- 
Olivier Benjamin <olivier.benjamin@bootlin.com>


