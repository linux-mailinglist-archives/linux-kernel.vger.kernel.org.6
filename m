Return-Path: <linux-kernel+bounces-178268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC2E8C4B49
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D20285CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72032D054;
	Tue, 14 May 2024 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8Z6NeTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4518633
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655090; cv=none; b=M6IePVIXxOIMKvhUWdNg0eqDxVqBXT+A1zac8XaQSgkkyp/DNKnbAGUKmrPy+Z1WHqHzyqNTcS997+rtkda4rqBiAEr60aUwMmxWGBgMjhnF39/vssQcZP6AlIMFQzbeNpoFPPP4KAD552mPNdCVVWWZ8Fh2wN2iqOln9aXHfIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655090; c=relaxed/simple;
	bh=yuMmM/M1xVMozSwNFDsHPpEsMFsE3h7YN2F0++wbmHc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TCqrqRHLQtQz2HRRoSYbaK7TC26aJuTKIyEZwjEOIumdW52Xlfu18ffvMY1UFlOnmXyOct6F3fI+qQ6i1bn93lbP4wOF369B572t2ZKORdnT1kAs0XNBpe0G+HPgK8TLbqtZaOIeqvl0QEHw92SNiFDTr5Vh0dalj3abRBZ7CqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8Z6NeTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB7D0C113CC;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655089;
	bh=yuMmM/M1xVMozSwNFDsHPpEsMFsE3h7YN2F0++wbmHc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f8Z6NeTa8pp3lu82Q0Wjy2UyHZfOBSrUC9bs81H3hL4uTd3fAnhG4VM5Eto+Mr2ja
	 c51p6RO6PmuNW4bt1U4ixUIjX5LIE5GN1EixmGa9b7Pm6E737vNcrRkpSOGKR9eMXD
	 NX8mABVt2ollbL+OqsOXJouqiUZP7PWmgSti1sZ5PVt6JiqMhZH9FJk1e66WiMxhIT
	 XGVykNPxfMw/8hhUmcqChmZXCR3sJTioNqt755kNcwDDhbWr4KOMSH9pZi6fPNOV02
	 jLncWGTinecP3zQPO0An2szPabF9ycyYNhbAdnzkOi2iC0377wpIdH437SD9/3iph3
	 KSSyZjaRie8kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3C8CC433F2;
	Tue, 14 May 2024 02:51:29 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkG7O1JtDp8vDNH+@gmail.com>
References: <ZkG7O1JtDp8vDNH+@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkG7O1JtDp8vDNH+@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2024-05-13
X-PR-Tracked-Commit-Id: 71d99ea47fbd3179e01f8037aad1d1367a821de2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d71ec0ed03ae4318746ad379ab2477e5da853c7d
Message-Id: <171565508986.649.331280539367699560.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:29 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 09:03:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d71ec0ed03ae4318746ad379ab2477e5da853c7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

