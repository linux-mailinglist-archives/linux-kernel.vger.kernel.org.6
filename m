Return-Path: <linux-kernel+bounces-444412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB279F065C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA02282089
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69451A8F95;
	Fri, 13 Dec 2024 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIHHESbt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84A1A8F7D;
	Fri, 13 Dec 2024 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078687; cv=none; b=TgGHX/B2E0idDUtJ7sif9W2GzIUIZDAPFUsCrJQAVFBiuSotnI0aZgJhkH0K6kFmGyzXmX5UHVMSBflnIOHDUEHpL07RTPipboW42PXDpMSYP0yCisw07VXcnwGatgV11P45LjFWT66R3XmE2QFIaJ2CFuOLy5VhXD64Mv/lUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078687; c=relaxed/simple;
	bh=e/MEF4pvPAfE0mbIC8ioAQB5ZG388Lw8xBNOl6bDvvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E6czaaazjCoBTB5uG0qMjNULUEloXlt5CN8F/BF4/+Nd16MEIS1GvscVn823fPxAktcSBaNI8brehOlseXDOfKx/E7eKFDnn+RywMfqGIdxFzQAweDKpIsvkMEdZ7JmrnIISVOD0KFoxXD8cT4MJnjA/WOXkgcZxrrx90zMn2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIHHESbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5CAC4CED0;
	Fri, 13 Dec 2024 08:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734078685;
	bh=e/MEF4pvPAfE0mbIC8ioAQB5ZG388Lw8xBNOl6bDvvY=;
	h=From:To:Cc:Subject:Date:From;
	b=aIHHESbtauga0Oa1GfdHpHqNixTZHui7FS6fu4Bmy8SimUcf2AM3l+IMcrXhbaPWe
	 D0JDf2Iv6i0hE1kitporKVuz3RvIGv5Dm/w1g3091VWu3puvnGMo+jW70lT3SEIHWg
	 HyhjsO2W13sXSvYJov9Mo8dwwzcyGVqzSTO/jaJyfWvl4bpXVMGn+r6Iq37dFi6E98
	 bRkVojmEvdJiNcGFn7GgnQH144czCDjpKtPfhi0aZ0VGoEFWdarUfai6zOJ4ydPVb5
	 ZX3FGBBdhiIr5aPWgyH4xHpGpswDSoUj34do16p8QNhHI9Acv26LqEs/e3d28uTVci
	 +IZ2vpDFgveIg==
From: Arnd Bergmann <arnd@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"Everest K.C." <everestkc@everestkc.com.np>,
	=?UTF-8?q?Dominik=20Karol=20Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gpib: add module author and description fields
Date: Fri, 13 Dec 2024 09:31:12 +0100
Message-Id: <20241213083119.2607901-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The FMH driver is still missing both, so take them from the comment
at the start of the file.

Fixes: 8e4841a0888c ("staging: gpib: Add Frank Mori Hess FPGA PCI GPIB driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index 2ed286fa5d6e..0662b20a45e7 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -24,6 +24,8 @@
 #include <linux/slab.h>
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("GPIB Driver for fmh_gpib_core");
+MODULE_AUTHOR("Frank Mori Hess <fmh6jj@gmail.com>");
 
 static irqreturn_t fmh_gpib_interrupt(int irq, void *arg);
 static int fmh_gpib_attach_holdoff_all(gpib_board_t *board, const gpib_board_config_t *config);
-- 
2.39.5


