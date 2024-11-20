Return-Path: <linux-kernel+bounces-415299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13C99D340F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D29282E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E17156F39;
	Wed, 20 Nov 2024 07:21:52 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E5200CB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732087312; cv=none; b=YoGxwvC1Nq/RJlsxcDs4cZnjoWnJEGGNot5pOpO/q7pzzhkD14Iuz3PC+e7WXFyPdTeMYx3IA0np4R3JAxzYrD/jYJkMb60GfpxaDKkxBVGO3+/m3QRWpwwg5SSrkBXmM0aK+ygaHeI54P/CC6DXYWlB/vtNqJa6FFgzkS0/gfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732087312; c=relaxed/simple;
	bh=lLyFpaY6JnYRv/tgPZsR6Gu1KPcnV3tie3Tly4IrAcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+gnHbMae2n+JU1dCP/jynd64RjSn5tRIyJacos+1pEU8GQjUNE3JlQCd6JJLtw79RYI6SrzTQeXW8gvw25HsysCZc1N5YKMR5/37LoXcSD/KVuglmmGLbKjy2pC2XdTf56pFRI2r3lsJFpZ78XaNg02GchEXXt8qN68/SVY4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 173a0754a71011efa216b1d71e6e1362-20241120
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:9ed15e96-a1c5-414b-bacb-d34a1bdeb045,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-INFO: VERSION:1.1.38,REQID:9ed15e96-a1c5-414b-bacb-d34a1bdeb045,IP:0,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-META: VersionHash:82c5f88,CLOUDID:40a9b87deb0865a5548816819521b52c,BulkI
	D:241120152143UP1TZMOO,BulkQuantity:0,Recheck:0,SF:17|19|66|841|38|102,TC:
	nil,Content:0,EDM:5,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: 173a0754a71011efa216b1d71e6e1362-20241120
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1149833002; Wed, 20 Nov 2024 15:21:42 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: alain.volmat@foss.st.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	--to=lkp@intel.com
Cc: ville.syrjala@linux.intel.com,
	Pei Xiao <xiaopei01@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/sti: Add __iomem for mixer_dbg_mxn's parameter
Date: Wed, 20 Nov 2024 15:21:36 +0800
Message-Id: <c28f0dcb6a4526721d83ba1f659bba30564d3d54.1732087094.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202411191809.6V3c826r-lkp@intel.com>
References: <202411191809.6V3c826r-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse complains about incorrect type in argument 1.
expected void const volatile  __iomem *ptr but got void *.
so modify mixer_dbg_mxn's addr parameter.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411191809.6V3c826r-lkp@intel.com/
Fixes: a5f81078a56c ("drm/sti: add debugfs entries for MIXER crtc")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/gpu/drm/sti/sti_mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_mixer.c b/drivers/gpu/drm/sti/sti_mixer.c
index 7e5f14646625..06c1b81912f7 100644
--- a/drivers/gpu/drm/sti/sti_mixer.c
+++ b/drivers/gpu/drm/sti/sti_mixer.c
@@ -137,7 +137,7 @@ static void mixer_dbg_crb(struct seq_file *s, int val)
 	}
 }
 
-static void mixer_dbg_mxn(struct seq_file *s, void *addr)
+static void mixer_dbg_mxn(struct seq_file *s, void __iomem *addr)
 {
 	int i;
 
-- 
2.34.1


