Return-Path: <linux-kernel+bounces-262656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB01893CA1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DE02836D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F088213D8B6;
	Thu, 25 Jul 2024 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MXUWadsd"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E91DFF7;
	Thu, 25 Jul 2024 21:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721942008; cv=none; b=Tnvsgf0ujX2oz4bQSrUgIDnVN5qtzTtj6rnm5fmgVnYnnV5MS2lNKbgY+D//hUHHqYKMMkwqhnD+sTG4pZplsqn7Pp4gdj1Gz2Hr73Q71ylvwgkzb2IxsMU8Bv45jGj9NlrfmHMPEVTcoM+cXYDLS7QCLGywgcBDvCNZg8ZF0j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721942008; c=relaxed/simple;
	bh=WDY4qmiOBxXmKYv4nX2vft/++V2zPDsqZEqaE6CO6VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ff9ObfWK11TySg0PPwfBUPqcpAIlG46vP5eIQ69oXfGnCR6rswfl7qGGnQnV/oe/+KRlQhBfuBhVCIPlvBovMy/HQ8i8mAN2PzI8xLIdXD+puxku9QDlZhSvX80BZZo1RU9xHPDzaDrfxFb5yUJWMKG0IQE1OFh8nucKtLixX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MXUWadsd; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id X5lysEXlZxIArX5lzscUeW; Thu, 25 Jul 2024 23:13:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721941997;
	bh=Dvx74GTKCLxtBt0j69CFfrti2x6oZPPqXeUdFjRlfm8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MXUWadsd6jupaTa7OrpWEZ7IhxbabLX9FFoRqYb1OdbBbhCVQMncLdKG+JPWoA2Nq
	 nADJuYv9k5mN9AUGinW1GbM5FFL5isgOSNCAauLllrPkVgLxq+DeEMJDEr2pyK4y2U
	 OqHHc4rJtIAXC9SnUAo1E1zbrjvJLxExc5HpE/+OXAC9xkRyy1Etkqh9chPwKrLTWv
	 Agw6x0E21/h14BMfyNRttnrHmgbE6edOXK7K9khAOUu7Dc1MegzEx/nRuLt7B0+aG1
	 4aUujloK+pQjtoQY2U9b9tMH56FRDEL++b+VC6jOU7i4poPDV2xb0XEDULMeaoMxny
	 xgBcq52QWCuig==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 25 Jul 2024 23:13:17 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Patil Rajesh Reddy <Patil.Reddy@amd.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmf: Fix a double put in amd_pmf_remove()
Date: Thu, 25 Jul 2024 23:13:10 +0200
Message-ID: <72a97f7989f56c50e1ca417633fe703593d49189.1721941953.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'input_dev' is a managed resource allocated with
devm_input_allocate_device(), so there is no need to call
input_unregister_device() explicitly. It will be called automatically
when the driver is removed.

Fixes: 4c92d448e3e6 ("platform/x86/amd/pmf: Use existing input event codes to update system states")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only

I'm not 100% confident with this change. The error handling scheme is not
a clear to me as what I usually see. For example, the last calls from
amd_pmf_probe() don't handle error at all. So the probe just succeeds in
these cases.

So, because of it, it is maybe fine to call input_unregister_device() in
amd_pmf_deinit_smart_pc(), even if it looks strange to me.

Review with care!
---
 drivers/platform/x86/amd/pmf/tee-if.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index e246367aacee..cc721fbc3e0b 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -515,9 +515,6 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 
 void amd_pmf_deinit_smart_pc(struct amd_pmf_dev *dev)
 {
-	if (dev->pmf_idev)
-		input_unregister_device(dev->pmf_idev);
-
 	if (pb_side_load && dev->esbin)
 		amd_pmf_remove_pb(dev);
 
-- 
2.45.2


