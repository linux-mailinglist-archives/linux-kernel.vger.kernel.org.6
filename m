Return-Path: <linux-kernel+bounces-373438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238719A56A2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959031F21D06
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC641990A1;
	Sun, 20 Oct 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha7Hatgv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED26198E75
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729455383; cv=none; b=Qyk3TUMbRHZXEzXhHfx2U12s+Dxp3zlwkPOtgSprJ0N/34DKddcInhk2DNmsQV3bveqITERd+e+WOwgngXkCAHOt11mdV3/rUzNWZhnSuNmYcm3iNUAmmJO3sECKyHg6U8UZ3UTnEiNxEw3de5aWxrYvyOGTZu37ldf4WP3IBBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729455383; c=relaxed/simple;
	bh=FLyeaStImLV43IgD95Y+Abl0iiCyKLpiwx77IKyzGLU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N2/pJyHRLpDfYvUWhtRFLZ2EOCBetXE/RY27vKHcrcdgP6YPaqJgcXPMMPzJ0AuNTD1tieZVdsdw2UvNWYBZBRvpB0bD6Sm4bJWpXzLHguS5tHc4AUTKL3VIbZrRnvk85+Fif9ijrzxtIoT/U0nPyGpRbXdGZ2KubgFfEeNBEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha7Hatgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4B5C4CEE4;
	Sun, 20 Oct 2024 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729455383;
	bh=FLyeaStImLV43IgD95Y+Abl0iiCyKLpiwx77IKyzGLU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ha7HatgvAzFVNnZWofSYX5dZerypYQxIFstXVTJSx2aFQyWeHW0X+1n7PrZt2MhHZ
	 b6xRntrXulE43QrOOwpVnFuR7QsZLcQsya/nIuGUa/j8r3FkbHRbcyyw060vJP2PR7
	 18kzECimPNZsUI4oRR3v84LQZTKZYwNrx+5ulOMVwBmKm+D319DNd1BC03PV63nLx3
	 n3I51QNE7+aTSH9sAM8lQS+OZVAaMueyHC2vmvX/9VOdROzOG0wIGfH9opPgd4FKBr
	 g6E6dY+SWVSa0GWK0qARfiA3mNRkUDUxWqiwhM/dBY5OZ4cxDHnwyy2JpLCRSIvFQW
	 fX7MbtysdSx/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBBA3805CC0;
	Sun, 20 Oct 2024 20:16:30 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZxUH2J0BL3FCV6Hr@kroah.com>
References: <ZxUH2J0BL3FCV6Hr@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZxUH2J0BL3FCV6Hr@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.12-rc4
X-PR-Tracked-Commit-Id: 9b673c7551e6881ee0946be95e21ba290c8ac45e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c55228220dd33e7627ad9736b6fce4df5e7eac98
Message-Id: <172945538915.3637315.13011662465558044134.pr-tracker-bot@kernel.org>
Date: Sun, 20 Oct 2024 20:16:29 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Oct 2024 15:38:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c55228220dd33e7627ad9736b6fce4df5e7eac98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

