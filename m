Return-Path: <linux-kernel+bounces-194685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F148D3FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27301C21CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7D61C8FCB;
	Wed, 29 May 2024 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="eRsJUGMb"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40AF15CD6E;
	Wed, 29 May 2024 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717016408; cv=none; b=Rlyh7dXB6LHJ7Ez1SR0dOCUmAcQbkaJ7lQPxNN3wvu1PYo5q7T+bMXK3nVwt6tbhRytco76zR5uZqPdl7YOKAtevWaOxY34tIls5GVxLFvKZsM/xsTtqrOy1sQtsX4UggBO39akvx611Y4/Oc5MTTbKZsf8e1yAjXC/DVcJS1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717016408; c=relaxed/simple;
	bh=eNNu5XdpkvCFa20sCFUB9zKU8BX11Z4YPBrkRE81bHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTOGrjfXnA/PSVAcwJv1u+9bunhgLH/i/mn4S3Xj15Y65nHv9tu5Il0KlfY46+4ZQ+CVCMQt0OhZ1ZHmDACjxzZ/CZb/2mz6Fgzr3+O+EH5KCMHHrtrEWbrPw7BeGQA+1Ijp7GvZRPJfOiapo/Z7ERfWu3Nnz/VAtqPdg65Uc2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=eRsJUGMb; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=W4kjSM7663Qh7W4j002fmS4x2G6ciJUJNdGP1nbcIx0=; b=eRsJUGMbSFbdyC0B
	Q5yn7MxZqZr+FclseZF9ulu/D7GwyCPsvfx7MDf1PWc0ujh9mPFiU30Sbf1qU7wl+gLLdSiJB3PG2
	k/yyWEIJX9zqGztxMJgCpBzOkFwgDecLv9PhS/kpemfOBNF/5sxi5uwL2atiDQeXwC81DjWMTMarz
	Kc87u//MJNHJXPtg+6MlHxxCb86lIqFqTEHppZlKn24bqkdev0RkvaE3It61pXaK7BPxy+G8e2Yx5
	3BtVzLzzZu2D89TtimefAvDAz2xe46y0ipdS0bC3u+GN7PEP9mkZrni9EniolejPRm+YMYXuvQT80
	UTlPzUDVWIcrz0RP+w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sCQOw-003GJd-2z;
	Wed, 29 May 2024 21:00:03 +0000
From: linux@treblig.org
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] usb: host: oxu210hp: remove unused struct 'ehci_dbg_port'
Date: Wed, 29 May 2024 22:00:02 +0100
Message-ID: <20240529210002.106369-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'ehci_dbg_port' is unused in oxu210hp-hcd.c since it's original
commit b92a78e582b1 ("usb host: Oxford OXU210HP HCD driver.")
when it was in a separate header.

Remove it.

Note, that this structure, and some others in the driver
are mostly clones of include/linux/usb/ehci_def.h.
Someone with the hardware to be able to test it might
be able to remove a lot more structs as well and just
use that header.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/usb/host/oxu210hp-hcd.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index d467472f9d3c..3f871fe62b90 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -196,31 +196,6 @@ struct ehci_regs {
 #define PORT_RWC_BITS   (PORT_CSC | PORT_PEC | PORT_OCC)
 } __packed;
 
-/* Appendix C, Debug port ... intended for use with special "debug devices"
- * that can help if there's no serial console.  (nonstandard enumeration.)
- */
-struct ehci_dbg_port {
-	u32	control;
-#define DBGP_OWNER	(1<<30)
-#define DBGP_ENABLED	(1<<28)
-#define DBGP_DONE	(1<<16)
-#define DBGP_INUSE	(1<<10)
-#define DBGP_ERRCODE(x)	(((x)>>7)&0x07)
-#	define DBGP_ERR_BAD	1
-#	define DBGP_ERR_SIGNAL	2
-#define DBGP_ERROR	(1<<6)
-#define DBGP_GO		(1<<5)
-#define DBGP_OUT	(1<<4)
-#define DBGP_LEN(x)	(((x)>>0)&0x0f)
-	u32	pids;
-#define DBGP_PID_GET(x)		(((x)>>16)&0xff)
-#define DBGP_PID_SET(data, tok)	(((data)<<8)|(tok))
-	u32	data03;
-	u32	data47;
-	u32	address;
-#define DBGP_EPADDR(dev, ep)	(((dev)<<8)|(ep))
-} __packed;
-
 #define	QTD_NEXT(dma)	cpu_to_le32((u32)dma)
 
 /*
-- 
2.45.1


