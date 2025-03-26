Return-Path: <linux-kernel+bounces-576809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7D4A714B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771A5177C97
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DCD1BEF8C;
	Wed, 26 Mar 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NV/BRJay"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D481DF97C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984413; cv=none; b=EcZQwuUM2+rOH6w6AEGkJsOx5HACea5y97uuDSJWJlyDacu8M22U6y5naQ6Vgxxc3AZJeIYjmYzg3QaCgcLrTaepUBwN9FCzjm70w5U04jZD4lMVned4nBUju5CXoo/YxLz4kd9cdWIVz5TtfC1CSbmV8RIghAnR+xX66EtzC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984413; c=relaxed/simple;
	bh=lBLcJTp27oH8nx+Q42bjYsDuSqrlS+B/PS5pKuzffio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QRkceq8MopfmAlw+0gDLHPxiionYY7Wu2jGXUPYOxKGkry9CS68vch80qPoPmToUgKsCI+UralX2b+BXEwTbmW7TExykuawMnLQ4A+fwIDSQAWEqGkn+KMcwkDyF3C7ROFimhy+koW/3aRGzbwR73W3rzb0hck99Ch943oRqiX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NV/BRJay; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742984410;
	bh=lBLcJTp27oH8nx+Q42bjYsDuSqrlS+B/PS5pKuzffio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NV/BRJayJottts90cn7jmeXPwaKQnX7Wy7IxeKaGstQk/ybxs3mj68eQPQLf9aSJx
	 wnu5mXcK+eHFubUglTvEU+YGp9OYJDxtvah0DePS7arPMbA8aD0PG1rLFgZFRkczhY
	 +3T8BHs1b/4PD1H74rtuQi3bC+XLye583bCdwf9ZANCQ6J6RigJdoSUZ5++DOteoZ5
	 wmYerypN42xgiMBO09hBIlesMDxbv+rXg+CsJSRbX7Rb8rTWvFdgKKDc0ftv382Xx0
	 D5rpS+af1jNjkAHSwpsBYpNQ9ScJtQuj9q8QxqJRbto4tO8tiNysq3QXZkfTJCay/v
	 8a3aADXMqcO7g==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 60C4217E0B9D;
	Wed, 26 Mar 2025 11:20:10 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 26 Mar 2025 12:20:00 +0200
Subject: [PATCH v3 11/15] drm/tests: hdmi: Drop unused
 drm_kunit_helper_connector_hdmi_init_funcs()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-hdmi-conn-yuv-v3-11-294d3ebbb4b2@collabora.com>
References: <20250326-hdmi-conn-yuv-v3-0-294d3ebbb4b2@collabora.com>
In-Reply-To: <20250326-hdmi-conn-yuv-v3-0-294d3ebbb4b2@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

After updating the code to make use of the new EDID setup helpers,
drm_kunit_helper_connector_hdmi_init_funcs() became unused, hence drop
it.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 7b2aaee5009ce58e6edf2649e2182c43ba834523..1e32694041277a541f0f8941d9c35e8ca9264599 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -207,9 +207,6 @@ connector_hdmi_init_with_edid_funcs(struct kunit *test,
 	return priv;
 }
 
-#define drm_kunit_helper_connector_hdmi_init_funcs(test, formats, max_bpc, funcs)		\
-	connector_hdmi_init_with_edid_funcs(test, formats, max_bpc, funcs, NULL, 0)
-
 #define drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test, formats, max_bpc, funcs, edid) \
 	connector_hdmi_init_with_edid_funcs(test, formats, max_bpc, funcs, edid, ARRAY_SIZE(edid))
 

-- 
2.49.0


