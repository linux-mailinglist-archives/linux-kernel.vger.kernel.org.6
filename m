Return-Path: <linux-kernel+bounces-574081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2674A6E064
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F723A2F19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C52262D1D;
	Mon, 24 Mar 2025 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfiSJPgW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C44D25D915
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835621; cv=none; b=sfq2zbO5twHKUIFzeDpU5BcwCnIMZ1cowSpLzUkosmbybvnR8iu3wki4xJOTISKGF+RGDuJW5vwxwD4/Plc4+LTjg7B52lKAcx+kjwoGPYP7fhhMuyBedauvPGqup7mJBx+5Cx6t+CZO6/nRYoa/zocI1LLX2FI6H4zzTQ8uQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835621; c=relaxed/simple;
	bh=OYjY4yF0Ez+kzMNj68HY08LHLXeZZ33IkW2+u3BjZZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RLqd16qMntTnKe4rEl3kyDLu8kPk2GhFKXE9CPUp3PTGu3SvlL6+W/KUSj56P0b5BEn10Gb+Q/wU4NTXk2mg3QgW6paUCpUPiy86Z5/TAOYmLpmr4wiD5bDbL09/Xqa1NXp/1YpYia8ICwdYEMPoQtj0OrtWVxtDpIro20qBo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfiSJPgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B527C4CEDD;
	Mon, 24 Mar 2025 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742835620;
	bh=OYjY4yF0Ez+kzMNj68HY08LHLXeZZ33IkW2+u3BjZZ4=;
	h=Date:From:To:Cc:Subject:From;
	b=hfiSJPgWrK3n5XEuTs6lLgyR6+Oc9d1NYdK5bm78TUs5+KTNw35+JRP+QhdME6zgP
	 gI+UfttrT13h6Kj8rCGpsJpshxF+B9m1XduyUidcuVJ8vMrc/s6+NWCpDyoPqSibAB
	 bsw27jxl9gQZfjVZ5uNt+zfuGdlP+vppSbMvku2CwMnq5TT3JgkpRZUUfsZ1MJmt2t
	 L8jw9MARkq3k+NjSubuwmH+1UX3unxaImn2GA23Xa2iX3ndPlPV+igW40swoKBF4l/
	 tW1xKhlnctxDTyrFuMjbrwzxEFIKv2Lv/0JP8em6wHXI9Oc4vNVlFD5WAQVVFQvLoD
	 2+DyQnwLhAOvw==
Date: Mon, 24 Mar 2025 17:00:18 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs update for 6.15-rc1
Message-ID: <Z-GPopTYCOl0hjp3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit f286757b644c226b6b31779da95a4fa7ab245ef5:

  Merge tag 'timers-urgent-2025-02-03' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2025-02-03 09:10:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.15-rc1

for you to fetch changes up to 21263d035ff21fa0ccf79adba20bab9cd8cca0f2:

  f2fs: fix missing discard for active segments (2025-03-18 01:26:06 +0000)

----------------------------------------------------------------
f2fs-for-6.15-rc1

In this round, there are three major updates: 1) folio conversion, 2) refactor
for mount API conversion, 3) some performance improvement such as direct IO,
checkpoint speed, and IO priority hints. For stability, there are patches
which add more sanity checks and fixes some major issues like i_size in
atomic write operations and write pointer recovery in zoned devices.

Enhancement:
 - huge folio converion work by Matthew Wilcox
 - clean up for mount API conversion by Eric Sandeen
 - improve direct IO speed in the overwrite case
 - add some sanity check on node consistency
 - set highest IO priority for checkpoint thread
 - keep POSIX_FADV_NOREUSE ranges and add sysfs entry to reclaim pages
 - add ioctl to get IO priority hint
 - add carve_out sysfs node for fsstat

Bug fix:
 - disable nat_bits during umount to avoid potential nat entry corruption
 - fix missing i_size update on atomic writes
 - fix missing discard for active segments
 - fix running out of free segments
 - fix out-of-bounds access in f2fs_truncate_inode_blocks()
 - call f2fs_recover_quota_end() correctly
 - fix potential deadloop in prepare_compress_overwrite()
 - fix the missing write pointer correction for zoned device
 - fix to avoid panic once fallocation fails for pinfile
 - don't retry IO for corrupted data scenario

There are many other clean up patches and minor bug fixes as usual.

----------------------------------------------------------------
Chao Yu (15):
      f2fs: quota: fix to avoid warning in dquot_writeback_dquots()
      f2fs: don't retry IO for corrupted data scenario
      f2fs: add dump_stack() in f2fs_handle_critical_error()
      f2fs: fix to avoid panic once fallocation fails for pinfile
      f2fs: fix to set .discard_granularity correctly
      f2fs: fix potential deadloop in prepare_compress_overwrite()
      f2fs: fix to call f2fs_recover_quota_end() correctly
      f2fs: fix to avoid out-of-bounds access in f2fs_truncate_inode_blocks()
      f2fs: control nat_bits feature via mount option
      f2fs: do sanity check on inode footer in f2fs_get_inode_page()
      f2fs: do sanity check on xattr node footer in f2fs_get_xnode_page()
      f2fs: introduce FAULT_INCONSISTENT_FOOTER
      f2fs: fix to avoid accessing uninitialized curseg
      Revert "f2fs: rebuild nat_bits during umount"
      f2fs: fix to avoid running out of free segments

