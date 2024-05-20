Return-Path: <linux-kernel+bounces-184117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9018CA2C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A152281FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7C11B960;
	Mon, 20 May 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLHzoaPb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7C1095B
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233824; cv=none; b=VXahpoX37DxURPfYZTigzD9OuG+gGVFSxWLc00IPpvxBjwxlfNs46YaVdu4IHONOD0VFyymHTush8iUG3GBHX2lTYmazrEaZ6qgTt+JebjqcCSJWd+dy9GbbcSFJ0Ee220d09Pm6ERoo77KaFFr3y+A1BtZeUT7EdWsH/XXDASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233824; c=relaxed/simple;
	bh=BekAKXd9PvZTFhWVif2pUi2JEUho+okCBgcI2xIHEX0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MIupTwmYSaiJCXR9FwAiW4zqpDBu+3aK+LvdwntTtBAVpVNiwIR2Xxpbf6hQC2/3VviTJImd8qwXGtpQJ7EVfzipxYspj1o69LKaF9lcX6Itt/ZKhs1BAJhxF8zznq8d0Hd2xOo927vx5NzuKnrFjxT/fnMTjsM/vWlY/zIjiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLHzoaPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308C5C2BD10;
	Mon, 20 May 2024 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716233824;
	bh=BekAKXd9PvZTFhWVif2pUi2JEUho+okCBgcI2xIHEX0=;
	h=Date:From:To:Cc:Subject:From;
	b=ZLHzoaPbeCOJPq/X63Tqa59N6AJpOpG0/dXD/BFAQVR2KdwbQXvNUPgmwkanm3aQD
	 nO0j2JbVYqtWobWmx+vTY3pbZ3U2CCAVyYXkNjAp8Z33IGkVeHwQYxlLmcneJuib3j
	 KBM2PsD6qugsonDkFBL38sBl6kOS98tTnp6c463DamjODz9WaG4BAMWax4xzr8JlsC
	 wRc+THRbRAionezjv/4JbiM8/NCEpKFm1+n4WfyHGEUZeuY2JWlqUfDpGJaBtINIIX
	 nbkbsDeev64Ue2nCcMyXJdsyQNnIooJnHz0L+zDcqs2StfXdzXiA/Slc8C6ZrK0Qxf
	 uTSYIGN1VAeaQ==
Date: Mon, 20 May 2024 19:37:02 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs update for 6.10-rc1
Message-ID: <ZkumXs7POGImbr-k@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Could you please consider this pull reuqest?

Thanks,

The following changes since commit 928a87efa42302a23bb9554be081a28058495f22:

  Merge tag 'gfs2-v6.8-fix' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2024-03-25 10:53:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.10.rc1

for you to fetch changes up to 16409fdbb8828d7ae829bc4ac4e09e7ff02f8878:

  f2fs: initialize last_block_in_bio variable (2024-05-15 04:18:40 +0000)

----------------------------------------------------------------
f2fs update for 6.10-rc1

In this round, we've tried to address some performance issues on zoned storage
such as direct IO and write_hints. In addition, we've migrated some IO paths
using folio. Meanwhile, there are multiple bug fixes in the compression paths,
sanity check conditions, and error handlers.

Enhancement:
 - allow direct io of pinned files for zoned storage
 - assign the write hint per stream by default
 - convert read paths and test_writeback to folio
 - avoid allocating WARM_DATA segment for direct IO

Bug fix:
 - fix false alarm on invalid block address
 - fix to add missing iput() in gc_data_segment()
 - fix to release node block count in error path of f2fs_new_node_page()
 - compress: don't allow unaligned truncation on released compress inode
 - compress: fix to cover {reserve,release}_compress_blocks() w/ cp_rwsem lock
 - compress: fix error path of inc_valid_block_count()
 - compress: fix to update i_compr_blocks correctly
 - fix block migration when section is not aligned to pow2
 - don't trigger OPU on pinfile for direct IO
 - fix to do sanity check on i_xattr_nid in sanity_check_inode()
 - write missing last sum blk of file pinning section
 - clear writeback when compression failed
 - fix to adjust appropirate defragment pg_end

As usual, there are several minor code clean-ups, and fixes to manage missing
corner cases in the error paths.

