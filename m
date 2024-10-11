Return-Path: <linux-kernel+bounces-360651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27145999DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B36F1C21F30
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97D820ADD2;
	Fri, 11 Oct 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wNUmBlLs"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07220A5E1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631371; cv=none; b=WaFjH4oPT80bvA5NN3vr4tpA3VS0vc6RzMrXJo3JydIHj1giTgUifvkc6V9yaGjcrcI57HEMBNjZncPM9HL29YnyAcaVVnvH8582Il2w4cJAs/gSF36Cn+Ll2L+VB2PcsnqdtyVDvNTvcm1pYZ7yvI/FqYpUvVvPAIonbmyrDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631371; c=relaxed/simple;
	bh=whVPtN8m5r3DzuuuWAl7siTfoBgaFyvL0UZeWgrArA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXs+u/V2qEusvzqCNducigybd0tu9aKRjCBBCYUdUrQe/4MFZn+C0xcgzpUQ0xBbUQU1W1i5NCi0nbig/e5DwPbYvtTg46mTOyCjbSJ5D4WuzP0R0TyqtmxwgIxVk0M/kdw+jp+DSeu1wHYgrxFB4MDnZDz/xDo0mJZYfw1o4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wNUmBlLs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F4D0D8B;
	Fri, 11 Oct 2024 09:21:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728631270;
	bh=whVPtN8m5r3DzuuuWAl7siTfoBgaFyvL0UZeWgrArA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wNUmBlLsnebbbAP8tyHbVdk7FkwpCzJ2K98UOzkgZxQ0yRVTbEpzJxBf1lQjgzpNI
	 /0Y4LEo5Gm0/ZfdYV5YvPYoBRaxZ7WhPUgKGtuNB2Aifdc1SnpoVAeiODuIWFv39V3
	 mliPhShQEXPwaDXbMVaTRHQ83cGfE8qyJRrzuI20=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 5/8] staging: vchiq_core: Indent copy_message_data() on a single line
Date: Fri, 11 Oct 2024 12:52:07 +0530
Message-ID: <20241011072210.494672-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241011072210.494672-1-umang.jain@ideasonboard.com>
References: <20241011072210.494672-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the copy_message_data() indentation in queue_message_sync().

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c   | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index b95443043c27..3ed949343608 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1194,9 +1194,8 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 		state->id, msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
 		VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid));
 
-	callback_result =
-		copy_message_data(copy_callback, context,
-				  header->data, size);
+	callback_result = copy_message_data(copy_callback, context,
+					    header->data, size);
 
 	if (callback_result < 0) {
 		mutex_unlock(&state->slot_mutex);
-- 
2.45.2


