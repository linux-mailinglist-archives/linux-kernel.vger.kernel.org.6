Return-Path: <linux-kernel+bounces-210548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69395904568
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57FAB24AED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCE4142620;
	Tue, 11 Jun 2024 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu7Bhgpr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6582490
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135935; cv=none; b=FpukxAj4+v+4Fxag0yhlXr0MNmU5iN+HRLtv4QeY3gZCJZTJtUvoMYVda+Z9oHbHTFN7rnCVkkrK5GY3a3Tehg9+D9oRPMtne5uXBGav5iy0J4sxCppshp++mFEaMtM4pR74twQbAMCjm9jF3oT2IwJvk3Fp7IR6gos8wtWPqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135935; c=relaxed/simple;
	bh=lXlj/SstpuQpKJCP8HW5gJ3hni3Cit4VvKRlRHAAa4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bbRBBhq0+xAdt4YQw6H+TYHKjoryGm2FGvf2syWaTs9bV0mWZ1iaghUHNW7tZxgu4U1ehy6B64irstikonj4JdvlCCg+rMWgzZmShcZe2oy1YmGPGGRlfQQZKEhgoJpx8ejI48aq79A5msBFT5M04131pEE+j8TwAbKyo3Pwb0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu7Bhgpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3D4C2BD10;
	Tue, 11 Jun 2024 19:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718135934;
	bh=lXlj/SstpuQpKJCP8HW5gJ3hni3Cit4VvKRlRHAAa4w=;
	h=From:Date:Subject:To:Cc:From;
	b=iu7BhgprMOv8XOaBfONHSAx1MZ0tsPJvlJh0PSsKLcpKkvgMQaxkQIQ86soxxL3SQ
	 2LAtx8PSkRMasS+eya8sp7MhyF9H0KkMVLzX3GvYdfpkwmmbHS6cpIzhiCu/yQkJID
	 IGf/ZY6x25hnmb7NC9gW7Vr13tdaLUxr3clTbdbicHIndhtALLVDVC8Qpa3TefzCjK
	 6ckg+gWMWtx2TzB3vkyqHkp/amtXkKuZGS5q96mHtJz4RXz4F+9rB++s588SWhB11h
	 scVLUExz8DwgB6N+MwkOADpUblBoNfunvxk5lNr3WcaktmHElxEa63j74V3PcMSjGD
	 +AYBDUEHbsrRg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 11 Jun 2024 12:58:41 -0700
Subject: [PATCH] hostfs: Add const qualifier to host_root in
 hostfs_fill_super()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-hostfs-fix-mount-api-conversion-v1-1-ef75bbc77f44@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHCsaGYC/x2NSwqAMAwFryJZG7BV/F1FXJSaaha20qgI4t2tL
 gfevLlBKDIJ9NkNkU4WDj6ByjOwi/EzIU+JQRe6KmqlcAmyO0HHF67h8DuajdEGf1L8XGxLmoz
 ubFM5gvSyRUrbvzCMz/MCkc5BuXEAAAA=
To: Christian Brauner <brauner@kernel.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=nathan@kernel.org;
 h=from:subject:message-id; bh=lXlj/SstpuQpKJCP8HW5gJ3hni3Cit4VvKRlRHAAa4w=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGkZa2qXOP7YIvwhTFa/7j7T7FabE9Yrc+KesvFMm8IZr
 z/zu8LXjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRakZGhuPcM21muJdM8fRa
 GZci717ov/I9l+LbadwzdI9NWDHvvw3DP/0Xe9pduV3ZpZM44zasq9ui6CO+2dTb3ffBDEMvQS0
 ddgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After the recent conversion to the new mount API, there is a warning
when building hostfs (which may be upgraded to an error via
CONFIG_WERROR=y):

  fs/hostfs/hostfs_kern.c: In function 'hostfs_fill_super':
  fs/hostfs/hostfs_kern.c:942:27: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    942 |         char *host_root = fc->source;
        |                           ^~

Add the 'const' qualifier, as host_root will not be modified after its
assignment. Move the assignment to keep the existing reverse Christmas
tree order intact.

Fixes: cd140ce9f611 ("hostfs: convert hostfs to use the new mount API")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/hostfs/hostfs_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 6ec3c368d7bf..e44747bbfe87 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -938,8 +938,8 @@ static const struct inode_operations hostfs_link_iops = {
 static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct hostfs_fs_info *fsi = sb->s_fs_info;
+	const char *host_root = fc->source;
 	struct inode *root_inode;
-	char *host_root = fc->source;
 	int err;
 
 	sb->s_blocksize = 1024;

---
base-commit: cd140ce9f611a5e9d2a5989a282b75e55c71dab3
change-id: 20240611-hostfs-fix-mount-api-conversion-83eda29c74fe

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


