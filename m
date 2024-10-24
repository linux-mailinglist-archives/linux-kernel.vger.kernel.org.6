Return-Path: <linux-kernel+bounces-379534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E69AE00F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BFE1C219EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F31BE223;
	Thu, 24 Oct 2024 09:03:54 +0000 (UTC)
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407F1B21A9;
	Thu, 24 Oct 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760634; cv=none; b=FvbtKsGOe00RwH+xXDgT9s0dcR6yh4zUicmqHNrMb/VA1+EAOYyhZ2IVvYUBXMq5gPfy28YOf3F34Vrfk9Eq09ThZfM1czODgLs1Kx1ki52yTEJ327YNRd/bvRSVKAH5aBtB8Auz7D3rxCkQLaombAcUMLLi62a/b/6VnWDigkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760634; c=relaxed/simple;
	bh=TcA6J9JU98+Wd9tM98/wzW/CN3AG10blL2YeVDo3iI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsmpwSqixkZVBWCa24md86AvpAKimfWgRGjU+pqcBATNvmKJj7qtwHGs66fSVcDVFZBAT1Y5gaMXNsJdnBNCdOOMigb1zihb5FErGt6niKPTsIzKr4hu21iU6/EAyNyWhqAji03BFRBQwC6oT3pCi3t8ufjyDTX5eR+CBPk2NAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.ZrObrs-_1729760616 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 17:03:41 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	neil.armstrong@linaro.org,
	rf@opensource.cirrus.com,
	arnd@arndb.de,
	wangweidong.a@awinic.com,
	luca.ceresoli@bootlin.com,
	quic_pkumpatl@quicinc.com,
	herve.codina@bootlin.com,
	masahiroy@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V2 1/2] ASoC: dt-bindings: Add schema for "awinic,aw88081"
Date: Thu, 24 Oct 2024 17:03:23 +0800
Message-ID: <20241024090324.131731-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024090324.131731-1-wangweidong.a@awinic.com>
References: <20241024090324.131731-1-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Add the awinic,aw88081 property to support the aw88081 chip,
which is an I2S/TDM input, high efficiency digital
Smart K audio amplifie.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 Documentation/devicetree/bindings/sound/awinic,aw88395.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
index ac5f2e0f42cb..3b0b743e49c4 100644
--- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
+++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
@@ -17,8 +17,9 @@ description:
 properties:
   compatible:
     enum:
-      - awinic,aw88395
+      - awinic,aw88081
       - awinic,aw88261
+      - awinic,aw88395
       - awinic,aw88399
 
   reg:
@@ -56,6 +57,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - awinic,aw88081
               - awinic,aw88261
     then:
       properties:
-- 
2.47.0


