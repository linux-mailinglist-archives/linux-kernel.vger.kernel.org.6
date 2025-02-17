Return-Path: <linux-kernel+bounces-517526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECDCA38206
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BD317314C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D1A21A42A;
	Mon, 17 Feb 2025 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzxT3XhR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56517218EA8;
	Mon, 17 Feb 2025 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792377; cv=none; b=Hqbald2O8aZen7RohypQhazLnv+l/eP7GxGNa5ODMcNglF/JawiF1nFMv8vDL319/fyRSLIvvE8meotNCYs6UCYEJ/VlUmyB8GOHg2wvq5ViKOi+FOHpV8NJfvBkJuYmQWisKc2BuHO1Be9QYDJKCyk/BYhd4JQf8j3k9qT8M8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792377; c=relaxed/simple;
	bh=jgUIKutYD6JHar/7UGNU4iJs/xInxZUk3vydF/EOQVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qKb4fN+yNVT2Fkb/Aw6caJ2qHoT0Kxm4qCYyAYEOKiqaMdTwXgAa87kJfE5CQN7HbIZQqzQwC0eGsdlZNfgP8F0sW9dTx/0iTPuSN1if6/iS9ovMlYJhEpBpXmh4ccjNLjNDA4C2T0jz4Jd0mO/fjB4gI2+a/74ulum9KyyjIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzxT3XhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30806C4CEF6;
	Mon, 17 Feb 2025 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739792377;
	bh=jgUIKutYD6JHar/7UGNU4iJs/xInxZUk3vydF/EOQVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kzxT3XhRjCcjpnvE3++zGyD9rzcaqOjhZUt/UwNxmggVTfyXuL+FyUMHghPQJ33Uf
	 1rvZjaF+3G9gd9m7RLw0rbRRCtWJQbY+sN8tmHdWm9fKv/eY0IlIldYXXZqadUn/w2
	 0jTsj/baJIlu63Fd18V1qbxPzuMevn1QLyLrz+R5K59se/dSthFBOHL4D4jGGlyEGR
	 9ERMKkptF43foAxm3qFoPVJYD3O2X35BTmsvzTzNgs6ogdQ4RuPA/Wd7EW5KplNzld
	 bXhryTX+2FPKcjbc331ZjMf4Hqh+A5vASO01aZzSDv6rffP6bF+Ggw4d9CNEV33Oba
	 mTH58v5bVgszA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2586CC021AB;
	Mon, 17 Feb 2025 11:39:37 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Mon, 17 Feb 2025 12:39:35 +0100
Subject: [PATCH v7 5/5] MAINTAINERS: Add entries for touchbar display
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-adpdrm-v7-5-ca2e44b3c7d8@gmail.com>
References: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
In-Reply-To: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739792375; l=1450;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=bjGQY6YcAfvFhQstvcidH714PAZmif+zGGMT8HLhTJg=;
 b=CP5gH1NHTRgD2P0uDekGEfmEIKssn+z/69IoffnSBjcMumJcL/ltIZ3nNsYf28XV4BSrdBGq7
 abPAy+0Gi3tBOEnhmFXEFHPOtzA6nZvYx8j1STsY/VT6AWQIzzSzrXK
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



