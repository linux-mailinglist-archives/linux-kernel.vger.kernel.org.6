Return-Path: <linux-kernel+bounces-421334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E09BB9D8A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110C9B2AD40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1BA1AD3F6;
	Mon, 25 Nov 2024 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEbcd5Md"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F8291E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550076; cv=none; b=Y/ROQEW+oQErfyv50fFI0aGbXfZxvkWFJmUaYGBjgx72xzpUAQDSfPXinpoV/ibbPFm7ttKYINIYo2/Ohezb77Wv4aD4vQpe4x9qFK7htRH9dc/PTDPIrVWjM6whbOrSGozDzuXlk34S+lV0UXOG9TtYdVXT2vaaeE5QaZgokUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550076; c=relaxed/simple;
	bh=fDb8cXzJ6711mCKX8xueWhchOvWxtDD7B4KN9b/sYaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dMd7LhMSoGqiMP1dHcXz++KghfVIgWR15Acn5aRInBiYCgoYZBlQgeH6WRQSpEYTYDB0kSOEQYCgRqSsj5zq01nQZg8bW/iAkRhXWm8DdFHpq/mxVkbuoqq3jel1n8l1qc5UZR4T2Gkd4EYTYsBfwTtrfGSz7krb5BUgw7ggDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEbcd5Md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1279EC4CECE;
	Mon, 25 Nov 2024 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732550076;
	bh=fDb8cXzJ6711mCKX8xueWhchOvWxtDD7B4KN9b/sYaA=;
	h=Date:From:To:Cc:Subject:From;
	b=bEbcd5MdllLmTjnUK6AbPpSWE+ikv3T0gUc7WTfItclhhhmFTaThen+03NktGMdku
	 zh0RBG3LnBVoBMz7fVNxS4qrFYodEdxVHYWFzwxf72zuQ+vXcA25dGY6LfkUtp0Nsw
	 G4KOgB1nLZ8mVMQeiwIEkPjl7T96PWoIaC5M+leWztyN0BQeDqOV02YMkyaisbGqKK
	 HItUoBI63oZOyYHbfiEXvUXBr/7S2Sf4+3MrustAHimR8WMIDm4KuV6Kc4RPRFpC12
	 qN1edFdYAg/jvFyOEleTJ8IG05t8pX/SbYH5VXwnBGzKQ4qTn81lhB6tTAtyODN8tl
	 v5D11hsq7UwJg==
Date: Mon, 25 Nov 2024 15:54:34 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs for 6.13-rc1
Message-ID: <Z0SdunZ61-OMaH1o@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Could you please consideri this pull request?

Thanks,

The following changes since commit eca631b8fe808748d7585059c4307005ca5c5820:

  Merge tag 'f2fs-6.12-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2024-10-14 11:19:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.13-rc1

for you to fetch changes up to bc8aeb04fd80cb8cfae3058445c84410fd0beb5e:

  f2fs: fix to drop all discards after creating snapshot on lvm device (2024-11-23 15:48:15 +0000)

----------------------------------------------------------------
f2fs-for-6.13-rc1

This series introduces a device aliasing feature where user can carve out
partitions but reclaim the space back by deleting aliased file in root dir.
In addition to that, there're numerous minor bug fixes in zoned device support,
checkpoint=disable, extent cache management, fiemap, and lazytime mount option.
The full list of noticeable changes can be found below.

Enhancement:
 - introduce device aliasing file
 - add stats in debugfs to show multiple devices
 - add a sysfs node to limit max read extent count per-inode
 - modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable
 - decrease spare area for pinned files for zoned devices

Bug fix:
 - Revert "f2fs: remove unreachable lazytime mount option parsing"
 - adjust unusable cap before checkpoint=disable mode
 - fix to drop all discards after creating snapshot on lvm device
 - fix to shrink read extent node in batches
 - fix changing cursegs if recovery fails on zoned device
 - fix to adjust appropriate length for fiemap
 - fix fiemap failure issue when page size is 16KB
 - fix to avoid forcing direct write to use buffered IO on inline_data inode
 - fix to map blocks correctly for direct write
 - fix to account dirty data in __get_secs_required()
 - fix null-ptr-deref in f2fs_submit_page_bio()
 - f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks

----------------------------------------------------------------
Andrew Kreimer (1):
      f2fs: fix typos

