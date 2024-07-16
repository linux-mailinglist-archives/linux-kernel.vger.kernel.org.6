Return-Path: <linux-kernel+bounces-254365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EE193323E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5074B28356A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635BD1A08BA;
	Tue, 16 Jul 2024 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igrmwgP+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F81A08B2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158645; cv=none; b=A5Z5N/CdTG6GBNlqy0CwjQi0WFULG8GLnkXnMjybWYVcywi+eWwz6KUGhnSUUihA7873l4v6JEbqdehj0cQB1nLl1O7Xnu9wGKGF5xMQVa/MGFFl8EOZ/7DIF8PRE3yafXAkMKBPL7VBDF78E+uQsp5Cz/SBfmP8/s5Q15O3bHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158645; c=relaxed/simple;
	bh=ezUxYx7dVvX+0XB8qXmtZtrBO88mhcRhMS6b9UsFxPw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CX150M9kc062TCPVuBUU6kdr4hAwuysolncLgAq7uqBP6L4jdn54XQI2/czg+5nrCmuYE1mJhunMrqjIqUsDTLd67Bgo2g0yvEG5215R1+RfyVs1nvsg0PfaBJEgSLsTjcsisfCkIYxUV+bsLRzt7iG1yU6nH3GnlASKlr0z8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igrmwgP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 836AFC4AF0B;
	Tue, 16 Jul 2024 19:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721158645;
	bh=ezUxYx7dVvX+0XB8qXmtZtrBO88mhcRhMS6b9UsFxPw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=igrmwgP+BvFZ204bquq47+UZ/PgAfkHvmB203DiU2A9DXgZb5Tj5QP7QbkKozOaPW
	 LDGNdz9lOcBJQOi/uK06S8oFyx1ZF7/UYnsEcGxpWkSFohksDHJVFKlTB+W8sxUBQf
	 74ezQu5F/CbUTTMs2QxmvfJq10BDqpuOUe17pbyJZbWbpZpAwLVE96Jacp6e2r9z2G
	 kt4yuBb4L5tAu5jD9B6U/4Wfdl02HHt/RwXv5PzmSzMS6x4azGRuY+vjqqEuxtJcCe
	 9w2LXfYo601oHj1v2enyJQ9voe18otYdPI+dQMuEaLbF+XUxog2INzDf09XpyUZxNu
	 r/ICervlb7+kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FE2EC43443;
	Tue, 16 Jul 2024 19:37:25 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715054732.7508-1-jgross@suse.com>
References: <20240715054732.7508-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20240715054732.7508-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.11-rc1-tag
X-PR-Tracked-Commit-Id: 9fe6a8c5b247e182c1781556794324a8e26a7cd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f83e38fc9f1092f8a7a65ff2ea6a1ea6502efaf0
Message-Id: <172115864544.21341.8821775973276387007.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 19:37:25 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 07:47:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.11-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f83e38fc9f1092f8a7a65ff2ea6a1ea6502efaf0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

