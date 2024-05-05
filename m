Return-Path: <linux-kernel+bounces-169076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19358BC2BD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E441F21105
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB86E61F;
	Sun,  5 May 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NszCBM6R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D736CDCE;
	Sun,  5 May 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714929181; cv=none; b=On1i9a9R3Wv6r/BrawaVgmfB6JSMcjqv9Sy4JVCh0qoH9Wda2wVBMRwDTW+GzLX7hcPfm62QSo3wUDWlMGjQy8N4RdSrGqd/VIhkrMwaHzgcn5dwJXe9q2iUU0KBbbrcdZhoZ+I6HDmdauAP2AmRhtGpImV1GLyflxSbBGmlKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714929181; c=relaxed/simple;
	bh=55JBA5bEs304QZsto7rViA8JO1sVy0UUHAyroeUAa0A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dAtQMb8dWAax5QAti3cYX9Bs/f4imf9b2/L1QUeDBeY5tqCOkptKS/WKjpXcLOMYzHrVV33kQktuKt3r1Xzf2RY6uaq4qXKaQG3qetHsLQXLOt+TcGszdBHKKjmwX19LAVU8JRuUc6CNq+cPreG4VGKwB83IWAaKzqwkvK3r25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NszCBM6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5141C4AF68;
	Sun,  5 May 2024 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714929180;
	bh=55JBA5bEs304QZsto7rViA8JO1sVy0UUHAyroeUAa0A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NszCBM6RZ/ezpkCxDo4BOCEw1JyUwsC+H4+sTPxhX7QOrqUhejuScYWxVcNRqiKH5
	 925MMiPL7cWTJilsDig1NMdv3l/biHSWG9oAivd2LFrK5LMJ1tLzWNX6MccycZVSXt
	 YSP9joj9OqmznPV3VCR53ZZ8FjxpmNft0d72bZo33kHSoXoWlvIoT8a+XDApAyzuKv
	 cMYp4M8UhPLvx6VatoKr+T/uqNs3G5ZXmx9jqBfhl+IDPub0rhb3sh8NZeywi5Vdm3
	 BYBNxVRTuAg6oO+npdLTV9WCSxiQox3EYlmnhlTYq9xiKjCmP7H7QsTADwO8uMZNh7
	 viU9k9J3N5F2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB379C4339F;
	Sun,  5 May 2024 17:13:00 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZjdEyLmMIZ1_TPA3@kroah.com>
References: <ZjdEyLmMIZ1_TPA3@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZjdEyLmMIZ1_TPA3@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9-rc7
X-PR-Tracked-Commit-Id: ae11f04b452b5205536e1c02d31f8045eba249dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c15237018eb8a9a56bb49a5dbf4d8eeb154b5cc
Message-Id: <171492918075.31500.3362395060941802266.pr-tracker-bot@kernel.org>
Date: Sun, 05 May 2024 17:13:00 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 5 May 2024 09:35:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c15237018eb8a9a56bb49a5dbf4d8eeb154b5cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

