Return-Path: <linux-kernel+bounces-263586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D7993D7FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB02828AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7D917D8A9;
	Fri, 26 Jul 2024 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLPBhOJ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287017D899
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017258; cv=none; b=u1qHlb+gilNjC7K3KpnNVD22l2u4ltZNlMeZS7i4W+qZFA2/bs/7TZUm1DyZZqrmWIJW2M9k/FuRlv4Vv8QYLzuHnX7tKpv06TvEDROuTBK9CbwITsprTZfbFnmenGV15qO5h9nT3GM6ag+L5/80qJsDFTdgjWIi4Hgud8Id3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017258; c=relaxed/simple;
	bh=lDHV427QZRtMqiuL8aDbuoPl1OtHauXkgDahfoLIcpM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sQm0pha46YWQpANtgDv3RVSPLXq65ToBpKQkEsypRCD5wqaP6L+5KpRJ2ZClQwJ+c7fML/P+GHkcvuy1lDfbQmwa/HXhJfxQo4HE7vWMy0iAweMuXjI7otl4uqg3lW1uCLbB3rsCa8ArcTu2uNd2C6LvTt8C2YKmXyVI+f+FvGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLPBhOJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B311C4AF07;
	Fri, 26 Jul 2024 18:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722017258;
	bh=lDHV427QZRtMqiuL8aDbuoPl1OtHauXkgDahfoLIcpM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MLPBhOJ4hPZ70ewuQ8eWWJmidBoBdKf/PV2Sr1LsioD6HMjTcI+UUo8oq/9GyjUwv
	 PSeqiZmAafca3rqBnZ1/TqicvG795zUZOmlux0PROQcH5aExeASUPttBys3VRXatv1
	 pysSEQRJ+W2DbmZbaWu+icS8+DNKRRQi3ifrbou6xdeESVlD7iRfCtJMOVSDu7uowo
	 GGqjIi4ica4vBZkFgzGRCf1G/+p81W7SYTIneZcvNV/UGdVD9Mi8RzQYPS+UcRco5R
	 99tPvkeNfA1zmq1Hgo/USY89/IVwEzCMjl3lw7wFzwbWiMIWItVnigRFINV4BbflWj
	 uz65BiTbztbEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 637D1C433E9;
	Fri, 26 Jul 2024 18:07:38 +0000 (UTC)
Subject: Re: [GIT PULL] erofs more updates for 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZqOgy0Xh2hPy4Ojm@debian>
References: <ZqOgy0Xh2hPy4Ojm@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <ZqOgy0Xh2hPy4Ojm@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc1-2
X-PR-Tracked-Commit-Id: 14e9283fb22d0d259820a5f05c6059678bab9ac5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 732c275394305b6d71b4bb74f5432d2d91f05257
Message-Id: <172201725840.32235.15562992456918184265.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jul 2024 18:07:38 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Chen Ni <nichen@iscas.ac.cn>, LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 21:12:43 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.11-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/732c275394305b6d71b4bb74f5432d2d91f05257

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

