Return-Path: <linux-kernel+bounces-314286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E232396B153
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999BB1F2623B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106AD12C46F;
	Wed,  4 Sep 2024 06:14:27 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3188C11
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430466; cv=none; b=eNCsCGzCs6lCm1dmxwApGch+tq975SZYfKVmBqrt0qGAvDWv8R0drrtR+iOJEOBKYwALQRtk9GoAcL2j8nr6eIneI8IX08H3hg7O8GG8+S+Tql6a6lexnIJjeWUypmX79M3UjrSFJT6UDJKFMgYPbsV6C9vspjJ/oL+1k2+bqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430466; c=relaxed/simple;
	bh=NVtGnZsZqJ6R9bn9gN6Lg6tKSwCHjHqF0QdQhlAwPVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BghxAgqhC2oGs0Y+T8e0HcfQ9pcNOZXtcG4L2au+UFNJf7veUAq6XwT2tFM3+xl3YqxAdO3kBT/N1bXZtNbyy41yBMnUPXDceRqOU/3s8d4wU4SlfEYeXdrttD1gOZBBqAMYhnuXxeiOUmxa+GK5uIVbJeaNDtn5OncBwGL0VvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee266d7fabc9fa-18a02;
	Wed, 04 Sep 2024 14:14:20 +0800 (CST)
X-RM-TRANSID:2ee266d7fabc9fa-18a02
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee466d7faaf38b-158dc;
	Wed, 04 Sep 2024 14:14:20 +0800 (CST)
X-RM-TRANSID:2ee466d7faaf38b-158dc
From: Ba Jing <bajing@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: warthog9@eaglescrag.net,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] config-bisect: Fix the cacography in config-bisect.pl
Date: Mon,  2 Sep 2024 14:41:39 +0800
Message-Id: <20240902064139.3988-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word 'orginial' is wrong, so fix it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/ktest/config-bisect.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/config-bisect.pl b/tools/testing/ktest/config-bisect.pl
index 6fd864935319..b0fff2a75e30 100755
--- a/tools/testing/ktest/config-bisect.pl
+++ b/tools/testing/ktest/config-bisect.pl
@@ -462,7 +462,7 @@ sub print_config_compare {
 
 # Pass in:
 # $phalf: half of the configs names you want to add
-# $oconfigs: The orginial configs to start with
+# $oconfigs: The original configs to start with
 # $sconfigs: The source to update $oconfigs with (from $phalf)
 # $which: The name of which half that is updating (top / bottom)
 # $type: The name of the source type (good / bad)
-- 
2.33.0




