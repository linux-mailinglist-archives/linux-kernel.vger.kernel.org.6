Return-Path: <linux-kernel+bounces-342861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA189893B9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AA61F212CE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7735413B5A1;
	Sun, 29 Sep 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="mT0wzIAW"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483881F60A
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727598005; cv=none; b=I1ObaZrknCIiyz/X2WKJlu2nd9hEXGdNl2DZZ9xVLWAVaHkyjyg4/IhkdPy+AdJFZZa5uGY1fP1eg17lUrPJ3y2V2t0aXFUqe54x3qQx9UXwrt0ueWg90+nhpPh1VCjM5N889D4hseAo+SwBcKfxB7UspSKmUxHmdoLRT74aYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727598005; c=relaxed/simple;
	bh=VxLFDDzaMZTdGPwHwCRk4tr7HYYHHGBG+DTuf7qJMWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AkFxLKgb3HLVFSoBhUf3fg0ILaIJm+6VK4oteQ++chbd0cNk9r1axnHtwUqBhLiOo+KHMS7etcjRN/8rrsnsJwuFWvN+mxTMM9cEsxXGE+8Lobe2b6MjIWYl+/HmBMBLeM1YJBjK+nU+szW1zEjs4vCHeAt0oHRMzETkdeknrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mT0wzIAW; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727597871;
	bh=6YV2fR/+lcgYsZy5uUjjQYRKMPyCgBTERmvZeyHE7Jg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mT0wzIAW+KlxtKLvjkikXqJKtI9Md38mtoOmnizkBnjEn0VDv7XVYtm+h5mwbcsNJ
	 C4LEXN8Vd74WT+cdxB3TtO+42kK+8nK7KCR7MpKeScTVmuMel4N/ZImk3lUQm7qcpj
	 +q8Gq/pP5vwq9xKYhRAYGvJN3wU7yCluJa3iIyXo=
X-QQ-mid: bizesmtp84t1727597837tx5k7nmm
X-QQ-Originating-IP: WOuXqP3Ef+8ZR3DJg0d7OzjQzj3+osc5CPfWAR1wMzg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 29 Sep 2024 16:17:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10417054919207803844
From: WangYuli <wangyuli@uniontech.com>
To: linux@armlinux.org.uk,
	jgg@ziepe.ca,
	jroedel@suse.de,
	robh@kernel.org,
	catalin.marinas@arm.com,
	jsnitsel@redhat.com,
	robin.murphy@arm.com,
	wangyuli@uniontech.com,
	baolu.lu@linux.intel.com
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
Subject: [PATCH v2] ARM/nommu: Fix typo "absense"
Date: Sun, 29 Sep 2024 16:16:17 +0800
Message-ID: <25F9FF4477394196+20240929081617.999000-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NGtzFk5A1JYAslLj8+x0rXW2rvr2zkulVXekEEhb+IkvHQD2SZ/bPY5M
	hlKXvBQx9M40hU61hFrjG7NGG6THvk57OiOg3BykUAe+cFmrjfYW+/FvEKbYJhAgIi+e0Tg
	1rTRjibxBTh+3HrXOnX+uaqCEnI6797gFQmeIolktCbWNJFaVWZGKtiPdwNU/K6l9Zrgaqa
	lVM/oKdXlyAOuJ8Q1Ns92Epw+agRCf2ivIMi2qmKtaPd3YNCRh+2CykGUgH8tFQBTdwlvI5
	C+NFGFFlGCsqL3LtL0eSkAtMkzGmLzV2z6ro+HMJRz1zGJkkvOVNOrMTnhU8HcMqUhTJQzi
	dMWJf9DF1/Qo9MbK/VvytwuhCesMgvK34O1rCo4NMGwWnXuZ08Qi1ETpuFBCzi3BTBW34XT
	TIXBrH2xmCuxN2Skw9isHOtGs6C/w953eX8CvL+XAn5mGuzF1VbxtFAsSSk1pWvwb4K8YNx
	ptR2qKQN8uGJhmuMbzaJBeixldvvvIM6f4scJibm9zXcpbuqyypF0owTYAHwYmSwQO3sGsM
	s5MsZLQHr7l74o3+eREjeK5IIUA2NaJUq8UjzizKHwnXVLQtwiD/ePllZiFtjpakMQC9hHP
	pk8S1hfOT7i4MAeu7CZTcIWM/YAhuVE2xTmDxrR6PNwj4fSNqgLo+2D5v5IlgFYIlu2Bcr+
	FDcJ1w8p92gbcchd+y+9hwIS/VvUOs9LryI/obnfSQGEkkhiVGdOcRt6MmVRUx87gXnCITi
	9OM/DrZcFKipQLXAkWjkp5CEW9RBKLfRDUp/Q9cqtEuMRMVEKnns4GhaR58XCgta5DuRxCs
	5ewbAY91z2gdJrBkovrwNKS1jzqLdcsEqoDbKO1hYgby8jJOwcsKzFw6H/6pZFVMJPRW+T/
	fqHZcXCc3wYoxJWuoOBrJOTEL8FJCZHZbLFtCtdH8ghm3a3H9hjDnsvIBHXe013y6giCfp2
	yoG1H8CZVaM21Q0fzzPE4lQmpiUuMptV/yn09GJ0/1+JVtQUlXrcsNg0fTQrCj0+ZbP79up
	7LBr90s++ym7s0YjMQ6vUBGiFPPgQ=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'absense' in comments which
should be 'absence'.

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
2.45.2



