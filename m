Return-Path: <linux-kernel+bounces-245867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DAC92BAA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015FA1C21FCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4228715B0E1;
	Tue,  9 Jul 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YJTH6zj4"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D0158875
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530410; cv=none; b=DgpUMFvJQRxMKnP6d7bylsPj6ggNU9n/RHoLO1W+Ck9dKSHEnmdlaBpt+X28WnKQ0tFaeZyd7/ajXuet7V1KrxFCZRjWmbqgXJuSSjl/MBeJvJXsEa7sUH85TEzIzcHafS7xiRtRJk87O92G90zR85hrFhDwAoH1mfyUXp2VdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530410; c=relaxed/simple;
	bh=1BJf/XJcvLmMhOwbhmHFtx47CgnpTnCFHISjl3X2HGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LpNwxxbCzEX6o+QfZAHLsu8Jq4tl2GRu4oE8ipctTjIU3GRyaNSU3hjbvScNmOJBZWF29ia4qCWWdarkqcKpHUjvjC98zM0PkRa1rshetORxNfJ9llG/HORyO58QNrHKSjCLsoxPBvK2FkzwtF6HI4RiD+VstTuJRxvPjZn3oVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YJTH6zj4; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CED852000B;
	Tue,  9 Jul 2024 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720530400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9kTB7ZTyQldJHdaVmFP9fe9jIgcBZ8LklllYjeSZp+s=;
	b=YJTH6zj48HVCL1xyhuE2LQ5Irk09qPu9ZLYfpZxdflLh2KCHiOnHlgDyy/4fiBMBegGDjQ
	24Ieno0voTvof9ta1Z3eMhekTFuQlt6LVZVr4Ktcb1aCp/xq+sDrF82jNHOjy8uOlC8T/n
	VCBbaAxUFsl7DsXpDK9OfNinNj43g2hWlvYHsJnl+IZ6jsZ0bUANqZEyun1Wf41POCghWX
	YGe3gz5gsTtyrJtUPx1kU4o/bb240wAcWLW3dQgnIO5j1+XNM4d5iNaV2DLx02mitUt1kB
	wGkSVcsLXFgopHZcKTcSO7pC4F4Dg/Us4eXTko4q+Sz7C5f2mSZF1o7A0T126A==
From: Kory Maincent <kory.maincent@bootlin.com>
To: linux-kernel@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net-next] MAINTAINERS: Add ethtool pse-pd to PSE NETWORK DRIVER
Date: Tue,  9 Jul 2024 15:06:36 +0200
Message-Id: <20240709130637.163991-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

Add net/ethtool/pse-pd.c to PSE NETWORK DRIVER to receive emails concerning
modifications to the ethtool part.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0f28278e504..b8312a8ba808 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18050,6 +18050,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/pse-pd/
 F:	drivers/net/pse-pd/
+F:	net/ethtool/pse-pd.c
 
 PSTORE FILESYSTEM
 M:	Kees Cook <kees@kernel.org>
-- 
2.34.1


