Return-Path: <linux-kernel+bounces-219734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F6890D711
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDC71C25429
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82645949;
	Tue, 18 Jun 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oaZgI0UP"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FBA2E3F2;
	Tue, 18 Jun 2024 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723993; cv=none; b=mM0pFQVRwkcsUnTv1M5doPeWky23BIG/8PMvKvEibnveONFaQnaHqfr3JmglgIYDXs63CSg6Co1ZcIyOnIyL8gjkRwsmAZ0zeamNRAJ/fnwqzCtJWPAM7vjEjc/d5/MVHZCu8vx+d0ChoqUE2KT58zs2zsrZvfhn+HNYuJQr1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723993; c=relaxed/simple;
	bh=Y/DeW8T7qUkfHB3rXaNUziOx6QG+ZeaietB12LNJ4GE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLYQm+gG9nGBB1ReTBoxTf8ZVY48wuyn4ihB7kA67CIq1rnSCubZATz4Wu91Rix0A7YfNC+lS6hee67HNpHFxskHGJjO6ZEWZNnd3KTsiPA2Eu91CALBFcJ5DlADq0SvCyFvvOrS8eD0YRDSP1SlB8Mm0lj60sxDzgm/gxIrAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oaZgI0UP; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85CC3E0003;
	Tue, 18 Jun 2024 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718723984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zfY3qZji5TbZMZxXgnWCFNJU10jxEio8DZJ9M7Nk0o8=;
	b=oaZgI0UPuaWRRee2fnOTuu58Dh9xjiBqK2LSGXZ7XbkoLwwASdg1i06fERbKVrWa7zKBxG
	DIHE4/V+zLPINT3RAnL3bpVWgmkmMBj3FdoWs5HTZWZQtd4kUwD5lLbCyyul3T/g57XPBU
	X3gfWlzus5QqNLWb8Hxod/60OWaMw2PDhZ0mxxz0ymMOg7CBY6YyQeC3lRWoxOOQ1icBNn
	ktfmffwNieZzSkuftsQt9YzhhSnbuVtvOsHO+WyxCFrBEKVMEOE3u2c/OcAK99FPVYq8/C
	kbT2kF+J5fVJT5jVz/DLgJEuPCNewe3W9STJmtK5W5xjtv0sa2hyavbo2LdSIQ==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Bin Liu <b-liu@ti.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH] writing_musb_glue_layer.rst: USB Configuration Wiki Page is down
Date: Tue, 18 Jun 2024 17:19:38 +0200
Message-ID: <20240618151938.1827064-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: richard.genoud@bootlin.com

The http://processors.wiki.ti.com EOL in january 2021

The old documentation is still available through the wayback machine.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---

I didn't find the new web site, that's why I fall back on the wayback
machine.
Bin Liu, if you know a better alternative, feel free to nak this patch
and send it.

 Documentation/driver-api/usb/writing_musb_glue_layer.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/usb/writing_musb_glue_layer.rst b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
index 10416cc11cd5..e755c8551bba 100644
--- a/Documentation/driver-api/usb/writing_musb_glue_layer.rst
+++ b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
@@ -717,4 +717,4 @@ https://www.maximintegrated.com/app-notes/index.mvp/id/1822
 :ref:`Writing USB Device Drivers <writing-usb-driver>`
 
 Texas Instruments USB Configuration Wiki Page:
-http://processors.wiki.ti.com/index.php/Usbgeneralpage
+https://web.archive.org/web/20201215135015/http://processors.wiki.ti.com/index.php/Usbgeneralpage
-- 
2.43.0


