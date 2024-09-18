Return-Path: <linux-kernel+bounces-332341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C3197B88F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33E01C20FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0D214F135;
	Wed, 18 Sep 2024 07:31:59 +0000 (UTC)
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E5273DC;
	Wed, 18 Sep 2024 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726644719; cv=none; b=MgC3z2C8uLzFig7IuhXewFWUnAa5MVnUVxAz1gJJhlCufXvZJNl8HcssYrXxDig0bjJXcG/19weTw2sD1VFD//91jT3FFWUE6KZEc7sUAcYUHCZm6UCqcuu+FBO8GTD7vtRKt2NDJvrNTeuAIwOouO5c4uZwheYLdJb/0FA8bKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726644719; c=relaxed/simple;
	bh=vlf1ZBRI9wDDax1WdsvmMvExEWZ+WEy3ket3BOut1Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HjoMPnKq+k9cqwrTMDzhzXQeDJOhRKJSqnGYKxJ6mvBMyFuBCbr0qe8JuU769ASutRt4CB70ikxsn60DoXYMcA8c1HnhaIEce6H+U1pchcaB1jDe++p0J3hWx5ua1QI2s2DhAvtkS0dm6ID2UljdaitTMP4oGBOA9GRD60wcOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1sqot5-005k8K-2Q;
	Wed, 18 Sep 2024 09:14:07 +0200
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1sqot4-000000012GP-40wa;
	Wed, 18 Sep 2024 09:14:06 +0200
From: =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@jo-so.de>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	=?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@jo-so.de>
Subject: [PATCH] doc/pstore: Fix parameter names in examples
Date: Wed, 18 Sep 2024 09:13:28 +0200
Message-ID: <41bc35342567227eb73c1b7683870b5975b9241c.1726643608.git.joerg@jo-so.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Jörg Sommer <joerg@jo-so.de>
---
 Documentation/admin-guide/pstore-blk.rst | 2 +-
 Documentation/admin-guide/ramoops.rst    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
index 1bb2a1c292aa..5c247c25e13a 100644
--- a/Documentation/admin-guide/pstore-blk.rst
+++ b/Documentation/admin-guide/pstore-blk.rst
@@ -35,7 +35,7 @@ module parameters have priority over Kconfig.
 
 Here is an example for module parameters::
 
-        pstore_blk.blkdev=/dev/mmcblk0p7 pstore_blk.kmsg_size=64 best_effort=y
+        pstore_blk.blkdev=/dev/mmcblk0p7 pstore_blk.kmsg_size=64 pstore_blk.best_effort=y
 
 The detail of each configurations may be of interest to you.
 
diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index 6f534a707b2a..2eabef31220d 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -129,7 +129,7 @@ Setting the ramoops parameters can be done in several different manners:
     takes a size, alignment and name as arguments. The name is used
     to map the memory to a label that can be retrieved by ramoops.
 
-	reserver_mem=2M:4096:oops  ramoops.mem_name=oops
+	reserve_mem=2M:4096:oops  ramoops.mem_name=oops
 
 You can specify either RAM memory or peripheral devices' memory. However, when
 specifying RAM, be sure to reserve the memory by issuing memblock_reserve()
-- 
2.45.2


