Return-Path: <linux-kernel+bounces-571460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EFAA6BD6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A458188A368
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7521DC745;
	Fri, 21 Mar 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="rqXRScU2"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2051D5CD9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568353; cv=none; b=DXO/AgNwVpnXPjAPrsnRyR4tEVF5jMnl8GSxFp37zLHJ1hVNj4jDRxYaIPDMcDCizNg3E9gVnWiSnV+ogA/NBMifNRJ1af9EUbeVtVNbn8bbZ8xVtXlOFq7EjMKRSFqBC/LAMtqjbSRL7YgkB219XWXI7gItbSdnMgBIxLQymHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568353; c=relaxed/simple;
	bh=GLAsUw1OONraXoc4O2AxkqLiMT4MdPKRGHr5nbrSBI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yy9zS3abRH0XdyRPIqXgZxcrpmzsbfd4gyvmox9tCR0NGdnq1UIoP4yFPpntZy3uspGiJalCL824ySLqv7naD06WNOgJd7AINuCH+nURCU/qJwwPBcVN4v48tNg6+I0nUywxzjfGNN2IFBy4uiuW6eylNNSsnloMXx/p7lh4Lpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=rqXRScU2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so3066264a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1742568349; x=1743173149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHERlL971lhRhRNPhw773ZN7phaB0MazKYjf9mnRkOo=;
        b=rqXRScU2DtXHdaciscHnD6KSOKHbxpgIVAGJgAVdUyoF627tNp+VP0sjIqJ9I74l1a
         fYdxqhF2wgbIxtXKgDtPcqZ78D5opVnyAE7wy2d3s3KfWYlvprimXVmrOadae74kxiiq
         9ojxWKaJD4PoBvNHZsjXE5O8yZZNPjcAkkJLPrXsJbNTDd5gvl+itlUxDeizIlTRWvA/
         H3qSvveniv5qWc3UNGiJMCdKNCnod2mVjiI9oTZ2fVE/TdI4iRK9UGg0U1IpbL1F4J96
         cf4qPO/XL31S+QQ8m09L1N0VpDj2SrWcwo0KMb3ctG3wxIXtzr9bVhseh/x26ddvSY8e
         1AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742568349; x=1743173149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHERlL971lhRhRNPhw773ZN7phaB0MazKYjf9mnRkOo=;
        b=tTtlVQYByotAGfcM9H7JyO4jUPXNlHMrG782uZ1FlB2+lGPfm+A8Lrr0ono+NeWYzy
         TzQ1i79yE6ZIvVuyEdBQiodN/aqxRu4N8vshTxjIdLkZ0upyBVvGerdmO0T7BmDp1Htm
         /WlHUaZHKRzIkLhj98G5kTzpRY2AkOX7QkNW5ATWCaGhJb1vMyRndvxAfIn/XsfaVpjw
         2oPsVsVa36oUmi3qEKtsR8kwzulaD1f9F5tAsc4Yz8iGUWhGhJM/1ftmeRtJXcS2XJmW
         SkHpISqptIGisPpT+JxVSZceOMdZAWQS04jn35VB+ssA0xuiBUzj20qoIBKTMBIPdw8P
         Upfg==
X-Forwarded-Encrypted: i=1; AJvYcCVj5SHMyVOY2y7hHV3PSyH+bIf+j2GTfS1KDSk9uV0iRv0EiVbFeTdsmeod/tJl7luqcGI0jMolybj2+7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xX3FPWxXyM+H9W39UU5eoWCU4DV1OO9XS0PzUFDpPH4mSg9h
	OJbXxpvAMkcpSeGvWH/ouUKcbt3BR88opdnJjx0Y6QtJxJrUj8spZ+TM7p3V148=
