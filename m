Return-Path: <linux-kernel+bounces-243206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AA292930E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF99C1F210E8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BC2156C68;
	Sat,  6 Jul 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="N7DggVXf"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345EE1534F9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264922; cv=none; b=oVDGpf3sfrXcoINIOIPC8aXRRVpJ1XK/llx6Oe/OwNod7zNTs5BaTAp0+Hrw/9G4Q/hcbVifmZprh0Pc4t/7EnTlmdIoGL8sgHdbZ6AKawiSaIqhjolu1//hx2clvrshVmnMwP4pwTHm7Hcr/aLQkPlhDBMcymrAQXqr2kvnC7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264922; c=relaxed/simple;
	bh=bqyay/X3ryYlkM6GK63fhh9HjwIXLb74ZPsZ65zkKcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoNfNtHdtS+aNNmXVcvSO9Q6XLHJJBowZF1S+DdOetIj9CwkyeQGivt8pizJqNB8CHrmPZigG58iR/4SCOJT2SMvnmGH9667KejxDF1Ui030663BrJQSvzxDaYrK4boAB26r0caSrRz9eLiNjP2fLww5XFgbbtCHM7M+sFgdCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=N7DggVXf; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=OFSio78sHLDzMdb966A5zrpCuagi9XRDemXSMad7UUs=; b=N7DggV
	Xfc9no1Xi8prtO7048djjtbo5C1n2E9sWS7L9KFO/I18OG/kq2vq081sD4IcSMP0
	nTc1PAeZN16FJjo2CY5KxfVw3xZO6UUALWIYN0fYB6oveIzzJDDY8pXkNAj5zL2o
	yGOMEowsLKWkfnRlfnN5Q5G725/5CGcQUXuoxIdgtj2gojPOylPIJ5obQAxaip7U
	s6jxanQ5hLXlHAtLAv0IJ4ZcPu4WWOf7pAIXjoy9de/+Ha3RapgrjIUdiKb7mOLH
	ugPFe5rYT5Vh24HCwgx9XwkSMnw3QzKDdhmjbX+F13Owvus7gF0EHYSInOKrYZkM
	Dajn86LrYeZDENSw==
Received: (qmail 3810343 invoked from network); 6 Jul 2024 13:21:43 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:43 +0200
X-UD-Smtp-Session: l3s3148p1@1MB8YpIcgIZQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/60] i2c: mpc: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:30 +0200
Message-ID: <20240706112116.24543-31-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
specifications and replace "master/slave" with more appropriate terms.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-mpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index c4223556b3b8..41d6c8ed163a 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -115,7 +115,7 @@ static inline void writeccr(struct mpc_i2c *i2c, u32 x)
 	writeb(x, i2c->base + MPC_I2C_CR);
 }
 
-/* Sometimes 9th clock pulse isn't generated, and slave doesn't release
+/* Sometimes 9th clock pulse isn't generated, and target doesn't release
  * the bus, because it wants to send ACK.
  * Following sequence of enabling/disabling and sending start/stop generates
  * the 9 pulses, each with a START then ending with STOP, so it's all OK.
@@ -759,7 +759,7 @@ static int fsl_i2c_bus_recovery(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm mpc_algo = {
-	.master_xfer = mpc_xfer,
+	.xfer = mpc_xfer,
 	.functionality = mpc_functionality,
 };
 
-- 
2.43.0


