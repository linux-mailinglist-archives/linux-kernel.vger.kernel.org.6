Return-Path: <linux-kernel+bounces-532482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A417A44E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67AA177CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F696211A31;
	Tue, 25 Feb 2025 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rua6QqsG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7E211494;
	Tue, 25 Feb 2025 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517407; cv=none; b=GHt+25GXxa5YsIan0UZfsKdKEk9/lyvTdK2ADYKKPXIwYhU4TqGMHP3Xu5v7U7qbLQOevcIoGE8uGnk7DKXdpC3R94oSpv6BhvYueuCAT5Xf1QdWzBjPtjShMygaG3To6YpQOGfZY38ZWCy+bD6ymEUyWPWo/ZMq2PlCLIpgQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517407; c=relaxed/simple;
	bh=3rjzucY2mzCS228H6NdD5SCcBe2EbMfvymk2w4oTTTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUjAvPzf3jSBbjcUOB1gzwA4q6eVIS+hbY2uPF4hH6i6VBXwsCTRQTZO5ACPMjZ8xxiJSFvsuwK3iKJjp9qqfsw+46mrMzgnVyLU5ttVbcOXzTy8h/nF/ZHtLP4o3plh7PyydqrfYwZTTzi0EpKGuWHsfZ41WRBE+XpuWtMtSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rua6QqsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A451C4CEDD;
	Tue, 25 Feb 2025 21:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740517407;
	bh=3rjzucY2mzCS228H6NdD5SCcBe2EbMfvymk2w4oTTTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rua6QqsGWULVo6JIaHkhYkZsmQsYHrG84S0o7f2MfZmZbE6CnRFdafTtciX0MpS7s
	 yk3Mg5XSHm/gFzcqdRrIvpIhv1v3sFFr5J0muP2KM9nHAiOUy9QOjIc+eUyw2DT8ZX
	 MAVvS9OHMVCfH/piWSd8OanTFXH/F/GpbB8Xfrzu0RNrZLcCu0D0Kycv33jQfhPoAy
	 /6VRmfokCqwOcSTM993ohRtwcGx+4ZEYgYqxjXxFxzk6JgLD977KczYz8EWJ3IIE7/
	 PytJBDjvcJusPc8EEn5zGVAnhizQbxou+DYBt3IU7UHJp5bibBwjSSlIQ73xz25n+w
	 IGN9HeadCuqsQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: display: mitsubishi,aa104xd12: Adjust allowed and required properties
Date: Tue, 25 Feb 2025 15:03:15 -0600
Message-ID: <20250225210316.3043357-2-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250225210316.3043357-1-robh@kernel.org>
References: <20250225210316.3043357-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Mitsubishi aa104xd12 panel requires an external backlight driver
circuit, so allow the "backlight" property.

There are users of this panel without a vcc-supply, so it shouldn't be
required.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
index 2c92d81caaaf..96621b89ae9e 100644
--- a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
+++ b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
@@ -43,6 +43,7 @@ properties:
   height-mm:
     const: 158
 
+  backlight: true
   panel-timing: true
   port: true
 
@@ -50,7 +51,6 @@ additionalProperties: false
 
 required:
   - compatible
-  - vcc-supply
   - data-mapping
   - width-mm
   - height-mm
-- 
2.47.2


