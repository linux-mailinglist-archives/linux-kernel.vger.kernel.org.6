Return-Path: <linux-kernel+bounces-525618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 479C5A3F251
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B4D3BF4C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ED5207E0D;
	Fri, 21 Feb 2025 10:42:30 +0000 (UTC)
Received: from out28-195.mail.aliyun.com (out28-195.mail.aliyun.com [115.124.28.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B71FECC2;
	Fri, 21 Feb 2025 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134550; cv=none; b=M9v69T2ry0gjo0eu7CT3nDf+19m06ozFxRw4dP29THDCqF3g5lrw3f+bchtepIaoaV+j2fpPCzOfZTJ+IR/CDxnibJvyyx+hJWUTfm2ehZhYXUs7eOBpZEqY8J1kZQADy4hHs1e4zooY+c/o8G3tWDVcSFkSgK31xV1Ss88X0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134550; c=relaxed/simple;
	bh=P/dnMhKBSL0cZoCTmCfRWmg71/OvQydkqUcu4vFPKJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpoUpI77qPEIUXlgXmh8qTDY2CwiUgQDetwGiePm8N2Ja+TckHOqkXbzsmYxLMLQixxIxAC/kx7RAUtmdG766MMXk/CPFkU7MdYeadpXAigcHk767AOcakfv7fS9bt/UW/CZfr8Fmrljc9oarADR1e8oVY+WotWBYeoJ6H/fATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.bYUQxP2_1740133591 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 18:26:35 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	rf@opensource.cirrus.com,
	jack.yu@realtek.com,
	ivprusov@salutedevices.com,
	zhoubinbin@loongson.cn,
	quic_pkumpatl@quicinc.com,
	paulha@opensource.cirrus.com,
	nuno.sa@analog.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V1 1/2] ASoC: dt-bindings: Add schema for "awinic,aw88166"
Date: Fri, 21 Feb 2025 18:26:22 +0800
Message-ID: <20250221102623.369435-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250221102623.369435-1-wangweidong.a@awinic.com>
References: <20250221102623.369435-1-wangweidong.a@awinic.com>
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


