Return-Path: <linux-kernel+bounces-230988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 978949184A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B3B1C230A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70D1188CC2;
	Wed, 26 Jun 2024 14:40:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94918757E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412845; cv=none; b=mm9tRNumAT4CVMUYJ/cg7zdL5yPXq6xkDDtOvZBvh43FaJHKmQlL+P8Q9jRXAJFYfh75JA+3yY44lWEE5rJRV4gfwL+MPkRL8bKxTfDlJHjKnFbTQHg/WjDFu/tVZajieJeQqG8NIaM5YzeC97DYayOm6QUnSjIq0/IXMRGb1XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412845; c=relaxed/simple;
	bh=20eVnPhUqx/jNjxH2u2zfRFD7wdKlA+qiwPesdDiEY0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OcYLQr8TVIs/Kw17g7ZFLvoFx40hCpGxvLCn8PjCJbhqIzBYbwK2Azxst23de4RkLw14nXe/0tzHYlr3iscVAOHMzphBZykkCQndVvS3AkH8PbIikT0RuCDMxt0xEk8HYlotpmc/9wN0aK/hFyrZyjw2ci9ez6NesamJ9r4NDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sMTp9-0007iB-Bv; Wed, 26 Jun 2024 16:40:39 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: =?utf-8?q?=5BPATCH_0/2=5D_drm/panel=3A_ilitek-ili9881c=3A_Suppor?=
 =?utf-8?q?t_in-panel_180=C2=B0_rotation?=
Date: Wed, 26 Jun 2024 16:40:37 +0200
Message-Id: <20240626-drm-panel-ili9881c-rotation-v1-0-e0ff54173e32@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGUofGYC/x3MQQ5AMBBA0avIrE1CKeUqYtG0g0komYpIxN01l
 m/x/wORhClCnz0gdHHkPSSUeQZusWEmZJ8MqlB10agGvWx42EAr8sqdMaVD2U97pg517XVljdG
 +dZAOh9DE938fxvf9AIQuxcBtAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14-dev
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The Ilitek IL9881C controller can rotate the image by 180°. This
might be desirable on devices with their display mounted upside down,
that don't have rotation capability in the SoC display controller.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Philipp Zabel (2):
      drm/panel: ilitek-ili9881c: Explicitly set address mode, allow 180° rotation
      drm/panel: ilitek-ili9881c: Report subpixel order according to rotation

 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240626-drm-panel-ili9881c-rotation-54d53a885d7c

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


