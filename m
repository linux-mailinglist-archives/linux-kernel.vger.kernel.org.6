Return-Path: <linux-kernel+bounces-183768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122AD8C9DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D691C23431
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A19513440C;
	Mon, 20 May 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="qBp6ucon"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A186626
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716209766; cv=none; b=D6iYcJeD4EjCv3a6hYD2bIFj9zKSUUuYP+5lxRU/KQKLI91LQVWmR6waoDVqY41LixNt9X8I0v06NGk22qNPVugVPGJ1Z+UhrAHdXvklSooTqODvtGmeGVJStE8I8fe398MMZbmbXsHzUNUWA/Swr66VkYUS725kwKc+MSjSDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716209766; c=relaxed/simple;
	bh=qByWwL0jBOToeT0RkL1j+uWeA6iN4uWSl8O6N8Ce90I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUsidIJHKO+lhSx7l9SGuptxdlrGdutCYcuTWywy/xlhn44HfYvEIxSiTDw9P2VSP1jIutWellMww8JTinH0Rx37uCYUrQZA8UqbeEe3K+tJ4664sdkWd5Lr7wsEhi2JDKEOUzYZvW5cWJj0oV4+/PHSJ8yWNgp4LE3cybhdMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=qBp6ucon; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=i+gBr0dyONZ8//GblVtrNJo1gt5VfgjaWVel6lxqg9w=; b=qBp6uconUQjLMovb
	h7msqVzFfDdv6mJ2Wob8E7s2Z7Rw23ajYWGwTk50c0EnTJP6c7XGDvJYSCU66MsA9UCqGA01uGGrm
	82Pc3XUUj+MonNshcTUy8y1EsHmoiBDRbMqxyA9MjQNbHRPGf1O6y5vJ/1r8QIKV4loa6ts8L5d8C
	C3vcde6qx+P+hdfXyMVnk6KlYfl9psMzEAjcKrRx1g2b+Mo98Dsl3hLbQHFYrzk/tu/shM5RGvO9j
	dyWskUr56R5bG47Ly/E/NcMjiKJubVDz0q84urD/tkkmzbMWogx5JouIShwJl1qDSZL41AqLDuF1d
	pq8cphw1XXr3/cp+DQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s92YU-001g4B-2a;
	Mon, 20 May 2024 12:55:55 +0000
From: linux@treblig.org
To: dmitry.baryshkov@linaro.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org
Cc: maarten.lankhorst@linux.intel.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] drm/bridge: analogix: remove unused struct 'bridge_init'
Date: Mon, 20 May 2024 13:55:51 +0100
Message-ID: <20240520125551.11534-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

commit 6a1688ae8794 ("drm/bridge: ptn3460: Convert to I2C driver model")
has dropped all the users of the struct bridge_init from the
exynos_dp_core, while retaining unused structure definition.
Later on the driver was reworked and the definition migrated
to the analogix_dp driver. Remove unused struct bridge_init definition.

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


