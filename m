Return-Path: <linux-kernel+bounces-528761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016B4A41C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8846B3A43F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7142505C9;
	Mon, 24 Feb 2025 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6cIv8pb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D9F25A346;
	Mon, 24 Feb 2025 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394939; cv=none; b=YQIaTrxLoTm/1qwPycTqOQvPN9g+Mgfl6s43D1sQKkowcAuXh4wrOnMBkoi2gbB7VM+PpTdfeqTSx6WgPgX47Uwz5EpOrD2c/+TzxsmvLVX0hvpVB4cvoE1KFKRokT1+TTaUUCeMKuolAM0gigu9aWFPy+VdvMv5Zzlj8cJQOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394939; c=relaxed/simple;
	bh=jgUIKutYD6JHar/7UGNU4iJs/xInxZUk3vydF/EOQVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7r0WenNl9f0un4dgn38W/sG/GMuFrMCD5pZQDBoXjSaUwN+mEo8raBF2/mP2WCRvp6q0VhWZfjKQ6+SCiNxhDqHwic2JbSfA32Ls0oo2lJ2JPYdj5GfBPr31bjgTXKKMJpAA1HIueiAw0s4XFP1nOMnsETbCzaOtkQf5PNpjj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6cIv8pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95D20C4CEF2;
	Mon, 24 Feb 2025 11:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740394938;
	bh=jgUIKutYD6JHar/7UGNU4iJs/xInxZUk3vydF/EOQVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c6cIv8pbAIrCW8ylEnQPrXc4iNkB/bZnN3CuZCWPxnO8BzJbm7lJE5VcKB1pu81pS
	 RTwyjKgzn222bhOZ050hlMB8hJX3d/tbsrEk3xQi+3N5nmLYTToTKVDI5sU68RvhVy
	 9IDfRkfxrW1N4i3D3CA13pUKiQxn5EC3vO82dcDyxoLEv0lM4GrugW61frxhl64LTC
	 X849yeRRzOkerLIRy1nvUHbzaHub724IRGXsV7FnhAbfEIsOYUGmkPXdhpm4m2eOcc
	 6xUjvLCHkDzF8zwB/+Ku/edim/NNUBYlotT0DupxX5v3fSx3z+r1U8MYD779nq+Cq1
	 T+YDmRK3z2BLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D340C021BD;
	Mon, 24 Feb 2025 11:02:18 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Mon, 24 Feb 2025 12:02:20 +0100
Subject: [PATCH v8 5/5] MAINTAINERS: Add entries for touchbar display
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-adpdrm-v8-5-cccf96710f0f@gmail.com>
References: <20250224-adpdrm-v8-0-cccf96710f0f@gmail.com>
In-Reply-To: <20250224-adpdrm-v8-0-cccf96710f0f@gmail.com>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, 
 Janne Grunau <j@jannau.net>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alyssa Ross <hi@alyssa.is>, Sasha Finkelstein <fnkl.kernel@gmail.com>, 
 Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740394936; l=1450;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=bjGQY6YcAfvFhQstvcidH714PAZmif+zGGMT8HLhTJg=;
 b=h37nVwZ9F5bmgDy71SXMvVSptZeWIvrNU1lxX9sOteApVreqjkkJkqkO6y1KZZmiDxDfReI3k
 R20062i+v+GChYOeeKqOOlttNUNRoimiALptpJfaD28eq9MH+AxU328
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add the MAINTAINERS entries for the driver

Acked-by: Sven Peter <sven@svenpeter.dev>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a87ddad78e26f28ffd0f3433560d6db1518f9f95..895d682bcf4e351971b04c6515ebf685fd39b662 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7746,6 +7746,22 @@ F:	drivers/gpu/host1x/
 F:	include/linux/host1x.h
 F:	include/uapi/drm/tegra_drm.h
 
+DRM DRIVERS FOR PRE-DCP APPLE DISPLAY OUTPUT
+M:	Sasha Finkelstein <fnkl.kernel@gmail.com>
+R:	Janne Grunau <j@jannau.net>
+L:	dri-devel@lists.freedesktop.org
+L:	asahi@lists.linux.dev
+S:	Maintained
+W:	https://asahilinux.org
+B:	https://github.com/AsahiLinux/linux/issues
+C:	irc://irc.oftc.net/asahi-dev
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/apple,h7-display-pipe-mipi.yaml
+F:	Documentation/devicetree/bindings/display/apple,h7-display-pipe.yaml
+F:	Documentation/devicetree/bindings/display/panel/apple,summit.yaml
+F:	drivers/gpu/drm/adp/
+F:	drivers/gpu/drm/panel/panel-summit.c
+
 DRM DRIVERS FOR RENESAS R-CAR
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

-- 
2.48.1



