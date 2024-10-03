Return-Path: <linux-kernel+bounces-349345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF6B98F497
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935231F22520
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919441A76D4;
	Thu,  3 Oct 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEqU1nwL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E31A4F09;
	Thu,  3 Oct 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974402; cv=none; b=GKdyLQYcqT5901W9nRTuH1DPtuVinEchWbxSjzTI1V/ewqcvjdPBhZATwk9zDJWl9sbZz6Kzuv42kIsUEPwNuS5VW9CS8KLCVw9AykAIXdTjWtQsDr2UeY0/bP4K71rE3Zzv6Js8tonvfMOEkuSqUEFUKhPLSMzheC3i/Q4Jt9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974402; c=relaxed/simple;
	bh=FOSrcqxsgXEE5JHZeHxy5Ro5qYdXv1589OgPtwQ6cWc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kduVIPF2c2tLz3f2qQKC2+IeP0s/05gHZ7j8wHcUJgvlR4OHYsHmZ4HrbONDd337gIds1pdDpvuEP9VjretZkPEilqAUQwxVYcgc1W9C3BlMS1PKX60PAvgGaRyKwobuZKyIkgl7zFpW7iwQjIlEaUjaizVLHZ029ruh9Vdgvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEqU1nwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60BAC4CECD;
	Thu,  3 Oct 2024 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727974401;
	bh=FOSrcqxsgXEE5JHZeHxy5Ro5qYdXv1589OgPtwQ6cWc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KEqU1nwLLI5ShtMn42hq6lk/IOO8AALr9IoUXASNCGV+wQqHvRtZtXqYqSKqj5NAa
	 PteU6CJJLf5eX5D2SDdwtkzgKqI7/9D3hOM407kSzhxHHYAULHKxEuZyf4EcIRxOFO
	 6NNwiEdpFHgWsEvDXHDbc2S96AKMnQse6zYpuklwfx0dnOkgnkyE9JKYvvyFZzq1Y5
	 PQJSd2MtsbBRVK9c/3869Zv9xx8sXQn2T3tl6bwaF/iS7EDE9a/0Fyw5fEPqLNdr7z
	 QHuWRUkScofSFtxHijUmHttXKuoGTxaA+UQRn2mJTHBIqMBZSMyb4j6ulEjWg+tGE0
	 up2LKNMxCUX+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB83803263;
	Thu,  3 Oct 2024 16:53:26 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241003132302.26857-1-pabeni@redhat.com>
References: <20241003132302.26857-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241003132302.26857-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc2
X-PR-Tracked-Commit-Id: 8beee4d8dee76b67c75dc91fd8185d91e845c160
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c245fe7dde3bf776253550fc914a36293db4ff3
Message-Id: <172797440508.1922078.1024509268807312955.pr-tracker-bot@kernel.org>
Date: Thu, 03 Oct 2024 16:53:25 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  3 Oct 2024 15:23:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c245fe7dde3bf776253550fc914a36293db4ff3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

