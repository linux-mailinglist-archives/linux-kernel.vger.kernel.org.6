Return-Path: <linux-kernel+bounces-434064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43A89E611E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A9E283901
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8591CF7A1;
	Thu,  5 Dec 2024 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vauq2aMr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4DB17E019;
	Thu,  5 Dec 2024 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733440112; cv=none; b=HZqkVmQyfqQQa+7w9f4+zEHDFF450+yTCBah78kcE93yCQuMa42nYL0H0Buinq+nBhRofzd+yUK2JU2EIEGkVgw5wgwVzVSduhmQPIBuYP4xMnqxVf0DDYETC4279hzqaEeVfkq1q/6X5jdomQ5pWkPl1zh3nVLsZ/ct/upHTg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733440112; c=relaxed/simple;
	bh=l5itN6jJsYZ+AJB5ItI5Q1jUVnzfK64kYskaToMDUzM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cOfrt8QHznBLbuHmcqQ4uy1hmSALp/L4xiyASvTraIk3Xh65KwcoN+s+bz5gS12xOxdmqufdMYtPVXxhudIQer3s3iCJs3f8CK/IK5x9vRdJBEGDlXye8Y+gV5CV9ga4KC7dp4f6TVgNjzttxWLkdDDxo1E7UkDaYUPNLie4Hjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vauq2aMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F56C4CED1;
	Thu,  5 Dec 2024 23:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733440112;
	bh=l5itN6jJsYZ+AJB5ItI5Q1jUVnzfK64kYskaToMDUzM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vauq2aMrw73x45xXlj+F5LZtKWXvzibjR05VX53J2b8HeZ1BYVemv8rjQdYpDfnPY
	 08luGepFvlW+yQFYkhnh7kCYouOujaWVQTBq9vsiNrg+LFNTvkW0kdf55MvawqzYOC
	 TOJSwvha6CJR8bw7LDGfWLphMm8/dBXa3ICMvrkPpjxt+yxCsDEbmQJuQbPleZjVtO
	 BZ/MbD8DppCcebTH1fb+1vq3qsbSnMwFfyGLhmsYcpahTdSG6prG75aBM1SClUW48K
	 GKiFrqWBuVKZEsXalcqeaiEdrZp/zEI/O/QyX+hDZpG59saGdkxBt4yxpAnC/OvFqq
	 BaghTnBtumh2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1AC380A952;
	Thu,  5 Dec 2024 23:08:47 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtvv021NNhBaHt2byQkFvPJ1cJ_oFSog02hOuRX2p8kpQ@mail.gmail.com>
References: <CAH2r5mtvv021NNhBaHt2byQkFvPJ1cJ_oFSog02hOuRX2p8kpQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtvv021NNhBaHt2byQkFvPJ1cJ_oFSog02hOuRX2p8kpQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/v6.13-rc1-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: 06a025448b572c3bd78dd23a31488a0907cd9512
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f65289a87128cfcf9c40739adbf495cdbb617cb3
Message-Id: <173344012656.2095723.18323334983593594748.pr-tracker-bot@kernel.org>
Date: Thu, 05 Dec 2024 23:08:46 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 5 Dec 2024 10:17:31 -0600:

> git://git.samba.org/ksmbd.git tags/v6.13-rc1-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f65289a87128cfcf9c40739adbf495cdbb617cb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

