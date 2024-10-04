Return-Path: <linux-kernel+bounces-351317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824E5990FA6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF4C2823AD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B676F1FBCAF;
	Fri,  4 Oct 2024 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0iNUnas"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE31E2823
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069464; cv=none; b=WS4jv3NbWw0Rk36v45CVq29iIlzlzVq/x9iq7wWhPexT2Ab2T3egXgl0rV/GWlE0Ngo6J4+PU1U4L8e6AXK495M7dtJLW8kJ8lcF2PXGCzjDAPzYeiYsCpzN2rOUodaLWFCiYTD/75+4Nc3z4y42Vz6Ll6XCRbJyN49+KBah72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069464; c=relaxed/simple;
	bh=S/YE1ibKTbORnZ5i2pN4IWH/gs5psoODBkaSAbRZ9h8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YxZbR8rUpvwhL590ldh/rnZ4yJNE1/yaGR+uGECj4F0LqLhPawZaRo3qDql4cJLj648juldTQfIrREJ8ZjRpC+GG0JBbOaQb6PMcG+1V2zwDCv4yadbLZnw8mYCz93fPfIVSJn61pGFoVeB8RyQlUeHBrdGHJ+Y3ORgyyilHJgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0iNUnas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB64BC4CEC6;
	Fri,  4 Oct 2024 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728069463;
	bh=S/YE1ibKTbORnZ5i2pN4IWH/gs5psoODBkaSAbRZ9h8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L0iNUnascsCJxv6p9KycpLiZFgceQNFVRHrJTrtas3/lqAWlzuwtY0cG3i0nQZrC8
	 F6uljop/iAMr6syqFcrk4GJa8w/xDo3+bb0zJTfQ2mdPgNaok559oFEb9FmmqcLKy+
	 cfwuLVvS84CQm7iUSZCE0yme0al4Y3UrnWIoYozWxxmZemwtcoeBgDxe6e6QsfRV/d
	 xux+O0ZfB3NaBaq5dJvcXuUCocYb3eoOF7UhTAtCmb7wJJBa4qJpCEiPI3VoLwTQ8M
	 dA0Zh/wxM34Wz3380Kw5oTEvMxgG+lOPb5nAX+ZNyrHOXo+aedFwZMsmMTQFlgbVRh
	 inkY9hMVGvCqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7111A39F76FF;
	Fri,  4 Oct 2024 19:17:48 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Various fixes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241004121815.18a7ad46@gandalf.local.home>
References: <20241004121815.18a7ad46@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241004121815.18a7ad46@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.12-rc1
X-PR-Tracked-Commit-Id: 2a13ca2e8abb12ee43ada8a107dadca83f140937
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 622a3ed1accbb8e008a7247317bf3e8bc1fd7665
Message-Id: <172806946701.2711222.7648211289982892169.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 19:17:47 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ben Hutchings <benh@debian.org>, Eder Zulian <ezulian@redhat.com>, Sami Tolvanen <samitolvanen@google.com>, Wei Li <liwei391@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 12:18:15 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/622a3ed1accbb8e008a7247317bf3e8bc1fd7665

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

