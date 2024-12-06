Return-Path: <linux-kernel+bounces-434259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658839E6412
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B31C1663BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494E517BB3F;
	Fri,  6 Dec 2024 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BwZCRcma"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E01553A7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451918; cv=none; b=O49U9nmqvYp+zCqPkVYPRP0QyABZ2idWMhZh4TtKKD5/Quk2cPXM1vhKEZ+1Udim1npgW0om9SpHrncgIRFoi9WwuYbONDTN+2fw4Eq95HjLRNcuygLj46L35ZXyojgOZtleASOfkuNmCwSXjEqs+53Jfvjt5xUSw++xCBFEpeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451918; c=relaxed/simple;
	bh=6CnnYbgX+U8p21U9RlvH4zbAJ+aX2QrLYlLDn+2XfmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OfW01JzVVjAue2CYUIqh/A1m6vmn8y7g06PzNc0C80k9WdLG8Tp9u8U8vRbmrB5YeAylo3EorLpmh0mykNJSUItruV0/XNe4m9MSbKqzs0wdJw4Lb+bewgX+JDlO/GoEo/v9KETeiPCDMpSqPXR+nzWb9abhFLmNaI1Zr0c68ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BwZCRcma; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733451912; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8D+f40Zx8bRgTvqVeFZvLtf/oLeDGcBhqIyVZLlxmCU=;
	b=BwZCRcmaXq+GOrY3/YJOw2w3U5T+e/JZU9b0u4qxDpHUq8iTltFi+b1OuZt+eZlYIqzmtH7+kEh4/EHLIH9bU6SfgApDvGAdG7bRTKDMuTb+tfO679bMxX0WvHxxYtpjRmegLEOQnDlZzTv9/iYhsZuNQvw3ghdFAa1A0pCnVtw=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WKuncbu_1733451906 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Dec 2024 10:25:12 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] staging: gpib: Modify mismatched function name
Date: Fri,  6 Dec 2024 10:25:04 +0800
Message-Id: <20241206022504.69670-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c:676: warning: expecting prototype for interface_clear(). Prototype was for usb_gpib_interface_clear() instead.
drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c:654: warning: expecting prototype for go_to_standby(). Prototype was for usb_gpib_go_to_standby() instead.
drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c:636: warning: expecting prototype for enable_eos(). Prototype was for usb_gpib_enable_eos() instead.
drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c:618: warning: expecting prototype for disable_eos(). Prototype was for usb_gpib_disable_eos() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=12253
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 1a8eb3bfb61c..5bfd8ccfd7db 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -606,7 +606,7 @@ static int usb_gpib_command(gpib_board_t *board,
 }
 
 /**
- * disable_eos() - Disable END on eos byte (END on EOI only)
+ * usb_gpib_disable_eos() - Disable END on eos byte (END on EOI only)
  *
  * @board:    the gpib_board data area for this gpib interface
  *
@@ -622,7 +622,7 @@ static void usb_gpib_disable_eos(gpib_board_t *board)
 }
 
 /**
- * enable_eos() - Enable END for reads when eos byte is received.
+ * usb_gpib_enable_eos() - Enable END for reads when eos byte is received.
  *
  * @board:    the gpib_board data area for this gpib interface
  * @eos_byte: the 'eos' byte
@@ -645,7 +645,7 @@ static int usb_gpib_enable_eos(gpib_board_t *board,
 }
 
 /**
- * go_to_standby() - De-assert ATN
+ * usb_gpib_go_to_standby() - De-assert ATN
  *
  * @board:    the gpib_board data area for this gpib interface
  */
@@ -662,7 +662,7 @@ static int usb_gpib_go_to_standby(gpib_board_t *board)
 }
 
 /**
- * interface_clear() - Assert or de-assert IFC
+ * usb_gpib_interface_clear() - Assert or de-assert IFC
  *
  * @board:    the gpib_board data area for this gpib interface
  * assert:    1: assert IFC;  0: de-assert IFC
-- 
2.32.0.3.g01195cf9f


