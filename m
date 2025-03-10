Return-Path: <linux-kernel+bounces-554673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A9DA59B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889E918871E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD62230D2B;
	Mon, 10 Mar 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cZAJdWPe"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00301230BDA;
	Mon, 10 Mar 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624810; cv=none; b=U1RyNNMx1K0NFvQgvN2wleB8XcHdbFNpYxZ+6vtJzspJ13u4vaRZ+V0vETXc5zpHq/lnTe/ouTMyGihUfxCPL3kEMfK2iMldHD0Bm7wvz5HpotaFmGetEaEQo6kpmxCb340aUovlAKlffrY2DmqpkTBuzI1+cGKgmDu5KzbquLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624810; c=relaxed/simple;
	bh=XPW/PNHU2C/8e9ggxKB1To3j4bIZAqkuOL8WACIX//o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d7vJNx9e3ULyx7u4n6g8iMA5C19Xa3f5MTwBdk4Bl2SPSiwTUgUGjST3st8aqZYeWK4AjahB4K/Re0qYf2OP3iSjXwSQts6f/E0uokjCWPRslKFwOLCByLFZEMUpUMqm7BTDjDesPPPSQeKSq7mpkwgEWwxKNr4V5cymg8EQ0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cZAJdWPe; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9462B44420;
	Mon, 10 Mar 2025 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741624806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g0FHvk7naxccnXtThg65SMBGYmS/oNOjelthUAROF7I=;
	b=cZAJdWPeX2l6AmnRUrcI6g36eTjGObKFBUGlz+W2ZGYkamFITqLe5V6R19BKXwlt6JpWJz
	y2GNpuI4qwbGQiuHZLSRebaj5L0gwBYZcoh2xqYJNbcxpAeKDKpooqsr2hOgQdryx22jr9
	b6soNUnbxVc2kDUkFz3qAAxNlkul5kSXNiLIMb4i0ojz2vzkQ2CesoX5fE/znTJV6zijFx
	cVeEj5fRonO4GyD1Ak5gtCYrKKctkDK7s5+74mVn0ceOLlBQmIR+TeIRPcQRHblG8KBhgu
	pXi1s35+U3ev9P25WDy2geiEW+GpVkdCSbZsPuwnVE1sYPrQSSxOJoTT8OVliw==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v4 0/3] Add Variscite i.MX6UL SoM and Concerto board
 support
Date: Mon, 10 Mar 2025 17:39:47 +0100
Message-Id: <20250310-varsom6ul-concerto-dts-v4-0-6034fda6ec64@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANMVz2cC/3XQQQ7CIBAF0KsY1mJgKCiuvIdxQemoJFoUkGhM7
 y6tGjWmyz/JvMmfO4kYHEaynNxJwOyi820J1XRC7N60O6SuKZkAA8k4MJpNiP6oLgdqfWsxJE+
 bFKlhixrBKOC6JmX5FHDrrgO83pS8dzH5cBvuZN5P3yQfIzOnjGItKm3slhmrVrX36eDamfVH0
 qMZvqH5KAQFqhpjQYNUeqH/IfGBBB8tmUWBpOSo2JwLCeIX6p69A54v5Y/pVb7rHp3J0CllAQA
 A
