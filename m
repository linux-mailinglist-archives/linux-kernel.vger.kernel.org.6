Return-Path: <linux-kernel+bounces-425936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B51C9DECB5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47BB2821AD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E335C1A4E76;
	Fri, 29 Nov 2024 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4LUNRBq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6A1A265D;
	Fri, 29 Nov 2024 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912285; cv=none; b=FUYindrpCrDa7XQc6lUmFpTbvsEcjF3C3g0wtYgDyqVnydioXgZ84Yz85bkqVybMd4lQYsxDc0pnHKKCEuS6Ow22p0luoJ9i83Njeey99T3r8iQd5yGsgaOUXi63mhl+hd+iQmMeO5vKBN2urJ9aiRIuKSwAiQ+xqQIxyERYTig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912285; c=relaxed/simple;
	bh=1El1ONckJrf4EeEt/kSr2oW2jD0F1+XKtFmO+UZNLoY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FlqgMF9WhVIcnpl1Jc8QOvqaEfO78uZr0mMs59Bu7Rt31IqMJVAN+ffLynstqc906wQt8iRvyfNh7ainyOBSpt2R6FqQ7Ax98zAU8nVVGiJONerub9/po+RhdeTNhCaFs6oTGHJ0RivBtghx2t6upDQE/DyGunqloipubNR4ZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4LUNRBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9AFC4CECF;
	Fri, 29 Nov 2024 20:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732912285;
	bh=1El1ONckJrf4EeEt/kSr2oW2jD0F1+XKtFmO+UZNLoY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P4LUNRBqOgyrfB6d0fubPpVSB1hwbDHRHEPpDiK/YqZnph/2rBJOVJiQII15jRa7c
	 6BQJj5jUySzFBO4JJI359sc4he8ZxzJAWZ6pjbkIvQgDhkQWCnvyEwd8AJ0enhV9Ja
	 W3Q3LDNWCSSNoNDNRr942NC8XqzTcFeLtO9EwFXynEjNig7lCINK6geTNutQ9w2qc9
	 xyVGWBWT6gYN1IbPiiHjhYIJKPplld0hzoxzfK5/hfd5ReoOS8f00OBMYWQLsLDnqK
	 LiSI7qLimCpWns/11j/+aA3U1SMc5t5MQgZeNGja4nwd4oStvK1xf5GfOlHBO5R3GK
	 zWUufiUUgfIcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF80380A944;
	Fri, 29 Nov 2024 20:31:39 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc/IIO driver changes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0lG-CIjqvSvKWK4@kroah.com>
References: <Z0lG-CIjqvSvKWK4@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0lG-CIjqvSvKWK4@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.13-rc1
X-PR-Tracked-Commit-Id: 5a6c35258d10a4966f45ee48ae24a7d4dad303ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2eff01ee2881becc9daaa0d53477ec202136b1f4
Message-Id: <173291229853.2176319.6994103914502591706.pr-tracker-bot@kernel.org>
Date: Fri, 29 Nov 2024 20:31:38 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, rust-for-linux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 05:45:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2eff01ee2881becc9daaa0d53477ec202136b1f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

