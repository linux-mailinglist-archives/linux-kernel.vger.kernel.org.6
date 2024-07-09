Return-Path: <linux-kernel+bounces-245130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F9992AEBB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B13284E4A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C650548F7;
	Tue,  9 Jul 2024 03:27:57 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C800770FB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495677; cv=none; b=a6fYvBWgZZv4uabMeLMPWuiVH+3rA17TtdIwd7AWauAZIzq3AeI/vAZ3TcPOD65e5nbLUZjvtm9UZAjh7QH0zcof2tOxWJs8m+Oyb2snrbD1l3DPkj89QKW7Gws2GiCeWOahnNMu+iAnutd+tIfvjv5yvQU45EYY5WJ/QjqH25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495677; c=relaxed/simple;
	bh=pKxi0mF8lMnoUcZD+Px5CPw7KKQhbEEBduiVTQH6ctk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aU0p/sSQ7eKH5mZ/eImW4MDGCvo8k3X+JHJp0j57FEgDGL/YV1DgK6KfQ/s/B8jlcWn+NP8YUUClCJ6uNWL6HHr5sBB/7qYZ9l0fOuas7yaF60aw/H2L0cqW8IM3iBMXa62IMDMVlfxvxipghGK5QF/rxHUrU8fzfByWZeT12ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowACHjso2roxmH4ZcAg--.18440S2;
	Tue, 09 Jul 2024 11:27:51 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: hverkuil-cisco@xs4all.nl,
	benjamin.gaignard@collabora.com,
	mchehab@kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] media: v4l2-pci-skeleton: Convert comma to semicolon
Date: Tue,  9 Jul 2024 11:26:33 +0800
Message-Id: <20240709032633.586042-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHjso2roxmH4ZcAg--.18440S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47Gr4ftF45GFg_yoWfWrX_t3
	90kas5urZxJrW29w1aka4rZFsIg3srt3y7Wr43KFW2yas3ua1DuF17Xrn8Cr45Wa1UuFs8
	Jwn8Jr1akF47CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
	Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeID7DUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 samples/v4l/v4l2-pci-skeleton.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/v4l/v4l2-pci-skeleton.c b/samples/v4l/v4l2-pci-skeleton.c
index 4fc2063b9f59..a131c27d5509 100644
--- a/samples/v4l/v4l2-pci-skeleton.c
+++ b/samples/v4l/v4l2-pci-skeleton.c
@@ -852,8 +852,8 @@ static int skeleton_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * function. The release callback must be non-NULL.
 	 */
 	vdev->release = video_device_release_empty;
-	vdev->fops = &skel_fops,
-	vdev->ioctl_ops = &skel_ioctl_ops,
+	vdev->fops = &skel_fops;
+	vdev->ioctl_ops = &skel_ioctl_ops;
 	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE |
 			    V4L2_CAP_STREAMING;
 	/*
-- 
2.25.1


