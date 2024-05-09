Return-Path: <linux-kernel+bounces-174314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1810D8C0CF6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E0B1C20F27
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D296C14A0A9;
	Thu,  9 May 2024 08:58:14 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0F13C8F8
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245094; cv=none; b=eRl1rSHT6NVgkPDQb8xdhGGnYm4n8j9FipoDKPoRaCxV4n60BwhObwq2DK6HRugwCBQy6OD3J/1MSA1u0rnmJz7Tv0wPK4xqhkXxJPUUIK9Ch5idJge43TNUMwXLrnbWYtxqJ4Wpxqn06oM3qidQjmynjjSFDxIhiQDb7+Q0XWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245094; c=relaxed/simple;
	bh=Xu2WCirexobQIh25VikC3MIOnC63W3f4KDUKltXAkeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hhyXpeXjP3Z9GX3OQdygIUW4LyXwC78vDemEh2+uxwNTJ3Wz44nrXR/kIKhsZ6TvrmicJzGd8LkmTGdtb/iKG/Ovn3JAeaJAKOQ1WyONvmb83r49vCJZe4IbL8XD7I+5GWc0lapRfWvVvErxLchuVApwU1yk23y3pV6JlPKmdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3dbb7bfa0de211ef9305a59a3cc225df-20240509
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:4de40844-5ccd-4772-b5d8-70320bbaec82,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-11,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-1
X-CID-INFO: VERSION:1.1.37,REQID:4de40844-5ccd-4772-b5d8-70320bbaec82,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-11,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-1
X-CID-META: VersionHash:6f543d0,CLOUDID:8d15c9d744e307d403f4a7dd4da8004e,BulkI
	D:240509165804T4MFGNYY,BulkQuantity:0,Recheck:0,SF:25|17|19|44|66|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CTIC-Tags:
	HR_CC_CHARSET, HR_CC_CHARSET_NUM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME
	HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-UUID: 3dbb7bfa0de211ef9305a59a3cc225df-20240509
X-User: oushixiong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <oushixiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 931486327; Thu, 09 May 2024 16:58:02 +0800
From: oushixiong <oushixiong@kylinos.cn>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Xinhui.Pan@amd.com,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/radeon: Delay Connector detecting when HPD singals is unstable
Date: Thu,  9 May 2024 16:57:58 +0800
Message-Id: <20240509085758.123046-1-oushixiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shixiong Ou <oushixiong@kylinos.cn>

In some causes, HPD signals will jitter when plugging in
or unplugging HDMI.

Rescheduling the hotplug work for a second when EDID may still be
readable but HDP is disconnected, and fixes this issue.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index b84b58926106..cf0114ca59a4 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -1267,6 +1267,16 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
 			goto exit;
 		}
 	}
+
+	if (dret && radeon_connector->hpd.hpd != RADEON_HPD_NONE &&
+	    !radeon_hpd_sense(rdev, radeon_connector->hpd.hpd) &&
+	    connector->connector_type == DRM_MODE_CONNECTOR_HDMIA) {
+		DRM_DEBUG_KMS("EDID is readable when HPD disconnected\n");
+		schedule_delayed_work(&rdev->hotplug_work, msecs_to_jiffies(1000));
+		ret = connector_status_disconnected;
+		goto exit;
+	}
+
 	if (dret) {
 		radeon_connector->detected_by_load = false;
 		radeon_connector_free_edid(connector);
-- 
2.17.1


