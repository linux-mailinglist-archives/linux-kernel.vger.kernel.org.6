Return-Path: <linux-kernel+bounces-364637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B583499D744
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CDB283F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97541CACE4;
	Mon, 14 Oct 2024 19:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAz9tIGE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565E31CC143
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933784; cv=none; b=rY0UDr0thtl/Af/jsldg44GnZ6VPiw6SA9HZhF8c2g8AHUrq8iccGx9NsOF/MHZYaLgqUrkphiS5cDrHJo6fdxosOT3Z6RSeCKG1SFpATzU5RYomOOsuKvZHd1PKVs2dbLlWOFWMndDcszccBN2DqbTmsVaCOxQKt0VhTfH7GEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933784; c=relaxed/simple;
	bh=dCUME0CI55Wl+NRXuXAKP5D7ZiIsOcTukDnUZQ5AyaE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s2tgOyGjWDEsk8Vc5CmTCAOG7qyPG+lxZ7pJqXb0fhXzvVfa0YPPXwTfQFRXyCL+6KfNbBddkjBqK+KiJ8Q1w1003b2CNhgfqkB3u6OdjhMWqgeQkIVbqkcSTQ3ulgIv9sRhyuCYWe9Z+XCkwTPHMnCAd4iCDc3gQBvgu+aRvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAz9tIGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29C1C4CEC3;
	Mon, 14 Oct 2024 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728933783;
	bh=dCUME0CI55Wl+NRXuXAKP5D7ZiIsOcTukDnUZQ5AyaE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qAz9tIGEcu6tlP5ZdtvuowBiz8iMvGl3uqNCWrHQI6LCTJEOmma/qDpi1rxuAZK48
	 oP+7cN5Rx72ilIXCU4G3lkydMy4lwE822m8boIaQkOtw8lRYd/gv9sxd2UMqM2+htt
	 vQF3BHDwhkzlWPDgloOQ9p6P8xJfMWZEJIIHD4nDinE8RlCubYNccPmVWMKoUsHGFh
	 D92LqkBP6CYDkO71XDY8IufAeMBHQgq4AmR7PnhGqxOxFqVAgDdeSPRPkmxXLGfpOK
	 GZvuU6HaTppnAQphjwa0P6QXn0Qo4t3AxpqGBlMwFaoE8bdR9XntxEaEQv9ydQDMrS
	 bb+U5UQj5Uvpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E333822E4C;
	Mon, 14 Oct 2024 19:23:10 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.12-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zw0g5xS5WXYve0Hj@debian>
References: <Zw0g5xS5WXYve0Hj@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <Zw0g5xS5WXYve0Hj@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.12-rc4-fixes
X-PR-Tracked-Commit-Id: ae54567eaa87fd863ab61084a3828e1c36b0ffb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63fa605041843b50ebc8dca6483dbfa6e835c61a
Message-Id: <172893378871.615880.7545042172265090461.pr-tracker-bot@kernel.org>
Date: Mon, 14 Oct 2024 19:23:08 +0000
To: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 14 Oct 2024 21:47:19 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.12-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63fa605041843b50ebc8dca6483dbfa6e835c61a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

