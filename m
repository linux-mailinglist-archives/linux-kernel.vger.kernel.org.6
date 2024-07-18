Return-Path: <linux-kernel+bounces-256077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCE49348AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE37C2820BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB2078C73;
	Thu, 18 Jul 2024 07:20:52 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D9F74058
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287252; cv=none; b=GWDlSed835biX7mi+SrySxgUGqeqpQTVS/ZvDEDfHI1NeuIP4a3cGhGu8QDbpVQDaSt7xNHDvL/rLRmOqs4nNK8di8ymIXAx+THZ2tMwf0LGXZc+4GuXoMf/M2ayDC/rYpWwhkCaaH80iwDJ8/ecU9sAY0IWHImRa0mm0tZ3I8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287252; c=relaxed/simple;
	bh=5RgJpskfnQBLGNBbJmxZ/9WkbHIpVM8ehSKPiV3QKhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzoAi89jR2wwk276mXBMqi4/IuKnl/Di7UzbE+mhWzQNnUCegK489/MuzfSmuxNNUbiIDye/WYAC2gTTigwa1ZBVAGgajTQjkMCBmn5W2dClOL3EKt2vUtHzQI4Xdbzj1SLrS3c/njMvxnB0wcWD5gHROWKuR3XvZmJnUFj9Vo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WPkcs0pFTz28fXS;
	Thu, 18 Jul 2024 15:16:29 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 51C221402D0;
	Thu, 18 Jul 2024 15:20:48 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 15:20:47 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 5/5] doc: soc: hisilicon: kunpeng_hccs: add low power interface description for HCCS
Date: Thu, 18 Jul 2024 15:11:34 +0800
Message-ID: <20240718071134.31155-6-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20240718071134.31155-1-lihuisong@huawei.com>
References: <20240718071134.31155-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)

This patch add low power interface description for HCCS.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 .../sysfs-devices-platform-kunpeng_hccs       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs b/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
index 1666340820f7..28bffb79e742 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
+++ b/Documentation/ABI/testing/sysfs-devices-platform-kunpeng_hccs
@@ -79,3 +79,29 @@ Description:
 			           indicates a lane.
 		crc_err_cnt:  (RO) CRC err count on this port.
 		============= ==== =============================================
+
+What:		/sys/devices/platform/HISI04Bx:00/used_typs
+Date:		July 2024
+KernelVersion:	6.11
+Contact:	Huisong Li <lihuisong@huawei.com>
+Description:
+		This interface is used to show all HCCS type used on current
+		platform, like, HCCS-v1, HCCS-v2 and so on.
+
+What:		/sys/devices/platform/HISI04Bx:00/support_pm_types
+What:		/sys/devices/platform/HISI04Bx:00/dec_lane
+What:		/sys/devices/platform/HISI04Bx:00/inc_lane
+Date:		July 2024
+KernelVersion:	6.11
+Contact:	Huisong Li <lihuisong@huawei.com>
+Description:
+		This series interface under /sys/devices/platform/HISI04Bx/
+		directory is used to support low power of some HCCS type
+		by operating their lane number. The 'inc_lane' and 'dec_lane'
+		are just exposed with root privilege and write-onely attributes
+		when there is the HCCS type supported low power operation.
+		The 'support_pm_types' with read-only attributes is used to
+		expose the HCCS type supported PM. The available input of
+		'inc_lane' and 'dec_lane' is from 'support_pm_types'.
+		Note: allow to decrease lane only when all specified HCCS ports
+		are not busy.
-- 
2.22.0