X-Gm-Gg: ASbGncs2aRZqOWn0eU59x5d3CnWc/Oc9e6jKnF5R1Vq2V65uHwTg4s5FcvUrBU9qvTG
	6Jz4z4G9WtwXrFQ7J66JR1NXy4/mZGuVCgfkN24ER19dTZNnF/BKC1PsMMhoPbYCti4iXO/eY2n
	fNEIKk/WimW78M2Dyb9rxuYhtiWziMU4LnuNK4/oFd4woH8T3BWWUmJ0djREOFzsSa99HHjHzyw
	tn8L17NFItd45Bops7IggHruydykaKJMiUZvuChRgAdBhlxCPQrCBnOg6qiPE8LhYuDAQ1XKnf0
	ygze5q3+PicSP4wb4aJuzNDntX85OJMd7mTcm2UKwueR8ss7qrpU9fbjVIgN+cFmS7iJWVS05m0
	J6hcRQGTyl5CHfFcTYewoRhyBW8sp
X-Google-Smtp-Source: AGHT+IFqAX43/zq/hujHzHnH37P90RVIE+VluZyGm3/YhAvwrRM7pYjzxeNBMWHwFGfVNM0d7l7R3w==
X-Received: by 2002:a17:907:7f8c:b0:ac3:cad2:9e53 with SMTP id a640c23a62f3a-ac3f28053b3mr412540766b.55.1742568349002;
        Fri, 21 Mar 2025 07:45:49 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb648acsm168092466b.98.2025.03.21.07.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:45:48 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 21 Mar 2025 15:44:59 +0100
Subject: [PATCH 1/3] dt-bindings: clock: add SM6350 QCOM video clock
 bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-sm6350-videocc-v1-1-c5ce1f1483ee@fairphone.com>
References: <20250321-sm6350-videocc-v1-0-c5ce1f1483ee@fairphone.com>
In-Reply-To: <20250321-sm6350-videocc-v1-0-c5ce1f1483ee@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

From: Konrad Dybcio <konradybcio@kernel.org>

Add device tree bindings for video clock controller for SM6350 SoCs.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
Co-developed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/clock/qcom,videocc.yaml    | 20 ++++++++++++++++
 include/dt-bindings/clock/qcom,sm6350-videocc.h    | 27 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index 340c7e5cf98024dedad6d7db4fea10e9f8077419..5f7738d6835c4ba999402e163fc85a07e3a47a5a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -14,6 +14,7 @@ description: |
   domains on Qualcomm SoCs.
 
   See also::
+    include/dt-bindings/clock/qcom,sm6350-videocc.h
     include/dt-bindings/clock/qcom,videocc-sc7180.h
     include/dt-bindings/clock/qcom,videocc-sc7280.h
     include/dt-bindings/clock/qcom,videocc-sdm845.h
@@ -26,6 +27,7 @@ properties:
       - qcom,sc7180-videocc
       - qcom,sc7280-videocc
       - qcom,sdm845-videocc
+      - qcom,sm6350-videocc
       - qcom,sm8150-videocc
       - qcom,sm8250-videocc
 
@@ -87,6 +89,24 @@ allOf:
             - const: bi_tcxo
             - const: bi_tcxo_ao
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm6350-videocc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Video AHB clock from GCC
+            - description: Board XO source
+            - description: Sleep Clock source
+        clock-names:
+          items:
+            - const: iface
+            - const: bi_tcxo
+            - const: sleep_clk
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/clock/qcom,sm6350-videocc.h b/include/dt-bindings/clock/qcom,sm6350-videocc.h
new file mode 100644
index 0000000000000000000000000000000000000000..2af7f91fa023bed469bbb2c071d93383dba29441
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm6350-videocc.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM6350_H
+#define _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM6350_H
+
+/* VIDEO_CC clocks */
+#define VIDEO_PLL0			0
+#define VIDEO_PLL0_OUT_EVEN             1
+#define VIDEO_CC_IRIS_AHB_CLK		2
+#define VIDEO_CC_IRIS_CLK_SRC		3
+#define VIDEO_CC_MVS0_AXI_CLK		4
+#define VIDEO_CC_MVS0_CORE_CLK		5
+#define VIDEO_CC_MVSC_CORE_CLK		6
+#define VIDEO_CC_MVSC_CTL_AXI_CLK	7
+#define VIDEO_CC_SLEEP_CLK		8
+#define VIDEO_CC_SLEEP_CLK_SRC		9
+#define VIDEO_CC_VENUS_AHB_CLK		10
+
+/* GDSCs */
+#define MVSC_GDSC			0
+#define MVS0_GDSC			1
+
+#endif

-- 
2.49.0


