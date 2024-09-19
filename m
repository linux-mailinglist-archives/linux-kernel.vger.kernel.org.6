Return-Path: <linux-kernel+bounces-333757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DBC97CD78
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7888D1F23D25
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A871C6B5;
	Thu, 19 Sep 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BSfCsj0H"
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1291C693
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726769538; cv=none; b=aqvcCkCVVt2beLbmtHCgRyGwgoaVKdIqfnn8MZuUo+Zxv3a//EQaL1lJhmy0hfJCLYnf/BTFYs600Ka7gdQ7aoZsQuI1yK16SHq4Celq7fG+OjO0u205hfrnYgPW61zjV5SNtwz+MNvlKP9ynEDpsN0aak8OfaycYHr4dbmrSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726769538; c=relaxed/simple;
	bh=I0fA8yIKCGrKxlfNj4tthxTos+JXzdCtc+g/vF4DkYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFnwe1fohK4Bwek1OIILxXe/GYeoOOtExPQLaOrbf35zilSiUnE47Uxs3WyPXTBMXJfd76iB3l+ouLPqOwBVnvgiIQEjpNK1BecOHqFzFV4I4pX64AFwfd9vtWCG1Q0/ZiAMsaPcqMYasZwQWyv9MZe+J9QYtsZRdmexzAul0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BSfCsj0H; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726769496;
	bh=oPIei+pR9L8l1Yj9NDOkz3DdyR74wC0wrUymNC22CXk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=BSfCsj0HURAEum1jD80P6mS+1mOTnfHrTNE0hKP/RxTJCgv/jZbhSniTiM0CQfHjI
	 3XN/rJ7+KBq+Mz73iF9em3xyR6wMOye/Vtq079ScDeZ0mlhGJhq74StrXY/lZMuXSK
	 zLR9EQGwBRekxWuc7ret8ockntD4DGqOHCEPGl4A=
X-QQ-mid: bizesmtpip2t1726769487tsijcvm
X-QQ-Originating-IP: eJLFLSaZ3/fEEsurApWgmCSrl19it565i2khEPC0vNo=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Sep 2024 02:11:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17695833223227453143
From: WangYuli <wangyuli@uniontech.com>
To: linux@armlinux.org.uk,
	robh@kernel.org,
	jroedel@suse.de,
	jgg@ziepe.ca,
	baolu.lu@linux.intel.com,
	mhklinux@outlook.com,
	robin.murphy@arm.com,
	wangyuli@uniontech.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vladimir.murzin@arm.com,
	alexandre.torgue@st.com,
	sza@esh.hu,
	benjamin.gaignard@linaro.org,
	arnd@arndb.de,
	rmk+kernel@armlinux.org.uk,
	hch@lst.de,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com
Subject: [PATCH] ARM/nommu: Fix typo "absense"
Date: Fri, 20 Sep 2024 02:10:43 +0800
Message-ID: <A67A39D621F7DAE0+20240919181043.71257-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

"absense" just should be "absence".

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/arm/mm/dma-mapping-nommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 97db5397c320..fecac107fd0d 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -39,7 +39,7 @@ void arch_setup_dma_ops(struct device *dev, bool coherent)
 		/*
 		 * Cache support for v7m is optional, so can be treated as
 		 * coherent if no cache has been detected. Note that it is not
-		 * enough to check if MPU is in use or not since in absense of
+		 * enough to check if MPU is in use or not since in absence of
 		 * MPU system memory map is used.
 		 */
 		dev->dma_coherent = cacheid ? coherent : true;
-- 
2.43.0


