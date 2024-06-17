Return-Path: <linux-kernel+bounces-217291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F20190ADE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C867A1F21D42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49479195809;
	Mon, 17 Jun 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="p7bvCDrQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ihXaP1Jr"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C2B195982
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627053; cv=none; b=tQwKKKhlwKCLJMXAV4VhIJdzz2+TVuD7nTFJoRLEw0XmJiXrrTeAZBIayM84Gc7iWvSKvyf1mz8XUbCzGMPF6+m9FMbrjrAUKaB+53QyFL3WMTbtx9QJ/NrRXaJEI75yncxa1d+RBeIjmtlNZ5myu7oOOOuX1LUEpepoRJqJ3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627053; c=relaxed/simple;
	bh=8P2BKaGl+m4sT9X/h4rmdKw6LSX0mVFUTmAwV7RHOpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNClghjA/mFstP5xbHEPuIfraDuqJG/E6P0tH6HYp1ZpXMzEvzS9/ah7ZJ+Jj8b4hrB200QUrr8zuwgkVQytDYrjxFbi09lv6kGbJRy7wI4ewXRPdIJ63U4akI7Lbs/8D4BwxZpu+4tpmQF6bqcuiWe+QBUHZATGAo+jofTDCHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=p7bvCDrQ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ihXaP1Jr reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718627051; x=1750163051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T6IG7WCN2l3Q0oOWQL7/4fYhZ8YqTKFpFsW1TiYtC1g=;
  b=p7bvCDrQH1AuKBmF1g6Xwlrk3VXScVd/PCG6wyz8LBN1vnnI6544R/6l
   h9d7McU7aJisXuGcEc9TTp9Fop+jbdL9lAWyyZLEf2TYYt/y6DrysXRvS
   ju8Q+9LfE7qERB8tkHxwUGfiRlsrGGQF57T9uhODKv78U0X+7sOcqi0L5
   NjLCNH1B76+XTLnoM7phiy9dm9xtCv2QLuiKc53wvzUlY94GqxPx9ZwRm
   EyyxFBjw/zUBKa3tXT2e0fQxAdmaZWQDtMgKO1eS7N8ceDZpik2/pOhHL
   q05WgUnf4wu4yjHsA7bQn3ML49KQOI4lDPd7w1sBi8GfA6+o96YQ+OQGQ
   Q==;
X-CSE-ConnectionGUID: iALsDXwdRQuoQQam2Qsc0w==
X-CSE-MsgGUID: EEdRxe0FQTy9+ucsZF/HcA==
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208";a="37427050"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jun 2024 14:24:10 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EAC4165A55;
	Mon, 17 Jun 2024 14:24:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718627046;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=T6IG7WCN2l3Q0oOWQL7/4fYhZ8YqTKFpFsW1TiYtC1g=;
	b=ihXaP1JrokY+X4kHKbnuOfOqieSYqfm33xccrDqjMec2/5UNqDFaU2p/NZ672lkaFraIVk
	PD+b/mMHuRh/LMwTS5t0BPnHCnFBpb7VqJVRG6PdF2x8AXBQjEBDfi3SK6XQPB3V3c9A7b
	XsV56r2OkWsu1UfX5NmxL9zCU9uLKzBIRZ2+582GxKQAffAIdc+l5OWWye6QD+h6vdZ1ib
	8wfnuz+pyG4NMlRVA+NGZ+4rTekGpPLZPjCo/YhABAR8E4XUzvhugCCFArG82bBTS4Y4XX
	wtQ9UqKwCpMw8srEmxvXqB2KX5iHq9CuaZdhnQxtO8c0F3VsWGr8wvWQWi9gUw==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 2/5] mfd: tqmx86: improve gpio_irq module parameter description
Date: Mon, 17 Jun 2024 14:22:59 +0200
Message-ID: <cb0de8e1058a8d6dcca17d317ebd578a41b87dd4.1718626665.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Clarify that "7, 9, 12" refers to the valid arguments that can be
passed as gpio_irq.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: new patch

 drivers/mfd/tqmx86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index e15b9be98c2db..7b2f9490a9af5 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -58,7 +58,7 @@
 
 static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
-MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");
+MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
 
 static const struct resource tqmx_i2c_soft_resources[] = {
 	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


