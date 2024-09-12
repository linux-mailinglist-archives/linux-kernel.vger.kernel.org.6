Return-Path: <linux-kernel+bounces-327231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9818397729C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D165A1C231D2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490396FBF;
	Thu, 12 Sep 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGmb2x16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59C1C1ADC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172120; cv=none; b=c/Zwa0T/Hrsiysao1Kpht83u84Wro5czSsbW4LZYtXe81higgZR1tvhBVWzOYvdx1een8frzVrhNPjvr0bwpiamhsni+DTu+U2PSuV6voJX1ejpQKdvuyF1zgGuMiEu5UR359tQa1OAbjU9jDr5xGxZJ2+F1JmMUrVzrM24M/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172120; c=relaxed/simple;
	bh=VSxq9wo0FqJFJ2OICBSnSh8NotamViIrO5uDOLR1774=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KlUiDtNHAeeDwwM0R4ewHjniKxnEPzP7phDwvAi+v/x7dEO09sFF4q2kt0lZKzM0u6MDR+RrgjEvr7NysB0SQBuZPJ26wBBLU9VOG377FaQSjHFt/rdQ+eyizqTZcaLXhPWO9PB34RGD16S2JFooaWiC9oTvwP+rcYQPgo+WS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGmb2x16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB27C4CECC;
	Thu, 12 Sep 2024 20:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726172120;
	bh=VSxq9wo0FqJFJ2OICBSnSh8NotamViIrO5uDOLR1774=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OGmb2x16RVNBCyx5y2c2GXDDiOgHz9sAVLkcZjopMgxHoK7An3619g0WNQNFJbLhb
	 ruY+W5Sp92pxKYKLQyIdbw/OP1ofUHF1sBWELp0wEDCmYaxafSgGhREI0q/3mQWR7/
	 OL59Q8Kb5YqoZs/RMhVR+INjHIUL6ccMyXrEmyYRPC6xkaBaQugWgz0iDkMQ1ZNltj
	 hnOa6YAB5zJvmiIqfUwaZlhrdQxTiIuXb8MATQw2drYgg2z4fDr4dYvieYscCIp4yZ
	 k2BdT3iunhduZjQwNF1LVho9kZqcZTzfgzBRtGKI63UCooTRNp/houCoGzDcxEH69H
	 iWdMdLPxYx2Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE76B3822D1B;
	Thu, 12 Sep 2024 20:15:22 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Fixes for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZuM56t-kul8mRw9d@slm.duckdns.org>
References: <ZuM56t-kul8mRw9d@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZuM56t-kul8mRw9d@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11-rc7-fixes
X-PR-Tracked-Commit-Id: 73613840a8896f4f859eea489cb4a7a656939e70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5da028864fde4856398f9dfb922aa0545dbad271
Message-Id: <172617212138.1705632.14843697259374209383.pr-tracker-bot@kernel.org>
Date: Thu, 12 Sep 2024 20:15:21 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 08:58:50 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.11-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5da028864fde4856398f9dfb922aa0545dbad271

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

