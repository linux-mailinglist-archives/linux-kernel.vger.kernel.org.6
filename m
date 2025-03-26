Return-Path: <linux-kernel+bounces-576807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CE0A714B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A32176108
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405561E1DF7;
	Wed, 26 Mar 2025 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="StXtodWw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B611B4F1F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984412; cv=none; b=MLve+qfPMTiY9AkMLS8zG0podcO2BRailn1f424BqtofwAkA61jy0BrrTwDmXCM96XGbfvdJQ/G2ml+7lsJKa8fFc0MG9zNYlADbI1zwL7K46I3j8gc6s9XGiB361++SliRvo2Ya208BrqU/SDmxDH71pqcB11pQfdmogxv6Og8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984412; c=relaxed/simple;
	bh=v/fyQCNrVCvHT2cQvAAE7Y6GNncKXO0CKQph6nEoM98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2oAYXFSrg44TlJTO9HW4m0wIZck3lAG3Hs8fKfvRSi6at+wBaWy6Pk+iZNcsH1KBqwJH9pfy1SJM37BfN4hMD0NHKSLwIVBDSRvIJXIomeJu2sV85N4RepsAe551JRv9z2OB3MFz0NlnChVXfiukeR5c/kTB+RIsfKUR8K/E20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=StXtodWw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742984408;
	bh=v/fyQCNrVCvHT2cQvAAE7Y6GNncKXO0CKQph6nEoM98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=StXtodWwXx0RhjEEZ+vHIJHX/By6TzJnC4UYUtOv7hEJRZ24VBbMLm1V59XCJkQFi
	 ChBgO5oQT5xPlNeyEQCE8SKDG56etc8u4HaH+JKLGPpiQ0HKJlAN2Wbk8T9rK/nJtT
	 Ka+u9lvRILzgf3ChItIskEcplvf8fKIWqrS4e5tjeqAXi6O876FIQOzVouj/2mBW8I
	 e7pLmMrhLmL1Dv1ZQ1ia+MueBcJqbtexk4n06xZm0UxjK26FbJ5gbJa/q/exDsQtxF
	 uEsWh1NTgXj7IUvb9WOOPyABc9FihpFAxtUQ/LWd02rH3plB9ShmAd4YmsxW5hiE6W
	 rJggJc9IwkU7Q==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id D577D17E0FCC;
	Wed, 26 Mar 2025 11:20:07 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 26 Mar 2025 12:19:58 +0200
Subject: [PATCH v3 09/15] drm/tests: hdmi: Fixup CamelCase warning
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-hdmi-conn-yuv-v3-9-294d3ebbb4b2@collabora.com>
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

Rename the reject_100_MHz_connector_hdmi_funcs variable to make
checkpatch.pl happy:

  CHECK: Avoid CamelCase: <reject_100_MHz_connector_hdmi_funcs>

While at it, also rename reject_100MHz_connector_tmds_char_rate_valid()
for consistency.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index bcbd146fb655f4402529e59af09c99dbae7be0bf..284bd9b1418a454d05c4a38263519eb8ae450090 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -89,15 +89,15 @@ static const struct drm_connector_hdmi_funcs reject_connector_hdmi_funcs = {
 };
 
 static enum drm_mode_status
-reject_100MHz_connector_tmds_char_rate_valid(const struct drm_connector *connector,
+reject_100mhz_connector_tmds_char_rate_valid(const struct drm_connector *connector,
 					     const struct drm_display_mode *mode,
 					     unsigned long long tmds_rate)
 {
 	return (tmds_rate > 100ULL * 1000 * 1000) ? MODE_BAD : MODE_OK;
 }
 
-static const struct drm_connector_hdmi_funcs reject_100_MHz_connector_hdmi_funcs = {
-	.tmds_char_rate_valid	= reject_100MHz_connector_tmds_char_rate_valid,
+static const struct drm_connector_hdmi_funcs reject_100mhz_connector_hdmi_funcs = {
+	.tmds_char_rate_valid	= reject_100mhz_connector_tmds_char_rate_valid,
 };
 
 static int dummy_connector_get_modes(struct drm_connector *connector)
@@ -1933,7 +1933,7 @@ static void drm_test_check_mode_valid_reject_rate(struct kunit *test)
 	priv = drm_kunit_helper_connector_hdmi_init_funcs(test,
 							  BIT(HDMI_COLORSPACE_RGB),
 							  8,
-							  &reject_100_MHz_connector_hdmi_funcs);
+							  &reject_100mhz_connector_hdmi_funcs);
 	KUNIT_ASSERT_NOT_NULL(test, priv);
 
 	conn = &priv->connector;

-- 
2.49.0


