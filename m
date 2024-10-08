Return-Path: <linux-kernel+bounces-355436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC7F995240
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE802287E02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACAC1E04A6;
	Tue,  8 Oct 2024 14:46:48 +0000 (UTC)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081601E00B3;
	Tue,  8 Oct 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398808; cv=none; b=iVlbN7YFSMi2bh2ge62+JCe8CpyG3oPRJbcvgRRVDIySaGnQI4j1rMHxsNBki1ZU8pqLGXOVYdjP43fdR6BdNGQOBt2rfgrylpp1AcFEqmOzzbZML3T5MOd496kP2k4WaJY5B21+ts6GuabHf6zSKLqswFUh9UAopWrxW7MwbGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398808; c=relaxed/simple;
	bh=sLKCCG8NFJ1zbby5odQrkInQlu0JltXoOhgocXbBh94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPzMoqLE/ZQ2LuK+tJiGefui1AMIy0UgyIMLuxYELpt/oEfwTChpIwgwBEBEb42pouBecfore9KbNq9YFP18iS3CsmZsorWKTEF5xJuN9+KumMCRWiClwPgXJ3k7NcKmTVDo8rx6ScymTes9PxXabA3ZFdiHPR8jYL8+VFe76lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E062BFB47;
	Tue,  8 Oct 2024 16:38:40 +0200 (CEST)
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: [PATCH v3 2/4] dt-bindings: display: panel-lvds: Add compatible for Jenson BL-JT60050-01A
Date: Tue,  8 Oct 2024 16:37:44 +0200
Message-ID: <20241008143804.126795-3-frieder@fris.de>
In-Reply-To: <20241008143804.126795-1-frieder@fris.de>
References: <20241008143804.126795-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The Jenson BL-JT60050-01A is a 7" 1024x600 LVDS display.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes for v3:
* none

Changes for v2:
* Add tag from Conor (thanks!)
---
 Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index 155d8ffa8f6ef..5af2d69300751 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -50,6 +50,8 @@ properties:
           - hannstar,hsd101pww2
           # Hydis Technologies 7" WXGA (800x1280) TFT LCD LVDS panel
           - hydis,hv070wx2-1e0
+          # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT LCD LVDS panel
+          - jenson,bl-jt60050-01a
           - tbs,a711-panel
 
       - const: panel-lvds
-- 
2.46.0


