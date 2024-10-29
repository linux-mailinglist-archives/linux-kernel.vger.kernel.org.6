Return-Path: <linux-kernel+bounces-386439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC9C9B4386
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F95280E34
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0531C202F73;
	Tue, 29 Oct 2024 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwN/qhyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917D2022ED
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188243; cv=none; b=gpDN7Oql6dUbTe6V/i4koC6x3Dv1owqZXcACqhieUAXQtwMTKJnY9d2fAyGuCFHSZubzwbwCDyfYlySvzLZL6kMZNCVkDJPl6ZQrsqkRr8j3OIXbznqED60LbUUWUNZyuWj2agbMzo1/wXpdsB2D/HVQzb1HqCRvKeLiurMIfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188243; c=relaxed/simple;
	bh=iTCIFb5as8gRuGAhW9u+lpTcf1ifKUDa1XK3Hi4hHHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NenfF73MB5z41h/BHg/NvgLqlE+6+PzNNtm2Gn+40spfRZc/OivpH8FS+2MFO8YMFeXBQsFU5ZNPQwAW2sLGLh45XQjo8G2UhXNjFiV/pRUM6AdPbaUCSCSR4Txv8uEX8WG1XKBNMYfoW5yRe3v5oWXzGRkx212d9y/Lsb/u3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwN/qhyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E565C4CECD;
	Tue, 29 Oct 2024 07:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730188242;
	bh=iTCIFb5as8gRuGAhW9u+lpTcf1ifKUDa1XK3Hi4hHHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwN/qhyG04DXBh3mMR9tIoMy4prApuP/aCcx44vQ1PVpbSE+AJDrEk7gp+w8ZxYd2
	 DijH37/L2jfdKsTw5LgOpVPYMAc/xHz5IMMryZ5W2niaJ7J0oUK9xlVkLwlMSFnMbm
	 GE7u4WmcZKKwgA244rEGvz21Ea7cJCft/kP1St1AJIXwqePMhg5K06vTdjYuHfer/e
	 XVotoXGHhD30d0x5lrDASRDujnNNmWZONbUfYbt5RyEDhxPCNIFDGY2MFdK4uOikol
	 GrYNWQ7OSrIGeDOx31wNtvHBq+IVVgAMUOjhBbpeAJclKaJ6iytaGAR0RWw+m/dSGq
	 UoGwEGldUuuTA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yann Sionneau <ysionneau@kalrayinc.com>,
	Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH] lib/iomem_copy: fix kerneldoc format style
Date: Tue, 29 Oct 2024 07:50:33 +0000
Message-Id: <20241029075038.645336-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <202410290907.0mDZVYPK-lkp@intel.com>
References: <202410290907.0mDZVYPK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added file did not quite get the punctuation right:

lib/iomem_copy.c:14: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410290907.0mDZVYPK-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've applied this on top of the series that introduced the warning.

 lib/iomem_copy.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/iomem_copy.c b/lib/iomem_copy.c
index 24c2b59a0ad2..dec7eaea60e0 100644
--- a/lib/iomem_copy.c
+++ b/lib/iomem_copy.c
@@ -11,10 +11,10 @@
 
 #ifndef memset_io
 /**
- * memset_io		Set a range of I/O memory to a constant value
- * @addr:		The beginning of the I/O-memory range to set
- * @val:		The value to set the memory to
- * @count:		The number of bytes to set
+ * memset_io() - Set a range of I/O memory to a constant value
+ * @addr: The beginning of the I/O-memory range to set
+ * @val: The value to set the memory to
+ * @count: The number of bytes to set
  *
  * Set a range of I/O memory to a given value.
  */
@@ -52,10 +52,10 @@ EXPORT_SYMBOL(memset_io);
 
 #ifndef memcpy_fromio
 /**
- * memcpy_fromio	Copy a block of data from I/O memory
- * @dst:		The (RAM) destination for the copy
- * @src:		The (I/O memory) source for the data
- * @count:		The number of bytes to copy
+ * memcpy_fromio() - Copy a block of data from I/O memory
+ * @dst: The (RAM) destination for the copy
+ * @src: The (I/O memory) source for the data
+ * @count: The number of bytes to copy
  *
  * Copy a block of data from I/O memory.
  */
@@ -94,10 +94,10 @@ EXPORT_SYMBOL(memcpy_fromio);
 
 #ifndef memcpy_toio
 /**
- * memcpy_toio		Copy a block of data into I/O memory
- * @dst:		The (I/O memory) destination for the copy
- * @src:		The (RAM) source for the data
- * @count:		The number of bytes to copy
+ * memcpy_toio() -Copy a block of data into I/O memory
+ * @dst: The (I/O memory) destination for the copy
+ * @src: The (RAM) source for the data
+ * @count: The number of bytes to copy
  *
  * Copy a block of data to I/O memory.
  */
-- 
2.39.5


