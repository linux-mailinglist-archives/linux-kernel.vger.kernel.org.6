Return-Path: <linux-kernel+bounces-321105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2697148C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E181B218CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916CD1B375C;
	Mon,  9 Sep 2024 09:57:49 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A350175D21
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875869; cv=none; b=AdO45GmxCTipSNyvgKMxyQHtHJMi5IdXp7LH3PXnQVX19ozm7ZnYlZU1glB1Lyhtf0sc+iJPi4STyATngogcGOqMtKoo/t6bvML+Rw7kvHdnRHvuZZ2/OY0fYZmsWUj0liV+l4EFx/pmmCOw60AIIRr4TyFxQrkC7TywmWZb40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875869; c=relaxed/simple;
	bh=5PN/6ZpVaXggMMBe3K+zTFAC0XI+2asECnyMK5e1Wus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFHjXxH8TZGUmI+W7wrpaeX4iZzQakiUORIgnluRqmBIvNiA9I3pMMXUzvbwIiLxJoMb3EiWoCX7GbGXH5Ff+zKfXgLvVMRncGwoa1G7Hc72UXakDcB0pddg1RwCqyqeAS3p3XNgmPMktv0fu6BNqF4AkX9bMWELv/OxwOMEvu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466dec697e28-dc71d;
	Mon, 09 Sep 2024 17:57:43 +0800 (CST)
X-RM-TRANSID:2ee466dec697e28-dc71d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee266dec68be72-4f29d;
	Mon, 09 Sep 2024 17:57:43 +0800 (CST)
X-RM-TRANSID:2ee266dec68be72-4f29d
From: Ba Jing <bajing@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: warthog9@eaglescrag.net,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] ktest: remove redundant declarations
Date: Mon,  2 Sep 2024 21:07:35 +0800
Message-Id: <20240902130735.6034-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since $output and $ret are not used in the subsequent code, declarations should be removed.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/ktest/ktest.pl | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index dacad94e2be4..ecb22626805d 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2960,8 +2960,6 @@ sub run_bisect_test {
 
     my $failed = 0;
     my $result;
-    my $output;
-    my $ret;
 
     $in_bisect = 1;
 
-- 
2.33.0




