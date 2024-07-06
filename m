Return-Path: <linux-kernel+bounces-243197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CC39292FC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069BC1C211B0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E74E81727;
	Sat,  6 Jul 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="amUatpvt"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F70811E0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264915; cv=none; b=lVmxxXxcC8ZwdgY6v3Td2onfU/Biy9FL2VmWiZklSxRZ9ITIjSJa+UR7JCAJsXaYaA8pXIzYsMGDNsbFIjS9vqCHXIIGMilzEqgucqVoJtZGSIPaTkQrHTORFc7zKXV6r2o9NTkpThgdphmIiIBIyP5dYqZYR7L7doaW76Gmzh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264915; c=relaxed/simple;
	bh=w4p5x6E9AF/XtTtu6q+8032MrinkSKAp8+QYHIUVFlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDqdqTmxabolDUP6ERa6FMwYDBfQdItaEycaA2t9aDFWfkQH2CycDz/oJVnspCBkGhzd0YqDjQS87m5RDT20DBxnmWq8896aml9lz28qZx2T6H/ui58wZ8viI7my4lXYa2UIrWoCuOFdZwLZ3WmzBoxIE+H8Ln6HXfHny4wJ6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=amUatpvt; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=CeHb9vjrMt9jgzTKk4gewrP64EVImhpH0TXk2i/YvJg=; b=amUatp
	vtX+JVTnJKBqKk4AaWb+7jUjoeeq/bj7qlrw53vstcgKXyRWQhxWPAVRQNfdoudf
	JfOZZpAz3BcAJ/aHuqGc5pGSyOOUtIgMlD+anz170ac9Fxk3GLI33mH8f7TyKGiw
	+X05oaD1Ax+lNSYGeBLthALrybelTHyNpqaO2lgE+NFRwBxwmadPydhOFnvsoM0V
	8y+Ox2r/ADb6fYSEqxNBzxRC8tdwLxFGqpezEC8U2ukT+8LFlMKszUHpi0Az66Zx
	oz0CqMt0IPctKz45ujwFtgFoMQnT9xNeFXzPNjj3XeGcWC2WCA00tngQ7r70Uyqi
	pA+FWzskUnTx5HdQ==
Received: (qmail 3810015 invoked from network); 6 Jul 2024 13:21:37 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:37 +0200
X-UD-Smtp-Session: l3s3148p1@QCMlYpIcPoZQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/60] i2c: iop3xx: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:22 +0200
Message-ID: <20240706112116.24543-23-wsa+renesas@sang-engineering.com>
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
Remove a useless comment while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-iop3xx.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 2e5f0165c3d3..859c14e340e7 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -22,7 +22,7 @@
  * - Make it work with IXP46x chips
  * - Cleanup function names, coding style, etc
  *
- * - writing to slave address causes latchup on iop331.
+ * - writing to local target address causes latchup on iop331.
  *	fix: driver refuses to address self.
  */
 
@@ -234,7 +234,7 @@ iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_data *iop3xx_adap,
 	int status;
 	int rc;
 
-	/* avoid writing to my slave address (hangs on 80331),
+	/* avoid writing to local target address (hangs on 80331),
 	 * forbidden in Intel developer manual
 	 */
 	if (msg->addr == MYSAR) {
@@ -349,12 +349,9 @@ iop3xx_i2c_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg *pmsg)
 	}
 }
 
-/*
- * master_xfer() - main read/write entry
- */
 static int
-iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
-				int num)
+iop3xx_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
+		int num)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
 	int im = 0;
@@ -384,8 +381,8 @@ iop3xx_i2c_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm iop3xx_i2c_algo = {
-	.master_xfer	= iop3xx_i2c_master_xfer,
-	.functionality	= iop3xx_i2c_func,
+	.xfer = iop3xx_i2c_xfer,
+	.functionality = iop3xx_i2c_func,
 };
 
 static void
-- 
2.43.0


