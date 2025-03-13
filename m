Return-Path: <linux-kernel+bounces-560462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A81EA6049C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC8A19C3A51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEA91F7580;
	Thu, 13 Mar 2025 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MJT5qlm2"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031561B4247
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905948; cv=none; b=IlOFtpSW6fkKFFn4bFRQbfNbVprQjuT6uPsnGTOBwAzUBqyYDsQojgIYDYvPuBbKdCidCnRPVTBxYc6PsUMMYL9gZVilTVBjEhMnjIAppL814dpcgPmLM7bcoZw749c7punR8HGBGOO7X13b49D8QK18e8ImUYZYnDzyutPR9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905948; c=relaxed/simple;
	bh=Ymy0B5muedkUu/7d59s/P9NCVbZU8Ja1pMH/Wa7JwX0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ONHSBK6ihcepIhX/7m4o6fl9tgpYRAsayFqMN+SsFMU2bwP6+QiouZ+qdP1y2wJ3mMfhYKyw6hncx7ZoWNanehMOu0WFtZuCRDIBa9mp2nMUcIz+RC+dC2H7AvAkmGBfNfUb8ZbFllDCauB1T6KNba2AMman5CQZMeSJ3Mk0eW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MJT5qlm2; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Mar 2025 18:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741905934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mPDyGh56r2beH47Vbuy8u85ZHdi1u9UW+poaGehUIXk=;
	b=MJT5qlm2FP77eypgdSRLIDeMSuM4Pf8sofL/JC00S7T9EwvQDesGfKYK24UsNJenyl7/SF
	D1fN4CIcYLdItJa8mkV06iXJ5KRtMeVcGuikxONDoBjn5vKysi3hJcgx88XrkI0Cucm1nZ
	hnoqHP1WvXHUj3QsRjFNaLuHsEejg24=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.14-rc7
Message-ID: <de7fintuxlgh7wteymuo4oproofqngifpul6gq5f66p4b7qih3@5q34khdi2ikv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit 80e54e84911a923c40d7bee33a34c1b4be148d7a:

  Linux 6.14-rc6 (2025-03-09 13:45:25 -1000)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-13

for you to fetch changes up to 9c18ea7ffee090b47afaa7dc41903fb1b436d7bd:

  bcachefs: bch2_get_random_u64_below() (2025-03-13 12:40:22 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.14-rc7

Roxana caught an unitialized value that might explain some of the
rebalance weirdness we're still tracking down - cool.

Otherwise pretty minor.

----------------------------------------------------------------
Alan Huang (1):
      bcachefs: Fix b->written overflow

Kent Overstreet (4):
      bcachefs: Make sure trans is unlocked when submitting read IO
      bcachefs: fix tiny leak in bch2_dev_add()
      bcachefs: target_congested -> get_random_u32_below()
      bcachefs: bch2_get_random_u64_below()

Roxana Nicolescu (1):
      bcachefs: Initialize from_inode members for bch_io_opts

 fs/bcachefs/btree_io.c |  2 +-
 fs/bcachefs/extents.c  |  2 +-
 fs/bcachefs/inode.c    |  1 +
 fs/bcachefs/io_read.c  | 19 ++++++++++++-------
 fs/bcachefs/super.c    | 11 ++++++-----
 fs/bcachefs/util.c     | 23 ++++++++++++++---------
 fs/bcachefs/util.h     |  2 +-
 7 files changed, 36 insertions(+), 24 deletions(-)

