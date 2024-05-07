Return-Path: <linux-kernel+bounces-171663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7B8BE70E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A78C1C23B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D3C16192D;
	Tue,  7 May 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LDn3C9Gm"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F2160785
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094652; cv=none; b=gTun9VZ+cne1hoa4sRIS2Habl4JGkjE/gOHOEiZc4j+TkAokzaw0GpGBgMy9jNvJGf6Y0Ccu+OGdaOi5AuomMkFCL2ht0q/J1wt1OvOJlCjqpkmB58rfGNpUp8Jlk4sC4iZe2L674DboWum8SXdKo8H88Vs451Dhacmk4i+OVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094652; c=relaxed/simple;
	bh=V+S2qM1dz5fAisMdCHHRofI9ko5Z8Y95GSiwB94PLxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQWOnP3h9yOL/+hCTSLkPENPZhTTU/GaFO2GLYPJEkRhz96HznWHowxXRE0KAkgNAt5fC0GzVG2Lt6MfNVATMoxTnrRrL9tSxmNAFdV6xQ0lNEHbc8pgaHe9uPM2y+Rdr1zwc2dNJhoeJU2zk7cagS+bp7w8aLkO4d2LS0d1XnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LDn3C9Gm; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 May 2024 11:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715094647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvrXXR4AzK2MTWLrKNYWr8Cf39vw5dHBPWvT1LSDqnw=;
	b=LDn3C9Gm5K06A74oA5w+Cql7aY5vRPu5Jbh8NZqeH3V2MhW+YNcm0qfze7cEOEqAnOelkf
	HhPs5XaaoerLfq+scwxoaDWPDaUA4LfuxYO+wBrfRSgBsNubTR0hBMCM0sKCvqmdxQCWe+
	sv/mnuzmEjWe01MtzpMIR03Zgr6gGKw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.9
Message-ID: <4u2imuisg3sxaomerwbss6p22vxyc2lk6esyn5asybytwgrhe3@tccxjeu5hqmq>
References: <3x4p5h5f4itasrdylf5cldow6anxie6ixop3o4iaqcucqi7ob4@7ewzp7azzj7i>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3x4p5h5f4itasrdylf5cldow6anxie6ixop3o4iaqcucqi7ob4@7ewzp7azzj7i>
X-Migadu-Flow: FLOW_OUT

On Tue, May 07, 2024 at 10:43:11AM -0400, Kent Overstreet wrote:
> Hi Linus, another stack of fixes for you.

I have a report from a user that the sb-downgrade validation has an
issue, so that's been yanked.

The following changes since commit c258c08add1cc8fa7719f112c5db36c08c507f1e:

  bcachefs: fix integer conversion bug (2024-04-28 21:34:29 -0400)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-05-07.2

for you to fetch changes up to 6e297a73bccf852e7716207caa8eb868737c7155:

  bcachefs: Add missing sched_annotate_sleep() in bch2_journal_flush_seq_async() (2024-05-07 11:02:37 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.9

- Various syzbot fixes; mainly small gaps in validation
- Fix an integer overflow in fiemap() which was preventing filefrag from
  returning the full list of extents
- Fix a refcounting bug on the device refcount, turned up by new
  assertions in the development branch
- Fix a device removal/readd bug; write_super() was repeatedly dropping
  and retaking bch_dev->io_ref references

----------------------------------------------------------------
Kent Overstreet (19):
      bcachefs: Fix a scheduler splat in __bch2_next_write_buffer_flush_journal_buf()
      bcachefs: don't free error pointers
      bcachefs: bucket_pos_to_bp_noerror()
      bcachefs: Fix early error path in bch2_fs_btree_key_cache_exit()
      bcachefs: Inodes need extra padding for varint_decode_fast()
      bcachefs: Fix refcount put in sb_field_resize error path
      bcachefs: Initialize bch_write_op->failed in inline data path
      bcachefs: Fix bch2_dev_lookup() refcounting
      bcachefs: Fix lifetime issue in device iterator helpers
      bcachefs: Add a better limit for maximum number of buckets
      bcachefs: Fix assert in bch2_alloc_v4_invalid()
      bcachefs: Add missing validation for superblock section clean
      bcachefs: Guard against unknown k.k->type in __bkey_invalid()
      bcachefs: Fix shift-by-64 in bformat_needs_redo()
      bcachefs: Fix snapshot_t() usage in bch2_fs_quota_read_inode()
      bcachefs: Add missing skcipher_request_set_callback() call
      bcachefs: BCH_SB_LAYOUT_SIZE_BITS_MAX
      bcachefs: Fix race in bch2_write_super()
      bcachefs: Add missing sched_annotate_sleep() in bch2_journal_flush_seq_async()

Reed Riley (1):
      bcachefs: fix overflow in fiemap

 fs/bcachefs/alloc_background.c |  4 ++--
 fs/bcachefs/alloc_background.h |  8 +++++--
 fs/bcachefs/backpointers.c     |  2 +-
 fs/bcachefs/backpointers.h     | 14 ++++++++----
 fs/bcachefs/bcachefs_format.h  |  8 +++++++
 fs/bcachefs/bkey_methods.c     |  4 ++--
 fs/bcachefs/btree_key_cache.c  | 16 +++++++------
 fs/bcachefs/checksum.c         |  1 +
 fs/bcachefs/errcode.h          |  1 +
 fs/bcachefs/fs.c               |  2 +-
 fs/bcachefs/io_write.c         | 30 ++++++++++++++++---------
 fs/bcachefs/journal.c          |  8 +++++++
 fs/bcachefs/move.c             | 22 +++++++++++-------
 fs/bcachefs/quota.c            |  8 +++----
 fs/bcachefs/recovery.c         |  3 ++-
 fs/bcachefs/sb-clean.c         | 14 ++++++++++++
 fs/bcachefs/sb-members.c       |  6 ++---
 fs/bcachefs/sb-members.h       |  4 ++--
 fs/bcachefs/super-io.c         | 51 ++++++++++++++++++++++++++++--------------
 fs/bcachefs/super.c            | 15 ++++++++-----
 20 files changed, 150 insertions(+), 71 deletions(-)

