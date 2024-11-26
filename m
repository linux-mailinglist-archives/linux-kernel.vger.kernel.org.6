Return-Path: <linux-kernel+bounces-422872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466159D9F33
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C3CB2456F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FAD1C07C0;
	Tue, 26 Nov 2024 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkbIK/Sg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32721DFDAE;
	Tue, 26 Nov 2024 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660289; cv=none; b=h1CH1t/iY6FzzJRAtWQ4nkryimV/DvAuH4lj/jV6wYTdOK/u+MSICLR/lg3xL9rSScKN8Q4+S+CBDSu8ToNoMvpqYydQmsSVLyDIrkBExdg+RPK0N6CufSUHfDg3TyBTcHnfmRzNQ2yllRDJ1gGK2+lWNnl9QUdihN58UgECnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660289; c=relaxed/simple;
	bh=eX8uPoIwd+4/O8t5v3m1MD2GdS34JnsRPLhBGj1rDrA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=axG7whnGiQ/yuMDcni29DQulTHT1gzBAE24Rw4Jycbi0ZBbytTMsqGNJDNSxQ3WDdDNzvHohYw56uzvLJgdhkfFt0b6Vbmw10H9mvOQvWwlGsuWBKY5SwRzMM7JFkvFEujPG8BB+q3TWjQ+Es339IPpgD2V4i7iuIDdz8SVkoZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkbIK/Sg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402B6C4CED2;
	Tue, 26 Nov 2024 22:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732660289;
	bh=eX8uPoIwd+4/O8t5v3m1MD2GdS34JnsRPLhBGj1rDrA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JkbIK/Sgat4arvgy0JPZkb8yGfyoOqMSjr+i1s47C+WRN4y2PSzaZdWLX0GvV/7qq
	 y0Isv17WI4XTmrQ/28UAf/3XiVUh0Wo9zKqXf5EOJTDdFRlEw1P7vG3EEQ0rUBK5M8
	 gHOW/MA9G90C7Ug+KR2kcuAn5Ha5gPdwZULWnrS0OmuHPhomP7ENoWVm385Qfqqx6H
	 ioFxYNKG0LHEttPJcZtIc1kPqfTkXtlK/Pe59fu0c+50rTY/wOa9p2fbzfD/Odld0y
	 Z6lzhWRqvxtJH2xcusjlsHuq15wNBMuD4boRDgr3wgnmsI2QOUrbrVziMgKK1D92ev
	 VypUSJDQhf7hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 675443809A01;
	Tue, 26 Nov 2024 22:31:43 +0000 (UTC)
Subject: Re: [GIT PULL] A bit more documentation for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <8734jeam3m.fsf@trenco.lwn.net>
References: <8734jeam3m.fsf@trenco.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <8734jeam3m.fsf@trenco.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.13-2
X-PR-Tracked-Commit-Id: 83a474c11e8cb59e230a43365cb42fa00d3bddaa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e68ce9474a1dac72ea9b1eab25bcd7a5b28adc79
Message-Id: <173266030212.560344.8616427284190869535.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 22:31:42 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 Nov 2024 17:13:17 -0700:

> git://git.lwn.net/linux.git tags/docs-6.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e68ce9474a1dac72ea9b1eab25bcd7a5b28adc79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

