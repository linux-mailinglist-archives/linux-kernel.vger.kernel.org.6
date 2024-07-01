Return-Path: <linux-kernel+bounces-235890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F28491DADE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D3C51F2201B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CD113D2A2;
	Mon,  1 Jul 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EqtpMg7h"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611D13C68A;
	Mon,  1 Jul 2024 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824374; cv=none; b=YawlMT94rvRX2JAytjshE1G/oQI8MhTJneUiAidkWsYhZnjqIN8+TH9/gnMxMEQedmwNPCKyf4nNM99OG6kmwOr3Ya6K6ooVPK4eJv22lm7YTRywxVLueO7TJtQ0Fmu/UlKtl6Smau9fBY61yFoZR2htvVlRo9Exy8tix3ADTA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824374; c=relaxed/simple;
	bh=vKsDgZDbAveDzASb8F3C/IqfEeLs4OJGXgc8VAbr7pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnqFexsWrugpKlVHt6BX8uT4KKY/eu1lXLPlCAkDjanvPOBz+LJVBzGqg+kX0R8MYMLbwviLVbf+nMCGISDf4sJOwrzI/1l6z6AkA8P7FpSaD2viDwGfpHPnl9YbridznncZtS6vFeXYX+NwuS7/kCTntdy3JaHoVeLT+X6qHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EqtpMg7h; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719824372; x=1751360372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vKsDgZDbAveDzASb8F3C/IqfEeLs4OJGXgc8VAbr7pk=;
  b=EqtpMg7hlOTCuQPnqAisDmgojkblTDA7C4OTN2+JtySv+B/XESwiqcvP
   QsnoEqdpGCIZQ4iOfKOK7LkZqfI7xIJ1DssVAiz99f4GaQpjAaq5uxg1P
   bansF9s3bzn0tk/lLLnY54dCOxZpWMuM+OHfDRTNdAOJdZwQrqkuUhDdW
   SpPlwvVEADrRNdKvqUQhihgg5xTuRe99MQWkViNTu5veypvZ8kUzma+cB
   N4iLY/gXbXdFSzcgIzqUNKNaWpEz/Ekex4n+yDibNy3JELi/HTrq6IEC+
   gNFv4Adl70SO85O5HQAWluUkXwWy2nu8yKs/aUoNGxmDXlNCgmmwXEWZr
   Q==;
X-CSE-ConnectionGUID: ZeBr/Ue5TPu0YC0REmLPhw==
X-CSE-MsgGUID: 5lDZQskOTR2k6Yaj0r0mVg==
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="31278303"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Jul 2024 01:59:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jul 2024 01:58:58 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 1 Jul 2024 01:58:52 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <megi@xff.cz>, <javierm@redhat.com>, <neil.armstrong@linaro.org>,
	<quic_jesszhan@quicinc.com>, <sam@ravnborg.org>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v2 2/3] drm/panel: himax-hx8394: switch to devm_gpiod_get_optional() for reset_gpio
Date: Mon, 1 Jul 2024 14:28:36 +0530
Message-ID: <20240701085837.50855-3-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701085837.50855-1-manikandan.m@microchip.com>
References: <20240701085837.50855-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Switch the driver to use devm_gpiod_get_optional() on reset_gpio to avoid
driver probe issues when reset line is not specified.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/panel/panel-himax-hx8394.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index ff0dc08b9829..d0e44f1f85d9 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -487,7 +487,7 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ctx->reset_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset gpio\n");
-- 
2.25.1


