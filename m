Return-Path: <linux-kernel+bounces-529328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F8DA42305
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CECF7A83B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1BD1624E1;
	Mon, 24 Feb 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="IS0VP8m5"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D91537AC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407307; cv=none; b=iEHJI+RmmmDkY6qIYPXsuogJpDoakFiImnRtkUk/cyDTKAboiAhE5y6pXBhT9/FPgmxcUxW+W/0MWTxAdo7HgjTBr1uXD7zFRFpUNWBBaBE6LIsjblhbUcLY8qgtfsXgELKgZzrUo5bya6ctpNOpQK6xxBHP944B26Ipcc7bikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407307; c=relaxed/simple;
	bh=2JMalLgjfRK25edIOS9ES/uni0TwoR7K+RntbNRCyu0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OvFSWiFiFv/Y5IxMKNbFme/eIwGGriqZZnF3EBZ8JLXO5x3AAyEDIS/R7SNii93BEStLHTtiXDn5+n84PuG2AQPPMs982yt7vlBgEe39xGvCNUVfHUCcdeTIKP3Th9PjwAXZKTINxw3v+x2voVZzBGjmawOrS5/hahSE9wPKJxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=IS0VP8m5; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=Uj/PxR9uqsWz2zubPEqUz7qmP4inCOwAhIXu45X2hMA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=IS0VP8m5wOBRPt9NmB6TcocaYEJpYH4F3oGiCDSf73FeGO3K3//FBuyrKSHEbEFmi
	 +wC3L6s/RJTiT2BRcRp4LAhFQWfpWCbxz1PuPcwcB1yTlLCJHmt8ySr2WtBM5yC3yl
	 mmusTAhqoFPxvmR2I9aUE4kdnX8ljADPX72eunpNc6z8VrRF+qA2MPmvMGeQyvicSB
	 pF8Mrf1NuODZl4Np0BzaO5dogXKZaL+5KRInHd9877PHDc7Q+8qjaw4c+nFlJsUdC7
	 mwwyJ9L0ZUtUG1fXaKZOoYL0Ww7T9VC9QFZtn4w9j9eQ7tqp/Y5RrSw8Zqn+Y2cFwD
	 5g84YzRA0hwhw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id DA8794A0237;
	Mon, 24 Feb 2025 14:28:21 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/5] of: Trivial cleanup
Date: Mon, 24 Feb 2025 22:27:56 +0800
Message-Id: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOyBvGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyMD3fy0+KTS9LTMCl1DM1MLQ0tDy0QTEzMloPqColSgMNis6NjaWgB
 RUltbWwAAAA==
X-Change-ID: 20250120-of_bugfix-16581919a446
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Gc5ElloVhbbKVDSgojrej0nZgjtN4HDv
X-Proofpoint-ORIG-GUID: Gc5ElloVhbbKVDSgojrej0nZgjtN4HDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=736
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502240104
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to do some trivial cleanup.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (5):
      of: Compare property names by of_prop_cmp() in of_alias_scan()
      of: Introduce and apply private is_pseudo_property()
      of: Correct property name comparison in __of_add_property()
      of: Do not change property state under __of_add_property() failure
      of/platform: Do not use of_get_property() to test property presence

 drivers/of/base.c       | 12 +++++-------
 drivers/of/of_private.h |  7 +++++++
 drivers/of/overlay.c    |  4 +---
 drivers/of/platform.c   |  2 +-
 drivers/of/resolver.c   |  4 +---
 5 files changed, 15 insertions(+), 14 deletions(-)
---
base-commit: 7526e4fe550f51bd8c41eb51492436117917e3f1
change-id: 20250120-of_bugfix-16581919a446

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


