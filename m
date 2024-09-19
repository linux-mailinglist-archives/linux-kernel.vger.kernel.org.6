Return-Path: <linux-kernel+bounces-333307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DB597C6BC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B372285AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95AF19408B;
	Thu, 19 Sep 2024 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qSksTegV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180E1922EF;
	Thu, 19 Sep 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737391; cv=none; b=uvKcLX1f/nqyEbMLQiBfHYSNXPQbsfyV6uFo/fT3bZkGqzndeGqB4sVGyPn7aCTCxcWY+vUvcd6GGadK46kdYK6734zb6v1YgEPjEs5cd7EwDie50z742o8hAbKHV8aR9/2jhUwqCQx+aESJkv63CaQmNerHbZ2FbRa9k8lg2UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737391; c=relaxed/simple;
	bh=aXlvumLIjXjwd2EDcOSG4ZlwS9Ftm8iZU5L1gUO4cZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mJ0J5aSLLcDrVQ7KuunVQxLyOJlaD9sLnX1xywY05kkq9YyP+VGnvWRNAj+eldec6LSDWzoTyRjtspm+NHxGg1RCcGL6xogQlVVMizhe1cFWdqu39NI/czp4DfYsKXU+evGpdYsW9oJQkwR3EsSkyQJcm7BTyhBAE18M5Rj8/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qSksTegV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726737389; x=1758273389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aXlvumLIjXjwd2EDcOSG4ZlwS9Ftm8iZU5L1gUO4cZk=;
  b=qSksTegVEepstb3RJqPh6fo33DGaswcSHRsxPwBh9Rzc/9jH843AYLrq
   fwKmHk0YEqunrZZBJVN2inqPujQE9zPQlc1iixI8ZxoOGti2kCgSPhKOE
   3G8iWi0xSVXii5njVi/p8e3WahOuMm/Tbmc+gfH0rmj/N5WlEILk6aDlQ
   bOQc7TRDCQzZtxd12iOpm7aGlcbKRyPCArPSOao+E+VeU/dS0QZoXwJra
   LG+aPMmAM1Vifyhd1goEJcjgx2qUrfkXuSNIWQDKbYSpZSm2asKlaBaPn
   /sfykKh25UF22V3CYAuRVh4t+NezZ304LE5cIu2R7VxtoKsR7YWYGZvxp
   g==;
X-CSE-ConnectionGUID: hZG0F33CRTSCTHegcNjbKA==
X-CSE-MsgGUID: oxDeqYO8S0W8YSrSaOxLaw==
X-IronPort-AV: E=Sophos;i="6.10,241,1719903600"; 
   d="scan'208";a="31861850"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2024 02:16:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 19 Sep 2024 02:15:57 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 19 Sep 2024 02:15:52 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <neil.armstrong@linaro.org>, <quic_jesszhan@quicinc.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<sam@ravnborg.org>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: display: panel-simple: Document support for Microchip AC69T88A
Date: Thu, 19 Sep 2024 14:45:47 +0530
Message-ID: <20240919091548.430285-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Add Microchip AC69T88A 5" LVDS interface (800x480) TFT LCD panel
compatible string

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
changes in v2:
- Replace microchip,ac69t88a-lvds-panel with
microchip,ac69t88a
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index b89e39790579..18b63f356bb4 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -200,6 +200,8 @@ properties:
       - logictechno,lttd800480070-l2rt
         # Logic Technologies LTTD800480070-L6WH-RT 7” 800x480 TFT Resistive Touch Module
       - logictechno,lttd800480070-l6wh-rt
+        # Microchip AC69T88A 5" 800X480 LVDS interface TFT LCD Panel
+      - microchip,ac69t88a
         # Mitsubishi "AA070MC01 7.0" WVGA TFT LCD panel
       - mitsubishi,aa070mc01-ca1
         # Mitsubishi AA084XE01 8.4" XGA TFT LCD panel
-- 
2.25.1


