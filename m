Return-Path: <linux-kernel+bounces-188947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A03F58CE8DE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24BDFB20C08
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038B1130E30;
	Fri, 24 May 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STgF2q6O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88909130483
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569127; cv=none; b=SQAh/IgJVlhwbOCszMyZ3Tgmg9QQwtu6TXPOsmb9zBhiXk7IeS/2jHUfVQcvx1XL5vEsX7fyTdnNxxbiD/6T716yJq75OC1q/LMkpdO5L80Ts2f1QG7DtBjqwzK0KIE64Tu/g/CVxXunowckGv2LVdpXwEQ7FEREyuDy4G94bjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569127; c=relaxed/simple;
	bh=ozTP1Gzp6c9BpT25/+sBCPNKeJIm8Q21Qstys50GJCs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gOEreyYA1R0Q354tuU92oahyNyWwyv8dp/LJY0PbtJVZu9HxJtX3eNdnnGcZT3Qr5dkYYdGKpjE0eojzqz6fWOmUczFLWroD/uX6dPiJqIz7d3JkvYXjsnRvnAYYODWtHqpouozhWgMlE054zYJCoNbGiue70TfZnaHBW22WR7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STgF2q6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A278C32789;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716569127;
	bh=ozTP1Gzp6c9BpT25/+sBCPNKeJIm8Q21Qstys50GJCs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=STgF2q6O6KFzjP9KG6Lkslrs3yQ119HQlsBpTVdMqvUWYrVrvDxL1mrmILCZxqh2k
	 EZKsCWaNCzYIR/qZ+WmpXrx+2Wvn6HugHK/YPSe33XR1CMLyWGGhI4NP0jvzuiSi7W
	 sOzRNGYxxPKoLd5QsUl0CcEdMi2JetiKvkMIysHSBQUqCDe8ArxIpNvq8DeabGNS6b
	 ygUfDl3ez70nP9g2KiH4Kxq9laF+U5rhMlEm09xH1oiwHSvoWduXD88CDS2xpCqW4b
	 titNqbmZEha7DsGn/9VNfdKXN5U8wfa4u4XONs2ZDgORou6HGK8eJ/EwPoHJMQuDB6
	 mn3NGnGZUZUBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CC56C4332E;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
Subject: Re: [GIT PULL] erofs more updates for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZlCc2s0h0H1v16er@debian>
References: <ZlCc2s0h0H1v16er@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZlCc2s0h0H1v16er@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc1-2
X-PR-Tracked-Commit-Id: 80eb4f62056d6ae709bdd0636ab96ce660f494b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcb9f48667824399e496113f2374d08e6aa59770
Message-Id: <171656912737.29701.1703227778398439623.pr-tracker-bot@kernel.org>
Date: Fri, 24 May 2024 16:45:27 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>, Hongzhen Luo <hongzhen@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, Chao Yu <chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 May 2024 21:57:46 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.10-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcb9f48667824399e496113f2374d08e6aa59770

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

