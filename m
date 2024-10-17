Return-Path: <linux-kernel+bounces-369133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE3E9A1954
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24879B21016
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D44536AF5;
	Thu, 17 Oct 2024 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XEP7oGby"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A6C147
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729135917; cv=none; b=Lecv0l14PD0kusNzNUMIrecgTmRq0+r9aMv7RHd30SPIXIfb/0E1dR92wchrMLAJl8Y/HNTquFPZCG4T/cdk4uItT3Ckv8Lns1b0Ya0YcP8/QEztAxcznMdluIfvctDmWgLs5lMUvjpjRQc62gz1hoWg+PCJSG9530vFBuU/lvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729135917; c=relaxed/simple;
	bh=EJGsOla+ZRdvt6GYrYi6ewU3MgDRaxZQPwBVNFqE0IU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUbl4pefoqlG9i9cP3ZfeQKhirpqMZiN+yjzvT1suXOXrxu7t8VC4KKqgaKwC7y8Dzw3kDTJ/QOWOuhK4kIJL9pRVGJZqX084k+y/qB/yHUntdwODuQLG8ZlAjkr7pq94vhiDZqHJeajjcElipYKVLjEH15X+/soMqarrFgVWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XEP7oGby; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729135806;
	bh=guY2A1uv/UVDcSBL63OmZkziRH9Yxw3DElZXOobNI/0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XEP7oGbymzuyltOYybt5OhTZ+U1gYOc16Na4hoI3JNUMidYnBriIWXQ87oGOeaQXN
	 WPvlbhHnJ9nWcmmhut/Cqt3bc8KchfjSRW0CYsH5r8n6BmQszqji0gabHwdMa6QBDm
	 0ohOQhF6PsigMlQio1SF9p2z5XatAKkArblkQYvc=
X-QQ-mid: bizesmtp89t1729135776t69ra9ul
X-QQ-Originating-IP: SrpuTbCZeiPc6X/v+BTIBgrhddIgwrkiFkQOjOvxMrw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Oct 2024 11:29:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6230225498919478691
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
	guanwentao@uniontech.com
Subject: [PATCH v3] ARM/nommu: Fix typo "absense"
Date: Thu, 17 Oct 2024 11:29:29 +0800
Message-ID: <104F90E5B8D0EC97+20241017032929.105068-1-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: NnA3IMNPwBd+G1I7pgFtwW1/CmMxo4Hv0YRe/jxUMYe2PQzk5fDT/Cb/
	zubqrN07xq563sMKeFy9puDGsJ/4FwquSdSp6cJOLU3FUBVywLMckzdlLjz3+uoQIdBjVK/
	f2sfdkjAHOWvPS8eG2MfOsmXTD1hy7Z6grVn239+6TOwNKXW+jhxSv4d9uD4fItfVHbN9XV
	VzliJ61RUVziM6kA9OlZEWDfiNVNH6jQVi+XC4XyIlgqL2Rt0tNLmBQ34N32nDCz+kJ2/h4
	GFDrirX3y5bwEgGfPZGwfix/62v0P7VGPzM9lD//Ssti5OSVMSZK7wAILn2vHQodySU+v3v
	PPyU2gwS4aMPc9YY6oa4NvFHLysMagPMhvVUtBe7UpxXMKWqdZC2yA1JnER3GoiWLPTjuz0
	xztN3tFCBrl+GlGbryMZKiTlq+Ogd8jGwSVpRcX2JMLX9n3DgG+yqVxHkEhCpH70dPQBzeg
	VgZpF5HId6W3IGt1oO0k79mUjlL0jzNY05Y6kDDsij+8ypQOqSQBEC5Uzzq6KH/83xS/uOf
	SWCPq1oKoAf9duTvwJbz8BWk1+WtyE+qofxGbaj+FeqvV89VFyhEF4nVKg4KuZq8879laI4
	flDBY5ux5VGk0dP9IysGsKVC2X+TlSQZTOFQcAXfrG36Jfsj9BEwuF7nwKpoMsvBsH5JTOU
	Limt+YjZ3PLvQLb1tTY4vd2eVjIuFFPHJZbDj3m/ytWJLYBoC7nJUZIEMurVwny+q2V3oWa
	vzzri/i/yPM/AbmR3W8Xu9sU0b/XLscEweKTgsDsfXrTedijeCn46phqMwRorZwFOoyl+HC
	PbfSZ3lndzY95DK/qWRxw+8uozgGXxyvWwSRL21fSDTpupMaEmQEzOuQt25es20aXGMyFGJ
	Bham4dImzL3dF+L9JbBFQzmLrYzAVRDvJFue2WdkQKjEZY4W3xLwuCJIB3zI+8hYeNNWsRq
	73poIuI6LcCDOomfrR6EWMaF0LIr3ZS5aDwp2NPIFaNgsy3bojKmIKHA3x8Hs2L8ZAQnDSR
	7eAUi7kg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'absense' in comments which
should be 'absence'.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
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


