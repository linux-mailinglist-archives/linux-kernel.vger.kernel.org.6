Return-Path: <linux-kernel+bounces-257860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EA8937FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 09:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600531C2121E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80B0250EC;
	Sat, 20 Jul 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sR5FBlsi"
Received: from msa.smtpout.orange.fr (smtp-84.smtpout.orange.fr [80.12.242.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A12030B
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721462278; cv=none; b=e8gy3yO6MKZbQgA+81cxyZ0Ok1ObspEsHWDLzTt5kYHcfRIE8UAvmE/A5DOCkUTOrY+vE/DiTJCVhLRkVHiHQaRzPlN1Icq8EUtF1MO0mxQHwOcGM62hnRJctBlHUkEsr2teH1Ea3Ypn0BFhkAF1Hf6i0OBN7CYGQGAPbL5CzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721462278; c=relaxed/simple;
	bh=IpnVnKoVmaVStSmwYM1JkiD5ZdFGiMlAjgfRwhBF0MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0rTM62ibPUQy66JH/jPo6HM1/T4QEsxg21ifJ63e9LWkYSBpM++XJ/fMUFWVkGVvbUVnuqXXGEhCg8CiPXMNRh1WuOHU7xIC7sTwlD0wRHjLrqFUV7iNBjzJNRozrSVg85/yyrGV3eLbRZ9Jx+ZVyubBlMOD/QbUUInaS28/Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sR5FBlsi; arc=none smtp.client-ip=80.12.242.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id V4xLshfjaBzr3V4xLsGWXp; Sat, 20 Jul 2024 09:56:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721462200;
	bh=aigZPqaUzQGUxsAtdtEhaj6ytUo+tfH/K0mHpnLo2eg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=sR5FBlsi+l0EdVU/NHSW33SaX0DRU1EkThYEn1XvG9BbQN3fTuxVTMoB+gbqpagKL
	 b/JW3nSRmsde5V64z0GvwXAFL6FUn4BNtdp9EIyjdQEi8nJXhEPgOGwwqzBdkow5qy
	 G49oOxipWZlgb3qoDZt4Di4XWFNMwF/oJ/YiuKwof6zK24vzl+L2vXAcECoVf3d6yv
	 YA3B4nUY02NmIJH94jLtbGMaa1TIjiYmhqIAlG0DnqYDDLrDnSmRhkUEIBpvKVerzs
	 BuB1Mvsz52+BO1NIA8uEdg3UYpotLynNY6ozgsLd+WWB/tVK4Jpv2//lNL4EM2OY/S
	 2MrBMjL6ACfMA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jul 2024 09:56:40 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] nvmem: core: Constify struct bus_type
Date: Sat, 20 Jul 2024 09:56:34 +0200
Message-ID: <841acfda8ac924200e776c3dd04e65cb87c40b72.1721462169.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct bus_type' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  36908	   3256	     32	  40196	   9d04	drivers/nvmem/core.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  37068	   3096	     32	  40196	   9d04	drivers/nvmem/core.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 516dfd861b9f..19f2b90e6740 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -534,7 +534,7 @@ static const struct device_type nvmem_provider_type = {
 	.release	= nvmem_release,
 };
 
-static struct bus_type nvmem_bus_type = {
+static const struct bus_type nvmem_bus_type = {
 	.name		= "nvmem",
 };
 
-- 
2.45.2


