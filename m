Return-Path: <linux-kernel+bounces-377978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533819AC971
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB451F22265
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F59A1AB6EF;
	Wed, 23 Oct 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R59/aJfP"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8801A00DF;
	Wed, 23 Oct 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684389; cv=none; b=JRmgR3dmrjhw2hOoFZUZH79HtLAlkssBgduzrsYN+rV3ZwGgMrSntyyj3LSUnCpLW2ZG6PosplK7NbbiyYewxTZp3dnTrdMsuaAClpTHIiqYuzI9nxYftbzk7Gc87B89or07/RvszP3EWtaiiZbSuZIf6YM7QG7lJffg9VxbGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684389; c=relaxed/simple;
	bh=0nXdny8O8iGUgqDAF00HrUd2uDNhZdKpP4uH+IQ26w0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=be4H0WnW9HuDmWxl7G1kEmJVyFYOAvrJ9+DwcqdoRsFBe+lOXCAKnn/q0zNbNp0LQJsZDNwgaE7UzxOP9KeLStgAsHboF1zHh3D29/buSzw7tBLYGDwnJidM94IMRpmL+/MvWywl4B3KwvmcG2x0UlAX9fvWp6FvPg3cXaGy4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=R59/aJfP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1A3F5BDB;
	Wed, 23 Oct 2024 13:51:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729684278;
	bh=0nXdny8O8iGUgqDAF00HrUd2uDNhZdKpP4uH+IQ26w0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R59/aJfPnbpZGtwZ1qQSJtD3fHzTy14A3ZzkBQcjjudvVsnTsTwnBwVsMGRi9Dt8M
	 dyZRJOgtXqbJScn0x5ETzrf//upNQZ9dQD6naMgX4DIjQ011j8KHJv8x3m+xTzSGv+
	 isbpH4g0GvtP/h4r4pwlUuhVcQKIZRv7QKa74Ad0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Oct 2024 14:52:41 +0300
Subject: [PATCH v4 1/3] dt-bindings: display/xlnx/zynqmp-dpsub: Add audio
 DMAs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-xilinx-dp-audio-v4-1-5128881457be@ideasonboard.com>
References: <20241023-xilinx-dp-audio-v4-0-5128881457be@ideasonboard.com>
In-Reply-To: <20241023-xilinx-dp-audio-v4-0-5128881457be@ideasonboard.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2459;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=0nXdny8O8iGUgqDAF00HrUd2uDNhZdKpP4uH+IQ26w0=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnGOOdpKBl+X813tbIgGTmzFFMPK3Gp7XP/9miR
 7DrnReJ/BuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZxjjnQAKCRD6PaqMvJYe
 9eDPD/wLQU9l0Mgkos2zZlF6ZrXjFHLHao6agTr1lVZZUIzUjxr1af0QQDTny61xXmoye15/8DI
 QAAQEwPiE+lrKk3Km831bZx+X3Tjd18G3ag13jpZfng1dbTbzAbfw0ig1QBdKiIG/01H3mkfPvu
 Va8QPgpx0gomtOL1wgogGL51RBQDlBCAXgkQAKVPqftRxVVuA5XaHUkZvNhJzFsSq7q9hBo5HeF
 4fG/RXkSlCSkkbJszudyuuA3sYp343O7cCyRNQaYSy1ffRT3x8FGlJtWXAjsxm/nIe+gBe2+ZSo
 coylP4n0U79uloKVyUI1zDDdNtUO0ZbZDKsEP7w9Ovn+4jDYhGM0y+WVxJWpoQwPmdqEdHxy6n2
 3Z8jR2yQhta4IDtT7ksfgK7Yl9JxbF1brXoKftCmbt2JHwxrSdSKzPuplta0mSdZRqVlAuNhWrN
 GmNntwmcXE36tE5OKlhS3fbmIb3XbNjjvr2NU8E2ZY4ZzsTGHOvzjcCrOJA7gJS3b6rbt/UI7+l
 heCEXvjQjLNVy8Bs5rKNRQRB7qCgyUGQmuz20ULmYr/GdQLywiK6jAkI5r77c5L+iPojyk54UXn
 4Xa+5Nl74vHt/akUuq6l0Z53AQ+KNck6JkMjI+91pBKiXDunDiI/TUP1Af5Yofp45KjdacjXGAE
 SO5CEDH1/vtxjHg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The DP subsystem for ZynqMP supports audio via two channels, and the DP
DMA has dma-engines for those channels. For some reason the DT binding
has not specified those channels, even if the picture included in
xlnx,zynqmp-dpsub.yaml shows "2 x aud" DMAs.

This hasn't caused any issues as the drivers have not supported audio,
and has thus gone unnoticed.

To make it possible to add the audio support to the driver, add the two
audio DMAs to the binding. While strictly speaking this is an ABI break,
there should be no regressions caused by this as we're adding new
entries at the end of the dmas list, and, after the audio support has
been added in "arm64: dts: zynqmp: Add DMA for DP audio",  the driver
will treat the audio DMAs as optional to also support the old bindings.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml    | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
index 554f9d5809d4..6b754d4f260e 100644
--- a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
+++ b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
@@ -100,12 +100,16 @@ properties:
       - description: Video layer, plane 1 (U/V or U)
       - description: Video layer, plane 2 (V)
       - description: Graphics layer
+      - description: Audio channel 0
+      - description: Audio channel 1
   dma-names:
     items:
       - const: vid0
       - const: vid1
       - const: vid2
       - const: gfx0
+      - const: aud0
+      - const: aud1
 
   phys:
     description: PHYs for the DP data lanes
@@ -194,11 +198,13 @@ examples:
         power-domains = <&pd_dp>;
         resets = <&reset ZYNQMP_RESET_DP>;
 
-        dma-names = "vid0", "vid1", "vid2", "gfx0";
+        dma-names = "vid0", "vid1", "vid2", "gfx0", "aud0", "aud1";
         dmas = <&xlnx_dpdma 0>,
                <&xlnx_dpdma 1>,
                <&xlnx_dpdma 2>,
-               <&xlnx_dpdma 3>;
+               <&xlnx_dpdma 3>,
+               <&xlnx_dpdma 4>,
+               <&xlnx_dpdma 5>;
 
         phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
                <&psgtr 0 PHY_TYPE_DP 1 3>;

-- 
2.43.0


