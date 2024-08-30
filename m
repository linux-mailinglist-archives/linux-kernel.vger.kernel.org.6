Return-Path: <linux-kernel+bounces-308187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29323965863
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C03C1C23100
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6F3155332;
	Fri, 30 Aug 2024 07:27:29 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B91509BF
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002849; cv=none; b=n7HH0J95Ih2DAG0OLJlXjZrbHJuC/FOrZZdE1IaKSIlvv1J7iYHEpfOKvnrVi6uQEJaoK5JL7GzcOTA0lct9QJX64iMh6Iebc6VNBkSVzbr+hBct89SUhBRuP35fuLTlAUDY9gEeLzHJ9mwEQYuS3VndXA1QRN2g7VusHvbvA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002849; c=relaxed/simple;
	bh=g9v8vgDJZ3UiSfpn4refhNP18mJmeECgWJQiozcCxIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tKMciMbE/F1qqT95MCV9P5KLJGJ9IjC87x4GBD//TJc+bORhSro9SOQicKNgxUtUIEkpiiUML+QEQlEHQBBRjfC8e0ARY1iDCfUXvoz6cr69iybb7nn0at7xkfN+3yr4zAhNs0omJGfR5640jHAMv3TF7vtWCa04mLTuZlz/lxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 47862aaa66a111efa216b1d71e6e1362-20240830
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:82dd6eef-c9b1-4bf2-9366-e17651fb300b,IP:15,
	URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.38,REQID:82dd6eef-c9b1-4bf2-9366-e17651fb300b,IP:15,UR
	L:0,TC:0,Content:-20,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:82c5f88,CLOUDID:f549c8c9d72633c064f2ff9297a78f9b,BulkI
	D:240830152717Z6VFUDEA,BulkQuantity:0,Recheck:0,SF:66|25|17|19|45|102,TC:n
	il,Content:1,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 47862aaa66a111efa216b1d71e6e1362-20240830
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(111.48.58.10)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1438311477; Fri, 30 Aug 2024 15:27:14 +0800
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
Subject: [PATCH] drm/amdgpu: enable gfxoff quirk on HP 705G4
Date: Fri, 30 Aug 2024 15:27:08 +0800
Message-Id: <20240830072708.128502-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Liu <liupeng01@kylinos.cn>

Enabling gfxoff quirk results in perfectly usable
graphical user interface on HP 705G4 DM with R5 2400G.

Without the quirk, X server is completely unusable as
every few seconds there is gpu reset due to ring gfx timeout.

Signed-off-by: Peng Liu <liupeng01@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2929c8972ea7..bd17e32b432d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1301,6 +1301,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
 	/* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
 	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
+	/* HP 705G4 DM with R5 2400G */
+	{ 0x1002, 0x15dd, 0x103c, 0x8464, 0xd6},
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.25.1


