Return-Path: <linux-kernel+bounces-439348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A72EF9EADF9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FE11888F22
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A39E1DC9A6;
	Tue, 10 Dec 2024 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="AQq1pcMM"
Received: from st43p00im-ztdg10073201.me.com (st43p00im-ztdg10073201.me.com [17.58.63.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3339B23DEA7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826557; cv=none; b=WDaS4ANZNujhKQMDzzmIJlJcXfCttfNVa5SckO7T08fT/pDkMxnhfGhczUI8VWYCupHvINaxLXa17o2tCrTN667Qy76CEONaf+tc2zW9hnKih/uviSaZ4WW/U5LJf0vDltSnPVoDRR+I/kmIR+ZG5YN2d23RP/3OeWoGfg2cbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826557; c=relaxed/simple;
	bh=fRVkXHtgtj3c1+fA3Njm4bAmaUPEMEzaLzODzHPIQDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VnBZxwVSI9HvkdHQKq1y2upoatH1vq5ifW6L+KQm0X/fvjRAdD9sMa6yDUquFbozTX486uur9gd4659QTfK9sfnEZNjUcaulm0wJVqrJYSp7h3OR8705ysl7PiSx6GMUK8KoKrCi1x4m6GYk7eZ9tqhOgB9SmFjZ9ewIjA/MV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=AQq1pcMM; arc=none smtp.client-ip=17.58.63.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733826555;
	bh=SAQCPLZ/4O4cpIzB3DaPnXL/WMcxQBBd3sR7WcIeCQU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 x-icloud-hme;
	b=AQq1pcMMIIUBTG0YNK+gyWxmkRq/igs5SLFtLV+LlV6GUdbF9FaOhMc5wjoNwD9yI
	 mdvT140UdjjU6d9qODpG3gwHRsL8hp8wDYVcQTcBhJ7uQbXZlMdYa0EvL1iztHYuCa
	 xXAGJdycpScoeAqZYgbNifKJ5VJJExE0GWyD5hsUoQTozQICY+OoURRSHxorhcc+UL
	 wgL5nQ9GzlOKegkwK9LdKrEETYm1NRtZ0H2XdiqrZxyoYm1/Q7gvlu3yjlcqUI4Oep
	 pk7WzTBBoTbCbh1bAWKi6cWB56Ar9SXE7w1CpzmZxN3unYepdORPNQoaac6Oce+OzX
	 RhLFxm5Bx0K2w==
Received: from lunix (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztdg10073201.me.com (Postfix) with ESMTPSA id 1D7C49C026C;
	Tue, 10 Dec 2024 10:29:12 +0000 (UTC)
Date: Tue, 10 Dec 2024 11:29:09 +0100
From: Lucy Mielke <lucymielke@icloud.com>
To: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] usb: common: expand documentation for USB functions
Message-ID: <6nvegfmo6d5ak4soaf5nyifsaasfts4qlsnnpsd4sgpnikc2jd@amfmgdr5n3bi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: DEkAsDe8nbglDuPl1HF32w5YwVZqyioL
X-Proofpoint-ORIG-GUID: DEkAsDe8nbglDuPl1HF32w5YwVZqyioL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_04,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=432 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412100078

This patch adds documentation for two USB functions:
- usb_otg_state_string(), which returns a human-readable name for OTG
  states and
- usb_get_dr_mode_from_string(), which returns the dual role mode for a
  given string.

Signed-off-by: Lucy Mielke <lucymielke@icloud.com>
---
 drivers/usb/common/common.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 871cf199b6bf..fc0845f681be 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -41,6 +41,12 @@ const char *usb_ep_type_string(int ep_type)
 }
 EXPORT_SYMBOL_GPL(usb_ep_type_string);
 
+/**
+ * usb_otg_state_string() - returns human readable name of OTG state.
+ * @state: the OTG state to return the human readable name of. If it's not
+ *    any of the states defined in usb_otg_state enum, 'UNDEFINED' will be
+ *    returned.
+ */
 const char *usb_otg_state_string(enum usb_otg_state state)
 {
 	static const char *const names[] = {
@@ -179,6 +185,14 @@ static const char *const usb_dr_modes[] = {
 	[USB_DR_MODE_OTG]		= "otg",
 };
 
+/**
+ * usb_get_dr_mode_from_string() - Get dual role mode for given string
+ * @str: String to find the corresponding dual role mode for
+ *
+ * This function performs a lookup for the given string and returns the
+ * corresponding enum usb_dr_mode. If no match for the string could be found,
+ * 'USB_DR_MODE_UNKNOWN' is returned.
+ */
 static enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
 {
 	int ret;
-- 
2.47.1


