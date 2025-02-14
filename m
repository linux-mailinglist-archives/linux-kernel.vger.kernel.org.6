Return-Path: <linux-kernel+bounces-514923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824B7A35D63
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116FE188D7BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD2726137F;
	Fri, 14 Feb 2025 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GG2YeyLm"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2117204F6E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535614; cv=none; b=grplO+RHKWmChAnGCwwS9HSFHSQfJCQ39wdv6kwjDQF9IgNuliLoD0ff127vhjYlf6VBuaTNM/uPZ1KAl5Y2O5VDtjIhJtAJkl0pG6WYEPHVyJHunhUs4Sr471YSJxHMAavRgJ50AZ3aizZR2wXkzcKH2ZuTDks1idDJ0PNnsF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535614; c=relaxed/simple;
	bh=De+vmjaqnFamTkhuUc13zkI64EmpCP/N52/DQmkKJmk=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=CfsOhFIvwgIeXUWMTZCArG8dUSWMmYWvkcnNN3vDUiyD5VMyJ3Q8AfCiSYLYnI9iRV2qucdXMNszMNZi5KFwkk9ycLxhpGPcGVPAYPkmQ2yelEIfKibhkGRZhJhpYQcIgV1RNZtUiD0PwivzzSb659rTHl9Ug2dV4+wQjrINdzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GG2YeyLm; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250214122002epoutp01cd31378e51c8ab13cac0acb0e69f3ffa~kEmoSKUMn1703117031epoutp01S
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:20:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250214122002epoutp01cd31378e51c8ab13cac0acb0e69f3ffa~kEmoSKUMn1703117031epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739535602;
	bh=SE3/PBnj+kUlDZG7aR8PEM/EIX4WzDNA2ccU6mMTP4w=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=GG2YeyLmZgLVQ/7PRz244WnciUMXDtV+ZkmQf2oYN4Fy1OyhgCgDuqCzXzQrPiNw5
	 ymc9W4nU9+RZjY/IyXsxzxB97ezAtqvRD0oqw4PaNBeAysTWuYMKjVlHucpSoe7IIw
	 Hsqaa3ujhmWEgb0h/kYo46sVoX7YcCtRcAD1Q0f8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20250214122002epcas2p4e0d98b01441ebf8a38e0c9f431b2cee5~kEmn6xulS2864328643epcas2p4h;
	Fri, 14 Feb 2025 12:20:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YvWMk32Frz4x9Pv; Fri, 14 Feb
	2025 12:20:02 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: Fix incorrect bit assignment for temperature
 notifications
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From: Keoseong Park <keosung.park@samsung.com>
To: "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"avri.altman@wdc.com" <avri.altman@wdc.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "beanhuo@micron.com" <beanhuo@micron.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, Daejun Park
	<daejun7.park@samsung.com>, Keoseong Park <keosung.park@samsung.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1891546521.01739535602406.JavaMail.epsvc@epcpadp1new>
Date: Fri, 14 Feb 2025 19:52:19 +0900
X-CMS-MailID: 20250214105219epcms2p3a60810a14e6181092cb397924ce36019
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250214105219epcms2p3a60810a14e6181092cb397924ce36019
References: <CGME20250214105219epcms2p3a60810a14e6181092cb397924ce36019@epcms2p3>

According to the UFS specification, the bit positions for
`UFS_DEV_HIGH_TEMP_NOTIF` and `UFS_DEV_LOW_TEMP_NOTIF` were incorrectly
assigned. This patch corrects the bit assignment to align with the
specification.

If this issue is not fixed, devices that support both high and low
temperature notifications may function correctly, but devices that
support only one of them may fail to trigger the corresponding
exception event.

Fixes: e88e2d32200a ("scsi: ufs: core: Probe for temperature notification support")
Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 include/ufs/ufs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index d335bff1a310..8a24ed59ec46 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -385,8 +385,8 @@ enum {
 
 /* Possible values for dExtendedUFSFeaturesSupport */
 enum {
-	UFS_DEV_LOW_TEMP_NOTIF		= BIT(4),
-	UFS_DEV_HIGH_TEMP_NOTIF		= BIT(5),
+	UFS_DEV_HIGH_TEMP_NOTIF		= BIT(4),
+	UFS_DEV_LOW_TEMP_NOTIF		= BIT(5),
 	UFS_DEV_EXT_TEMP_NOTIF		= BIT(6),
 	UFS_DEV_HPB_SUPPORT		= BIT(7),
 	UFS_DEV_WRITE_BOOSTER_SUP	= BIT(8),
-- 
2.25.1



