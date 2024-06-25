Return-Path: <linux-kernel+bounces-228595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E98916208
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3056CB272A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AB014A61E;
	Tue, 25 Jun 2024 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VuZ9+nxV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303314A0BC;
	Tue, 25 Jun 2024 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306576; cv=none; b=QGcjee/npcTw1SGl/nnEIaRhWQdIjSCS3fyM2mkIRU6eNjTckeSCPy4i9D+kos15Lmvt9CvLF/Hnm88FZnnmckg+dquzfZloJ9N92Bv8Is87XXZAp5FYjgKeFpx+j2WYj/ovD+gBv7OC/H4D+KCjtKK+0lk1lCmJfm0S0bywzWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306576; c=relaxed/simple;
	bh=JKCpk5dk6D/SobJZSKKYeEwrkj1EvysciZO75GXo7IY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HA9lrVwz3YFSZza24j1XqsFYdCNt+MHAQLuTQRZg0Or+2N1A/XlaVUX2nL04bfNatqqJnvddwxYAWPzIQdyFcLaWBavKy6Xo90tfk5Y4p6iuDFjiCJqa08fk3BTouC2DpcQLsLHpZPoIiY99kEcgISLK9c3g0DOq4QZM4fmakrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VuZ9+nxV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719306575; x=1750842575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JKCpk5dk6D/SobJZSKKYeEwrkj1EvysciZO75GXo7IY=;
  b=VuZ9+nxVb9x8kYDuPvT2+dzRtOieAwd4bsOMVxn3cEMPn9q097Y86Gnh
   B2elPqSyFVdtrxwbZgLGGmhDKCE0vVnQRj3QBqiUDzxiprDz38DKnaHZX
   RP+3u6FQAyRjryEzCM/n6Z9UWdsYODd5rZceirzVeFzr0IP1JLaKd5LmP
   lyLE2R/ivx9JlxxNB3oSJ8JrMBODze581zfTZ2gutU+q9tfxiAGpsOtys
   T9ZorOHkBriBTEZ/eGCPIplbmS7PQlcIgzY6/7ApIX34PuYSwl0G1RZHU
   WEjttjXF6HPR8o8dU8T3MW7cqsQbEspthHTGRwSFmsSPlpspPxezvLIwZ
   w==;
X-CSE-ConnectionGUID: VUslT87US1uPmx+Nea0QOA==
X-CSE-MsgGUID: MRhWt4BEQDqSog1AnAJX2w==
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="29096477"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2024 02:09:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 25 Jun 2024 02:09:11 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 25 Jun 2024 02:09:04 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <megi@xff.cz>, <javierm@redhat.com>, <neil.armstrong@linaro.org>,
	<quic_jesszhan@quicinc.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 1/4] dt-bindings: display: himax-hx8394: remove reset-gpio from required properties
Date: Tue, 25 Jun 2024 14:38:50 +0530
Message-ID: <20240625090853.343176-2-manikandan.m@microchip.com>
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

Remove "reset-gpio" property from required properties list and
make it optional.When interfaced with some boards where reset line is not
populated it leads to driver probe issues.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../devicetree/bindings/display/panel/himax,hx8394.yaml          | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
index 644387e4fb6f..017cb19ed64f 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -46,7 +46,6 @@ properties:
 required:
   - compatible
   - reg
-  - reset-gpios
   - backlight
   - port
   - vcc-supply
-- 
2.25.1