Chao Yu (17):
      f2fs: fix to account dirty data in __get_secs_required()
      f2fs: fix to do sanity check on node blkaddr in truncate_node()
      f2fs: multidevice: add stats in debugfs
      f2fs: zone: introduce first_zoned_segno in f2fs_sb_info
      f2fs: fix to avoid potential deadlock in f2fs_record_stop_reason()
      f2fs: fix to parse temperature correctly in f2fs_get_segment_temp()
      f2fs: clean up opened code w/ {get,set}_nid()
      f2fs: fix to convert log type to segment data type correctly
      f2fs: fix to map blocks correctly for direct write
      f2fs: fix to avoid forcing direct write to use buffered IO on inline_data inode
      f2fs: fix to do cast in F2FS_{BLK_TO_BYTES, BTYES_TO_BLK} to avoid overflow
      f2fs: clean up w/ F2FS_{BLK_TO_BYTES,BTYES_TO_BLK}
      f2fs: fix to requery extent which cross boundary of inquiry
      f2fs: print message if fscorrupted was found in f2fs_new_node_page()
      f2fs: fix to shrink read extent node in batches
      f2fs: add a sysfs node to limit max read extent count per-inode
      f2fs: fix to drop all discards after creating snapshot on lvm device

Daeho Jeong (3):
      f2fs: decrease spare area for pinned files for zoned devices
      f2fs: introduce device aliasing file
      f2fs: adjust unusable cap before checkpoint=disable mode

Daniel Yang (1):
      f2fs: replace deprecated strcpy with strscpy

Jaegeuk Kim (1):
      Revert "f2fs: remove unreachable lazytime mount option parsing"

Long Li (1):
      f2fs: fix race in concurrent f2fs_stop_gc_thread

LongPing Wei (2):
      f2fs: fix the wrong f2fs_bug_on condition in f2fs_do_replace_block
      f2fs: clean up the unused variable additional_reserved_segments

Qi Han (3):
      f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks
      f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode.
      f2fs: modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable

Sheng Yong (2):
      f2fs: fix changing cursegs if recovery fails on zoned device
      f2fs: clear SBI_POR_DOING before initing inmem curseg

Thorsten Blum (1):
      f2fs: Use struct_size() to improve f2fs_acl_clone()

Xiuhong Wang (1):
      f2fs: fix fiemap failure issue when page size is 16KB

Ye Bin (1):
      f2fs: fix null-ptr-deref in f2fs_submit_page_bio()

Yongpeng Yang (1):
      f2fs: check curseg->inited before write_sum_page in change_curseg

Zeng Heng (1):
      f2fs: Fix not used variable 'index'

Zhiguo Niu (3):
      f2fs: fix to avoid use GC_AT when setting gc_mode as GC_URGENT_LOW or GC_URGENT_MID
      f2fs: remove redundant atomic file check in defragment
      f2fs: fix to adjust appropriate length for fiemap

liuderong (1):
      f2fs: introduce f2fs_get_section_mtime

 Documentation/ABI/testing/sysfs-fs-f2fs |  13 ++-
 Documentation/filesystems/f2fs.rst      |  44 +++++++++
 fs/f2fs/acl.c                           |   5 +-
 fs/f2fs/checkpoint.c                    |   2 +-
 fs/f2fs/data.c                          | 114 ++++++++++------------
 fs/f2fs/debug.c                         | 111 +++++++++++++++++++++-
 fs/f2fs/extent_cache.c                  | 119 +++++++++++++++++------
 fs/f2fs/f2fs.h                          |  38 ++++++--
 fs/f2fs/file.c                          |  71 +++++++++++---
 fs/f2fs/gc.c                            |  19 ++--
 fs/f2fs/gc.h                            |   1 +
 fs/f2fs/inode.c                         |  23 ++++-
 fs/f2fs/node.c                          |  28 ++++--
 fs/f2fs/recovery.c                      |   9 +-
 fs/f2fs/segment.c                       | 161 +++++++++++++++++++++++---------
 fs/f2fs/segment.h                       |  72 ++++++++------
 fs/f2fs/super.c                         | 101 ++++++++++++++------
 fs/f2fs/sysfs.c                         |  16 +++-
 include/linux/f2fs_fs.h                 |   7 +-
 include/uapi/linux/f2fs.h               |   1 +
 20 files changed, 700 insertions(+), 255 deletions(-)

