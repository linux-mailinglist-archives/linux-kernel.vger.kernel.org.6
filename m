Return-Path: <linux-kernel+bounces-239265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DCF92589F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4895B1F27482
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95411791ED;
	Wed,  3 Jul 2024 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LlNmUIWB"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C854D172BCE;
	Wed,  3 Jul 2024 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002529; cv=none; b=Yg0KgV96shtLxXXYegdDgaXmMu7vnePJz0yK/jmH0J3J7mvtMgYGD7DW9DxlT/+9KtANZdqdbFFB4Oy/biayg2zM4QhyojmYjtx2Yl1M5I2/SvyMzBBQ2sReY0u3rSWj7hmfMNwApJzS7O5iFVgrE7tBxYWKKlH49BGMD/YaJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002529; c=relaxed/simple;
	bh=iW4nEYVeIC+sXQd4/K8zgIRVxXurmIFqKqfAT9zN62o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0RVvLaZ7vgP04PhZJg0GxDA/NuO9ydKMl7U3LCfaxVZF3Px6jjqJf0HS9l5/AcibNsPpQ1UNi0wOkJ5kK0xk3CN98HnXJAky4fz+sYW1e+RqrCKvNxPR0OKl8O5UMP0M5wnKJ1gBD2eQHF/qx/+1+RYu3+Ru5Teyru1QkrQMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LlNmUIWB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002528; x=1751538528;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=iW4nEYVeIC+sXQd4/K8zgIRVxXurmIFqKqfAT9zN62o=;
  b=LlNmUIWB+TLtecwUUGb1SQXnZ3/fTKiz+ROWTZ6NUdpUqZOwSxj4Fz9D
   Z74FbL2f7bWfft+YLs6K0rv+DWKxODzrKomYxD7JhtAzb54haECXl+UqC
   dOMkbUl5lrxEFjtAPHwGW6EJnXICToV0v8212+VVQIJbR1ad6G+r0dk+p
   7OG3Ke+w+DqZs8P6RMJVc5JXB3atGytS28FfwkJvxn68WwQb5vZp9VtQU
   sDRzPK0FLH0yDTbRM7HKAGPdEj2H+C+LbHLddC696xGDzE+3IerTW9ST6
   K6DrYvD/L+//TVMQRnl+TpVkGkRAfKx/u+4AnkYkfGNc2aVHBm/UrVoVE
   Q==;
X-CSE-ConnectionGUID: ywlN1IFORca1IOesWlMguw==
X-CSE-MsgGUID: 7KTdyXrOTBuQuZ1ZGgEHHA==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28804769"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:28:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:28:34 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:28:31 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<varshini.rajendran@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<durai.manickamkr@microchip.com>, <arnd@arndb.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 17/27] ARM: dts: at91: sam9x60: Add nirqs property in the dt node
Date: Wed, 3 Jul 2024 15:58:28 +0530
Message-ID: <20240703102828.196160-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703102011.193343-1-varshini.rajendran@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the microchip,nr-irqs property in the DT node and set the value
for the driver to get the value from the DT instead of a hardcoded macro.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v5:
- Separated the patch from the DT bindings.
---
 arch/arm/boot/dts/microchip/sam9x60.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 291540e5d81e..7dbe34b7587a 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -1201,6 +1201,7 @@ aic: interrupt-controller@fffff100 {
 				interrupt-controller;
 				reg = <0xfffff100 0x100>;
 				atmel,external-irqs = <31>;
+				microchip,nr-irqs = <50>;
 			};
 
 			dbgu: serial@fffff200 {
-- 
2.25.1


