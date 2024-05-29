Return-Path: <linux-kernel+bounces-193263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410FA8D2965
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7120B20E30
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DB923DE;
	Wed, 29 May 2024 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="cxf8GghL"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7692819;
	Wed, 29 May 2024 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941897; cv=none; b=s8jUQ9F10HLjkSRscLQLELaenbWmjoYlAoExxT8+YjFxu0WNuakiiQoxskfhVvglUi7fbko64fU7GyaQpElkRD7VqtQyCCoOi237urzV6CuO+KKtrsTdYD6LlsMRPH4Y1S/wEbgHBNNK3VO7K+zS+hVxg16/HA8qdqeyFs48jTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941897; c=relaxed/simple;
	bh=L4pHFdBE56ytSBzrVzapQ4SoOV5JCMlIlQYI9i9XOD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GrcH7wS1kqTX3W7dmTNqvNzMCsWETYxD99fVJhIdY1qbiQJ7hW5g/cFMv2C7R/A7/0BG5uLdziPWjsf/o4yQMF0bkPQdB5bxh2Zzsk3C53pP1UXWyx7gR6H0iEwT2vn+M7R/vZU53EV1qhUuMCyLd0yWVCCPN5LQYoXi0d/sIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=cxf8GghL; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=IJ817xnZCKNz/dtqhIBDZKs2MR8zd1jtPZ+X3nIbEYo=; b=cxf8GghLG6NtRN4Z
	BebRiX7gsuwLjC+Z08V5707jOjcXDDLOOla8Bep6QRfxcEFRoaU0MLR8ID4h0JmUyhzP1LMINZuFI
	aSaegwzUxjUW7k8ckne/I5SRgpyfv5H7nOjpwzZZjIEzUEwaG5EPOj/lOePIyVuHrStdjYapy/1sr
	v7mZ3DBsAOQGdMzn5uHfhJVCN7xggV6Vkvk5e0in1tjfMRXwMxLAEYeT+eAE9Di6KqxQcosZEU95s
	bm5OfMSaXlV5VZa/wYE1wFt2VfYrzju29UexNWV/VJsQajTvoG+F0R1E0Cs3sSK+ZHz/7nxn426qp
	/aSK/vFtIJp2NMcuZA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sC717-0034S3-06;
	Wed, 29 May 2024 00:18:09 +0000
From: linux@treblig.org
To: vaibhav.sr@gmail.com,
	johan@kernel.org
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] greybus: audio: remove unused struct gb_mixer_control
Date: Wed, 29 May 2024 01:18:07 +0100
Message-ID: <20240529001807.262955-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'gb_mixer_control' is unused since the original
commit 6339d2322c47 ("greybus: audio: Add topology parser for GB
codec").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/staging/greybus/audio_topology.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 5dc4721105d4..6ca938dca4fd 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -10,12 +10,6 @@
 
 #define GBAUDIO_INVALID_ID	0xFF
 
-/* mixer control */
-struct gb_mixer_control {
-	int min, max;
-	unsigned int reg, rreg, shift, rshift, invert;
-};
-
 struct gbaudio_ctl_pvt {
 	unsigned int ctl_id;
 	unsigned int data_cport;
-- 
2.45.1


