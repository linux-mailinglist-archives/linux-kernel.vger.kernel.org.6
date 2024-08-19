Return-Path: <linux-kernel+bounces-291866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01622956847
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D04283482
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F77160884;
	Mon, 19 Aug 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndktHXVp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976A1607BA;
	Mon, 19 Aug 2024 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063028; cv=none; b=cXrWUCs29OyemgMmrdzzEnunhoNiw5mESCnGuXEU/Ly9Djgmua/v1wmclPgZqZhPJm8d2979GAZuDunnEjnuCgP+9I8OyqPPwW8KKmeF9hha0WiWB8yhtvT4DIm5gXRRxe5CXYDgb+5YDB12lJVAmb61MxMlAnhZSgPTzJrXFbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063028; c=relaxed/simple;
	bh=FZHQ9VvduvDn1bnce/kD7k3NQT3iI7OL+dLY5pkUEQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qhchSGbjhf5/EIv+M71IHA7E98w0jwgUstTPbCT86PKjxxBXk6/Ljk9vJeTtgx8Nppm81q4e13/FGNZgkNi5vlePFrS4kt/1BP/qcKwcafAuYNb3eP3p4KK7IVxlKrRus0hD0inG/cykHtKuradZwMbCWZTW9/eSP/26ET0H+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndktHXVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C1EC32782;
	Mon, 19 Aug 2024 10:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724063028;
	bh=FZHQ9VvduvDn1bnce/kD7k3NQT3iI7OL+dLY5pkUEQU=;
	h=From:To:Cc:Subject:Date:From;
	b=ndktHXVpfiz+5hCu9g+Fp6L5b4WL078TvHZccuZ4aCXlRXVmP+JXIOXHWLRmOyUIp
	 gYB3MLQxHQ3PV+HqI5vDPLvjGjEx/VSEsngxm/Kga0WR1ZcNM4VmB3/x3Hrhp+FQVZ
	 2QDXdVEM3X4Yx2amEMzJlW9xItEg11weDbBVJojbGE2THAx8pHIDcpjKgkexbmbcbe
	 w6WcmLKYasl9lZPHmbF0qLw5NMfe0Y2oKp4vUjsKg8Y4BpWhlX1FG7AzsGuIeWqM5/
	 lat8ZVGhuS+Xw0p/jHt3rpwignBjY7IRGo7pKckeEDqXNbTb52aSyNsE/bJracsHz9
	 rNyxPct6PZdPw==
From: tzungbi@kernel.org
To: lee@kernel.org
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: cros_ec: update module description
Date: Mon, 19 Aug 2024 18:23:42 +0800
Message-ID: <20240819102342.5265-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

The module description can be backtracked to commit e7c256fbfb15
("platform/chrome: Add Chrome OS EC userspace device interface").

The description became out-of-date after a bunch of changes.  E.g.:
- 5668bfdd90cd ("platform/chrome: cros_ec_dev - Register cros-ec sensors").
- ea01a31b9058 ("cros_ec: Split cros_ec_devs module").
- 5e0115581bbc ("cros_ec: Move cros_ec_dev module to drivers/mfd").

Update the description.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/mfd/cros_ec_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 55b30076763b..8a22bd31a707 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * cros_ec_dev - expose the Chrome OS Embedded Controller to user-space
+ * ChromeOS Embedded Controller MFD
  *
  * Copyright (C) 2014 Google, Inc.
  */
@@ -377,6 +377,6 @@ module_init(cros_ec_dev_init);
 module_exit(cros_ec_dev_exit);
 
 MODULE_AUTHOR("Bill Richardson <wfrichar@chromium.org>");
-MODULE_DESCRIPTION("Userspace interface to the Chrome OS Embedded Controller");
+MODULE_DESCRIPTION("ChromeOS Embedded Controller MFD");
 MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL");
-- 
2.43.0


