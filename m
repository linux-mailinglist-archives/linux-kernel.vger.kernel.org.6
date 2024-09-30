Return-Path: <linux-kernel+bounces-343858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F6798A065
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A4F1C22B51
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8E2192D6A;
	Mon, 30 Sep 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="D92IekYt"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A418EFC9;
	Mon, 30 Sep 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695311; cv=none; b=MmwR3paAncPNBnhVJj7vGcHvE6W/diRM5yBpN/ZqR2zy/lr7KyQbh3ATeJUOVQBM4sKHk+ugcPe4gZKi/PNQgKcoV2ut+bbudwNLp2AgeTtq2Rpl6PbTxITMFQmoVg1ei5ToVTVj9No6m4koxyAtprkTwh3L9zU06jg9MfFKyWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695311; c=relaxed/simple;
	bh=tuE2Da4z2t/+tCz+SmNxdVPgCvfDimpR2ppsoJ+MyMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RytfaT209pjojtuQV19wGas/gcsZe+mhK2HXlFSdItsAnnIma8w7i3YP0SiFoGLJG7I7vuSZ4d4Xj6Z9XWSIrZfqf9cfGhRI7ArYkvZrBvvGa8CVpilxeKtJY5bpuxO5qv4/pXfFlGGvTjYqqgU7+/5NHpRZmjPtQmttUJxTjPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=D92IekYt; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nyVJ0vMCjCV702KmxvH+Ho117GiwdtzCNKNDXngnBZE=;
  b=D92IekYt3BLgXbUetq6phF8FQ/uwXsEz3sNkDdhPJyIBGG5qm7aRXeXO
   7j7590MUgJCu8vI0ltdx3bah1E8wZLUboPqjumoduFA6bHpkfDRUs6jtW
   bKMKQ5ojyGtMgEWU5xcUebnuMk5OCd98+f5flcVDOvcjbss+K+4YsoQMe
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956888"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:27 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Lee Jones <lee@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/35] mfd: atmel-smc: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:03 +0200
Message-Id: <20240930112121.95324-18-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/mfd/atmel-smc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/atmel-smc.c b/drivers/mfd/atmel-smc.c
index e560066e5885..4628ca14e766 100644
--- a/drivers/mfd/atmel-smc.c
+++ b/drivers/mfd/atmel-smc.c
@@ -255,8 +255,8 @@ EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_apply);
 /**
  * atmel_hsmc_cs_conf_apply - apply an SMC CS conf
  * @regmap: the HSMC regmap
- * @cs: the CS id
  * @layout: the layout of registers
+ * @cs: the CS id
  * @conf: the SMC CS conf to apply
  *
  * Applies an SMC CS configuration.
@@ -296,8 +296,8 @@ EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_get);
 /**
  * atmel_hsmc_cs_conf_get - retrieve the current SMC CS conf
  * @regmap: the HSMC regmap
- * @cs: the CS id
  * @layout: the layout of registers
+ * @cs: the CS id
  * @conf: the SMC CS conf object to store the current conf
  *
  * Retrieve the SMC CS configuration.


