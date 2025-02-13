Return-Path: <linux-kernel+bounces-513183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7ACA34378
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7144E1881BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52924BC0B;
	Thu, 13 Feb 2025 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNpC+9Ki"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241D22172F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457869; cv=none; b=DGPRO89vU5gO6j07x2Xtn8E6g7Zo3fJ1TDXP58eFzopG4ngaC8kaPUpnHwyRVakI8+DmuOQWxp+5+J1SeRcB7fxeeToVlxMA7mobRDxr+EzZycgCe2y/XfQDLxU+lTgVpqcthwmcockPYj5pvc5hLAZX1H1D1fztymsNmqgpdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457869; c=relaxed/simple;
	bh=7JY8ITK80ol69Cjh+s2e0Bg9VnTdWWPoeH70KyOkKy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IoTC+Qykc6sp42TTAhTPCuTq+BECBKeK/tDSzXyyRKFzUjmjVgwOh6Lc6PWjzddCHV0xvZdJweJLLHXRa3L2zy4WMBslSRvMvwN1M3wpIS5yEW9nnf9sWwUpbGOQW2eZCwptzWHY5X17hr22L6Nk1nziFEEX15oyv8JJngdW0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNpC+9Ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB6AC4CED1;
	Thu, 13 Feb 2025 14:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739457868;
	bh=7JY8ITK80ol69Cjh+s2e0Bg9VnTdWWPoeH70KyOkKy0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lNpC+9Kiok/EPtiby6RfXkNDaPk724mQlkiba8EaSo69P7K+1sc9LNVJSGtZfxs42
	 YP6VVxudZAc2UPiUo6rNcOjEA6E3ZfgZ1c5eXTJcaX4TzXUOk10VW8j/CXU+vOJwBv
	 y1SQDFph9CXOviSWWbuR+sAc1bcnJutUPglfmml67JUmkSSt643bPQBTlL9scKfIYU
	 ls6JxZBH1SWw2xOLHraQvRhao4TuaTGOBSRH6EK66VbrA71CcGrbQ7ZDInJ7/wP6WF
	 7hjDvieK4LRrqi4MPQ8sy41ComZ8MMxTMHFRiSG3rlplhrYChA/jQFcb7vs+cRquhE
	 Enp7Xpqxig+8Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Feb 2025 15:43:31 +0100
Subject: [PATCH v3 12/37] drm/bridge: Change parameter name of
 drm_atomic_bridge_chain_disable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-bridge-connector-v3-12-e71598f49c8f@kernel.org>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2034; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7JY8ITK80ol69Cjh+s2e0Bg9VnTdWWPoeH70KyOkKy0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnrWKVLZ3TURDFyTL4g4psrJWZe/f2ZkIv3H7n/Bzjcv
 X69rnnTMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZSGcRYK+G44WLl66+/852k
 1F87391u2dK8c+60vamNfneXaOfUuDxoctv094loyPcPdlvWcgZyMTb8e/TtUOhDFb5XZd7rEk8
 3zaoWvV+ytW7+4cTytWEOC1S2TjhjqFe4s+Y3457qDar3TSwB
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_atomic_bridge_chain_disable() disables all bridges affected by a new
commit. It takes the drm_atomic_state being committed as a parameter.

However, that parameter name is called (and documented) as old_state,
which is pretty confusing. Let's rename that variable as state.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index cb71ec57c47af889c2028c74d0bbcfa2fed1f88b..b21b43af3d1de69c1aa9a4925922e0b2f522f026 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -548,32 +548,32 @@ void drm_bridge_chain_mode_set(struct drm_bridge *bridge,
 EXPORT_SYMBOL(drm_bridge_chain_mode_set);
 
 /**
  * drm_atomic_bridge_chain_disable - disables all bridges in the encoder chain
  * @bridge: bridge control structure
- * @old_state: old atomic state
+ * @state: atomic state being committed
  *
  * Calls &drm_bridge_funcs.atomic_disable (falls back on
  * &drm_bridge_funcs.disable) op for all the bridges in the encoder chain,
  * starting from the last bridge to the first. These are called before calling
  * &drm_encoder_helper_funcs.atomic_disable
  *
  * Note: the bridge passed should be the one closest to the encoder
  */
 void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
-				     struct drm_atomic_state *old_state)
+				     struct drm_atomic_state *state)
 {
 	struct drm_encoder *encoder;
 	struct drm_bridge *iter;
 
 	if (!bridge)
 		return;
 
 	encoder = bridge->encoder;
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
 		if (iter->funcs->atomic_disable) {
-			iter->funcs->atomic_disable(iter, old_state);
+			iter->funcs->atomic_disable(iter, state);
 		} else if (iter->funcs->disable) {
 			iter->funcs->disable(iter);
 		}
 
 		if (iter == bridge)

-- 
2.48.0


