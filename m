Return-Path: <linux-kernel+bounces-412332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A009D07B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E921F21B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7AD1803A;
	Mon, 18 Nov 2024 02:04:51 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7B33E7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731895491; cv=none; b=TwPZQgbVGJeOBgCxdauYf+m7SFqu6dZWhVI+zzCZIW6WCwEuoaOtEPUisjrRcxCPEAn7CpzutLWp0yp2OOoIMg4nkfGxwf5ONRqpYS/zlLhKjt5EPJneLmng+WQK/cIFHyqXac5BrPUK3anYk2CtFiJskcyBpigFVLBryv0u2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731895491; c=relaxed/simple;
	bh=Rk1yRnp4ZmebIHn/c6UGvY0Tpybf6YqolRBTyqRfDYU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AgMEmREQWSMSlSKL1paJRdsAIGss8PlRJso5SPtwgaSm/bR3xv35jPzJ2I7JsewAu57yW66FZpGKLwVKUKZEtK8WoQXE1a3Aeqf1XakKpdu3fNTza5tq9Z2oJJ2GZqMqndNqu/FQXC+m6nK/gB3a/GZejVbQvVxIFKb876+7SJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2673aa0b468e-716aa;
	Mon, 18 Nov 2024 10:04:37 +0800 (CST)
X-RM-TRANSID:2ee2673aa0b468e-716aa
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1673aa0b4c81-a4d67;
	Mon, 18 Nov 2024 10:04:37 +0800 (CST)
X-RM-TRANSID:2ee1673aa0b4c81-a4d67
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] macintosh: Fix spelling mistake "toogle" to "toggle"
Date: Sun, 17 Nov 2024 18:04:34 -0800
Message-Id: <20241118020434.10971-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There is a spelling mistake, Please fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/macintosh/adbhid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index b2fe7a3dc471..943a7123786a 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -604,7 +604,7 @@ adbhid_buttons_input(unsigned char *data, int nb, int autopoll)
 
 			case 0x7f:
 			case 0xff:
-				/* keypad overlay toogle */
+				/* keypad overlay toggle */
 				break;
 
 			default:
-- 
2.17.1




