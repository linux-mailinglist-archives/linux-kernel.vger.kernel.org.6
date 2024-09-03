Return-Path: <linux-kernel+bounces-312074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2451D96919B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A161C22988
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFAA1CDFA3;
	Tue,  3 Sep 2024 02:56:58 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95801CDA36
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725332218; cv=none; b=qK2vtd6o3qKE0Apyp/QLB8cDZR94raSUrC1zIE1z3hEyv9wLEt6XjirnS1S2SMfGIUoftR+f0SPU0rMru3Cd4Bv9GIXdOHT2P0Zq+HCO91CgBMGUKUAzm+9ocESpFBHpXk28PwBrac0niblrxoE+W03jvn8h9trDiBd3WSLaLvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725332218; c=relaxed/simple;
	bh=K5KBrNNKs2v3/4RefgFilAcNyEzc1Kbq6dcINtqeu8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NK1Os+qvnTuoxZ4KxQ8FkchdMi6XQSJs0NwUG90lzBC2gus6qiQ3yGher9xbo1ZWoTOKyMUOL+JSbEYr1r9mXMMafhcnufnqkd2nYD4Q7r+iyuiZ7G3MJEc1Nkn4QEFMYojXp4C4/ZeRiDAbZiZgeY7LkexsZCEgVzN8MmH79vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowADXaarvetZm_EK1AA--.36173S2;
	Tue, 03 Sep 2024 10:56:47 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] drm/i915: convert comma to semicolon
Date: Tue,  3 Sep 2024 10:55:58 +0800
Message-Id: <20240903025558.493977-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXaarvetZm_EK1AA--.36173S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47Grykuw4fGrg_yoW3ZFcEkr
	yrCr4fCFy5CFnFvw17Cr43ur9Ivw4q9F4xW34rt3sIyw17J34UX39ruFy7Z345AF1jyFyD
	Aa18Wr97ZrnrujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5hL0DUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 19498ee455fa..00e98a5ede09 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -1313,8 +1313,8 @@ static int intel_hdmi_hdcp_write(struct intel_digital_port *dig_port,
 	memcpy(&write_buf[1], buffer, size);
 
 	msg.addr = DRM_HDCP_DDC_ADDR;
-	msg.flags = 0,
-	msg.len = size + 1,
+	msg.flags = 0;
+	msg.len = size + 1;
 	msg.buf = write_buf;
 
 	ret = i2c_transfer(ddc, &msg, 1);
-- 
2.25.1


