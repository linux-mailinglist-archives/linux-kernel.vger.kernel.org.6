Return-Path: <linux-kernel+bounces-415009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CD19D3089
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0219D283D44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33C11D279B;
	Tue, 19 Nov 2024 22:34:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF81D1F43
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055661; cv=none; b=Any0ypKqbFlfNowzY1gOshelQ1gYDRCTE+BwuOPanwIGumVUcwnVoXNg+Jd1GqFciPBtumvZNzW0O2J+Inul8Om2HYqJPOxy1GgijoQplcBCd3Qe/z9mGXEbEJ3weeTmBjMKJebYzIenYH2CjY3aDKAMYLZbVe/ar5suTZ7PWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055661; c=relaxed/simple;
	bh=h4Oc3f0BWoAszDFIcfl37CbhvLHeg8AetmCPXHM/4Kc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M8181zp/gAeLSaxafy4sakrENEFppkrvvE04AQvfUG9QsT3Z/PQg8LkOcuhuNXkM3usaU4ns1vFGqvIU4jQWcWvQUzRTRcnpp078hmPrjNAkHrG6oG/bJBQRv7x8ZKnUAI55T9hLhksOHt33gkTl5dO8Pon8h7/7NKUZHASZyiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1tDWnF-0002gF-2M; Tue, 19 Nov 2024 23:33:57 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH 0/5] Input: Add support for TouchNetix aXiom touchscreen
Date: Tue, 19 Nov 2024 23:33:49 +0100
Message-Id: <20241119-v6-10-topic-touchscreen-axiom-v1-0-6124925b9718@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE4SPWcC/x2MSQqAMAwAvyI5G0jEDb8iHqRGzcFWWhVB/LvBy
 8AwMA8kiSoJuuyBKJcmDd6E8wzcOvpFUCdzKKgoqaESrxqZ8Ai7OuPp1uSiiMfx1rBZqpqapWV
 iBnvsUWa9/38/vO8HFfMdIG8AAAA=
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Marco Felsch <kernel@pengutronix.de>, Henrik Rydberg <rydberg@bitmath.org>, 
 Danilo Krummrich <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, kernel@pengutronix.de, 
 Marco Felsch <m.felsch@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

This adds the initial support for the TouchNetix aXiom touchcontroller
family.

This series is the successor of [1] (many thanks to Bootlin) but I
started from a fresh v1 since I had to rework the driver completely.

The following features are added:
 - I2C communication
 - Input event handling
 - Touchcontroller firmware (AXFW or ALC) updates
 - Touchcontroller config (TH2CFGBIN) updates

[1] https://lore.kernel.org/all/20240703142520.207066-1-kamel.bouhara@bootlin.com

Regards,
  Marco

---
Kamel Bouhara (2):
      dt-bindings: vendor-prefixes: Add TouchNetix AS
      dt-bindings: input: Add TouchNetix axiom touchscreen

Marco Felsch (3):
      firmware_loader: expand firmware error codes with skip error
      firmware_loader: add support to handle FW_UPLOAD_ERR_SKIP
      Input: Add TouchNetix aXiom I2C Touchscreen support

 .../input/touchscreen/touchnetix,ax54a.yaml        |   62 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 drivers/base/firmware_loader/sysfs_upload.c        |    5 +
 drivers/input/touchscreen/Kconfig                  |   15 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/touchnetix_axiom.c       | 2764 ++++++++++++++++++++
 include/linux/firmware.h                           |    2 +
 lib/test_firmware.c                                |    1 +
 8 files changed, 2852 insertions(+)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240704-v6-10-topic-touchscreen-axiom-105761e81011

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>


