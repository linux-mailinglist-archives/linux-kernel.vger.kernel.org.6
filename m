Return-Path: <linux-kernel+bounces-308185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00617965860
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970321F252C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AD21547D4;
	Fri, 30 Aug 2024 07:26:52 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6561509BF
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002811; cv=none; b=OifdmNELXckahpRTtFyeOeVat7vVeZPykLX/xqK/cZVcaqciFXoHjegNgCzOQAAgIZYEHnqj6Z+JwDLX6iBKYzSuOliL3URu8AR7yN036wYm5J9a4/IwV4vC2XToqJSofjPzSmhcchCza+w4Q7WUwtWaelhKWqjnJGraU03g0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002811; c=relaxed/simple;
	bh=jrovaLCLNFIHWoUQRDdsO6cbVsJO8xtSGaUqeZGsxnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LIPumY3RoBzYuw+t7hdw0NUQqhEj72FLIvRE85nH64sopzqeEJRRBHq+yHSvNXdsPu7dPYsNH8XF2blpb3gtQ3v68x8SDZx3u83s9EjY2tCjbLufS3mIIlEB5Xq7vA3dRjQif6JXlImLhh83TyyKkpHBPckZCX7EamDgzzuwacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 322d169666a111efa216b1d71e6e1362-20240830
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_UNKNOWN
	GTI_C_BU, AMN_T1, AMN_T2, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:a4f6c202-7660-45f3-bcdf-5810b3120bae,IP:15,
	URL:55,TC:0,Content:-20,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:45
X-CID-INFO: VERSION:1.1.38,REQID:a4f6c202-7660-45f3-bcdf-5810b3120bae,IP:15,UR
	L:55,TC:0,Content:-20,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:45
X-CID-META: VersionHash:82c5f88,CLOUDID:a9fbdbb88d84a01379cb1ad92a24edec,BulkI
	D:240830152641GKLTJXK6,BulkQuantity:0,Recheck:0,SF:45|66|25|17|19|102,TC:n
	il,Content:1,EDM:-3,IP:-2,URL:13|11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: 322d169666a111efa216b1d71e6e1362-20240830
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(111.48.58.10)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1941210951; Fri, 30 Aug 2024 15:26:38 +0800
From: Lu Yao <yaolu@kylinos.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Cc: sunil.khatri@amd.com,
	Prike.Liang@amd.com,
	Felix.Kuehling@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liupeng01@kylinos.cn
Subject: [PATCH] drm/amdgpu: add raven1 gfxoff quirk
Date: Fri, 30 Aug 2024 15:25:54 +0800
Message-Id: <20240830072554.128132-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Liu <liupeng01@kylinos.cn>

Fix screen corruption with openkylin.

Link: https://bbs.openkylin.top/t/topic/171497
Signed-off-by: Peng Liu <liupeng01@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2929c8972ea7..0cd5fd3fa18b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1301,6 +1301,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
 	/* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
 	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
+	/* https://bbs.openkylin.top/t/topic/171497 */
+	{ 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2},
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.25.1


