Return-Path: <linux-kernel+bounces-264255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC8993E0CC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA131C20C65
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D9718784B;
	Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuhiFf4Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EEC187552
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110843; cv=none; b=e1gkuPwH39nAYjp+IxjbOHaAQDtYat/CicKhxmooF+1n5IJjUB/bxHPeNsdFMyIXWW3zmJcKVXwXrEsGM1aERCGTIJ2ckY/eZ0blOtwXGshfJfF0ivTn48eqvB0mDwZ01uXblNtYTF8AwAk5+Js8jt/0oQ+A2M2bNz3WFxyYhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110843; c=relaxed/simple;
	bh=GXzX7Bh5FzfCbOvFuuUV+xdEP1fi8kCBTU+0qCZVGU0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dtIRU+9sy09ZxHovuJvRvwzG7lErJJOUmMk47DJl61QsxxFLZF5fmT5S8Im5ALeWLUcqV7lL2ZVtk6QGA4g96j0roMDdhTnUCFzIHZqUJKp/Ajgini5W7NO/X6GxAYxTYahznYWiRlWU6wBppzmhbpaIvFXlvnOxVJCKFbEdQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuhiFf4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C1EEC4AF0B;
	Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722110843;
	bh=GXzX7Bh5FzfCbOvFuuUV+xdEP1fi8kCBTU+0qCZVGU0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YuhiFf4ZtQKWzDis2s6TEAfg++0Q8AgWlKTBjZNUExObaZBg1hk+4hHkk7TRvYenL
	 3pnmltXbesEl6jn5uzKv3BlOEMKXXFmM1aT1MLveBJUu8IpLoSYakG2OE749ay6ywT
	 1b9HGnrOq7agz3Q6fAwC1fBJQMMNCZo/YSjeQQlQ96fdxWf4Qo2TPg0npca3vLIRir
	 D+mCZlK6cQbyCT5YxYAgb3rg8KUFMXiQNf9DgDuvlscibNLHQMj0QVTZJkdzTuS6i9
	 zBjxTs0ggIg3ibIlGF70T5/y6RxGKZrodTfjJyrwjOhezPUJ2MKptjApG38qPEib5Y
	 2oxQkfLOhUH4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 119CEC43601;
	Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.11-rc1 take 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240726095758.15879-1-jgross@suse.com>
References: <20240726095758.15879-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240726095758.15879-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.11-rc1a-tag
X-PR-Tracked-Commit-Id: 4c006734898a113a64a528027274a571b04af95a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c17f1224b8d79339e9f2156fdf2966281cdb31df
Message-Id: <172211084306.16614.4055916101052089743.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 20:07:23 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 11:57:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.11-rc1a-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c17f1224b8d79339e9f2156fdf2966281cdb31df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

