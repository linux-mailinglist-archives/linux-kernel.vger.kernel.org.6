Return-Path: <linux-kernel+bounces-394711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636F9BB312
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DA6285507
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352151C8774;
	Mon,  4 Nov 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Xy6HNwD7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JlAUwXxv"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75721B6539
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718853; cv=none; b=fo2fKCHM7LrXzBd0GxGxEwM0V0WR4e1WhhKgYl6xO6oubh1BciYQY0X247cDLW+SCBZpVtycuKvWoZic/sZ2EkS4xnBMFHLLfi8Q+tjhsds6+Rb2MA3PVIjVZqFbUvkBmogd1XSBo9zj8AaQDx3O32Xmur3Zci1Y9/51CLc8a3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718853; c=relaxed/simple;
	bh=I5W+a2Yq5uNm3qVK3Oy3wkHDAhvR3a9OaEclN8+/0ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZl1mJdZPxfBh63+56h6XrighcPqWFcKnXWPZqfktGBwiT9ZL0UOxUcKRZHSvbOyV6OLDRPJ/Cma4gBnj9ST25r2W2Fm0YMsViAS9Gtog1e2fb931IqA/3EGOCohKyp8DM3KglfJDPozB25+JdlLKy4xW+HdsaE1z88m4hseIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Xy6HNwD7; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=JlAUwXxv reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730718850; x=1762254850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rKqow/CvlcwE5gBbqhsmlEBb2jOEmT6Pew34oYuS32o=;
  b=Xy6HNwD7qvsYo69+K9LTO5OFNVUE6wksYQcOv0y+hchE/sXgKJ/u5VM1
   4ihZE/xlHIpAuRdHvVOaF5PZWxwKX0VouLmym+D01fEvp/FicVnPoUnDT
   Jqld7aXEGUQZyeT8dOqb4qul2iaC+TOhp7r1fviaPGiGutVqjwCBtCz+M
   ixEv3+vKl8aefp6Ydqum0YERhYx7Ez2Lz5r1TZLB3Puz4rak2NVW9qPwn
   7YETJ26fujZxSZtUt3PyBr6qIguIcq+/0YnuCYe55n04Q3Wn5kBi0L11b
   31zOaffUQM8jEE6pvsjLErWbVVASP7O/a7VtDVMu+eCNrZ9YLH/2PIJtG
   Q==;
X-CSE-ConnectionGUID: 4JUXGrAJSledOWLcLP5WGg==
X-CSE-MsgGUID: AeOTjComQ3SmwgQ6tOo2fA==
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; 
   d="scan'208";a="39829943"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Nov 2024 12:14:10 +0100
X-CheckPoint: {6728AC82-5-5736D786-D50827BE}
X-MAIL-CPID: 790D321F476324D40E2C3BCA74ECE8C0_2
X-Control-Analysis: str=0001.0A682F20.6728AC82.0065,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E120F167F14;
	Mon,  4 Nov 2024 12:14:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730718846;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rKqow/CvlcwE5gBbqhsmlEBb2jOEmT6Pew34oYuS32o=;
	b=JlAUwXxvpkE4NqlkWcIRMhxbgpV96NQBGYo/YBE0cRupnshMZsSenz/EMgTIEiNImp+ZXb
	yIayy3Rszd3uUY7p8qQA+0gH/oW8jtAgfQclLdvQedumSm2+5SH57PByMSeQ1pdqtYmkmW
	y5nWPj3HrKwG5uV3l+rql2q9KzducdSb2PmH77NTRHkXoAXn1/sPFkQWQC57alxGpLOgNh
	bijh5ORv4kqlIdOfbm6993AHoUkGcSzYfVeKyojkRPYh+H7uHNdp+M5xxAPnR2hc7D/5sz
	DwK4ynVcoXpm9a9cS+XrYrmvUS+K1zx+aYsFFPyHJXes9uk5TvRmgRpRhFL1Lw==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v6 2/5] mfd: tqmx86: improve gpio_irq module parameter description
Date: Mon,  4 Nov 2024 12:13:30 +0100
Message-ID: <3275f436b66f6807c02256bc852d39b03ebd64d5.1730717841.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730717841.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1730717841.git.matthias.schiffer@ew.tq-group.com>
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
v6: no changes

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


