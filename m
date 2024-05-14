Return-Path: <linux-kernel+bounces-178974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721618C59F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9333B215ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0871017F394;
	Tue, 14 May 2024 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD4kWrCz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EDD12E7F;
	Tue, 14 May 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705879; cv=none; b=lhBUR6HkxB+OWa627zKTm4ne2R0XLUcTDdwGBFqUZq8nTGAX10JxbBluivooF89PiUBYPuj3jC/6RCpLTrMaoB/LEmxRMGQiCJWpxMoDy5EC/XLCGYe3eNn5nfKROrTGE5VlBhvDHDVu7fiVAUo+LINRkC8mpd0pUFCrsPCGYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705879; c=relaxed/simple;
	bh=/MWaahrhjj80ErYEg4hyCfK00+nuIf3V/pFFDQ1dDcE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a8xBqyByP02A5TS5F+71N7F9X8zFMYrH1SymYT5VT2QakJujvSlXGCKYZ4BEov464hu+sJoJyuLr+W8McVCNyeoPXvYf0NrNJ4iXKXohUA+oajc8YAgXYkwquA+fFX6aD6p79z95dvTiLNdfij7yotta49iCC9oEgvEknrikFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD4kWrCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6D9C2BD10;
	Tue, 14 May 2024 16:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715705879;
	bh=/MWaahrhjj80ErYEg4hyCfK00+nuIf3V/pFFDQ1dDcE=;
	h=Date:From:To:Cc:Subject:From;
	b=cD4kWrCzvXn66YbXS2XukhORlHDcf7NxfoIyxBIaWQEdKvyZrYYpHEB1mDZXAyHXX
	 TxLHaZWQt2AhWTz4XUTN9uNsXAr1M/3BisH5dYMwFpvBKyV0wV/7cJFbDLwcXisG1E
	 o0oj82iAe9Zxvhjw7FMzSI55FWsHhY7+0/fKj3QIh525XwEvEXT4ya7ShiNAzT5B3Y
	 /DQz2etKHa76ProUATy2bE9mZXpwyIqhWWrjhLIg6udUFihFHlNSQB7E36g89jrOtE
	 h/C0TzVdIHyb+yUGnz+k2vyOksP/1Jwf43cURCOHYvduSiznpszfZ2EC6yTyO0mR4t
	 aSEixemzZEZUQ==
Date: Tue, 14 May 2024 09:57:57 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [GIT PULL] fsverity update for 6.10
Message-ID: <20240514165757.GB2965@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to ee5814dddefbaa181cb247a75676dd5103775db1:

  fsverity: use register_sysctl_init() to avoid kmemleak warning (2024-05-03 08:30:58 -0700)

----------------------------------------------------------------

Fix a false positive kmemleak warning.

----------------------------------------------------------------
Eric Biggers (1):
      fsverity: use register_sysctl_init() to avoid kmemleak warning

 fs/verity/init.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

