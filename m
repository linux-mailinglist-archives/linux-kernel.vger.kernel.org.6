Return-Path: <linux-kernel+bounces-177185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AC98C3B24
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62946281589
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF531146593;
	Mon, 13 May 2024 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNrlbj/5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C850280
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715580526; cv=none; b=mvmc1suc8gYCdiWwRxd3QfnOuhG0wwXNxsriCQKYRvi6lgQSPZFsYVCXW5oNcXlW7ZLIfwgR5G7gHiNwpnu1qa9bmcOERyGP8H1CknbhfXi/ZGxlxUZQPGYInDIjWfjO904YFUEIUYqc05A8OG1JFDVSiS/jSODYgRWQQXdgMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715580526; c=relaxed/simple;
	bh=CEN/6ECcGbhwsoH3ZfDaw9JNq/DjakjQX74isPF0xJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FlmKrupBXRaKxW4L9L14VkDF4WjH2nCaTbhaYyTEv5o1I6dsoOOcbmsNCDvlHKF34eG4nGucwEW8obFhrnrjPqn4Cqq+R4Haoy7f2NAacc7+ytfE/bELLtweuUhoJcV4qubDvtRD79PUw9yODBxjZuTTcShYBtRNJXXXG/Xt9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNrlbj/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2A9C113CC;
	Mon, 13 May 2024 06:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715580525;
	bh=CEN/6ECcGbhwsoH3ZfDaw9JNq/DjakjQX74isPF0xJg=;
	h=Date:From:To:Cc:Subject:From;
	b=iNrlbj/5wnalJExrDBpuEoPN/Tx3Otd2wPPyk/4NyA7nw/OMt4iQMf/ZRpOly+tJV
	 gEoX1aA6VYDKrOzYPn78jk1M5B09FxS9n3F80tdqSvP3o75QuraWF2bdBtSVKUJHyQ
	 /+eIQQi9sa5iTHFK4YiVRNXaZX63lfjP7Pn3JHFaBOhUpa+9LCnSbeXrE6423XZXly
	 YzfShQQRw4ZagQseT9DUaz0duWDI6NcA0X0cO8o0RDarBPthC1+fwTkxWRzd1vFrV+
	 J1HnnjKaMwVfzZ2BBAi89tYmw0HZBzBAypcwqzrqsW9d5eVOZqOjqANIeBhVyVgDlm
	 CfPDtV9tn4tOw==
Date: Mon, 13 May 2024 14:08:39 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chunhai Guo <guochunhai@vivo.com>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>, Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [GIT PULL] erofs updates for 6.10-rc1
Message-ID: <ZkGuZ319TzAiLS+Z@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Chunhai Guo <guochunhai@vivo.com>,
	Hongzhen Luo <hongzhen@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>, Jingbo Xu <jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider this pull request for 6.10-rc1?

In this cycle, LZ4 global buffer count is now configurable instead
of the previous per-CPU buffers, which is useful for bare metals with
hundreds of CPUs.  A reserved buffer pool for LZ4 decompression can
also be enabled to minimize the tail allocation latencies under the
low memory scenarios with heavy memory pressure.

In addition, Zstandard algorithm is now supported as an alternative
since it has been requested by users for a while.

There are some random cleanups as usual.  All commits have been in
-next and no potential merge conflict is observed.

Thanks,
Gao Xiang

The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc1

for you to fetch changes up to 7c35de4df1056a5a1fb4de042197b8f5b1033b61:

  erofs: Zstandard compression support (2024-05-09 07:46:56 +0800)

----------------------------------------------------------------
Changes since last update:

 - Make LZ4 global buffers configurable instead of per-CPU buffers;

 - Add a reserved buffer pool for LZ4 decompression for lower latencies;

 - Support Zstandard compression algorithm as an alternative;

 - Derive fsid from on-disk UUID for .statfs() if possible;

 - Minor cleanups.

----------------------------------------------------------------
Chunhai Guo (4):
      erofs: rename utils.c to zutil.c
      erofs: rename per-CPU buffers to global buffer pool and make it configurable
      erofs: do not use pagepool in z_erofs_gbuf_growsize()
      erofs: add a reserved buffer pool for lz4 decompression

Gao Xiang (2):
      erofs: clean up z_erofs_load_full_lcluster()
      erofs: Zstandard compression support

Hongzhen Luo (1):
      erofs: derive fsid from on-disk UUID for .statfs() if possible

 fs/erofs/Kconfig              |  15 +++
 fs/erofs/Makefile             |   5 +-
 fs/erofs/compress.h           |   4 +
 fs/erofs/decompressor.c       |  15 ++-
 fs/erofs/decompressor_zstd.c  | 279 ++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/erofs_fs.h           |  15 ++-
 fs/erofs/internal.h           |  28 +++--
 fs/erofs/pcpubuf.c            | 148 ----------------------
 fs/erofs/super.c              |  28 +++--
 fs/erofs/zmap.c               |  24 ++--
 fs/erofs/{utils.c => zutil.c} | 206 ++++++++++++++++++++++++++++---
 11 files changed, 555 insertions(+), 212 deletions(-)
 create mode 100644 fs/erofs/decompressor_zstd.c
 delete mode 100644 fs/erofs/pcpubuf.c
 rename fs/erofs/{utils.c => zutil.c} (58%)

