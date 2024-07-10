Return-Path: <linux-kernel+bounces-247972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB9192D6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD4BB26B57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE90A194AF0;
	Wed, 10 Jul 2024 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F/Qyzfae"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F55257D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629881; cv=none; b=OF5HcE91VGLPtIl/XKYGP3if6ohldLYIwyE+c+mQ0Q6Wx9xNTE37ySnqOsVdbk1Ez7gLsPehAlOuPhCoN0ZlW0s1UgAFgMxSWqPQredkti9i01wS/iM8YGIB7myMbTCBr+DBbS8aB2cRSG3ZuNthm24WLT2gU/VQ2cy5dL8bO6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629881; c=relaxed/simple;
	bh=5ZzOHfd3R0+0zqGqHFDsyrkYUTop8TDSuImC+ChHTj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kzZXUmB79AB8c6x9ezcH955H/VhQR9U20i2pnTTqgi15au9OMVMe+LLV7t1jXQkKveEDhiHf9ycLt2SZ2aLlRS1o/lY6ZjFCv+/ESxaaGFPkXdBThCV/hZRIYSq0JTvwMNibFlICOM9yGd9Z0yBnOAxCqmC8g+R0FWxQeewdhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F/Qyzfae; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720629876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9tF9D8XaKYCGC9eMddRJtpdZ7Xm28FQve9kppKorHRw=;
	b=F/Qyzfae6hnaeJmLHBL8+VAJZ+ETORBn3joeq3evxHOSOXDXWIig6LJkce/qibtDnl5F5B
	2ylrRKVQXe4qEySH/9fPIohpz/Gx4cNnSsxznQ61OJquUvPPrO/Inlzeq9jmRnuJ3ystTq
	u9yJiDa0BM51e1F+PDoB2hvq7U/Ek78=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Wed, 10 Jul 2024 12:44:31 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.10-rc8
Message-ID: <lmdvnow3yfejsiqgoxg5yxcs4patibvllsc533skksxpoykzcr@fstcszxequbj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, fresh batch of bcachefs fixes for you.

Cheers,
Kent

The following changes since commit 64cd7de998f393e73981e2aa4ee13e4e887f01ea:

  bcachefs: Fix kmalloc bug in __snapshot_t_mut (2024-06-25 20:51:14 -0400)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-10

for you to fetch changes up to 7d7f71cd8763a296d02dff9514447aa3de199c47:

  bcachefs: Add missing bch2_trans_begin() (2024-07-10 09:53:39 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.10-rc8

- Switch some asserts to WARN()
- Fix a few "transaction not locked" asserts in the data read retry
  paths and backpointers gc
- Fix a race that would cause the journal to get stuck on a flush commit
- Add missing fsck checks for the fragmentation LRU
- The usual assorted ssorted syzbot fixes

----------------------------------------------------------------
Kent Overstreet (21):
      bcachefs: Switch online_reserved shutdown assert to WARN()
      bcachefs: Delete old faulty bch2_trans_unlock() call
      bcachefs: Change bch2_fs_journal_stop() BUG_ON() to warning
      bcachefs: Fix shift greater than integer size
      bcachefs: Don't use the new_fs() bucket alloc path on an initialized fs
      bcachefs: Fix bch2_read_retry_nodecode()
      bcachefs: Fix loop restart in bch2_btree_transactions_read()
      bcachefs: Add missing printbuf_tabstops_reset() calls
      bcachefs: bch2_btree_write_buffer_maybe_flush()
      bcachefs: add check for missing fragmentation in check_alloc_to_lru_ref()
      bcachefs: Repair fragmentation_lru in alloc_write_key()
      bcachefs: io clock: run timer fns under clock lock
      bcachefs: Fix journal getting stuck on a flush commit
      closures: fix closure_sync + closure debugging
      bcachefs: Fix bch2_inode_insert() race path for tmpfiles
      bcachefs: Fix undefined behaviour in eytzinger1_first()
      bcachefs: Log mount failure error code
      bcachefs: bch2_data_update_to_text()
      bcachefs: Warn on attempting a move with no replicas
      bcachefs: Fix missing error check in journal_entry_btree_keys_validate()
      bcachefs: Add missing bch2_trans_begin()

Youling Tang (1):
      bcachefs: Mark bch_inode_info as SLAB_ACCOUNT

 fs/bcachefs/alloc_background.c   | 48 +++++++++++++--------------
 fs/bcachefs/alloc_foreground.c   |  2 ++
 fs/bcachefs/backpointers.c       | 70 +++++++++++++++-------------------------
 fs/bcachefs/bkey.c               |  5 +--
 fs/bcachefs/bkey.h               |  7 ++++
 fs/bcachefs/btree_gc.c           | 24 +++++++-------
 fs/bcachefs/btree_write_buffer.c | 37 +++++++++++++++++++++
 fs/bcachefs/btree_write_buffer.h |  3 ++
 fs/bcachefs/clock.c              |  7 ++--
 fs/bcachefs/data_update.c        | 44 +++++++++++++++++++++++++
 fs/bcachefs/data_update.h        |  5 +++
 fs/bcachefs/debug.c              | 12 +++----
 fs/bcachefs/eytzinger.h          |  6 ++--
 fs/bcachefs/fs.c                 | 11 ++++++-
 fs/bcachefs/io_read.c            |  4 ++-
 fs/bcachefs/journal.c            | 18 ++++++-----
 fs/bcachefs/journal.h            |  2 +-
 fs/bcachefs/journal_io.c         | 12 ++++---
 fs/bcachefs/lru.c                | 39 ++++++++++++++++++++++
 fs/bcachefs/lru.h                |  3 ++
 fs/bcachefs/move.c               | 25 --------------
 fs/bcachefs/sb-errors_format.h   |  3 +-
 fs/bcachefs/super.c              | 11 ++++---
 include/linux/closure.h          |  7 ++++
 lib/closure.c                    |  3 ++
 25 files changed, 266 insertions(+), 142 deletions(-)

