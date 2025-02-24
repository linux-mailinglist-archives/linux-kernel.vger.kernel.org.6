Return-Path: <linux-kernel+bounces-529236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D56A421FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F631892D42
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECED25A2B9;
	Mon, 24 Feb 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvkeoqHl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099D24EF7C;
	Mon, 24 Feb 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405065; cv=none; b=pAdPraOZmrJWEblNGjnDhPXqezjke7KONgyl4P6tLz0Nlzd6DDVrH33AYWeAaohdh1f1fTyHm4Xpgt4qQ4079O3vssfnI2L1A8VvnVr3UUisHKN0Iti8jNedyz2Dl+WmESOqhs1gg+1m879pKsTMdmNP585qS0cFSM2OINQ3d1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405065; c=relaxed/simple;
	bh=hTPrO7u9vikyA+T0pYfEy9szULQyXPV8+3Ucv3Dz7Aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TaV6j1Eh3CYUpmn7nvF/ohKdZ4xPQ6QIE7qk8ZLePcmrte+szT2HjxXs7JOqXwLZ7BQOdl5qoxkAEjT73H/PYxF8pdgqmRpRJi/0nR6/F6uAcVT18aljcNniOYg8+zXciYnjMez/5q1Y0rIjjjCiSQuXS+Juou31YcYoPUHNXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvkeoqHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD7DFC116C6;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405065;
	bh=hTPrO7u9vikyA+T0pYfEy9szULQyXPV8+3Ucv3Dz7Aw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dvkeoqHlB9lYgUKZdTOejRPwtzq6S0NQ+Ii05pTy5Jx7bS+T1vGymNsHjJLkfqC+4
	 CZmN8YsLNPi9AqqWFS6Yfn0USHXnC83zlcgoXpLAghuRTb0KPKLqtypsBNHZFMdZ+X
	 63oFsUZycayI9rfSvIfNCYr8WLJ70kcL1arJJrFAuQny9EZHeykU08hTmFoFYuiwCx
	 REUMgouU+W510AavoXNs32o/rKvmXkN6Kw7jcH0BAZ+10Gn8jo/WlHDgb41jWNjozz
	 uHFIIaKNXQhjWFJ79XPJATkIWOvmEM7qUvhc4bTM6U40clOdLrHH8VuCBR7Qe275pg
	 eLEH0vQ0No3Ag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17F0C021A4;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Mon, 24 Feb 2025 14:51:00 +0100
Subject: [PATCH 10/14] MAINTAINERS: add maintainer for the GOcontroll
 Moduline controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-initial_display-v1-10-5ccbbf613543@gocontroll.com>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
In-Reply-To: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740405062; l=783;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=z0gueLFcKY7qkz1B8onsTw44Uj3rSydQ9QleSWa8oZk=;
 b=lAU9+MTJ3smyQz3gcyDoGEboLTWpbgUoebuITkTiRp8H/PJvmRbJR/btf5ukRY8Wu3Lu5UwTg
 LPE6zgrlw3EDBUSFGvF/oFRYliLy1A0rdygD1WXk695M6Udt9lsXsZy
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add a maintainer for the GOcontroll Moduline series of controllers.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4c76d7ad890be0f618109918ad89328bc72e8cd..d80688d833322d4dbece34226180875c6b10ae40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9843,6 +9843,12 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/usb/go7007/
 
+GOCONTROLL MODULINE CONTROLLERS
+M:	Maud Spierings <maudspierings@gocontroll.com>
+L:	devicetree@vger.kernel.org
+S:	Maintained
+F:	arch/arm64/boot/dts/freescale/*moduline*.dts*
+
 GOODIX TOUCHSCREEN
 M:	Bastien Nocera <hadess@hadess.net>
 M:	Hans de Goede <hdegoede@redhat.com>

-- 
2.48.1