X-Change-ID: 20250120-varsom6ul-concerto-dts-a08be2a6219b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Antonin Godard <antonin.godard@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2339;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=XPW/PNHU2C/8e9ggxKB1To3j4bIZAqkuOL8WACIX//o=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnzxXlA4CwvIV3hDMNMGAj0KX5KcGsHpcacPtqQ
 cVQ4ig44iKJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ88V5QAKCRDRgEFAKaOo
 Nk05D/wN7QtblCSzXP24wqWsH+praenTTdVTidGDLesjDjGPOC11EKF1hUp6HpdZCgIl8p+QEm0
 29EPDiD8b31hRZs+fL9eDN0LdhOtbtD5Oj1OqaHq50unamFep+0VuHenwnUcm9cHyYdB7uAbyZz
 XuDCeM1itX303K/hmPh6gQ1fJdfTJkYNsuyd9dbPiQwEqL7jiFFwbmgRClIXY5YUAybnsf89V09
 cGjH5b2UMk2OkGsDG4sSoShJ4i7XHRe2OwSG2Ti6uyGx7iB5RyC64F1Zr96oIf6ZxH7Fh73N6/p
 M+FQ8+ePUD7sr2sJWFBQuBURjRwn6yyZwduOMiIerbd2R1Uf15ZQ6fPfttHeaMxZodTCbVK1yFo
 18XYMZYP1H1nL6uibTVaKbGoYN1zPVbpy9QH1BjGF9g/vWvGmR/PfBXb/AF97kgtJEpuT3lCGHV
 55JO+kOqsrMyKx6SeXP/Hypx1bZQjpXwD4zMhkZvk7yNpSbZe10dg7UARm0TslPOIJ5B0yapC8A
 HOvTEYjKXTRjWI/CrUobOmoGWGUANxKmrD/kT/V963ZTBDxB5rTlB4T/+9Xt3wi8NEaD8mCRGik
 XP+JmQlU18Xob0mSUvTv7ifOIYYMD++f3rxQ9HyndqGi8yOS3V5tltX9HcQqOx0BSZtVN2Ba9WO
 B72aPWUTGX5YkNg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtudeuhfelveehueevudefgedvtdfffeevleefuedtjeeuteelgeelvefftdejteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopegtohhnohhrrdguohholhgvhiesmhhitghrohgthhhiphdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com

Add support for the i.MX6UL Variscite SoM (VAR-SOM-6UL) and the
Variscite Concerto Carrier Board.

I tested this with a VAR-SOM-6UL_G2_700C_512R_8N_IT_REV1.3A (one variant
of this SoM), meaning I couldn't test all of the possible options of the
SoM - so this device tree includes partial support for it.

These are based on the 5.15 Variscite kernel fork but adapted for
mainline.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v4:
- Add missing trailer on first patch ("Acked-by: Conor Dooley
  <conor.dooley@microchip.com>").
- Link to v3: https://lore.kernel.org/r/20250310-varsom6ul-concerto-dts-v3-0-551e60713523@bootlin.com

Changes in v3:
- Reviews from Shawn:
  - Fix alphabetical order of nodes and pinctrl entries.
  - Fix rmii-ref-clk label (remove "-grp" added by mistake).
  - Fix order of properties for eth nodes.
  - Convert deprecated fec properties to eth properties.
- Link to v2: https://lore.kernel.org/r/20250127-varsom6ul-concerto-dts-v2-0-4dac29256989@bootlin.com

Changes in v2:
- Reviews from Krzysztof:
  - Use imperative mood in commit descriptions.
  - Remove backlight node as I am unable to test it.
  - Rename gpled2 node to led-0, and set function, color and label for
    it.
  - Remove unnecessary comment "DS1337 RTC module".
- Rename binding "variscite,mx6concerto" to "variscite,mx6ulconcerto"
  since this is for the VAR-SOM-6UL mounted on the Concerto.
- Remove pinctrl_ft5x06_ts_gpio iomuxc node, unused.
- Link to v1: https://lore.kernel.org/r/20250121-varsom6ul-concerto-dts-v1-0-eb349acf0ac6@bootlin.com

---
Antonin Godard (3):
      dt-bindings: arm: fsl: Add VAR-SOM-MX6UL SoM and Concerto board
      ARM: dts: imx6ul: Add Variscite VAR-SOM-MX6UL SoM support
      ARM: dts: imx6ul: Add Variscite Concerto board support

 Documentation/devicetree/bindings/arm/fsl.yaml     |   6 +
 arch/arm/boot/dts/nxp/imx/Makefile                 |   1 +
 .../boot/dts/nxp/imx/imx6ul-var-som-concerto.dts   | 320 +++++++++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6ul-var-som.dtsi      | 233 +++++++++++++++
 4 files changed, 560 insertions(+)
---
base-commit: 66683f3b2661643f694607283ee8f01b7a934c83
change-id: 20250120-varsom6ul-concerto-dts-a08be2a6219b

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