----------------------------------------------------------------
Chao Yu (30):
      f2fs: support .shutdown in f2fs_sops
      f2fs: fix to detect inconsistent nat entry during truncation
      f2fs: introduce map_is_mergeable() for cleanup
      f2fs: multidev: fix to recognize valid zero block address
      f2fs: support to map continuous holes or preallocated address
      f2fs: fix to wait on page writeback in __clone_blkaddrs()
      f2fs: compress: fix to relocate check condition in f2fs_{release,reserve}_compress_blocks()
      f2fs: compress: fix to relocate check condition in f2fs_ioc_{,de}compress_file()
      f2fs: fix to relocate check condition in f2fs_fallocate()
      f2fs: fix to check pinfile flag in f2fs_move_file_range()
      f2fs: convert f2fs_mpage_readpages() to use folio
      f2fs: convert f2fs_read_single_page() to use folio
      f2fs: convert f2fs_read_inline_data() to use folio
      f2fs: convert f2fs__page tracepoint class to use folio
      f2fs: fix comment in sanity_check_raw_super()
      f2fs: remove unnecessary block size check in init_f2fs_fs()
      f2fs: fix to avoid allocating WARM_DATA segment for direct IO
      f2fs: fix to do sanity check on i_xattr_nid in sanity_check_inode()
      f2fs: zone: fix to don't trigger OPU on pinfile for direct IO
      f2fs: use f2fs_{err,info}_ratelimited() for cleanup
      f2fs: remove unused GC_FAILURE_PIN
      f2fs: fix to limit gc_pin_file_threshold
      f2fs: check validation of fault attrs in f2fs_build_fault_attr()
      f2fs: compress: fix to update i_compr_blocks correctly
      f2fs: compress: fix typo in f2fs_reserve_compress_blocks()
      f2fs: compress: fix error path of inc_valid_block_count()
      f2fs: compress: fix to cover {reserve,release}_compress_blocks() w/ cp_rwsem lock
      f2fs: fix to release node block count in error path of f2fs_new_node_page()
      f2fs: compress: don't allow unaligned truncation on released compress inode
      f2fs: fix to add missing iput() in gc_data_segment()

Daeho Jeong (4):
      f2fs: write missing last sum blk of file pinning section
      f2fs: prevent writing without fallocate() for pinned files
      f2fs: allow direct io of pinned files for zoned storage
      f2fs: allow dirty sections with zero valid block for checkpoint disabled

Jaegeuk Kim (5):
      f2fs: don't set RO when shutting down f2fs
      f2fs: use folio_test_writeback
      f2fs: assign the write hint per stream by default
      f2fs: clear writeback when compression failed
      f2fs: fix false alarm on invalid block address

Nathan Chancellor (1):
      f2fs: Add inline to f2fs_build_fault_attr() stub

Wenjie Qi (1):
      f2fs: fix zoned block device information initialization

Wu Bo (3):
      f2fs: use helper to print zone condition
      f2fs: fix block migration when section is not aligned to pow2
      f2fs: initialize last_block_in_bio variable

Yeongjin Gil (1):
      f2fs: Prevent s_writer rw_sem count mismatch in f2fs_evict_inode

Yifan Zhao (1):
      f2fs: remove redundant parameter in is_next_segment_free()

Yunlei He (1):
      f2fs: remove clear SB_INLINECRYPT flag in default_options

Zhiguo Niu (3):
      f2fs: fix to adjust appropirate defragment pg_end
      f2fs: add REQ_TIME time update for some user behaviors
      f2fs: fix some ambiguous comments

 Documentation/ABI/testing/sysfs-fs-f2fs |   2 +-
 Documentation/filesystems/f2fs.rst      |  29 ++++
 fs/f2fs/checkpoint.c                    |  13 +-
 fs/f2fs/compress.c                      |  96 ++++++++----
 fs/f2fs/data.c                          | 231 ++++++++++++++++------------
 fs/f2fs/f2fs.h                          |  57 +++----
 fs/f2fs/file.c                          | 256 ++++++++++++++++++++------------
 fs/f2fs/gc.c                            |  11 +-
 fs/f2fs/gc.h                            |   1 +
 fs/f2fs/inline.c                        |  36 ++---
 fs/f2fs/inode.c                         |  22 ++-
 fs/f2fs/node.c                          |  20 ++-
 fs/f2fs/recovery.c                      |   3 +-
 fs/f2fs/segment.c                       | 132 +++++++++++-----
 fs/f2fs/super.c                         |  80 +++++++---
 fs/f2fs/sysfs.c                         |  21 ++-
 include/linux/f2fs_fs.h                 |  10 +-
 include/trace/events/f2fs.h             |  42 +++---
 18 files changed, 688 insertions(+), 374 deletions(-)

