Return-Path: <linux-kernel+bounces-188474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E23D8CE273
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF6E28308D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D7B129A70;
	Fri, 24 May 2024 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Mclfm2qb"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2C383A2
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540110; cv=none; b=NjAmASCVgvIfbPTY2m6pLurEuMUns/1hOQZODqcek4VOH9cfJRnquJybXrStcKmXCd2pe5E7fb2EmNbz1CvoSwZ9LLRrMh1WCJXULJhdpdvSgTOM1jqd2Nohz4hq0BahMb+0oOSXU/k9I0thqiDqZ8EiwMnzkaIEN42ll/74/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540110; c=relaxed/simple;
	bh=e5+L5SBvzSbV28oQcw8gx5HYgfjLqOw6uTnbrnA+RYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZO7P1m9l58wfGTxJYYYGSmmg9UBFxrTtQSvQTv0/e74/MWhwMYM7pgD3zAVmptOKEk9n7eqbaQYAYr1Jw87sK2ViqpRnoGIQzT5Zz+JUj8+RgVD44tJcOqrSrxLYM+XfrZb4R0yx/mqIdUuun3zwvjjJ5y1nzhHJ2zEWB1Tmh9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Mclfm2qb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716539617;
	bh=e5+L5SBvzSbV28oQcw8gx5HYgfjLqOw6uTnbrnA+RYM=;
	h=From:Subject:Date:To:Cc:From;
	b=Mclfm2qbw9bM2D2YTK0RJLAdzpxr4DY9pKKkgbtZ6oaIE+h0/ECxbz/7aRR2yllWg
	 DRMvmcxPJvIvkmUV/de13hWPu59SNmsLLmI6K6foBni+FjXPSCYiHDU/TvL3Ik5idq
	 8SHK+759ktOhzzm5tPwfJA1V9flhpi39x/C1SsvY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] platform/chrome: cros_ec_proto: Trivial kdoc fixes
Date: Fri, 24 May 2024 10:33:32 +0200
Message-Id: <20240524-cros_ec-cmd_versions-v1-0-8a148647d051@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANxQUGYC/x2MSQqAMAwAvyI5W9C6HPyKiNQkag4uJCBC8e9Wj
 wMzE8FYhQ26LILyJSbHnqDMM8A17As7ocTgC18Xja8d6mEjo8ONxov1882Rn2iuQjtRQEjpqTz
 L/W/74XletTrBH2YAAAA=
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716539616; l=572;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=e5+L5SBvzSbV28oQcw8gx5HYgfjLqOw6uTnbrnA+RYM=;
 b=ujL9GC0Y9YWChyYrvGEeiFl+pf889hCJuDbpNyetWqoVCKdV6fUmd8dCYV+hU8seTyHGSvlkB
 Bd4ClgEB9mOBNtxW00RbJ9Uku8Ieu+EOZeHheeFVdbHhM49fHWmBLju
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Two tiny fixes for kernel docs.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      platform/chrome: cros_ec_proto: Fix cros_ec_get_host_event_wake_mask kdoc
      platform/chrome: cros_ec_proto: Fix cros_ec_get_host_command_version_mask kdoc

 drivers/platform/chrome/cros_ec_proto.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
---
base-commit: 6d69b6c12fce479fde7bc06f686212451688a102
change-id: 20240524-cros_ec-cmd_versions-d2bdf3a6bdac

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


