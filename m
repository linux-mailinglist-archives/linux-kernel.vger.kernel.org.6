Return-Path: <linux-kernel+bounces-340922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B32987911
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 20:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1103F1F21F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9387165EE9;
	Thu, 26 Sep 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt3J1T6M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C301474B5;
	Thu, 26 Sep 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374903; cv=none; b=QVRugiFd7lhhrpcgdRxTmZjdJdmeF0a5rHb82R9yTP9iP9RRfPsOnTwFVuAo8pKlpmsUDbDSy1KXOj7HS5qPlESLxCOumcO7pa6rFhlOAMZnfQHrA5/h6DHmMOpNqSl5WlNnS8R6Aw8K28PLbbTgI7aijx/5mT2cPCioJIZQyA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374903; c=relaxed/simple;
	bh=mEeJQhpXTP9wropc/9whu3I2ybgXzevX7OLX++IG3vs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UFxDe00Y0HaYzKHDbu8Prp2fl4wtG4dxGtoO+vo8xilpCJ4B0DkCSyFgjmHVQq0aF/j6LD96BZJbExGikHycYNGimqPANoK5CuApXUwSLqrntaLxIqZaT5L7i1yTWyPWCKJdXnaI0Qo0JFVAJ8zbYKX+qNhejNFPZvGB7KN56ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt3J1T6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D84C4CEC6;
	Thu, 26 Sep 2024 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727374902;
	bh=mEeJQhpXTP9wropc/9whu3I2ybgXzevX7OLX++IG3vs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Pt3J1T6M09eHj+TVO/KyInKxNVuR8Y6c3tjEQ4m+WPHl3V7ycH23nbh02nrRnFDIn
	 hf4LevepSIGcdwexM2WzQdS719WciYuFvZJynQzzSKlbcXaFdKYJpyM7tzOup5bcyR
	 Gg3qyoCvS0saNRe/PWTVgTUH61akP3z4bdd9t0X53yAwvD8A9a5cnjskHUcz4LM76D
	 50ikXItIgEau+cZDc5mpGBcWv8knNVDKU+DQOra/NbOvYiRuTHhKSxcm+HFgztBjC4
	 /iY8lbv9C141MICsFrcUyqyrCKWj/x9IwR+uft3KnRyHlB86Af9gy7Aj2chJYuj/j3
	 b8fhJy2blf41Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1563809A8F;
	Thu, 26 Sep 2024 18:21:46 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240926151325.43239-1-pabeni@redhat.com>
References: <20240926151325.43239-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240926151325.43239-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.12-rc1
X-PR-Tracked-Commit-Id: aef3a58b06fa9d452ba863999ac34be1d0c65172
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62a0e2fa40c5c06742b8b4997ba5095a3ec28503
Message-Id: <172737490533.1352926.2654461438977148911.pr-tracker-bot@kernel.org>
Date: Thu, 26 Sep 2024 18:21:45 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Sep 2024 17:13:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62a0e2fa40c5c06742b8b4997ba5095a3ec28503

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