Chunhai Guo (1):
      f2fs: fix missing discard for active segments

Daeho Jeong (1):
      f2fs: add carve_out sysfs node

Eric Sandeen (9):
      f2fs: use f2fs_sb_has_device_alias during option parsing
      f2fs: consolidate unsupported option handling errors
      f2fs: factor out an f2fs_default_check function
      f2fs: make INLINECRYPT a mount option flag
      f2fs: make LAZYTIME a mount option flag
      f2fs: Pass sbi rather than sb to f2fs_set_test_dummy_encryption
      f2fs: defer readonly check vs norecovery
      f2fs: pass sbi rather than sb to quota qf_name helpers
      f2fs: pass sbi rather than sb to parse_options()

Jaegeuk Kim (6):
      f2fs: introduce f2fs_base_attr for global sysfs entries
      f2fs: add ioctl to get IO priority hint
      f2fs: keep POSIX_FADV_NOREUSE ranges
      f2fs: add a sysfs entry to reclaim POSIX_FADV_NOREUSE pages
      f2fs: fix the missing write pointer correction
      f2fs: set highest IO priority for checkpoint thread

Kohei Enju (1):
      f2fs: remove unnecessary null checking

Leo Stone (1):
      f2fs: add check for deleted inode

Matthew Wilcox (Oracle) (31):
      f2fs: Add f2fs_folio_wait_writeback()
      mm: Remove wait_for_stable_page()
      f2fs: Add f2fs_folio_put()
      f2fs: Convert f2fs_flush_inline_data() to use a folio
      f2fs: Convert f2fs_sync_node_pages() to use a folio
      f2fs: Pass a folio to flush_dirty_inode()
      f2fs: Convert f2fs_fsync_node_pages() to use a folio
      f2fs: Convert last_fsync_dnode() to use a folio
      f2fs: Return a folio from last_fsync_dnode()
      f2fs: Add f2fs_grab_cache_folio()
      mm: Remove grab_cache_page_write_begin()
      f2fs: Use a folio in __get_node_page()
      f2fs: Use a folio in do_write_page()
      f2fs: Convert f2fs_write_end_io() to use a folio_iter
      f2fs: Mark some functions as taking a const page pointer
      f2fs: Convert f2fs_in_warm_node_list() to take a folio
      f2fs: Add f2fs_get_node_folio()
      f2fs: Use a folio throughout f2fs_truncate_inode_blocks()
      f2fs: Use a folio throughout __get_meta_page()
      f2fs: Hoist the page_folio() call to the start of f2fs_merge_page_bio()
      f2fs: Add f2fs_get_read_data_folio()
      f2fs: Add f2fs_get_lock_data_folio()
      f2fs: Convert move_data_page() to use a folio
      f2fs: Convert truncate_partial_data_page() to use a folio
      f2fs: Convert gc_data_segment() to use a folio
      f2fs: Add f2fs_find_data_folio()
      mm: Remove wait_on_page_locked()
      f2fs: Remove check for ->writepage
      f2fs: Remove f2fs_write_data_page()
      f2fs: Remove f2fs_write_meta_page()
      f2fs: Remove f2fs_write_node_page()

Yeongjin Gil (1):
      f2fs: fix to avoid atomicity corruption of atomic file

Yohan Joung (1):
      f2fs: optimize f2fs DIO overwrites

Zhiguo Niu (1):
      f2fs: fix to return SHRINK_EMPTY if no objects to free

 Documentation/ABI/testing/sysfs-fs-f2fs |  18 ++
 Documentation/filesystems/f2fs.rst      |   3 +
 fs/f2fs/checkpoint.c                    |  71 ++---
 fs/f2fs/compress.c                      |   1 +
 fs/f2fs/data.c                          | 190 +++++++-------
 fs/f2fs/debug.c                         |   3 +
 fs/f2fs/dir.c                           |   2 +-
 fs/f2fs/f2fs.h                          | 155 ++++++++---
 fs/f2fs/file.c                          | 126 +++++++--
 fs/f2fs/gc.c                            |  42 +--
 fs/f2fs/inline.c                        |  22 +-
 fs/f2fs/inode.c                         |  33 ++-
 fs/f2fs/namei.c                         |   8 +
 fs/f2fs/node.c                          | 450 +++++++++++++++-----------------
 fs/f2fs/node.h                          |  13 +-
 fs/f2fs/segment.c                       |  55 ++--
 fs/f2fs/segment.h                       |   9 +-
 fs/f2fs/shrinker.c                      |  92 ++++++-
 fs/f2fs/super.c                         | 191 +++++++++-----
 fs/f2fs/sysfs.c                         | 139 ++++++++--
 fs/f2fs/xattr.c                         |   8 +-
 include/linux/pagemap.h                 |   9 -
 include/uapi/linux/f2fs.h               |   7 +
 mm/filemap.c                            |   2 +-
 mm/folio-compat.c                       |  14 -
 25 files changed, 1059 insertions(+), 604 deletions(-)

