Return-Path: <linux-kernel+bounces-181884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF74D8C82C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5981C219A5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27424A04;
	Fri, 17 May 2024 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xjmz-com.20200927.dkim.feishu.cn header.i=@xjmz-com.20200927.dkim.feishu.cn header.b="nCyoAPeY"
Received: from va-2-52.ptr.blmpb.com (va-2-52.ptr.blmpb.com [209.127.231.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA823754
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936026; cv=none; b=AEOt/OKczeHklNsFNnybQnJ1CEkOzzO2cqnXNXMcoZLc4YeC0j5dzPLbA5G02vGSXF3qbotx3xOabl+cQn2I6FIWIat9RIqkO/zoyiw3xYNASW1QDNjaOB0YYlRAQMQnchs0Ur6emfhaOOyNEImewotuAb39wsRbl3BhQnWC0lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936026; c=relaxed/simple;
	bh=z+tJOzT6G7uLGllHiRzwPeRmqIDSWu7BS5oK45nuVCU=;
	h=Content-Type:Cc:From:Date:To:Message-Id:Subject:Mime-Version; b=Q/p+YVW54yQRs7SHiNrXgf4yN2yklBKhINnRnu7ybQaY8DEErtFhyEODL1CrSxjswPqUtrpaGjNuO+9fhlVnQpidX7L8R9UJom19txyM074+Nbh4KGcG01Jt/R7NZlcBU8OIK5q9bXG/f4Y0uxbpoJHKNWKQUxlQGX2s6pQ9PeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xjmz.com; spf=pass smtp.mailfrom=xjmz.com; dkim=pass (2048-bit key) header.d=xjmz-com.20200927.dkim.feishu.cn header.i=@xjmz-com.20200927.dkim.feishu.cn header.b=nCyoAPeY; arc=none smtp.client-ip=209.127.231.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xjmz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xjmz.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=xjmz-com.20200927.dkim.feishu.cn; t=1715936010;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=eNuRp/dEoB8FHHvBWNozzZFQrAyVqRVVHo1Xz6xq4eM=;
 b=nCyoAPeYbJA25VMER2rXqk9/h/NHm9gULAe8lanOGitYMI4IurCrkkkHIgMA63KnUZaTZ7
 5UDovZ032rd1j/nQM3B+jd5rC+f9yDB/InT6akehOY9HLr0fBCkg/R6rr84JScPmNnA6o9
 lJsE/P3PNFatucvvqH5vGGK2v+lvogKd3nA6iMkYEOuXoVlHed0OrbECLh7kDZcyV/A9P+
 pKBUB/rupQFTiHq3lT5TojOZeOhHiymM7mhyiqhIDVEJtcNCtLmHiJ0bTd2uixCkOGqUQC
 sWcGqCqHpWZ59qwRJNj/LY4HojeiVI1mlESSF30arZvv+kcC6/0peYxwceuH6Q==
Content-Type: text/plain; charset=UTF-8
Cc: <linux-kernel@vger.kernel.org>
From: "chenyuwen" <yuwen.chen@xjmz.com>
Date: Fri, 17 May 2024 16:53:27 +0800
X-Original-From: chenyuwen <yuwen.chen@xjmz.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Message-Id: <20240517085327.1188515-1-yuwen.chen@xjmz.com>
X-Lms-Return-Path: <lba+266471b09+4159d5+vger.kernel.org+yuwen.chen@xjmz.com>
Subject: null pointer exception at fscrypt_set_bio_crypt_ctx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.34.1
Received: from meizu-Precision-3660.meizu.com ([112.91.84.73]) by smtp.feishu.cn with ESMTPS; Fri, 17 May 2024 16:53:28 +0800

Hi jaegeuk & chao:

We are facing an issue on 6.1 kernel while using f2fs filesystem at startup=
.
The call stack as follows:

[   14.904678][ T1116] Unable to handle kernel NULL pointer dereference at =
virtual address 0000000000000011
[   14.904986][ T1116]  fscrypt_set_bio_crypt_ctx+0x78/0x1e8
[   14.904988][ T1116]  f2fs_grab_read_bio+0x78/0x208
[   14.904990][ T1116]  f2fs_submit_page_read+0x44/0x154
[   14.904992][ T1116]  f2fs_get_read_data_page+0x288/0x5f4
[   14.904993][ T1116]  f2fs_get_lock_data_page+0x60/0x190
[   14.904995][ T1116]  truncate_partial_data_page+0x108/0x4fc
[   14.904998][ T1116]  f2fs_do_truncate_blocks+0x344/0x5f0
[   14.904999][ T1116]  f2fs_truncate_blocks+0x6c/0x134
[   14.905000][ T1116]  f2fs_truncate+0xd8/0x200
[   14.905002][ T1116]  f2fs_iget+0x20c/0x5ac
[   14.905004][ T1116]  do_garbage_collect+0x5d0/0xf6c
[   14.905005][ T1116]  f2fs_gc+0x22c/0x6a4
[   14.905007][ T1116]  f2fs_disable_checkpoint+0xc8/0x310
[   14.905009][ T1116]  f2fs_fill_super+0x14bc/0x1764
[   14.905011][ T1116]  mount_bdev+0x1b4/0x21c
[   14.905014][ T1116]  f2fs_mount+0x20/0x30
[   14.905016][ T1116]  legacy_get_tree+0x50/0xbc
[   14.905018][ T1116]  vfs_get_tree+0x5c/0x1b0
[   14.905020][ T1116]  do_new_mount+0x298/0x4cc
[   14.905022][ T1116]  path_mount+0x33c/0x5fc
[   14.905024][ T1116]  __arm64_sys_mount+0xcc/0x15c
[   14.905025][ T1116]  invoke_syscall+0x60/0x150
[   14.905028][ T1116]  el0_svc_common+0xb8/0xf8
[   14.905029][ T1116]  do_el0_svc+0x28/0xa0
[   14.905030][ T1116]  el0_svc+0x24/0x84
[   14.905033][ T1116]  el0t_64_sync_handler+0x88/0xec

According to ramdump, we found that inode->i_crypt_info is NULL.
The error occurred in the following function:

bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
{                              =20
        return inode->i_crypt_info->ci_inlinecrypt;
}
EXPORT_SYMBOL_GPL(__fscrypt_inode_uses_inline_crypto);

The inode->i_crypt_info variable was initialized through the fscryptget_enc=
ryption_info
function. Can the f2fs_truncate be called at f2fs_iget when opening file en=
cryption?
______________________________________________________________________
=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E4=BB=85=E4=BE=9B=E9=A2=84=E6=
=9C=9F=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=8C=E6=9C=AC=E9=82=
=AE=E4=BB=B6=E5=8F=8A=E9=99=84=E4=BB=B6=E4=B8=AD=E5=8F=AF=E8=83=BD=E5=8C=85=
=E5=90=AB=E4=BF=9D=E5=AF=86=E5=92=8C=E4=B8=93=E6=9C=89=E4=BF=A1=E6=81=AF=E3=
=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E6=9C=AA=E7=BB=8F=E6=8E=88=E6=9D=
=83=E7=9A=84=E6=9F=A5=E9=98=85=E3=80=81=E4=BD=BF=E7=94=A8=E3=80=81=E6=8A=AB=
=E9=9C=B2=E6=88=96=E5=88=86=E5=8F=91=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E4=
=B8=8D=E6=98=AF=E9=A2=84=E6=9C=9F=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=
=8C=E8=AF=B7=E9=80=9A=E8=BF=87=E5=9B=9E=E5=A4=8D=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E4=B8=8E=E5=8F=91=E4=BB=B6=E4=BA=BA=E8=81=94=E7=B3=BB=EF=BC=8C=E5=
=B9=B6=E9=94=80=E6=AF=81=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6=E7=9A=84=E6=89=
=80=E6=9C=89=E5=89=AF=E6=9C=AC=E3=80=82
This email is for the intended recipient's use only. This email and its att=
achments may contain confidential and privileged information. Any unauthori=
zed review, use, disclosure or distribution is prohibited. If you are not t=
he intended recipient, please contact the sender by reply email and destroy=
 all copies of the original message.

