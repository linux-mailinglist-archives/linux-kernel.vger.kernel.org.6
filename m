Return-Path: <linux-kernel+bounces-509920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFD9A31608
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BE61889701
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB5265634;
	Tue, 11 Feb 2025 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="c+gXPHYR"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE6126561B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303680; cv=none; b=OeGZAywxm7YKLqf0FiZVN/Sq5t1yptNTqvueLaeQ7EPGpJ7sEPSDC9Ry20ysER0S3r7uuZwmCHf1pyRcnK1+dKGd3qSWlkarc/02KHDmgcM3LYcVSHOvqh+mYmxm4mHP4ZjO5qlEW/uxLXCodoAw6IBZ24r2Yc1dyEfa5vt9qE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303680; c=relaxed/simple;
	bh=pFpf8dL5ADZfvFnoqSP2NvXLSTIOTz1Wa6whLoN7LuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EJZsmsADnjiwVa+Q+3DbUK32hIsbUD7NK1fA8gPT7nZF9DnoTDTfM48Cn9HSccWD+VIOEe0kwv/p613ewNvWU7Tsg3fBaw0Fz1nerf+4SpIF/lS28L+iSfhYXEZywRQTqgjLimWa/HJb94+bVNBFDaxEt47mFLj6TXxFRWfXw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=c+gXPHYR; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739303676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9z3aAv8IagfPXTqvWHznNbHWmTyNuVAlNgwMD8bOopE=;
	b=c+gXPHYRXLFvGM7DA1cUyWXIsY1fL2QlNrQv+qo+cy+YuIKJRaYQmfX5TXPD9S25GhPzgI
	rGD9XAFOgED3gMWGl7QVBFwXlPx9kRiFE4vrbdSi2mUluO4paEZf0ZU8D/K9hVJYxoREFR
	THXO9Tw8To2Slxj7abSFgSI5GqN55ZFInxWkenTCtYKHqhMcDppzvIIjHKlHjv3Xw2etCw
	hbWRSAl+Nkbpf3hPkCahb9CVLVEwNzl18JuWnuqa5x31DN3O56wg+7i6k+8l4yERRZfjTc
	T6CmwO46lScEVf4lNT+y4gV+u75X3UdoT6hbt8Mfrnv5Sc7JkBB+MMssNcma7g==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Tue, 11 Feb 2025 14:54:26 -0500
Subject: [PATCH 1/7] dt-bindings: pci: apple,pcie: Add t6020 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-pcie-t6-v1-1-b60e6d2501bb@rosenzweig.io>
References: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
In-Reply-To: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Marc Zyngier <maz@kernel.org>, Stan Skowronek <stan@corellium.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=788; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=pFpf8dL5ADZfvFnoqSP2NvXLSTIOTz1Wa6whLoN7LuU=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq6r1TeeVHZs1Xd12TSUBL6/EGOnx4tDyU6cMg
 OlYJ/9tK9yJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uq9QAKCRD+/lBaCvVY
 DdKxD/9rD0CnxsgdepfE6OswMxwTF4VjruMeWCA6bEaPLzpHPU+237FDLpVVWeJGnkDpLOY/r5I
 kS1dAHlEFPfwD7jwwqmW6Kwx/5COt5GE0RcDDxjdGY7GX9Tw16alajpKqqSLGgRUlpYc1sMl+Kj
 E84JOrk3z4uutDS5oqCZw458sRgEUmjcKfh1dkA4/MuLkMlj+ADav6JCr2lgcHrZIb/CBixPbFs
 dAbGIJJ6ePr9fpTrXVZj4LUxMljCTi009B2EW3vnfSRe5cdlpjGsR5uc7fJw9K3ByFldsaHgbLI
 1lMcYf1FDm/c1dJAunf02CSgi1ZWUIvMFyAoyUGQXGpNyTUyeLdKfYTh+SdUBiLuIZzl0OcbXau
 kgEMnXqTpmJU0xuKtLhLrdybTkFid/9frs0dZJUsXuxi0R2R6n3jEiNODLsc3+tQsfJoTpMg1RB
 xAFSs0lGmPRWyDNSLRbMUDf4Pe3K43WEs39uj96bf/7O0WKOh49SoHirE+XrjJXijK/g1HGUwbh
 watKZzg7cNHN957cBKH+nAzA1Gvmd6e0H9zSm2GRmLd+J7nXktn6xKTzqwTnDQSYJm69Mbw8k3n
 DILYGrbsxTSfbe2VpH8DgRq1f46+Ca6I1lTdFrDRlSpvKXCd1l2dR05A9CJXxajvwUzTbFZRiuB
 Z/CfA9cCixoB9iQ==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

This shuffles some registers versus t6000, so requires a new compatible.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 Documentation/devicetree/bindings/pci/apple,pcie.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
index c8775f9cb071339dfa6f17f9f4a99f031c98b70a..4885788ff623eebe6a79bccc0f8a9a231a01c5ca 100644
--- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -35,6 +35,7 @@ properties:
           - apple,t8103-pcie
           - apple,t8112-pcie
           - apple,t6000-pcie
+          - apple,t6020-pcie
       - const: apple,pcie
 
   reg:

-- 
2.48.1


