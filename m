Return-Path: <linux-kernel+bounces-250022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59B92F316
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835711F21DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B951C2E;
	Fri, 12 Jul 2024 00:36:51 +0000 (UTC)
Received: from 4.mo576.mail-out.ovh.net (4.mo576.mail-out.ovh.net [46.105.42.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2610F9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.42.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744610; cv=none; b=E1uWfNi87UiFhKTpuRg+ovC/LbmCgJYql5DQZ6uQpgCB2DXSIbO9jqKJFF8d7j2IYb1ghEn6wpnRs+XOW492y7CUykWo3qOfBumKehRZH6uEOJ6U6lRzSVgXMFZfQRErSTg5PwEkjYq19y+T+whZDXgI8oqCcuEYororfTdALlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744610; c=relaxed/simple;
	bh=4ThW3HGd+YRxn2SxvEpOsve+Iop28if1m6UzEwedOfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYYUi3S1VIvxzP14cMJ8j9rMwCDJqvMrrR8PnuI2wBVAAHRsXj+0CwNo9DdtUZD3SRRsHaHR6O5vJbSAvdfNi5YtvMtS++K/VhEJnggtGqG7ierSvkrYnmXzNPhne9nZecnGtLI0j3aOAQ2ch+YxfISOipTvSYjTTXAKwMAtkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=46.105.42.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.176.101])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4WKrL83bHKz1knK
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:20:16 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-fbwl6 (unknown [10.110.113.149])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id AE7741FD2F;
	Thu, 11 Jul 2024 23:20:14 +0000 (UTC)
Received: from etezian.org ([37.59.142.104])
	by ghost-submission-6684bf9d7b-fbwl6 with ESMTPSA
	id BpzUJ65okGbNfTQAHYCkqg
	(envelope-from <andi@etezian.org>); Thu, 11 Jul 2024 23:20:14 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-104R005a60b7224-5bbc-4c00-98ec-c8a7fd5038d7,
                    47FBFB77BDCA57EA66E7955FCDEBFA84A3B4AB1A) smtp.auth=andi@etezian.org
X-OVh-ClientIp:194.230.248.195
From: Andi Shyti <andi.shyti@kernel.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: Drop Thor Thayer from maintainers
Date: Fri, 12 Jul 2024 01:19:26 +0200
Message-ID: <20240711231927.3103820-3-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711231927.3103820-1-andi.shyti@kernel.org>
References: <20240711231927.3103820-1-andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7543529379841903248
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrfeehgddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepgffhtdefgfeijeehtefhueeukedtfeeuhfevhedtkeehhfdtlefhteduffevudegnecukfhppeduvdejrddtrddtrddupdduleegrddvfedtrddvgeekrdduleehpdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht

E-mails to Thor Thayer are bouncing back:

5.1.0 - Unknown address error 550-'[...] Recipient address rejected: User unknown in virtual mailbox table'

Drop the Atera i2c controller driver entry which will now be
maintained by me.

There are two entries related to Altera drivers:

 - Altera system manager driver
 - Altera system resource driver for the Intel Arria 10
   development kit.

Mark those entries as orphan.

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
---
 MAINTAINERS | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96745f7971100..366b9e2d33f7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -846,12 +846,6 @@ ALPS PS/2 TOUCHPAD DRIVER
 R:	Pali Rohár <pali@kernel.org>
 F:	drivers/input/mouse/alps.*
 
-ALTERA I2C CONTROLLER DRIVER
-M:	Thor Thayer <thor.thayer@linux.intel.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-altera.txt
-F:	drivers/i2c/busses/i2c-altera.c
-
 ALTERA MAILBOX DRIVER
 M:	Mun Yew Tham <mun.yew.tham@intel.com>
 S:	Maintained
@@ -872,14 +866,12 @@ S:	Maintained
 F:	drivers/gpio/gpio-altera.c
 
 ALTERA SYSTEM MANAGER DRIVER
-M:	Thor Thayer <thor.thayer@linux.intel.com>
-S:	Maintained
+S:	Orphan
 F:	drivers/mfd/altera-sysmgr.c
 F:	include/linux/mfd/altera-sysmgr.h
 
 ALTERA SYSTEM RESOURCE DRIVER FOR ARRIA10 DEVKIT
-M:	Thor Thayer <thor.thayer@linux.intel.com>
-S:	Maintained
+S:	Orphan
 F:	drivers/gpio/gpio-altera-a10sr.c
 F:	drivers/mfd/altera-a10sr.c
 F:	drivers/reset/reset-a10sr.c
-- 
2.45.2


