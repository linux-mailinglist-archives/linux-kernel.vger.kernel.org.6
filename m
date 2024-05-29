Return-Path: <linux-kernel+bounces-194037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7F38D35C3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E4A283497
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12ED1802CD;
	Wed, 29 May 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OPfGpurK"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F3B1BC57
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716983197; cv=none; b=dAOSK2vTQzs1i5pLS0xUn8DAoFP8oxqJB/O63M/lZtiazduFxBa5FMZoI73Qa0i/N9z7Pd0OeTo3ltCr0ksjggNwFN2xu3Qlz8jo8oyrAz1Y5Pf6RfG9sSTE4V1iQEP8kDUPMpNfb2O/lTrzKOK8M6Mkeh+MabXRvGcZQuPgIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716983197; c=relaxed/simple;
	bh=2c2yRV+OWwmNPEk+pMImYM0aXvGX2seOsoanbiZFV/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5AzDqd/2GVq/J8EJyHCy6fgEJp7LzKzrKxV/8tZPtVN/3bLkTidN73DwdFE5Vwv9TArdtSKXqH/OsAThM1ROoPNRAeXdP7IbYVa0cpzz3LxkHkYqGSYPqiJ1Ndhr9MSE+pkHI/s272TkT5fMdmanT8GIJwHZG9kTDdlFVbQJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OPfGpurK; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=setKG9FGDtL/mG
	82WsX06rmtzy5NTTWcpcUdplSUhcc=; b=OPfGpurKNBji1cepO43EY2TXOKHYaR
	bmXQRx/Ac8ic5PCsnBCjeQYk3CcO6j94J0A2CogKuX+mMYvdYmUfAKP4cKQfj80m
	2A3XYVVEJxktTREcfrs4r3P1X1GXO0H2XW+2oVXaWweHJoSDg5KDCYc9MOwW4QMS
	COR2/g4oQSF/r/RXGeXjuCzX10D0c8JMkrn8ACRJIi2G7qWSnAkX2wA4c/aMP4VJ
	5oAWkcIxpO2cWg9rDFGYjd+doA9uanlYezo2pgU+OTyAltzBzNDc2xOU77+Yr7XE
	XmD5SJ/TFfeHFfT21i+FrAFT4oyVAjvqoV3tsh0MDOYnRd57UyZX8H1w==
Received: (qmail 558637 invoked from network); 29 May 2024 13:46:28 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 May 2024 13:46:28 +0200
X-UD-Smtp-Session: l3s3148p1@tDcGTZYZvLwgAwDPXwS5AFh1mWvQq9Po
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Evan Quan <quanliangl@hotmail.com>,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] MAINTAINERS: update email for Evan Quan
Date: Wed, 29 May 2024 13:46:03 +0200
Message-ID: <20240529114621.11795-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old email address bounced. I found the newer one in recent git history,
update MAINTAINERS accordingly.

Cc: Evan Quan <quanliangl@hotmail.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Against v6.10-rc1. Still needs ack from Evan Quan

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..b2fd2a19277e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1092,7 +1092,7 @@ F:	Documentation/ABI/testing/sysfs-amd-pmf
 F:	drivers/platform/x86/amd/pmf/
 
 AMD POWERPLAY AND SWSMU
-M:	Evan Quan <evan.quan@amd.com>
+M:	Evan Quan <quanliangl@hotmail.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/agd5f/linux.git
-- 
2.43.0


