Return-Path: <linux-kernel+bounces-371381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E819A3A56
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45451C208FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35DF18660F;
	Fri, 18 Oct 2024 09:43:55 +0000 (UTC)
Received: from out198-16.us.a.mail.aliyun.com (out198-16.us.a.mail.aliyun.com [47.90.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A61FF7C8;
	Fri, 18 Oct 2024 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244635; cv=none; b=KgCvkcECYYmzXH/gw/C3g6jBc5oyrP/3KVQAYMM4wTR9gRASTcNnflvY3IX77OKpIIC1ah3VCcZqaOtZn6jJk0gme2xZo8Sr1aXtL6YwP2/N1efjZEAMarlqTyDcQpso0YQ2KB3OixeYtEfDCweNgsuiCPqAs6TaEhaBEwjJSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244635; c=relaxed/simple;
	bh=lKIQneQS3w+FKKQIpVx5TpsAD7ZlnChbfi6P/4mo3gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkVP12igNhyusD5A9ChDOKS8kjTt4LlkW7X6eqbI3MN6KdWpCMJD5lSzKqNlnCWEkD8ycu58j+1NeT2KIch88AkZWss23EXAeKTjHO90zykz+PAuyPxlG3zhoYyj8dROBOcWwzULvEeYSFCfXYykerAyPqxOHw2j9mxfJXxZiIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.ZmCbDW0_1729244610 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 17:43:35 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	rf@opensource.cirrus.com,
	neil.armstrong@linaro.org,
	pierre-louis.bossart@linux.dev,
	luca.ceresoli@bootlin.com,
	wangweidong.a@awinic.com,
	arnd@arndb.de,
	quic_pkumpatl@quicinc.com,
	herve.codina@bootlin.com,
	masahiroy@kernel.org,
	shenghao-ding@ti.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V1 1/2] ASoC: dt-bindings: Add schema for "awinic,aw88081"
Date: Fri, 18 Oct 2024 17:43:18 +0800
Message-ID: <20241018094320.113477-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018094320.113477-1-wangweidong.a@awinic.com>
References: <20241018094320.113477-1-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Add the awinic,aw88081 property to the awinic,aw88395.yaml file.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 Documentation/devicetree/bindings/sound/awinic,aw88395.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
index ac5f2e0f42cb..b39c76b685f4 100644
--- a/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
+++ b/Documentation/devicetree/bindings/sound/awinic,aw88395.yaml
@@ -20,6 +20,7 @@ properties:
       - awinic,aw88395
       - awinic,aw88261
       - awinic,aw88399
+      - awinic,aw88081
 
   reg:
     maxItems: 1
@@ -57,6 +58,7 @@ allOf:
           contains:
             enum:
               - awinic,aw88261
+              - awinic,aw88081
     then:
       properties:
         reset-gpios: false
-- 
2.47.0


