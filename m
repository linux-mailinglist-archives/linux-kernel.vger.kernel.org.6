Return-Path: <linux-kernel+bounces-529234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4A8A42218
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8B416E996
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA3425A2AB;
	Mon, 24 Feb 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvh2zCxb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC624EF62;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405065; cv=none; b=OBfdPE1uHkulTABdrXHSXDdIMgKTZrFXsnbWcwTZ1TD2KjpGXSkP/MdyOocpkTdClzQq6dehWys/S3BW9ASDXP7hgeWzSSvqila0CSZ9pyKPMAnwrW7GiGYQNrn6A6WaJMCtVpM4Ym6+k8gomDbNezWNirHmIADCLED2DobGDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405065; c=relaxed/simple;
	bh=9qpPM7N9vuJGBAdiNYiFYqBpqZja21Y/Swf+Oy1Pdo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3HlmR0IWeJ6z0xgRdXZIGxSHpxLKa9Hcvq7jKsjbeZJKMKyso7JdSC08loX+hVwFx+13ucmCLonBb2Bl/886Uzk81TN9YkAy5VhB321X4kL9T4jizjotYBa4e4eqIsJaeAgwL0vIX2yiI7+z/6u4bnllzdnz34Yhrj5Wdh03I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvh2zCxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4011C4CEFF;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405064;
	bh=9qpPM7N9vuJGBAdiNYiFYqBpqZja21Y/Swf+Oy1Pdo8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lvh2zCxbk/2uYKf6Mfl532Rtv+vGGuJWsj+2lSXJynLqA/zcTwiIJYt3PfKozVanT
	 61ljnFcmAKfCSUG+jB2/qkp6MsQWHhgM61+6N3yU3Qm+A2mHu6ekWY8yafOdu5grAO
	 gdSteqqw2ZjKvXo1/bZDCOwJdjgDZ6rfWyk5z69FzEz490CjBzfIAUULwnc/p9eb5w
	 7DfQg1EEbTtSR3Dd7f0pIv1RbCVuQ96JKRAj0BQ4b/Q1Murs/reRL7+c2UwoKEhwmX
	 khdkf0ocTPLQ0gw8MJx4glxXT791tf1GtQ2Kq5s3x1R0+vOK6WhdowiQbCknSJ/38M
	 cHdcimOF8991g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB56C021BC;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Mon, 24 Feb 2025 14:50:59 +0100
Subject: [PATCH 09/14] MAINTAINERS: add maintainer for the Ka-Ro tx8p-ml81
 COM module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-initial_display-v1-9-5ccbbf613543@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740405062; l=938;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=7OO/jW02mlmITYurf1caNsK1hmpbzWDELvNR0DyCiU4=;
 b=Xkn0L9FsTbldxUxjE+yaej7H4MVyF0S4cM5s/s3mXo4ubykUJXKtzdLG8GyRpqbAtudg00kHk
 ew3Fd7F8J3bC8frzhOywklsHPk1Idb4q0m7QaCqjYcUwKFMlTfeH151
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add GOcontroll as unofficial maintainers of the Ka-Ro tx8p-ml81 COM
module bindings.

This support is not officially done by Ka-Ro electronics, if they at
some point will supporting mainline, this should be changed to them.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f076360ce3c60123e9afa61e6e5822326f72f244..b4c76d7ad890be0f618109918ad89328bc72e8cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12510,6 +12510,12 @@ S:	Maintained
 F:	Documentation/hwmon/k8temp.rst
 F:	drivers/hwmon/k8temp.c
 
+KA-RO TX8P COM MODULE
+M:	Maud Spierings <maudspierings@gocontroll.com>
+L:	devicetree@vger.kernel.org
+S:	Maintained
+F:	arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81.dtsi
+
 KASAN
 M:	Andrey Ryabinin <ryabinin.a.a@gmail.com>
 R:	Alexander Potapenko <glider@google.com>

-- 
2.48.1



