Return-Path: <linux-kernel+bounces-354811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1499942DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD4F2872F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672FB1E22FA;
	Tue,  8 Oct 2024 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MqtpQSXm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43925199E92;
	Tue,  8 Oct 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376526; cv=none; b=B1D8GRWEPQLeAfBSCHr0lsH/8JZsurUvlR0AhRBKLva6Nixbl0O7F3HRKMqW+OkCmyVgMdx3wqEQNTXKN9kdxZimYS+pwgiGrG8kq+lgcSr1butnzsjsG9DwqPFAVeIUPK/YLOHjSX3ye8/HSmP+ltDuCSp3UZEvtQBv2HChd0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376526; c=relaxed/simple;
	bh=YhFfJuMCV4lTci8xB84pERvoub1l7ZXh/JbnRzKvkE4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OzUEnBC42kAZZDYcNiy3CtW4m/VR4Da+1Reo4W0gG38WJmA877v0nSv2MvdYqaNB2j0GJ5PdeuwUtmojFfHzcXTwoerSgTpgiSC9CGuogSW6lzu1ySUGI7kaM9KDCGp2BgheSobU5YqQWHlXg0hcVpyzXY7ve1cr0HuNv1My8cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MqtpQSXm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728376525; x=1759912525;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YhFfJuMCV4lTci8xB84pERvoub1l7ZXh/JbnRzKvkE4=;
  b=MqtpQSXmYvMGveHajhO8SSl4P6HLIKFGnmgcMpVH4j+o5522RfeOqnKN
   YOjzYbXzSLeAXobwkbcc62tiFH+yHZ38VXaf18OCId0iv2FndQaX/QU3G
   zB+AGhjEhUvi8xguWgLp14YcbXhDnqq8hRhOKkt5Qf8QgybNQTs/Fr00n
   WR/GaCOEebg/k52nDnRvjrBXfr1p7GbtgKHIEG6Jm7sCC9NIXvHdBff0D
   fiQeqlN9k4I1hU9pzbbabIzIiA0VZP5a+wQTua0KVsTyM5hgZ2vJtyv2u
   1lBX7MM4jelkhEZSPupZgTpSt6LWAxpu5o1bO4An3zS7fgnzlSFIdZfx9
   g==;
X-CSE-ConnectionGUID: VNNFp7ZBRESLYVTNhM1m7w==
X-CSE-MsgGUID: VTUf1i0WR4iiR9cwNszzgA==
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="33314300"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Oct 2024 01:35:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 8 Oct 2024 01:35:04 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 8 Oct 2024 01:35:01 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <richard.genoud@bootlin.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 1/2] tty: atmel_serial: print the controller version
Date: Tue, 8 Oct 2024 11:34:59 +0300
Message-ID: <20241008083459.51249-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support to print the controller version similar
to other at91 drivers like spi and twi.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 09b246c9e389..5f93974918c0 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2970,6 +2970,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	 */
 	clk_disable_unprepare(atmel_port->clk);
 
+	dev_info(&pdev->dev, "AT91 USART Controller version %#x",
+		 atmel_uart_readl(&atmel_port->uart, ATMEL_US_VERSION));
 	return 0;
 
 err_add_port:

base-commit: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
-- 
2.47.0


