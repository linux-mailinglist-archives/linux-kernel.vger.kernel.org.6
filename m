Return-Path: <linux-kernel+bounces-537728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F86BA48FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595953AEAA0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792511A08B5;
	Fri, 28 Feb 2025 03:55:51 +0000 (UTC)
Received: from out198-10.us.a.mail.aliyun.com (out198-10.us.a.mail.aliyun.com [47.90.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2311B5A4D5;
	Fri, 28 Feb 2025 03:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740714951; cv=none; b=HHAxABUE1D6z46mBmOcqPH5NmCr1pNHlr/9A2CU6YrhE2ufFpgJFXX7gBlJllDYZH/M75qtMzmrP0Vppn4YrBtIkz2YT4PNVHj2Rx9N6qYasCn6Hs7NCs+oVrHqASstO0iAKXKkxJ69sZAHVKhsmTRqUtlS7gMUU81LDdZ47bsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740714951; c=relaxed/simple;
	bh=pWc74shK32lkZhQiSfmvUI+todDZaRyyNXPcz4+zklc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY7pUYpod0r/JtzkmfHqKlEH6rtbl0DkPuq/THwBt74UBuX4WXAVe3fjmh35t9iwZK0cSTlYFcyOSHzpe+yomyH9Q5PtIdwH8vHXdqswKz2rRtwNF5Jq1AcxjdcBg4h7fIj/Byhtp0Pg9EPCF/6l0UVUBH9sxuljaKtYdevRnn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.bfYTb7K_1740714605 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 11:50:11 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	ivprusov@salutedevices.com,
	jack.yu@realtek.com,
	wangweidong.a@awinic.com,
	zhoubinbin@loongson.cn,
	luca.ceresoli@bootlin.com,
	quic_pkumpatl@quicinc.com,
	paulha@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	nuno.sa@analog.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 1/2] ASoC: dt-bindings: Add schema for "awinic,aw88166"
Date: Fri, 28 Feb 2025 11:49:57 +0800
Message-ID: <20250228034958.181934-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250228034958.181934-1-wangweidong.a@awinic.com>
References: <20250228034958.181934-1-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Add the awinic,aw88166 property to support the aw88166 chip.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/awinic,aw88395.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
index 6676406bf2de..bb92d6ca3144 100644
--- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
+++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - awinic,aw88081
       - awinic,aw88083
+      - awinic,aw88166
       - awinic,aw88261
       - awinic,aw88395
       - awinic,aw88399
-- 
2.47.0


