Return-Path: <linux-kernel+bounces-228597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA2691620C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4141C1F212A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C814B09C;
	Tue, 25 Jun 2024 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RR1D9Yb1"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B65A1494D9;
	Tue, 25 Jun 2024 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306583; cv=none; b=VcS4ICvTw9BsPG4vsn5SxQcUBFhA5+rzHBZ8c7LK2xTm2R9WDIa0gXwaprwVN1+e2pEwodVz93NO9j5Zq8KSXLo643DBM+d42weTwVvSvHd+1sQXHap2uMCKk7H7EocKv+YA/jDbF5nJVcehCjAw97WbUwih7ouMkjO3peKyRFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306583; c=relaxed/simple;
	bh=hGvbHljF9xjHMTI4lhUwfwH0I82vEpDfIngxhWIu2MQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1lnE8z3pDys7+skd6hYbPHiU0B0j+0XCfcP2odlfK5eCXGEaikzyO1uNR7mH7IFLamZ0NJZXskwOrKEr48GYhlThLWlt1Uo/TqiejQ5a0FJZRgdidq0jfX7Je8MInUTZ7foyQps51g2xrfV6oMqcxoZkZI0P1xfj1YdUGnfjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RR1D9Yb1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719306582; x=1750842582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hGvbHljF9xjHMTI4lhUwfwH0I82vEpDfIngxhWIu2MQ=;
  b=RR1D9Yb1m7A0IpeLL98O3rY5djO9fyyqfQMsdxkHM527HkPLUKAAm0IK
   uSVVIDWUYb9GeJyxRdPeNg0gabXI4/jLOJPl25R9Oft8chnqsGAudhF7A
   S4xPtwAagqSROaDTSt4RrtZFJnz5HLmOVQzzoetr0bZMX60wSG1ePmONm
   w0bxjTuQPAXj3ZcYcyIugrq+xNtaxn9oakf4yP6vaEQbIAJFUhN5PPM1o
   F0rpngBwskAf+9ZbulGSo5rYRgVV72hG/rTJxqq8uxSI6SUbm7ThMwhLH
   5amLi6osqqn+l9+183ZIJuebFribT0N/4VEkQrBGkA3hsArIu4/DsFz8J
   g==;
X-CSE-ConnectionGUID: zjd0MkvxRYe9+LbhgcS+Jw==
X-CSE-MsgGUID: KO++c9z9R3WMG+rqCc8piw==
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="28465914"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2024 02:09:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 25 Jun 2024 02:09:24 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 25 Jun 2024 02:09:18 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <megi@xff.cz>, <javierm@redhat.com>, <neil.armstrong@linaro.org>,
	<quic_jesszhan@quicinc.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 3/4] dt-bindings: display: himax-hx8394: Add Microchip AC40T08A MIPI Display panel
Date: Tue, 25 Jun 2024 14:38:52 +0530
Message-ID: <20240625090853.343176-4-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625090853.343176-1-manikandan.m@microchip.com>
References: <20240625090853.343176-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add compatible string for the Microchip's AC40T08A MIPI Display
panel.This panel uses a Himax HX8394 display controller.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../devicetree/bindings/display/panel/himax,hx8394.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
index 017cb19ed64f..d547df794b3b 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -24,6 +24,7 @@ properties:
       - enum:
           - hannstar,hsd060bhw4
           - powkiddy,x55-panel
+          - microchip,ac40t08a-mipi-panel
       - const: himax,hx8394
 
   reg:
-- 
2.25.1


