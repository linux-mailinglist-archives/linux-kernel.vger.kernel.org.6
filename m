Return-Path: <linux-kernel+bounces-374197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247019A66AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44991F22D93
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1611C1E882C;
	Mon, 21 Oct 2024 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jjWfXkqM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="s8Fim2hl"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B51E5713
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510504; cv=none; b=a0B1f9xpurXiixfYI49UeqIEPcg1Q6kOf1CStbLBFXYnpcdJYdj2mC33/pE7x1xdKZUeDiEcsU4bmJFhNek4s1UIdSovh+bbJuA6nI5xuWTBHeJQ9TBEmmO1LPdzweuI8xj+oUxAXLeN1A98c4gkj5mMaObh7Xq9E6Bd0Dzwq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510504; c=relaxed/simple;
	bh=SWB+YIcKSa2cnIMjMV1MetO1v44wetA8djbP3HOM6xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQrffkqfy36hICia/sEgc7QK2/5P++1v2qHLAdLKh3kL03P/CKK7hGER3nDQaI1kA/Jz1OjpdbGQ1UQmPcgU1f+d5LKsLDgkba213gMFM7m9TUEClZ+ZfECJCUgqHemHidPj2zin1UnZIUL7RORIFGx1yX+WBmi0O2Z1F406SaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jjWfXkqM; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=s8Fim2hl reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729510501; x=1761046501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sx7Xorv8FjsmAB4buQ1e6aM0MbULMg22J2nr/WshdS0=;
  b=jjWfXkqMEqoH1JKE5mtR4GKTG7gldOdQZ2yBcKxL5SzKT7Zrt35KJFwb
   PeeRCzNsUYerxOfqXwLkQRcAeKmXxS4csp2oJ3HMRGJyx1KzxXextNFXX
   sNKXY14G3YlP2yYQqle1jR9yd9wnqQ4zRN2wu5xkvLrxDS1qdZAR+v5Rk
   EqP+aGnXynsnK07fJ+kkk9y0bq6KTmvmpIFNg9vTfzAMUkFRoVSNwGYv5
   WoB4V2Ppt5RMgkvGulpYJY3sIdnzdwyY5chw8OGJdwZ7my6BJanTdnXmn
   nq3TqXSdjVtjSPdxY4D2ZqHMQTuksDF6HWvVOPCe3zBeuF0sBpxhv4nSW
   A==;
X-CSE-ConnectionGUID: dnkRsAzDQlOlV34uNJSI/g==
X-CSE-MsgGUID: SVFzqBCDTCW71OFS9EXBMA==
X-IronPort-AV: E=Sophos;i="6.11,220,1725314400"; 
   d="scan'208";a="39572171"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 Oct 2024 13:34:57 +0200
X-CheckPoint: {67163C61-32-21611FC3-DAD22B0C}
X-MAIL-CPID: EE7BF2580129918420CE6084B8755F1E_4
X-Control-Analysis: str=0001.0A682F22.67163C61.00C3,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2DB5316B483;
	Mon, 21 Oct 2024 13:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729510493;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Sx7Xorv8FjsmAB4buQ1e6aM0MbULMg22J2nr/WshdS0=;
	b=s8Fim2hlylK+vd/pGfJA1qIUnuS2nGnUXXfgfcA7bV3hLvsg4byOHkLGteRXDpq/x16Tqh
	EswlaHPB1IyWGvyUMo00SIpoSA5YEiayIFyCZoSaSRtSo8N4cSYWoqY2ML3z5g9EiQmo67
	L7notjFxNOofXwgr0lJGgooiNPMtcURWVVA18fg8cjTMcI8HCprmBieZC6fQx/b0HGn3Al
	uKeaW3n5xWxBksf/MUzcz+uZ05r/tvDmE2uGF8imgW1iMv5SQUpnitRiLC5+x7N+Fp2ykf
	Wm0ZDymevjZzhiyeTe2c52Lh7A6ycQygFSDxsimeGlXiQ2pou6xTVfelHBoj3Q==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v5 2/5] mfd: tqmx86: improve gpio_irq module parameter description
Date: Mon, 21 Oct 2024 13:34:24 +0200
Message-ID: <b262686286ebf72c04572f03db8c1436ddf65d63.1729509613.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729509613.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1729509613.git.matthias.schiffer@ew.tq-group.com>
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
v3: no changes
v4: no changes
v5: no changes

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

