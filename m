Return-Path: <linux-kernel+bounces-191410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FB98D0EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5492826D4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8608E5380F;
	Mon, 27 May 2024 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="gYWmUe7N"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D57E167DA8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843546; cv=none; b=TllvzR+dobpiAumEXs+7EMwj8FIDogG+6Mawmwp/BoUnRDZAMyIOyzM/aSQM1KQPIvKdlp8M40YregorLJoWMfH54RGy+muPfLjYCJbk4vlTBE2sLKdFCSwIvN2gzchcI/lxlRrnVKEuwXNVc7CMERNMxdnXq22Lza5y0hQ3m40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843546; c=relaxed/simple;
	bh=rAvo1QnsP8kN8QRYgy15WEndhIVydhQ8B9Gi0OWkD9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AEBMtSsIHpa0FgLYavrlgAscwrPFVmfcMGM/yfLuAS9wQuGrK84ZdAaDGy1vk/XuBhBo3+w790uLj0FT2drHMAkVB9qtS1RelJP7iCC5pV+IMNe9q9VFrNUedE4uPheA+TwHkC6jvky4kozPFDSRnq/ba1/aSqQ2Ly4KdQpBoTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=gYWmUe7N; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=VgqIjuxx1+smWYJZJYTIL09wCDiSGuEM65OBxMPBFKk=; b=gYWmUe7Ns+T47it3
	fQdsqsZQAzxP0bau/GCS6H0B/oe/gBkyO+wTGc/3rbTHsZcWGo2txNoCc7rb/r8EogL2tzYYRzdcr
	JZdkMcAPqdcHCM86TQR681rGkuTP98fmipysqJ064mnMIjzGU+tqbaVaACRMquY/poiWqeBLULwyv
	cdP6cZjru5dJqllK246XF3RRJyidmXKVw7PSqj0MiwM//gsP4IdcyFJ/s6D1SG5PUCzAJQap3cEYF
	+hJmr9jg84xDez+Muck0/i0o0f+QgoDQw2A6ccXzcLd2Jgxg3PO3K9PGbacrOiEQvJLhXz1qj9ZaH
	QAcKw7p8B3QDeClNwg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBhQc-002oZl-2e;
	Mon, 27 May 2024 20:58:47 +0000
From: linux@treblig.org
To: patrice.chotard@foss.st.com,
	vkoul@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] phy: miphy28lp: remove unused struct 'miphy_initval'
Date: Mon, 27 May 2024 21:58:44 +0100
Message-ID: <20240527205844.165279-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'miphy_initval' is unused since the original
commit 2c14e9be0c60 ("phy: miphy28lp: Provide support for the MiPHY28lp
Generic PHY").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/phy/st/phy-miphy28lp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
index 063fc38788ed..43cef89af55e 100644
--- a/drivers/phy/st/phy-miphy28lp.c
+++ b/drivers/phy/st/phy-miphy28lp.c
@@ -228,11 +228,6 @@ struct miphy28lp_dev {
 	int nphys;
 };
 
-struct miphy_initval {
-	u16 reg;
-	u16 val;
-};
-
 enum miphy_sata_gen { SATA_GEN1, SATA_GEN2, SATA_GEN3 };
 
 static char *PHY_TYPE_name[] = { "sata-up", "pcie-up", "", "usb3-up" };
-- 
2.45.1


