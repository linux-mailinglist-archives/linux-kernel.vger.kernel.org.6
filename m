Return-Path: <linux-kernel+bounces-185719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626D68CB9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAF02844CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AAD745FD;
	Wed, 22 May 2024 03:28:14 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2543745E2;
	Wed, 22 May 2024 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716348494; cv=none; b=ng0kuvVMdVEfR/Ude8xnmC+0vL96xIl65O4ahtGn7fNS8vro7Vm/i10f7tcPKvqknf/o2jBEWQflPAuqFPXBBPQYBkyg+G8MwAxuQGNK6w9uHADGo7ulVacr1QU6uVJBJqnCzhE8aWBhzHlXOAAHzV0VF9A67L2suyKzZXixgKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716348494; c=relaxed/simple;
	bh=Ug2fwqEk1lUlgVtk0e0kPinWvQZFw3b4L8Si9bGSvS4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=Lr9lBfdbtmDyLR4eRBzZzeUffKYNELZWoL4n8zyEDNJD0Tnzb9GyHDXmmqxzRz8kY2l85YzVXyEELGPSxKyBrvgs5bCf7CKA4cmcWpLY+31V5vAB1jzYWQGsYPiGgvr/lkwHYcd3aqPzK0SmowBdhoJaXKEMZBt+qGAdXF00oYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 53D5A1A0E3C;
	Wed, 22 May 2024 05:28:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 177B01A0E5B;
	Wed, 22 May 2024 05:28:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 24FC31820F77;
	Wed, 22 May 2024 11:28:09 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] ASoC: dt-bindings: fsl,mqs: Add i.MX95 platform support
Date: Wed, 22 May 2024 11:08:24 +0800
Message-Id: <1716347305-18457-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1716347305-18457-1-git-send-email-shengjiu.wang@nxp.com>
References: <1716347305-18457-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There are two MQS instances on the i.MX95 platform.
The definition of bit positions in the control register are
different. In order to support these MQS modules, define
two compatible strings to distinguish them.

As one instance is in the always-on domain, another is in the
net controller domain, so the compatible strings are
"fsl,imx95-aonmix-mqs", "fsl,imx95-netcmix-mqs".

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,mqs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,mqs.yaml b/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
index 8b33353a80ca..030ccc173130 100644
--- a/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,mqs.yaml
@@ -23,6 +23,8 @@ properties:
       - fsl,imx8qm-mqs
       - fsl,imx8qxp-mqs
       - fsl,imx93-mqs
+      - fsl,imx95-aonmix-mqs
+      - fsl,imx95-netcmix-mqs
 
   clocks:
     minItems: 1
-- 
2.34.1


