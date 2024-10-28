Return-Path: <linux-kernel+bounces-385167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06FB9B3363
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2201F243E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB621DE3C7;
	Mon, 28 Oct 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWoduNTd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F21DA631;
	Mon, 28 Oct 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125388; cv=none; b=H2kVzgIAwFN8zLPbf5t+tRKjg0q41QlhUTWfEGRYEK/mAo0R7oXtuXCL6VNLf15HFjFZ5qrWWQPci5tYtKVzZlrmRN93niUS9NQDOoUeX3yBNM33C1tvm5rzJ6wMWsQtH4V0/5p/+9K2c+2XxdqrWGkA9CqE4o5D7F7CP0ppI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125388; c=relaxed/simple;
	bh=70JpgkYvN9YM24Jz+FtvScOfqAM/jZI33kSB5+f8jrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HT2BEox6k6gdv2Z5FMOcFw+agzM/OVEXSPUZSODeCt/Ecr7vfcA7ro+uaPY/4opQGNXdb8QJVq1s2iTlky5AdnEQrBJFk7wCiMshC1WKh/bBQ7ldyg2AKjfS49QqTS1TbWyFFOePNPGLHv88AC7LbMeDq/Wt958oEK37QCPxlRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWoduNTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4680C4CECD;
	Mon, 28 Oct 2024 14:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125388;
	bh=70JpgkYvN9YM24Jz+FtvScOfqAM/jZI33kSB5+f8jrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uWoduNTdbhD9TXD1VwGSVhid/JfbNZDhhSTtQ+Zs3ioRGg6tvVfDDsO7n6Ybo/UJl
	 NsxIokqQOYhAL4WSF2svmo6fDJ32xwI3BhJ4nntHQH/9m04sMJzuX8t4AytmOrUT6S
	 IxWlHolrSrED7yOnX/7n39zdEROIZr2p1dIlWx7wY+W7sUA86CfxB2bGLD+pOaaf6A
	 banm0ijjslbav+xsnj1utuXglFa/F/XmiZcKG1MexyAYqAZyvIQH0RfdF7NOp1l8JX
	 pN++CrTWodTvybBb9bEtYQ6Taw6kleIsLkJw3qOrLTxSI2wILjGwQQQgLV2ktbpqE8
	 GOTAT3N1G8tKw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Oct 2024 15:22:57 +0100
Subject: [PATCH 1/3] dt-bindings: arm,psci: Allow S2RAM power_state
 parameter description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-topic-cpu_suspend_s2ram-v1-1-9fdd9a04b75c@oss.qualcomm.com>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
In-Reply-To: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730125380; l=1434;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=qowdcUV0IcXfH3TE+fGW1N5ucMJrGFxOqfTc+GjqJNE=;
 b=PkrsrLQrYHBH3Z0pNaW3PK242z+Gnl0VhBs6CQJrIOlHjhysAG9+Zc9b2RC7ghkCCjFg5lCTT
 bin1KT4oKNJA+UZHJeDOPleGn5YYe0DX/fXojY3JnSxnRIA+8yqJTag
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Certain firmware implementations (such as the ones found on Qualcomm
SoCs between roughly 2015 and 2023) expose an S3-like S2RAM state
through the CPU_SUSPEND call, as opposed to exposing PSCIv1.0's
optional PSCI_SYSTEM_SUSPEND.

This really doesn't work well with the model where we associate all
calls to CPU_SUSPEND with cpuidle. Allow specifying a single special
CPU_SUSPEND suspend parameter value that is to be treated just like
SYSTEM_SUSPEND from the OS's point of view.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index cbb012e217ab80c1ca88e611e7acc06c6d56fad0..a6901878697c8e1ec1cbfed62298ae3bc58f2501 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,12 @@ properties:
       [1] Kernel documentation - ARM idle states bindings
         Documentation/devicetree/bindings/cpu/idle-states.yaml
 
+  arm,psci-s2ram-param:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      power_state parameter denoting the S2RAM/S3-like system suspend state
+    maxItems: 1
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#

-- 
2.47.0


