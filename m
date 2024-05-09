Return-Path: <linux-kernel+bounces-174054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459448C09AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C658DB2100F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF1613C9BD;
	Thu,  9 May 2024 02:13:28 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F410979
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220807; cv=none; b=ej1lcEyuInXKfptarks8qPSzqwEPdqJJRycBenI26TyJKMH1HU9HSyRKMEJd1IHgrDmZaq/prrMJmzi5ZeoiwevR7nAK5aqD8xhbAqJe40gKjFgk3SrpInR0KG7NpsZYNW/h5U3Tk+P0rycSrHc6iBitAYrTxNhQGvEUzO3oPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220807; c=relaxed/simple;
	bh=b4x2StJjDGXWYMl11hb3SNY+I3gmk55FoDFhh7uOoVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQRul4v2eAdVVULhzgpzXray/XoujYj24RTa8CNcGFHLjUCnWpKAAuhmbVlM2QoIWUTuB0YBghNGsyOyrBiH3R+VFgcLS2QHBmxXEK/y05+8HYhL3YrndEJuJ+RNFci8vty+jPhvfCmZlbchftHFLVDar8IkVAHWB3TTCPQgzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b32305160da611ef9305a59a3cc225df-20240509
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d4e9c9e7-be4c-42f5-9076-be0cb2d8f9ae,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-11,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:29
X-CID-INFO: VERSION:1.1.37,REQID:d4e9c9e7-be4c-42f5-9076-be0cb2d8f9ae,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-11,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:29
X-CID-META: VersionHash:6f543d0,CLOUDID:6f405a4b03c2efc3573f107fc9420644,BulkI
	D:240429110502VVCX1UY7,BulkQuantity:2,Recheck:0,SF:66|38|25|17|19|44|102,T
	C:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED
	SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-UUID: b32305160da611ef9305a59a3cc225df-20240509
X-User: liweishi@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liweishi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 761512348; Thu, 09 May 2024 09:51:49 +0800
From: Weishi Li <liweishi@kylinos.cn>
To: airlied@redhat.com,
	kraxel@redhat.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	liweishi@kylinos.cn
Subject: [PATCH] [PATCH RESEND] drm/virtio: fix memory leak of vbuf
Date: Thu,  9 May 2024 09:52:25 +0800
Message-Id: <20240509015225.38669-1-liweishi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both virtio_gpu_queue_ctrl_buffer and virtio_gpu_queue_cursor use
virtqueue_add_sgs to upload the structure virtio_gpu_vbuffer * vbuf
to virtqueue. However, when the vbuf fails to upload and virtqueue_add_sgs
returns -EIO or -ENOMEM, the vbuf will not be able to be free by
virtio_gpu_dequeue_*_func, resulting in a continuous increase
in memory allocated to vgdev ->vbufs.

Therefore, make virtio_gpu_queue_ctrl_sgs and virtio_gpu_queue_cursor
free vbuf directly after virtqueue_add_sgs returns -EIO or -ENOMEM.

Signed-off-by: Weishi Li <liweishi@kylinos.cn>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index b1a00c0c25a7..6701ce9d0ee8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -356,12 +356,14 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
 	WARN_ON(ret);
+	if (ret < 0 && ret != -ENOSPC) {
+		free_vbuf(vgdev, vbuf);
+	} else {
+		vbuf->seqno = ++vgdev->ctrlq.seqno;
+		trace_virtio_gpu_cmd_queue(vq, virtio_gpu_vbuf_ctrl_hdr(vbuf), vbuf->seqno);
 
-	vbuf->seqno = ++vgdev->ctrlq.seqno;
-	trace_virtio_gpu_cmd_queue(vq, virtio_gpu_vbuf_ctrl_hdr(vbuf), vbuf->seqno);
-
-	atomic_inc(&vgdev->pending_commands);
-
+		atomic_inc(&vgdev->pending_commands);
+	}
 	spin_unlock(&vgdev->ctrlq.qlock);
 
 	drm_dev_exit(idx);
@@ -469,6 +471,9 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
 		spin_lock(&vgdev->cursorq.qlock);
 		goto retry;
+	} else if (ret < 0) {
+		free_vbuf(vgdev, vbuf);
+		notify = false;
 	} else {
 		vbuf->seqno = ++vgdev->cursorq.seqno;
 		trace_virtio_gpu_cmd_queue(vq,
-- 
2.25.1


