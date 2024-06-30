Return-Path: <linux-kernel+bounces-235239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A7291D1FD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748F8281C47
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163797E572;
	Sun, 30 Jun 2024 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y0FUpO8/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954314A615;
	Sun, 30 Jun 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719756750; cv=none; b=Ji2yDbVOSngO3UnI8BAKMnUaYDRt0AqOgGmQ4H1lPIQliy+Kdl7wQu3RUBtW2RT1QkrBkbw5ECzm3bF4zs5tILo4Il+E5d6ex8dHTMtMMctUofp1c3EePnX+NCJ6Q3mTWM7FWP/KdY7f6cd0I0+TAlfaIjDPcLwfLLqoqhw6CGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719756750; c=relaxed/simple;
	bh=dzGyixgfNaRmiYisV5SYswp3Fy0QT2sXJULq4PAHX28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mnm+iVruaL9LaHOWzR/+jxQFhyM0iQzevSk6b2nnyWupzeFoV48LCjudFGNsCtfvc5XGVOcTln2yJVCg1xnzpBBsrH/35u1x//JPf/kQjvzFdxADcv8kqlZHD6+H/d+M50yknvQq2xBhqeZ8S86gl6htYkCgbu71ToAq+/0mV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y0FUpO8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAC2C2BD10;
	Sun, 30 Jun 2024 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719756749;
	bh=dzGyixgfNaRmiYisV5SYswp3Fy0QT2sXJULq4PAHX28=;
	h=Date:From:To:Cc:Subject:From;
	b=y0FUpO8/AdZju0TVb5yNZs7I0553C5hax6gHtMd1R8lzIYPAF1cdwcLJr2+Ut/8Ah
	 Aua6v6Xe91jIcez4DUBAjeByLJ2y/cYI5h3IP6VVlIxddyRH1JtZJox74HZj0DDL3z
	 83dj3dyxJj9Y/luxu8+uS0WirxJLWYAZvzkCPcUA=
Date: Sun, 30 Jun 2024 16:12:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 6.10-rc6
Message-ID: <ZoFnxy7Wy7fI_iDL@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.10-rc6

for you to fetch changes up to fcdd7b7bda3c21d1ba1247419e4a1eb8e2d0bfbb:

  staging: vchiq_debugfs: Fix build if CONFIG_DEBUG_FS is not set (2024-06-27 15:47:30 +0200)

----------------------------------------------------------------
Staging driver fixes for 6.10-rc6

Here are 2 small staging driver fixes for 6.10-rc6, both for the
vc04_services drivers:
 - build fix if CONFIG_DEBUGFS was not set
 - initialization check fix that was much reported.

Both of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bernhard Rosenkränzer (1):
      staging: vchiq_debugfs: Fix build if CONFIG_DEBUG_FS is not set

Kieran Bingham (1):
      staging: vc04_services: vchiq_arm: Fix initialisation check

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c     | 4 ++--
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h    | 5 +++++
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c | 2 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c     | 7 ++++++-
 4 files changed, 14 insertions(+), 4 deletions(-)

