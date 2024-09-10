Return-Path: <linux-kernel+bounces-322950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C459735DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965AEB2B061
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E8D18C33D;
	Tue, 10 Sep 2024 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PxGpsdaO";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="kMHkayiF"
Received: from a7-41.smtp-out.eu-west-1.amazonses.com (a7-41.smtp-out.eu-west-1.amazonses.com [54.240.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B76185B43;
	Tue, 10 Sep 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965478; cv=none; b=p+JUe6wLsokvXdynKhUelrPiz1pVtaGKSVdsJYLTL7lmvYFQQOc+UpJafpBOQb+hyV7FAFVF8fc0dGg5FEKfMDXnzNDtsldA5sQx7qskeKcrl20ewzxp38qsIG8LzdgiL80mjoXI90DOo64S+zRsu4q2enxb5jCisvbF8bu6/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965478; c=relaxed/simple;
	bh=GzLfsDTUMMdGBR6iRZk3PPetRE7pbsieNX4s440SIME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq2bHhHMSsOXuUtPg8wRXN8i8hyYBdpqAAOIDT/KJORjAYNpWrgtR61/+7U8UwVspk1wI/h77i/nVbDVXh2m100srrMP2TdFuXmXKoOm3IsNfrMdi/CeLfzwgwGWf5a/sEUFzWMSEkCQEQhqL/FFKiMlm+hgKzD5lFFbWhoM5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PxGpsdaO; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=kMHkayiF; arc=none smtp.client-ip=54.240.7.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725965475;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GzLfsDTUMMdGBR6iRZk3PPetRE7pbsieNX4s440SIME=;
	b=PxGpsdaOdQBWV7m9CIhBM9JlmLhz5JMsmQUlGP8N5v8Y9oIVTR0RFbBlBuDsxeT9
	6vJGeYX5IagBQ6Sd8MEqyLlKK+wtjzNXd9u7HyZ7G8s9YPzRf6qbZI3khaPsNvyJWdq
	sKT8aSUi7UFQ+VFgD3fzOzTwXiro4KiNlhLevCww6jyRJ6KOZ9qIOd5llRPXCQGe8HQ
	EquRXTovzmEEWF1ZjbUU33IVj+V/hbtgvLz8DlHQPkn/7xSp6/flCcdFJFXKEmzgrgC
	RP+FsVe9dj1WXfmdqpfuI6HY70SEOYLjkaLMaIG3MHTOWGquR2DJHzyBHO3qoo05yK3
	nFkBIO5fIg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725965475;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=GzLfsDTUMMdGBR6iRZk3PPetRE7pbsieNX4s440SIME=;
	b=kMHkayiFMkMVnmlgjx8D/5URNc9QKyae7D04k9yWaQFd9/dmzXUVj2fOK+TCK6ra
	6ZF3pgR0TnQPaQVJ02GhUjeP7OnbzmcOYdVrWl9YpjasfSVOed4YzwhPUq6OUdoEKN2
	DPOmbcw2zdip+OO4RUpvjvuqx4EIIElvD7dGQfTA=
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, shawn.sung@mediatek.com, 
	yu-chang.lee@mediatek.com, ck.hu@mediatek.com, 
	jitao.shi@mediatek.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org, 
	kernel@collabora.com, sui.jingfeng@linux.dev, michael@walle.cc, 
	sjoerd@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>, 
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v10 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph support for board path
Date: Tue, 10 Sep 2024 10:51:14 +0000
Message-ID: <01020191db8f1c5b-75771ca6-ad57-4568-96c9-b97353248de2-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910105054.125005-1-angelogioacchino.delregno@collabora.com>
References: <20240910105054.125005-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.10-54.240.7.41

Document OF graph on MMSYS/VDOSYS: this supports up to three DDP paths
per HW instance (so potentially up to six displays for multi-vdo SoCs).

The MMSYS or VDOSYS is always the first component in the DDP pipeline,
so it only supports an output port with multiple endpoints - where each
endpoint defines the starting point for one of the (currently three)
possible hardware paths.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Tested-by: Michael Walle <mwalle@kernel.org> # on kontron-sbc-i1200
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/arm/mediatek/mediatek,mmsys.yaml | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index b3c6888c1457..3f4262e93c78 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -93,6 +93,34 @@ properties:
   '#reset-cells':
     const: 1
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      Output port node. This port connects the MMSYS/VDOSYS output to
+      the first component of one display pipeline, for example one of
+      the available OVL or RDMA blocks.
+      Some MediaTek SoCs support multiple display outputs per MMSYS.
+    properties:
+      endpoint@0:
+        $ref: /schemas/graph.yaml#/properties/endpoint
+        description: Output to the primary display pipeline
+
+      endpoint@1:
+        $ref: /schemas/graph.yaml#/properties/endpoint
+        description: Output to the secondary display pipeline
+
+      endpoint@2:
+        $ref: /schemas/graph.yaml#/properties/endpoint
+        description: Output to the tertiary display pipeline
+
+    anyOf:
+      - required:
+          - endpoint@0
+      - required:
+          - endpoint@1
+      - required:
+          - endpoint@2
+
 required:
   - compatible
   - reg
-- 
2.46.0


