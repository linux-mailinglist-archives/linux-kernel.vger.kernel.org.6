Return-Path: <linux-kernel+bounces-182684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516068C8E73
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93051F223EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153D140375;
	Fri, 17 May 2024 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="QIOJ2aFW"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60651E891
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988282; cv=none; b=V9sGS/3bEzYH9VPEAcgxf1dQWUeQaOBDYuw7zIkuvNTYoGCTA7UXw8rk8f7a25i/tog1esyJY/rbLTtf7qO6ILFmNykWdYzF+0sX4NdaWHuFN4pwtG2vBO4Uj7X341RANizaFsnQ8TyfaNnTrgIz2FFNXNlW16Xlub3hmh6BL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988282; c=relaxed/simple;
	bh=RwyI7eicVkeS0yVJkEUQnY43UARBb8u/F8iadUfA6Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBl5zT+H47O386jKcIRjx90Yvl+1cPdiPx2R8KMb7JY3nKPbOAhYJVEk/+TlkFssTPpsIedm6mTkwwx9/S0kmEY618sAoin3yh/VUC3QoLSb2bCPRq9K+1b1yrZymhE2UFX0dl1nbD1xascu5JIydq9vz2aOyxDk5iXlLR7mV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=QIOJ2aFW; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=EGNBwt4Jhx0eU/bSMW+HjR2avZcfPg+d5TcR4LmRDO0=; b=QIOJ2aFWqPczygka
	F251WHiGcBngjQVLpm7xkQSPFQnaFR2tb8c8vDZOiFSlljtDMCus4n8L7lZczEY0mOb0Bry3UY0F/
	p6DovP7zlrLrt5lVOAjl8Xcq+Vyz6XoHSkvtEcmPaIUPpo51PKhJWKFU/+BJNo1oRG0l4Lof1Dmcv
	Puetk0I7MjbvA0bAdPVoXGH9lFrrrftembvpS9lqEkV6qYl2PnFG7Y63FnI0z8KRF4fx3pnZNNQdW
	8EF4RrMimQBo9but+RaHoakHGBHUu3QZbPjRKTi4mBj+DlSsA3c7PyD2FQUpfJYDtGxIAZcWvTaZi
	SP4XbjWAqSu2XcLKxg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s86wD-001ThF-0T;
	Fri, 17 May 2024 23:24:33 +0000
From: linux@treblig.org
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org
Cc: maarten.lankhorst@linux.intel.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/6] drm/bridge: analogix: remove unused struct 'bridge_init'
Date: Sat, 18 May 2024 00:24:27 +0100
Message-ID: <20240517232427.230709-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'bridge_init' is unused, I think following:
commit 6a1688ae8794 ("drm/bridge: ptn3460: Convert to I2C driver model")
(which is where a git --follow finds it)
Remove it.

Build tested.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index df9370e0ff23..1e03f3525a92 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -36,11 +36,6 @@
 
 static const bool verify_fast_training;
 
-struct bridge_init {
-	struct i2c_client *client;
-	struct device_node *node;
-};
-
 static int analogix_dp_init_dp(struct analogix_dp_device *dp)
 {
 	int ret;
-- 
2.45.1


