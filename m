Return-Path: <linux-kernel+bounces-260401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A2D93A86A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3EF71C22827
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F03B143C5B;
	Tue, 23 Jul 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZhq7PtA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647513C823
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721768294; cv=none; b=tI4zMsaXNIEBI5HuZ/Q5Lh+2iQcQqCv3JLBoCOPxPPL6F2fctuny5PehBhAQ09hZlR1n0KpOWHuVnr2GMagWtTOSaPYo0TDUANDNSD6L+XCnZ8w3ON6vk1W7VS78OQyEiN2g5rOCuNNgNuXqkF/ySjVQeevjYIkaGdRl9MlQAuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721768294; c=relaxed/simple;
	bh=vm7lqq1pDxSm5ib+uVF8/2QogGR2IqVX/x2iZhX1M7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BKVuNFiqe2iRJxcMUUbFbv6CIdZuj2hu643tviBJTZ+GKIea9q/u3E5XXcsiW4TRVRymWFYMCqHOm+vJme3t6P+llcahFNoSyLuh/UHzCrBMKSJCYqqCrehC9KkGmXMzmEqrLysgldb7WDJR/twVuHVrpAw/Lz+7LWUz5mj3h6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZhq7PtA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E427C4AF0A;
	Tue, 23 Jul 2024 20:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721768294;
	bh=vm7lqq1pDxSm5ib+uVF8/2QogGR2IqVX/x2iZhX1M7Y=;
	h=Date:From:To:Cc:Subject:From;
	b=XZhq7PtAx+SnLRsa8uewjsgGUJ2AljP4PR3dX+TwHyYC3U1VioXOljDT7QUHaJCS0
	 N+PF09Z3raEl+K5cB2XdEyI4kl2ZLSI9b+plwqEUgS39TVvdb6+2D1c2CJU39BDH2l
	 XV0W/KICOv9ZoUeykCFraoA4MT0gWbuguayu9ZqxI4IcPNyYA/wERKHnuYuKmQOjco
	 mvZxlRpvXCNRmdCnPDl5Byvh1qMttYFop+vhN3I9YJcifoWpUfJ2BIAJqn5kzM897S
	 wUYPPgwLA8t/7/jTqJCx5o2BE8tzrHoFIX+6U+/jbu7MGEVU3lgvT6EngGtyqDs9Gx
	 qRnQuct817Q8Q==
Date: Tue, 23 Jul 2024 20:58:12 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs update for 6.11-rc1
Message-ID: <ZqAZZAmghKIaBAkJ@google.com>
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

The following changes since commit 2ef5971ff345d3c000873725db555085e0131961:

  Merge tag 'vfs-6.10-rc4.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs (2024-06-11 12:04:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.11-rc1

for you to fetch changes up to bed6b0317441d82c32506750ccd868d83850e6f4:

  f2fs: clean up addrs_per_{inode,block}() (2024-07-10 23:15:36 +0000)

----------------------------------------------------------------
f2fs update for 6.11-rc1

It's a pretty small update including mostly minor bug fixes in zoned storage
along with the large section support.

Enhancement:
 - add support for FS_IOC_GETFSSYSFSPATH
 - enable atgc dynamically if conditions are met
 - use new ioprio Macro to get ckpt thread ioprio level
 - remove unreachable lazytime mount option parsing

Bug fix:
 - fix null reference error when checking end of zone
 - fix start segno of large section
 - fix to cover read extent cache access with lock
 - don't dirty inode for readonly filesystem
 - allocate a new section if curseg is not the first seg in its zone
 - only fragment segment in the same section
 - truncate preallocated blocks in f2fs_file_open()
 - fix to avoid use SSR allocate when do defragment
 - fix to force buffered IO on inline_data inode

And, it includes some minor code clean-ups, and sanity checks.

----------------------------------------------------------------
Chao Yu (12):
      f2fs: fix to do sanity check on F2FS_INLINE_DATA flag in inode during GC
      f2fs: fix to do sanity check on blocks for inline_data inode
      f2fs: add support for FS_IOC_GETFSSYSFSPATH
      f2fs: fix to force buffered IO on inline_data inode
      f2fs: fix to don't dirty inode for readonly filesystem
      f2fs: fix return value of f2fs_convert_inline_inode()
      f2fs: fix to cover read extent cache access with lock
      f2fs: fix to truncate preallocated blocks in f2fs_file_open()
      f2fs: remove redundant sanity check in sanity_check_inode()
      f2fs: fix to update user block counts in block_operations()
      f2fs: clean up F2FS_I()
      f2fs: clean up addrs_per_{inode,block}()

Daejun Park (1):
      f2fs: fix null reference error when checking end of zone

Eric Sandeen (1):
      f2fs: remove unreachable lazytime mount option parsing

Jaegeuk Kim (2):
      f2fs: clean up set REQ_RAHEAD given rac
      f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is valid

Sheng Yong (3):
      f2fs: alloc new section if curseg is not the first seg in its zone
      f2fs: fix start segno of large section
      f2fs: only fragment segment in the same section

Sunmin Jeong (2):
      f2fs: use meta inode for GC of atomic file
      f2fs: use meta inode for GC of COW file

Zhiguo Niu (5):
      f2fs: fix to remove redundant SBI_NEED_FSCK flag set
      f2fs: fix to avoid use SSR allocate when do defragment
      f2fs: use new ioprio Macro to get ckpt thread ioprio level
      f2fs: enable atgc dynamically if conditions are met
      f2fs: fix to use mnt_{want,drop}_write_file replace file_{start,end}_wrtie

 fs/f2fs/checkpoint.c    |  11 ++--
 fs/f2fs/compress.c      |   2 +-
 fs/f2fs/data.c          |  27 ++++++----
 fs/f2fs/extent_cache.c  |  48 +++++++----------
 fs/f2fs/f2fs.h          |  78 +++++++++++++++-------------
 fs/f2fs/file.c          | 135 ++++++++++++++++++++++++++++++++++--------------
 fs/f2fs/gc.c            |  24 ++++++---
 fs/f2fs/inline.c        |  28 ++++++++--
 fs/f2fs/inode.c         |  84 ++++++++++++------------------
 fs/f2fs/namei.c         |  20 +++----
 fs/f2fs/recovery.c      |  11 ++--
 fs/f2fs/segment.c       |  54 +++++++++++++++----
 fs/f2fs/segment.h       |   3 +-
 fs/f2fs/super.c         |  11 +---
 fs/f2fs/sysfs.c         |  12 ++---
 include/linux/f2fs_fs.h |   7 ++-
 16 files changed, 329 insertions(+), 226 deletions(-)

