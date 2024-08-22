Return-Path: <linux-kernel+bounces-297242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B50395B4D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA47C286EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66F71C9442;
	Thu, 22 Aug 2024 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMug2ECN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954F1C93B3;
	Thu, 22 Aug 2024 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328946; cv=none; b=Tj83V1tsY/vVUI8y3Zw3lvSY/1hpd0a29bLqctYlwGQDVWUgANrF7ZdZEPcUzIyaGUCZm/Y2iGME4ey+wcU3PKFU+xZppRdCxybZf6xR4TnA2u8qBKzxRBpEmj6IgJClXtJLdjrzNRPiUxuB8olWz0DHVYTMoSo9j4xhqVkT7Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328946; c=relaxed/simple;
	bh=0uGoE9r7ziKqpBpmXRYc9j0/bsYanK1ptyBgDHkdCWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wlhp5RP4JCPGSHyPLpRZecmn00VMMtkLeNRbAwynmDe5rBSuqBS6T/XBWUoGkQF6F1JkjnKH0J6uHf9YZYscAQhhKax2VIv7NnA1S3q4kg8FW3/1wrJSCNdaWovgCLdLko6J5RqWczdIKjmu33YSwPHmtkwRfQWX63iNl4QC6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMug2ECN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDF9C4AF0B;
	Thu, 22 Aug 2024 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724328945;
	bh=0uGoE9r7ziKqpBpmXRYc9j0/bsYanK1ptyBgDHkdCWc=;
	h=From:To:Cc:Subject:Date:From;
	b=ZMug2ECNEVz5Cg1buTW31ms1rMu1JVJbcgfkk384/603fNfDUPSgJxX14O9Dp4OnZ
	 XED7Fedfzsw5gG1X88Ldc9oOIHlO9EROZUrhpuTYi/jl73Xe/s45WfMflUcN0fKqio
	 wOHo/FPWr8uCtrtyBp4kikAmqXW2k+hHL3Bi1qcpyBnkQX0KUyvF7N9Mb+x4W8QpZB
	 k7LHOY8NaAhJQJFV+Lh5hY3Hu4VkYeznXZsCFiRKKjWvA/eUiopYdEAk0+oMvEG5zK
	 FcYz0VeXq1tqj6EdtqE8ddGGUj8FWOXRRywvk/Snkax8Y5Y9PAjCHIn2kSXerOeeNE
	 sI4wAYoLrJd6Q==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: lee@kernel.org
Cc: chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v2] mfd: cros_ec: update module description
Date: Thu, 22 Aug 2024 20:15:39 +0800
Message-ID: <20240822121539.4265-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module description can be backtracked to commit e7c256fbfb15
("platform/chrome: Add Chrome OS EC userspace device interface").

The description became out-of-date after a bunch of changes.  E.g.:
- 5668bfdd90cd ("platform/chrome: cros_ec_dev - Register cros-ec sensors").
- ea01a31b9058 ("cros_ec: Split cros_ec_devs module").
- 5e0115581bbc ("cros_ec: Move cros_ec_dev module to drivers/mfd").

Update the description.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Drop the term "MFD".

 drivers/mfd/cros_ec_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 55b30076763b..f3dc812b359f 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * cros_ec_dev - expose the Chrome OS Embedded Controller to user-space
+ * ChromeOS Embedded Controller
  *
  * Copyright (C) 2014 Google, Inc.
  */
@@ -377,6 +377,6 @@ module_init(cros_ec_dev_init);
 module_exit(cros_ec_dev_exit);
 
 MODULE_AUTHOR("Bill Richardson <wfrichar@chromium.org>");
-MODULE_DESCRIPTION("Userspace interface to the Chrome OS Embedded Controller");
+MODULE_DESCRIPTION("ChromeOS Embedded Controller");
 MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL");
-- 
2.43.0


