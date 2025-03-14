Return-Path: <linux-kernel+bounces-561188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23533A60E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665C116CFC1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585741F30CC;
	Fri, 14 Mar 2025 10:16:51 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B1AFC2AF00;
	Fri, 14 Mar 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947411; cv=none; b=atB4AzcW89bNiZybcSMcHz2QAnKRM1yK+4BEd/Kk5pIyokdRwdsgoYXmWZYtaKbiVyAhKaeqETVhhd8v3QArxmoGO9V70gcj3JRw4nusUSL/wdG9WICUzpgrwGJoXKjeSZQSAIDXR4E5+7Rwn3DEg2520wFsX83KNA/VRTgFxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947411; c=relaxed/simple;
	bh=WadiwXRYKhyTQfnziazA1hCza2z+4qJkR+ooXl+2JAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=q43EWRMPFlrKlF11B0O452cy/mxoxLnQ0PrpIcnWaysmXm3hpxEy2hAQI03PNO7w0wjBdkRdIkyXMWnuMOclSXFS+ZWXVu8vUi2YntROOQ6HT+fE7fN0NjvXklyS9UsRCislEgfI6vnWcednpXmU0tT/mu1W96XCESXuGMf/KHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from liqiong-suma.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 7716F606FFD4C;
	Fri, 14 Mar 2025 18:16:44 +0800 (CST)
X-MD-Sfrom: liqiong@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Li Qiong <liqiong@nfschina.com>
To: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>
Cc: Li Qiong <liqiong@nfschina.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] usb: cdns3: Remove the invalid comment
Date: Fri, 14 Mar 2025 18:16:38 +0800
Message-Id: <20250314101639.424013-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250314070921.355986-1-liqiong@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function don't return value, remove the invalid comment.

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
v2: Split the first patch to two patches.
v3: Add changes from the previous version.

 drivers/usb/cdns3/cdns3-plat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 59ec505e198a..735df88774e4 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -179,8 +179,6 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 /**
  * cdns3_plat_remove() - unbind drd driver and clean up
  * @pdev: Pointer to Linux platform device
- *
- * Returns 0 on success otherwise negative errno
  */
 static void cdns3_plat_remove(struct platform_device *pdev)
 {
-- 
2.30.2


