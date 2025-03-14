Return-Path: <linux-kernel+bounces-561707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0C0A61510
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8A718914CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4A61FF7DB;
	Fri, 14 Mar 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dDvpJc5q"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72424202C31
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966502; cv=none; b=LtMLN/UVGtLaSQGZZKza8WPRiJdLNOaG7dPwxTTQksFkH/7bE7nHCWT6BxT/No+LGFqpO7F3kZ5iv9uBTty12nnHDfHW889w6Xm7Rkh13Ct22p2s2Q9JEAl9npUs2ubHtdbQm20w7uz9HptHSBe9gjuLAuwbc2Tx6nHcoJU0a5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966502; c=relaxed/simple;
	bh=0E9olIAjOC1S9Dj7DCZPFn99oaBj1a5noir7fxtArdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AMQq3zOz1Ho8fl0HNuEJnnCsvYhBfbIGCFE1tfQoo+psRTJgTDBguI+nMHDYitZFlcMhKacFS8IgCirs0odbbyHTkz1UPuIVd5xVDLjT/lQTHQ2DWGb+j+eZx8j8Dn6tu5WP5msZVwn6U3o7NnmUcWJu93sMFOpYnkxgZB+ixaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dDvpJc5q; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 11:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741966498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=rT9B11DlPM/Ts6tbqOgpxuvW0VlMFPmcrBB7wfHMT0w=;
	b=dDvpJc5qPcRT58wiaWX37qIO6P2qp/Fdv1ptu4OK8IvCF/ryyPu4u65X+lB5ty7zt407hS
	87lu6WrxU378Tl//+qj3sPEnQg7nu0152Cr4Ml1ZGfsfP44X9yxbhQia8CDIGpwcd9k1O5
	4xqyohqL5lcbX/QzLUDlcNqPOLhfFfI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs hotfix for 6.14-rc7
Message-ID: <uueaqqyii2x3zcqdukj3tb35tkeawdwmi3ts65v4hlfdvv6ckx@vqkk7ntyyse7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit 9c18ea7ffee090b47afaa7dc41903fb1b436d7bd:

  bcachefs: bch2_get_random_u64_below() (2025-03-13 12:40:22 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-14

for you to fetch changes up to 90fd9ad5b0c981693c8512d9da01f14fb6596e9d:

  bcachefs: Change btree wb assert to runtime error (2025-03-14 10:25:25 -0400)

----------------------------------------------------------------
bcachefs fix for 6.14-rc7

This one is high priority: a user hit an assertion in the upgrade to
6.14, and we don't have a reproducer, so this changes the assertion to
an emergency read-only with more info so we can debug it.

----------------------------------------------------------------
Kent Overstreet (1):
      bcachefs: Change btree wb assert to runtime error

 fs/bcachefs/btree_update.h       |  8 ++++++++
 fs/bcachefs/btree_write_buffer.c | 21 ++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

