Return-Path: <linux-kernel+bounces-343878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF79098A0A0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7EB1C26292
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6243A19D075;
	Mon, 30 Sep 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="MoEqerLu"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9893419AD48;
	Mon, 30 Sep 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695321; cv=none; b=txWMNFBcB8LjUkVhU5UUnstGIA8M65nOQMOsTmlCVELTILVtfeB5KisqD2EhXDlCweduuQhlhcW9gsDnDPNvsTidTbgtCvq78F9xzpSrWmoi/CIxItwkv2fboF0mq1p4zJth0Q5BZnczE2BrI3KNa46uL8lzczixv2dJNxmzqck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695321; c=relaxed/simple;
	bh=y4Fv0VWY+4DUiOjz1qFmeBkzY7jm9zBsjVvNAcdXg/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qfr3rhNPN5cmASqb3hbKz2iPzeC9ewhgTx2cC/EwuQL54JQsPHc9e3JWcYbGe17UCdAQGq7TmfLM4kI8BWmWNTEGyxhdkBkRZVpF1V6lZjkS7ANINoO8MRXREJhD26da3LbPVe0iaXZgzbiDjqfXOnLKopZ966HzBJgqj2T6hUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=MoEqerLu; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ut1+ptJ8TzcKK5t9S/5Zs5GMEyTuiMMbV+IznpAOFB0=;
  b=MoEqerLujxxvJZQl7UVZrdHBnoCaZPSXnxs41y+xNEDp3XNCm8BiKbUV
   xfM8Z+wELLVoZlY7CHmqXjjTXkNwN5gyH4w5GD35Uxm/1X5VU/3lFXO7B
   +WNnvSJFe24i88tvVyhtK1XUYT7V+4DeA8Xml/iJbh1nrya5iDTolJdQu
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956917"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:28 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: kernel-janitors@vger.kernel.org,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 35/35] comedi: comedi_8254: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:21 +0200
Message-Id: <20240930112121.95324-36-Julia.Lawall@inria.fr>
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
 drivers/comedi/drivers/comedi_8254.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/comedi_8254.c b/drivers/comedi/drivers/comedi_8254.c
index 6beca2a6d66e..c62122b536bb 100644
--- a/drivers/comedi/drivers/comedi_8254.c
+++ b/drivers/comedi/drivers/comedi_8254.c
@@ -317,8 +317,8 @@ EXPORT_SYMBOL_GPL(comedi_8254_set_mode);
  * comedi_8254_load - program the mode and initial count of a counter
  * @i8254:	comedi_8254 struct for the timer
  * @counter:	the counter number
- * @mode:	the I8254_MODEx and I8254_BCD|I8254_BINARY
  * @val:	the initial value
+ * @mode:	the I8254_MODEx and I8254_BCD|I8254_BINARY
  */
 int comedi_8254_load(struct comedi_8254 *i8254, unsigned int counter,
 		     unsigned int val, unsigned int mode)


