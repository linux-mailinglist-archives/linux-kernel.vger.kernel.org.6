Return-Path: <linux-kernel+bounces-394271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1A69BACBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532B41C2074E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB98190686;
	Mon,  4 Nov 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXZmhw1a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1B318DF72
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702647; cv=none; b=D85EgIp/dC7Ml1/e1KoIdjCfZqMOHCeg9cr8LhuiAfb97pp+2d7OOqo+GLzGQvbb5BtIH6mDSBzfIwzKPxd1guksVaNlYVztQi+D48U2YoD6DfJq/onRDtpQyEqNi30zKXIu710rCIaIDCeu9D92yP4WE+meKmqPs6SSVhYZfSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702647; c=relaxed/simple;
	bh=V5YudWXnJ7rHUTU5EwXOV89odpcktqY9hIsiJyNOono=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdQ0m9e63voN/N7sdoTfdgIhYVS+3qNTcUo1BmOmaKN+wuPdQVnH1FRjt3Ci5cvivdY69aikHla65CZjGBy6q657o3s4YvsEif3IJDHmcEsUbUQyPlI1zLjGYABcjKqjKQYFgHO0Y3wZWqSWKeO0mf8bTYhPTD2+m/Ut5CPDYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXZmhw1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85A10C4CED6;
	Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730702646;
	bh=V5YudWXnJ7rHUTU5EwXOV89odpcktqY9hIsiJyNOono=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sXZmhw1axFGapV0gBXqiy/0zoNM3gw4ZIZVXAJiJ6hrUmaEUABUrGJTPov9f2EthO
	 TJunML8LsKCU/tXLP4+Yj1eval5qqSrfpRwo8Skkc85x6ZB0CVqvLzcO+nJEXLmFTM
	 CX0Ngd5EmHdYWzZtxVoX6t9v0y5U4FdoXi5QDhKnICh+TSICxPtQZtKaoHwsDh/VoM
	 vQmW2OPP5wwV2zMjBmLY4mDIe+9lbGTmNnvgHKoHC8ny5GwbLyR+gQcUJZ+DUslQD9
	 cyh14shLX0isbX4fBLU18WDPhCqImpEClEGvnbT5PmOZ84YLo1ZdS5DOn6Hp4s7Rbb
	 cvIA3m3u99G8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771B5D111AD;
	Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Mon, 04 Nov 2024 14:43:34 +0800
Subject: [PATCH v7 04/10] drm/bridge: it6505: Change definition
 MAX_HDCP_DOWN_STREAM_COUNT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-v7-upstream-v7-4-8b71fd0f1d2d@ite.com.tw>
References: <20241104-v7-upstream-v7-0-8b71fd0f1d2d@ite.com.tw>
In-Reply-To: <20241104-v7-upstream-v7-0-8b71fd0f1d2d@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hermes Wu <hermes.wu@ite.com.tw>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Pin-yen Lin <treapking@chromium.org>, 
 Kenneth Hung <Kenneth.Hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
 Hermes Wu <Hermes.wu@ite.com.tw>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730702658; l=994;
 i=Hermes.wu@ite.com.tw; s=20241101; h=from:subject:message-id;
 bh=LXCX7YKUcq6qewqH/z3sJdCcnXEOYr4Q2Lg8igxzYE4=;
 b=P+iT0z0dBfYBkX5Foabrt2Xum8ijPioFa24M1Oq18B9ckRPVR4m58R+9YzsklK5GGvUZOw1dP
 H4tv1W844lmCwy5UwPKTAyMMfgrzVVgvuOgd1bnjoQZcwY2Oj70Bvww
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=FOYYbsP2Nlw6mjB3rLFYSLmAiENzj4AWQly5XTcDuMM=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241101 with
 auth_id=268
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

A HDCP source device shall support max downstream to 127 devices.
Change definition MAX_HDCP_DOWN_STREAM_COUNT to 127

KSVs shall save for DRM blocked devices check.
This results in struct it6505 growth by ~0.5 KiB.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index ba37974967767a17b7025595f6864f057174efb9..9a90a36d0421422038b04ad00b2cb2e326a9cab4 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -298,7 +298,7 @@
 #define MAX_LANE_COUNT 4
 #define MAX_LINK_RATE HBR
 #define AUTO_TRAIN_RETRY 3
-#define MAX_HDCP_DOWN_STREAM_COUNT 10
+#define MAX_HDCP_DOWN_STREAM_COUNT 127
 #define MAX_CR_LEVEL 0x03
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15

-- 
2.34.1



