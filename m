Return-Path: <linux-kernel+bounces-393911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACA69BA763
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82538281EE8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 18:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A117B428;
	Sun,  3 Nov 2024 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trZlmqhT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF7142659
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730658556; cv=none; b=svIG6GU0N/14yhTMh/z24cM4oCLe2970J3Sgu/Mm00w1XaE4pQmV6JobgZzRqvx9bmBcnH+4hXxmhi5UEUV1N0t99rOQcpXUvx17m/XnC4ILtJNWtFOz9GukcEF3c/R5Fh1/VAzs5KiSYi8V6/EASbBSTR2At3NLUBWcud7bBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730658556; c=relaxed/simple;
	bh=sJfTnEf/D0NKggjeino+xyEMcW/OtEFzzfpwVhS1h6U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TKfTOddrwXvlUeP3PtZKsQ3WWai4l/I4HTskI3S2Tyr8JS166hY3j7LahpkUgpsTIbsA039DhWddSLxV2Oh95iD/qXwXekwoc1VNXKqUiUAXMaaNvATFIvCS+i0DSttU2w9uBalXM3xkqbOMFd9PiSJ3YdOjGgkaeUTrQ8jpNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trZlmqhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46DCC4CECD;
	Sun,  3 Nov 2024 18:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730658555;
	bh=sJfTnEf/D0NKggjeino+xyEMcW/OtEFzzfpwVhS1h6U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=trZlmqhTS2J6tk81GNuFD+AHXN3Dm9JKa3pEJ9dnvTSReD38NWasTEKRvjJboJiAF
	 +zQxzHIjzMTzlz+UwCKC8zo1On+ZGBpeOnTNN80dNmL86nqF1V1/DgNOC6CIBJZf/N
	 orlucCkp8rRSMllwU/3KGIEEiQXsztcz6w2pETQ581UjUZNDue8sXRWxT304k0taCU
	 14UZHxRygqbIlJFVQ01HabLHzrVJciU3WO6WovzZigyP3X1C0tCq2MaFDy7rldHLfK
	 esgDqABN6QZlD+FO5Ecfb25qKaHEQLpR7sAAdtxOQ0YHolKAsV90W8aUk8FBbp8tfO
	 1fvLSDq9aMBNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F6538363C3;
	Sun,  3 Nov 2024 18:29:25 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <173062982864.1467946.2540622433845043721.tglx@xen13>
References: <173062982864.1467946.2540622433845043721.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <173062982864.1467946.2540622433845043721.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-11-03
X-PR-Tracked-Commit-Id: e6c24e2d05bb05de96ffb9bdb0ee62d20ad526f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f0b844adc096feee437c6271a1419ee81383fc6
Message-Id: <173065856413.3226528.4801659737789684175.pr-tracker-bot@kernel.org>
Date: Sun, 03 Nov 2024 18:29:24 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  3 Nov 2024 11:30:58 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-11-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f0b844adc096feee437c6271a1419ee81383fc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

