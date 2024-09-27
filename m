Return-Path: <linux-kernel+bounces-342148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7F2988B02
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48D6280ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52321C2DA3;
	Fri, 27 Sep 2024 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJXRYlt5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B219308E
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467208; cv=none; b=Ftf3R5ixqbAF+jo1io28G3tkrtX1YX7sYCyItXLZDONBa5Phe4+etfbZUMq8NbaRvEluxJ6lOs5K2DOMyDkJEYxI5NYCgx9EZaY8nD2wkutMGTPu68dkOTbEHHfnpZ9+eKYHT83UcxCssv86mgllkLzGrUzC5wpK1BQ027dka3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467208; c=relaxed/simple;
	bh=pbhyLntCmBmG5WnoN+uNW3p1jxgLshqLGIyKLMvd2Kw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K3qBN9OarTIHwL/bIl+Yk53Rhel+/kWnIuYA7FSCp2P7JJ4gNXd4WNnW4FyfhECcwZUWdaEEI22MRroMaZJrZ1n/B/wqlTSJV9kbhrV5RtFknjH/vCzD0NrqDSXXXDzvGfCgJqU0LkbwmbYsRQpms367YImuxaEwLHZ08dakhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJXRYlt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84883C4CEC4;
	Fri, 27 Sep 2024 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727467207;
	bh=pbhyLntCmBmG5WnoN+uNW3p1jxgLshqLGIyKLMvd2Kw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JJXRYlt5J7qVzDlBe5EhzAbP8+4cVfl9/VcudP4zxpGPUNv0+KvfAgJX0f7MjPIeP
	 HdlGSv58mwBBBZncPx56mlKnNLcZR34zq1dbBed9qhDgHnY7eFuPbmdKy6GRIx1fYX
	 0/5mBhT+y+L0fs5Id9zUsUB/zLKkIIj01Z17MtbhQn5Rgwop0g6KsOpWw03Kx21Crn
	 1rk+tsjFwvqtKbuDjl5R8fLMdnilSrKJ2ouE+2yJiJVGFZqJtO6qPoM/2DoUDbwPsg
	 CDtK11mmS5uNv0O0d7v5GrbpjAdnVOQ+Pr39hSYfAAvxTEPEexrBOmqK76SCkZNSy2
	 Q5S/ohUnUMnfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71ECD3809A80;
	Fri, 27 Sep 2024 20:00:11 +0000 (UTC)
Subject: Re: [GIT PULL] UML updates for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1875454673.111023.1727465292786.JavaMail.zimbra@nod.at>
References: <1875454673.111023.1727465292786.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-um.lists.infradead.org>
X-PR-Tracked-Message-Id: <1875454673.111023.1727465292786.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.12-rc1
X-PR-Tracked-Commit-Id: 381d2f95c8aa575d5d42bf1fe0ea9a70c4bec0cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12cc5240f41a90b7fabc075c92c04846670c6932
Message-Id: <172746721005.2065768.12778610258506118675.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 20:00:10 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 21:28:12 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12cc5240f41a90b7fabc075c92c04846670c6932

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

