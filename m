Return-Path: <linux-kernel+bounces-188473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10208CE272
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE821C2095F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D596A129A6F;
	Fri, 24 May 2024 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="K6PK2L8l"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A25128383
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540110; cv=none; b=pfg1k1qlgvChFFcqh+QsKGwj+FU08lBcfKZXPFx52KKPy8iNytRcTVe9c3OpW/GEdjFjhWywtEP4lVQet7VABdjgjjC+hCJofSCwdoNthdkVhHVUKno8lT1gJ8uEo4NFSxbieWkz2oUONRRxmvmVxLVzKYyf2IvrJ/XtTGMN7WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540110; c=relaxed/simple;
	bh=jW7Ftx2KC1dZBw3RvLRdW6NdGdVgwOqgZIoRTzVqnw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQUy1Mh7VYhmdfiFa82GdDYcqz2ieK8YyiGp9pGu4dSwrnkokwYifpTfSA7bjYMOk3+2RLtgpTXV7V+iM+GlvigMI9FItJjWjoB/74WCq0D4rXrzj6ahS7Kjd+rXVgcfIJSQFYV37oEjGvRP6YHd+c7wivuD7eIy0267+whGuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=K6PK2L8l; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716539617;
	bh=jW7Ftx2KC1dZBw3RvLRdW6NdGdVgwOqgZIoRTzVqnw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K6PK2L8lKKciR/X/Z2zY3yWFXQw6PvLlk16PKu8opADJm4VQ4GH/hG/0LOZ/pO/84
	 a+xHxDuzqAQaOKy1RA41lMSS5lFN8ADdBabV0TveJnLQ2asM9PJs7LJ1arvUa1Pzo2
	 NRkSv2hqlAOfB/ZunmTS5UZ1XA0FywWoq0a3TFmA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 24 May 2024 10:33:33 +0200
Subject: [PATCH 1/2] platform/chrome: cros_ec_proto: Fix
 cros_ec_get_host_event_wake_mask kdoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240524-cros_ec-cmd_versions-v1-1-8a148647d051@weissschuh.net>
References: <20240524-cros_ec-cmd_versions-v1-0-8a148647d051@weissschuh.net>
In-Reply-To: <20240524-cros_ec-cmd_versions-v1-0-8a148647d051@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716539616; l=899;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jW7Ftx2KC1dZBw3RvLRdW6NdGdVgwOqgZIoRTzVqnw8=;
 b=tdDZmBqCcfDDvYZ/RXnm+5CGEpxY3ZccSVnb4kk8oI1wWqrTcdwwRQuwaLfHsPkokYnGfEG8e
 qUXQ1wkOAXvDbhT0OrPeEjIViW+OH7q82Ah71gsL6uVz5Fe4X4bS52k
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Mark the documentation block as kernel doc and drop the documentation of
the non-existing parameter "@msg".

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/chrome/cros_ec_proto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 945b1b15a04c..0006a3439644 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -239,13 +239,12 @@ int cros_ec_check_result(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_check_result);
 
-/*
+/**
  * cros_ec_get_host_event_wake_mask
  *
  * Get the mask of host events that cause wake from suspend.
  *
  * @ec_dev: EC device to call
- * @msg: message structure to use
  * @mask: result when function returns 0.
  *
  * LOCKING:

-- 
2.45.1


