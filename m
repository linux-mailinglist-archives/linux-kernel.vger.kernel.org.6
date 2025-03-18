Return-Path: <linux-kernel+bounces-566550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDBAA679A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C87E884F27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C566211472;
	Tue, 18 Mar 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mPmAW/9i"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F1212B3A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315228; cv=none; b=g2ZBp2bHv2gL0LTPDCbn1qgR4L2ecGOOV2zq2HE9duDgGz9dDDtaykIQIxHCfvNPCZHQWXC/Sx3S0Xd58TAm9h0TFQFnCm6YbA/w32YYYIU0cSnKjkt3tgdA5+Pw0PKb6Nw7tF6TRIqUG0u9VZBbyh3JAwWEjn0I43elmJ3lErw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315228; c=relaxed/simple;
	bh=La/WhBiYyFN1JXyne9e6uMXJ0y6XuaV1ttw4tCnOaSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWBDfmn6OTgpWcvu9Vn8GrtvgQE+ziXmeu6qj3VK9+GN+TmGbg8DBezJ9HJpuotpbXImFnUvikf+XyfL8OCAMj7Q7y/2EPz5tYjNyAp3OUVNasQILDSjXUcmWoa8/TrmFMFfLOQt3EEVK2SdVHW9mVCuV6os+k50Nq68DPAZM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mPmAW/9i; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742315224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OjJiIwlMpkeH+xMiT4Dzt06RFe5u+6AUQfkA8y/in8M=;
	b=mPmAW/9ifLtaPSMmRvVg8pLI0qL8+fsy41lPvQgy0BYrjbZyoEkhrTfOWVpBa/VIe5+fb3
	eBYvUQGxTNLgkMtb2T+d9naDrBjkVGvIZLlwbF1QMWzhNMD1zAbo5PTgu4FDXj9rvBa/LF
	IuJD23BS76oFwiWDoplPU8ioxhUSY7A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: Fix grammar in error message
Date: Tue, 18 Mar 2025 17:25:59 +0100
Message-ID: <20250318162558.100462-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/much/many/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ubifs/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 36ba79fbd2ff..923c0bbff303 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -982,7 +982,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 	dbg_jnl("ino %lu, nlink %u", inode->i_ino, inode->i_nlink);
 
 	if (kill_xattrs && ui->xattr_cnt > ubifs_xattr_max_cnt(c)) {
-		ubifs_err(c, "Cannot delete inode, it has too much xattrs!");
+		ubifs_err(c, "Cannot delete inode, it has too many xattrs!");
 		err = -EPERM;
 		ubifs_ro_mode(c, err);
 		return err;
-- 
2.48.1


