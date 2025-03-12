Return-Path: <linux-kernel+bounces-557220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FA4A5D549
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB62C1757DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9441DE2B5;
	Wed, 12 Mar 2025 05:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Y9KvdYaA"
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22713D539
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756146; cv=none; b=YgK/7FC4dUiSiL7S1F6ZV8ldDZPh630AXsCVbrIZwx5DAiOwpUp1BrkIRX5KG7omYviMgxjv7+rqiOQnOaKeQ6WngzlXzqf/G9g8YrEJecdrwT2jubxv43Sj0jGWb5Wc5Qc9VUdH9BuY6E36+S0R6aD4j1TAkwCmGXh72iphydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756146; c=relaxed/simple;
	bh=7jG0DFJYmZl4+AMWvZ+m8jbX6ePd5VYfPeJMfPje4Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ORhPj5aOuhjiUPdJn3o6AndhLadnUlPdyMzE3bDhgXbdQilo3uGsuyDiar2Fo62DfGtmaUZg5s9zgH2v2XnwCDpyr1i0yww7vKjOtgcWQK2XIsPfiKj3+gs9evlTKuFwS4HBHvu0gnuw/UCQZSsNlFoT17bXSwBLLIOfIrpu2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Y9KvdYaA; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741756072;
	bh=/rHRxf4F0jxH5KpLZ+al1TqYfHzckrKco/BgOA4EBec=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Y9KvdYaALty+lB/bad1VaAdv6iPwaL3qOFhu++FDX37HDLy3dxwtmYiBSZpMrDQ4v
	 viUU+VryBZQ8gK3FVHmh1bNasZr6OyVeeBpNm3IN+fU65A1n6zdqtTvMrcYGl6eOH3
	 0+9bwSB7j47nVJvDfhcJLixiM4kpdnvq542aE6uU=
X-QQ-mid: bizesmtpip3t1741756022tjbalwy
X-QQ-Originating-IP: Rm4w8WqZOyXkt8U5rimcg269hBvjvb9n1X8dE5ImDgI=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Mar 2025 13:07:00 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5519647041609310355
From: WangYuli <wangyuli@uniontech.com>
To: james.smart@broadcom.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	james_p_freyensee@linux.intel.com,
	jthumshirn@suse.de,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	chenlinxuan@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] nvmet-fc: Remove unused functions
Date: Wed, 12 Mar 2025 13:06:50 +0800
Message-ID: <E2A54BF9E5C050B5+20250312050650.1793024-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NYKBs1ZFv2UbvSCasQ1w3NBm1VvM64bQONYckMm+2ApRJhYlnBOVpk4o
	us+IKBBWTCjrz56XBY9JJmbGkOUPlMg6nFdLBHMvVJL5Fbmeoh1r59e0s0LouWsXMQ/gnz1
	oI9cx0PeP58+hbz2X1vCaX1Gj2Z6jZyyb05/nIH4MOLcaVSOF5bBrgXQz6uc0E0LrP2gHha
	yqljBJlH+2tULFJaIcew/r8fN+B3FFHyyjqpGvJYoKM7L/hdOJ/om63VMokf0cDshOFeIYg
	6vc43FtqQk6TDCyxHrd6e9xk+lNGAEENF58ZBHva15oGpsdOXEn0B+q7hPKi3vieN2Yg1tT
	dV7IOJsPLwJ6nohIGrOYpIqWN6uMUd4SCWuVvGLIy2Us2xbzwcYzQfSENvMQhw7MC8EAMXV
	9NCIhN/0OeDXdfBPdI9Ls/rMVVs7/z3RxzqCll3p1aP6Vy8bLlbT/8r2UG7xq4N6zWPETmS
	zTN/WvGwxP5rrkEd+u5PrgURmw6poKIJ1HUlKEYxJwSTYltPcTsMr+veWbXlsM/UHor2SXb
	Oj5CanTMuX7HG9W7kASlEqlz6mFLdqYQ5SScuTs1p8HfpUugnsORSIyvV2dWBAuSf9EfD0+
	Jh4wjOYyQ2NuhYRYqp4JFeqYqjAUCimd7O+I61T0Dpn8oZjjNvxLXpEonpISyI+4F4ztDi3
	mTLUFBoL5/mtiDXNADljy18hvR4m7ks5eAP3VsxZYjcwrxw6aTxq3ZWtnKG9H7kLgAiyjzj
	VKniLYGOkXWCDUEV4PC6EnNewn0c9RrNjGKR9TPP372pbghdweWLNdPZsyG1PsvEHyuP2v9
	LAcRsAgwRsPQtkaubb3JNHgpismYzmnHecrXqwkaZ0F0JWJYP/lXZ0qMqEP1NJuvn+3bdDq
	d9WU0RkSJqRprpCm978a81axg2WMAkPMeSGb5MVnR0qjhsofFT6ngrn2lbq1ELP9y5PWTWs
	d5yK+dZDTFsf/4HJAUspD31sCGOD/XBCo9HnfTM0NEVLlPjee3wYUylBMiNsHNRPk0HSI5R
	2jvIpbuj9T5HClxkSG
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

The functions nvmet_fc_iodnum() and nvmet_fc_fodnum() are currently
unutilized.

Following commit c53432030d86 ("nvme-fabrics: Add target support for FC
transport"), which introduced these two functions, they have not been
used at all in practice.

Remove them to resolve the compiler warnings.

Fix follow errors with clang-19 when W=1e:
  drivers/nvme/target/fc.c:177:1: error: unused function 'nvmet_fc_iodnum' [-Werror,-Wunused-function]
    177 | nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
        | ^~~~~~~~~~~~~~~
  drivers/nvme/target/fc.c:183:1: error: unused function 'nvmet_fc_fodnum' [-Werror,-Wunused-function]
    183 | nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
        | ^~~~~~~~~~~~~~~
  2 errors generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/nvme/target/fc.o] Error 1
  make[7]: *** [scripts/Makefile.build:465: drivers/nvme/target] Error 2
  make[6]: *** [scripts/Makefile.build:465: drivers/nvme] Error 2
  make[6]: *** Waiting for unfinished jobs....

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/nvme/target/fc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3ef4beacde32..7318b736d414 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -172,20 +172,6 @@ struct nvmet_fc_tgt_assoc {
 	struct work_struct		del_work;
 };
 
-
-static inline int
-nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
-{
-	return (iodptr - iodptr->tgtport->iod);
-}
-
-static inline int
-nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
-{
-	return (fodptr - fodptr->queue->fod);
-}
-
-
 /*
  * Association and Connection IDs:
  *
-- 
2.47.2


