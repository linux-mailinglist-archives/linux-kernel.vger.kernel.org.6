Return-Path: <linux-kernel+bounces-557663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57210A5DC22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90ACE17A03C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173DE2405E8;
	Wed, 12 Mar 2025 12:01:37 +0000 (UTC)
Received: from out198-12.us.a.mail.aliyun.com (out198-12.us.a.mail.aliyun.com [47.90.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490622A4DA;
	Wed, 12 Mar 2025 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780896; cv=none; b=VAqZrvTTyQGctTdRbQE3vrHi7a6CF+rOUF0O112YYzkUYrO7nbWFNSeH6/7QvT8ueMSV2VLazz2QzXuFDkXVIB6GNDjWZ26N6CD75fru6sLo/6cHYF5BaKANQSs4DGu0bZxAsarc9WHMVCoYk52zJCL1eakGw6QcI17lVV5BOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780896; c=relaxed/simple;
	bh=pWc74shK32lkZhQiSfmvUI+todDZaRyyNXPcz4+zklc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udeomX8qGKrgc1aUAGHW6h2vlhGyLOcV7jiq30/Y9NM3yPf8ZJFcZw0hlnskWWbchQfOD2KaBO0/2jOIMVT72z6Iw/yhIKKAZ/JRWH8ipPukWsYRgUHEhUbpqhD2f6A0+cnOnmp9rIhZNE3Pj7AjN6A2DS0sJ8+6xRcBE74fFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.brTSovc_1741780867 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 20:01:08 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	jack.yu@realtek.com,
	rf@opensource.cirrus.com,
	neil.armstrong@linaro.org,
	ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	quic_pkumpatl@quicinc.com,
	herve.codina@bootlin.com,
	masahiroy@kernel.org,
	nuno.sa@analog.com,
	wangweidong.a@awinic.com,
	yesanishhere@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/2] ASoC: dt-bindings: Add schema for "awinic,aw88166"
Date: Wed, 12 Mar 2025 20:00:59 +0800
Message-ID: <20250312120100.9730-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250312120100.9730-1-wangweidong.a@awinic.com>
References: <20250312120100.9730-1-wangweidong.a@awinic.com>
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


