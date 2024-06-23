Return-Path: <linux-kernel+bounces-226025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8E8913934
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 11:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF711C20C6D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084417BAE5;
	Sun, 23 Jun 2024 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dyzuUSzx"
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9597D268;
	Sun, 23 Jun 2024 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719134827; cv=none; b=glw3YP8dHOdfWHRw+fRu04ypjRouOJvxGmeL1AZk27xifWr5l6cxNpLC+ZNDC5qfXNb66/IvfeND/woydvgH2zUL50p7APqafbtsX5sSdQx4+HyAY0zD++88OD+ZGIgDnZWEMkwj/ieeaKM8hjS1QlAdR6p1BO0Jbc+XTVBNSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719134827; c=relaxed/simple;
	bh=TLNEBpXsxvu1DnebqtlJwoCdsra2HYh8r8LhZRyc+RE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UtagMHux4nU4u4nl/JQ4ECX3xLKnyQ/wf8TOX0SWHHXYXJJ0PM/qQ9RcSL6mhOplUIbwd1hF2Bpot0Lm1HJqJkkxrI85rB2lD0zXzClLEXNCE9XvniiEFpyUpcLMN7OePAKiUj8jKclzDAI7OFC//JhP07LnPzVe0Id31FSBcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dyzuUSzx; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id LJUss4O2bZn3gLJUssabkv; Sun, 23 Jun 2024 11:26:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719134816;
	bh=tuK3/1THv4OAkyKVZvTBBjQAk0ybiMNLzExzqmjJTAA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=dyzuUSzxf9eZkx/L57cs7UQgY5D2fkCX1H6T7jJb6bWQ3DK3wV0JxqoEy3REXvnF0
	 bNBmScvyJ66uvrZW7sheAkivRV+0XLlJcREzy+L5nbf2EeHjDAR2nr2GytyJOoMqdb
	 xlS8aGDRl9ifQmQYPQC7fTv+iXyQkl1LqLU+LSyR3mrB1ule/mCpzEGrN+gZxAPIU5
	 k4CPhL8LfJEeOHE018lSazeByHbFVm1USTGgNRnfJy/7IC2OFfqk868YjmWMMP6cUw
	 I2z1AMV7Iku29G47MmVgIfhTfr2VsfcSBGOhBz5GBp7b64tX1qot0vjR+bI0cFhLvW
	 StnZoUlHG3erQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 23 Jun 2024 11:26:56 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	xen-devel@lists.xenproject.org
Subject: [PATCH] xen/manage: Constify struct shutdown_handler
Date: Sun, 23 Jun 2024 11:26:50 +0200
Message-ID: <ca1e75f66aed43191cf608de6593c7d6db9148f1.1719134768.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct shutdown_handler' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   7043	    788	      8	   7839	   1e9f	drivers/xen/manage.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   7164	    676	      8	   7848	   1ea8	drivers/xen/manage.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/xen/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index c16df629907e..b4b4ebed68da 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -208,7 +208,7 @@ static void do_reboot(void)
 	orderly_reboot();
 }
 
-static struct shutdown_handler shutdown_handlers[] = {
+static const struct shutdown_handler shutdown_handlers[] = {
 	{ "poweroff",	true,	do_poweroff },
 	{ "halt",	false,	do_poweroff },
 	{ "reboot",	true,	do_reboot   },
-- 
2.45.2


