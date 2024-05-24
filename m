Return-Path: <linux-kernel+bounces-188475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217998CE274
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD1C1F22A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DC2129A71;
	Fri, 24 May 2024 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LcNB+fVr"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149FC128382
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540110; cv=none; b=E+aEZ7H9oPj6TQwVCfIoji4l46WNmNEz2SHqz6Wu4Yz42O5rFl+DXFeeRLPTSWjIpWG2sUTRZ+taA7A4xyKBQW10yp+rq678nDpdmXFKIfSo07Ezpy1BV6QLIy487qRnUNg1c2pXK/SmtQwqiZ1Y2Xa1OP+/IB0QM9PkJkWZHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540110; c=relaxed/simple;
	bh=5TOBwxsF/ssAhWevLOKVZZiad/EoE9Qjo1wELgR4coQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cr4wz52AALX0VJ8sKy88ttRNYFFQkA2LUbtHl6DK4FKn99TFPBgoWTluTJzpqyzWAwsX+Cjn7rUDUn1//VAz7ZFPV+5xF0Lh0z4TWrQ+34qUPx/d1poby5f+Dj0e35i/Vv+TJk6PT1NTg88dIRp9pSn0D6/nb7Tn6NR+9zFy/ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LcNB+fVr; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716539617;
	bh=5TOBwxsF/ssAhWevLOKVZZiad/EoE9Qjo1wELgR4coQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LcNB+fVrAstclMmo+s7OkLnZov3T5v4uYCIGxidfSmxDkoE9blWvLpDN3QXIlqulb
	 rNQQHloLLqm656kkw7QiCXRmNTHqniWpFwIgDey1wBsg19m/ehmt4i8UwLALQBvJ3x
	 3vNVuKCBoEFwtgQ6DeG4k5QDpqd2xJ/W4FrtDtGM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 24 May 2024 10:33:34 +0200
Subject: [PATCH 2/2] platform/chrome: cros_ec_proto: Fix
 cros_ec_get_host_command_version_mask kdoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240524-cros_ec-cmd_versions-v1-2-8a148647d051@weissschuh.net>
References: <20240524-cros_ec-cmd_versions-v1-0-8a148647d051@weissschuh.net>
In-Reply-To: <20240524-cros_ec-cmd_versions-v1-0-8a148647d051@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716539616; l=907;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5TOBwxsF/ssAhWevLOKVZZiad/EoE9Qjo1wELgR4coQ=;
 b=5JvEnK5PvixO13QAhdFeynqVs1V2NjccBnydXRn0155oulCmimDplO7i0ZdvDH3u0pQINFLVq
 y/6ffRXurkdBh8vFcjK1GY7k41WdcqJnZz55YMTZNybAkyhU/C+zBMQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Mark the documentation block as kernel doc and drop the documentation of
the non-existing parameter "@msg".

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/chrome/cros_ec_proto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 0006a3439644..dcfc18fe1cdf 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -426,13 +426,12 @@ static int cros_ec_get_proto_info_legacy(struct cros_ec_device *ec_dev)
 	return ret;
 }
 
-/*
+/**
  * cros_ec_get_host_command_version_mask
  *
  * Get the version mask of a given command.
  *
  * @ec_dev: EC device to call
- * @msg: message structure to use
  * @cmd: command to get the version of.
  * @mask: result when function returns 0.
  *

-- 
2.45.1


