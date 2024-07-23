Return-Path: <linux-kernel+bounces-260445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF1693A94E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3EEB218A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE3149001;
	Tue, 23 Jul 2024 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzQhbo4B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F951487F9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773613; cv=none; b=WwO573CWkKD2n7EgIZrrMXouE3GFiAQjPi/meYzXi2YIi9+vg2xW6DssjELe4DXGEGlGWomAW+KSTy48GoEHzJMPjpJ/g+/d9ZAP2ZXF3SM5gC2BKgYI60tlHYgTJHrADx2SDQ/uKTEpTAhHFdatumM5XvUJCIZ2xI3DImDpP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773613; c=relaxed/simple;
	bh=fULLGUDLIeNFvBBZga9l8thWsOiKQb2dvOik5/OIF+8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A9O6c2VG9jg1QTPuYBgMmw/gEgerhUWabR/MQ4XSYvsQhba6jvsPEXi74Waa7l0zjAww+LT1q/UpIzPGSQqsFIycipIoGlTqI40Gzh0PbWKPAqFjE5wctmTWrWRoPjWFrfCIfOJCAqwIhU+eFgzpOJwU9Z+OGYoN2sd+Xq6FDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzQhbo4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B93A0C4AF0A;
	Tue, 23 Jul 2024 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773613;
	bh=fULLGUDLIeNFvBBZga9l8thWsOiKQb2dvOik5/OIF+8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MzQhbo4B+oeyjz5d4pJn5rYePGwmg+cGou4LiiBufrEvi5+JH0ZJWP3bjrJhxkSkQ
	 vMMkeOdgJs5Ioyn6F/FBNqKwBlvSaVNPZba33uusPKomufezMGm6r7PdAul6xpcSV0
	 OMVk+Y7Xq4/08GezLSYmu10oJffUVqCvtus/+0JOkmLHAGrBxy4LRfDluWjUMVTv35
	 fFaOdTD/qBale7YckLAieDrZgs/qMLgfb0HTpaoPdZxveVJPkOpshZ3p9eKlULOVgX
	 Kn99Kf36tvyUUoRLlDpou8oWZBOyq+0IfKali6gF/K1CAkL2xhDBznc+nZeSncP2Kq
	 XSw57TNf9YFjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0A84C43443;
	Tue, 23 Jul 2024 22:26:53 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs update for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZqAZZAmghKIaBAkJ@google.com>
References: <ZqAZZAmghKIaBAkJ@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZqAZZAmghKIaBAkJ@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.11-rc1
X-PR-Tracked-Commit-Id: bed6b0317441d82c32506750ccd868d83850e6f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ad7ff8738b8bd238ca899df08badb1f61bcc39e
Message-Id: <172177361371.759.11999095889182184443.pr-tracker-bot@kernel.org>
Date: Tue, 23 Jul 2024 22:26:53 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Jul 2024 20:58:12 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ad7ff8738b8bd238ca899df08badb1f61bcc39e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

