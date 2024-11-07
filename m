Return-Path: <linux-kernel+bounces-400566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3159C0F4C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168941C22BCD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39835218323;
	Thu,  7 Nov 2024 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZyAD5dPw"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F318218313
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008903; cv=none; b=QXmMyF5UTqg7tpwRqFJBcBNVD40T00ZTa2YLuWDbA1lX7vY3CKT5wVbNaVSDngT2VpHL/2rag3FHNyvOJ5Ig1vFWMKRvIxh+BD+lDihtUDjGHOI0EMsM6JvjE7vYtVG5CzxPBiVwTi/N4VcGno7sPhORW3qwRDV4Wsj90oGeiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008903; c=relaxed/simple;
	bh=f0YywPWanEM24s0q52GKso9Nv195uicG46KTsPUxLW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BH9ADiTk+Ouk9kcIsqdsedc7E4nil6B9a6M3IGWg8JgSWPpRGxjUI5s5bQNRmNLNShqy593s4cLV98vMH4RUFprCe7Zbi7LR3pcNUztcnSMeEN7GobKbZm789U6jnNUf4ySsjH1gV0ZN7iLdhdb/bW0SodGeAYCRrAzf6Hzu9So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZyAD5dPw; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:c173:4b:4a04:3a21])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7B4DFA44;
	Thu,  7 Nov 2024 20:48:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731008892;
	bh=f0YywPWanEM24s0q52GKso9Nv195uicG46KTsPUxLW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyAD5dPwUsqoCX0oK08eQBVUxzuucLvpE56CEQAcS1Bg2BQ5gySzMC4cKZgAS41Px
	 0VteNgF5hMwh7EEv6c37NDD6FUPMz8ha9H6yXOXyWJxiO9r9N9TDBOv4EbXHM1ob54
	 vurRy453/TxYeVJO2wOYSU6LAEe/j+XR/1GEGuOo=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 3/3] staging: vchiq_debugfs: Use forward declarations
Date: Fri,  8 Nov 2024 01:18:06 +0530
Message-ID: <20241107194806.90408-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107194806.90408-1-umang.jain@ideasonboard.com>
References: <20241107194806.90408-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use forward declarations for struct vchiq_state and vchiq_instance.
We can then drop the vchiq_core.h header from vchiq_debugfs.h.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
index fabffd81b1ec..b29e6693c949 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
@@ -4,7 +4,8 @@
 #ifndef VCHIQ_DEBUGFS_H
 #define VCHIQ_DEBUGFS_H
 
-#include "vchiq_core.h"
+struct vchiq_state;
+struct vchiq_instance;
 
 struct vchiq_debugfs_node {
 	struct dentry *dentry;
-- 
2.45.2


