Return-Path: <linux-kernel+bounces-322972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDC797361B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E806C285816
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43C618F2F7;
	Tue, 10 Sep 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bXwtssOs"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933817D341;
	Tue, 10 Sep 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725967186; cv=none; b=MmdRR7kdBVplGpGN+w7X3z9S8FFguTjNj8mvqrUEd6omSrnHGUZWv4ksRBaoRY8KiWyDGknsPZ1oPVgVXs8lIKh+GqWum8IKWf4675hxtAf3e8j/PiZN8slwV0rNn4bcTx7oziZopvRivJM1qwgJ+XfAiSOf0nZE5KGfrB55jSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725967186; c=relaxed/simple;
	bh=2gbKCjbO/rQ1lMbWDdR6AXX0Gurc69aOVPF/Uingrl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4Im4PlUQ849loxM5dhCVjcHjvkg0HoneAZ6LbMdYkf7EvVtOMrbKWJAWa1nOFzmS+Ic2z1tWUdzjD8fF0BuzCXzFZ/4fSKJ89EfE6XvCbzmKqCCzPhzMkOjnZdtN43B64WEAYX8CVeLH3ZLiNw83Ur7f+N82LEMdw+RGA+gqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bXwtssOs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-156-87-48.elisa-laajakaista.fi [91.156.87.48])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8A5E0CDB;
	Tue, 10 Sep 2024 13:18:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725967105;
	bh=2gbKCjbO/rQ1lMbWDdR6AXX0Gurc69aOVPF/Uingrl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bXwtssOsJFTJaD0LEe1D6WlXqQHR7PJd+3sfnhoTAFpvWuDROPLKFKmXiToVNP9SK
	 lJxvIiNz6BENQ+h5QL570lvoMo3gKTHZxH9Dd2+B07NABhJF8vqA3HRnuert9rEziT
	 P6+H6fymj+Hj8wPqGiOCw8gt1B8UTRO66OrngjnA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 10 Sep 2024 14:19:19 +0300
Subject: [PATCH v3 1/3] dt-bindings: display/xlnx/zynqmp-dpsub: Add audio
 DMAs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-xilinx-dp-audio-v3-1-75560793f4d0@ideasonboard.com>
References: <20240910-xilinx-dp-audio-v3-0-75560793f4d0@ideasonboard.com>
In-Reply-To: <20240910-xilinx-dp-audio-v3-0-75560793f4d0@ideasonboard.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2409;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=2gbKCjbO/rQ1lMbWDdR6AXX0Gurc69aOVPF/Uingrl0=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBm4CtKgm+EqNc2XlDXS8dMFSzNafDruu/XeGWq0
 gVm7MRmIUaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZuArSgAKCRD6PaqMvJYe
 9W7aEACQNgQRnmxctbq5tQ7o5Xl/5T3Wm4W/g7tlXZp6jvw05nfnSXc13zZr16ktdpVywPSVBF9
 TKwNt+YklfR0wq34q6mIMaTfXeXbkWaEP85q74BvqkRuEjdw/QWXcBAZWClWF/s1pN1BVDBSADE
 NOIwJlNGZ+fUcbBufSI1ZNTOk1aU9Y7fnF2uuSqBm19A2cPZOpdx0+tEO9vvT/M54rlkoJI9Bd5
 LYDnvepLeAf1/sqf65hYyArghe+R9PclZpwDXrRrlxMeuf+u7F8mKTSsLw79oqZtyp8ZnCY+oT8
 ugi/JRdqZazf0jGtMdYXty2dZ3sOZMMq2/yrJn4m2uYevuKhw/zBK9ABUUs8ZymHasA8TO7DZSE
 56qwq3WJP9y6pf/GQJd3P4CIlsPKKem35EnLTJKkNJ185vcYsER89H0wRx9e0Y3wMTTdkNrbDd2
 cRcQjDNblHHc2XjimAwIXTmECj85MS7NABJ6E3pXi0YSnVdr5yC+P6LY8Em1wr/PLDKrohCT00I
 DqecCYicucKgyzywuSP97ce00BFdKDffs3rW07NKnZKzcHBiK19U1nKYpOFjp5FLm6RsQA9xYnB
 ci19cbGhrkM7SxHmTj2OSUylSEoik2ZP2jWHOrbR4hg//UvFBHlVA7burvRpAmCJcDuoIqM1yCS
 +2Gp0jM40jB300g==
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


