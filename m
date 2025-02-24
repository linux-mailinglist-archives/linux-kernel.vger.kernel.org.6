Return-Path: <linux-kernel+bounces-529229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B52A42232
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136673B0FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84497254845;
	Mon, 24 Feb 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM52n2M6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871724A06C;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405064; cv=none; b=auv3P8VTytZXbO0oRz+kUMljUxFLi2tTvrKQgnCVjK8n7A+KjFXVtUJv3pDzPtR9p3jhTFQERrzb0B1F3Sj4PSLqFy1Y2upw6pAjBaT9w7MgcYC2cAuWIWVOt3M86T9eCa6UPB9zbk6Z4nfpRLC5Q0ue5B/flyP6tJAEfgcAHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405064; c=relaxed/simple;
	bh=pZKfDA3ali55C1jq54Pf/O8lGAmzjSBZ65ftlVmOLmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gaCdNIaO82XRpaeqcjaYyhQreoMTMNYWY1f8aOacpYEjPsC+DMr/cguQgV+aLJImzAVld+bAf9FF8PG/uZizltS+4bDpgOaLNJiCe2osfFrTV13Io0R5FjbrR7WGYkQGvLBX4zL6yNiUAptaj3ljEQfLyUeEduuGV5362KXmNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM52n2M6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56299C4CEED;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405064;
	bh=pZKfDA3ali55C1jq54Pf/O8lGAmzjSBZ65ftlVmOLmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cM52n2M6D8g8xJjlTRy3CFPc8+QvvP40luSWKnZyOHyrE6ahQSF7fEMvpwIUQ53HT
	 qnU0HJWPI/V+8NmAhwrll8fjJ7OpUYascWVsTSYmnMXRebfbRajeTr6ICLv5EGrc8U
	 VbGj01J8660oNcoEsMar1KuRjlP7Jtdw/WXkMrhuEbCXTfZk+B0xMjpRto6y6tOkjX
	 9PLYLO9ToTM5Rfk1BW21ux09KgiAgtbvJLkFVoiqxiZ5wSF7rKOasOB9qe4vtnH179
	 MupX4QiUPqqkFKwB/LyDFaoPiArmpz739ZG24lSxZkfzSVAdel2ZZtim/idUqek0/6
	 HXVQFNQJEwDnw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB12C021B5;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Mon, 24 Feb 2025 14:50:54 +0100
Subject: [PATCH 04/14] dt-bindings: vendor-prefixes: add GOcontroll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-initial_display-v1-4-5ccbbf613543@gocontroll.com>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
In-Reply-To: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740405062; l=973;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=GJs6pNBexRn96NM+OGXxZUfK9O73xNA0YJNFsc5BkjU=;
 b=IJEmmCyq9UEKO0tAanMOCXF7YyKSMtNx5xwL9il4SoqOZ0zccX5GR4svLEQ+D5oAUtrxo2Flu
 CzPPhebk0IOA4dQ509AFMK+reya+R2ZDIqRtiXy22t5OplPrBzlh7Vc
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

GOcontroll produces embedded linux systems and IO modules to use in
these sytems, add its a prefix.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index dac80c62b742fec14cd7652d9d690acc4b4b1ee6..5dc61a05de0ce907caeb60bb92018569df0d19e3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -597,6 +597,8 @@ patternProperties:
     description: GlobalTop Technology, Inc.
   "^gmt,.*":
     description: Global Mixed-mode Technology, Inc.
+  "^gocontroll,.*":
+    description: GOcontroll Modular Embedded Electronics B.V.
   "^goldelico,.*":
     description: Golden Delicious Computers GmbH & Co. KG
   "^goodix,.*":

-- 
2.48.1



