Return-Path: <linux-kernel+bounces-439177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29A29EABEE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3E41887437
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F04234964;
	Tue, 10 Dec 2024 09:27:17 +0000 (UTC)
Received: from out198-20.us.a.mail.aliyun.com (out198-20.us.a.mail.aliyun.com [47.90.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77AF22CBE5;
	Tue, 10 Dec 2024 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822836; cv=none; b=nuBPHQcfH5jSIKKrvAMOz37aERrlEQ1UfXfVWmu0iAD+pol3YHxmuQTsHBRUgh5Q81s+s/PDMN/PZZ/elgCsbWqUoUDp3+zBtVBkl2WIP7cSs+1K0CJjtboI6lojpZOvfGELtBhfkyewVtFoz446AYbsM9mPh312k32p6gvtFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822836; c=relaxed/simple;
	bh=r6oSj83dD7x4l3sylY832J7bgOw+MsHJdO7sBgm1K1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkI/Lt7h0LbJxkKv586wqMe+klsmatuEyn09jeJefS0hP8MllcVzttsFpoWZwW913o7a4zdjwNnU2XoHGLbzGSpZkMBjnHHtylvOGDeHNvBChSWmU7M3m+X3H5Ye57WnyIHcQmI7Rac2qURQ3rIexnym9F8f1fCKtuqkPSuvhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.aaFUBsZ_1733821864 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 17:11:10 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	rf@opensource.cirrus.com,
	jack.yu@realtek.com,
	neil.armstrong@linaro.org,
	ivprusov@salutedevices.com,
	zhoubinbin@loongson.cn,
	wangweidong.a@awinic.com,
	quic_pkumpatl@quicinc.com,
	herve.codina@bootlin.com,
	masahiroy@kernel.org,
	nuno.sa@analog.com,
	yesanishhere@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V1 1/2] ASoC: dt-bindings: Add schema for "awinic,aw88083"
Date: Tue, 10 Dec 2024 17:10:53 +0800
Message-ID: <20241210091054.88779-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210091054.88779-1-wangweidong.a@awinic.com>
References: <20241210091054.88779-1-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Add the awinic,aw88083 property to support the aw88083 chip.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 Documentation/devicetree/bindings/sound/awinic,aw88395.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
index 3b0b743e49c4..6676406bf2de 100644
--- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
+++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - awinic,aw88081
+      - awinic,aw88083
       - awinic,aw88261
       - awinic,aw88395
       - awinic,aw88399
@@ -58,6 +59,7 @@ allOf:
           contains:
             enum:
               - awinic,aw88081
+              - awinic,aw88083
               - awinic,aw88261
     then:
       properties:
-- 
2.47.0


