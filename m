Return-Path: <linux-kernel+bounces-185315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45728CB362
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216F71C21B84
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFBF14901C;
	Tue, 21 May 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBzx5aXC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD236149007;
	Tue, 21 May 2024 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315230; cv=none; b=IRQoqaGCXXPRKUMDzpUTT+HZOOm70r1xFpIYXuibxbHQK5dx7M5d05NeGHiWpONWMvx26Lz3JhrMx1M4YK/Ss92Cs1EP6dfSN8o7JVaJAo43G+V4yFZZm3oz4SULxXhIw02XNbPNNBjL6rrXYJWLBUSrY76ngu4hEcaYkf8xLsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315230; c=relaxed/simple;
	bh=x+IsdV8M2pqNEvj1Xztj0JRrBS3zZ1SmhVxUBR+/rFM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PusahT1rykJ4rWdBPC0VxZuOVQE6J3VdPXnUFiNOy7aTQd2QcfxpS1wZyEvYszwU9PwXKzhicNczHAjrzVrKqCuYLyfluzNh00cZqwZ7bwSucUGC/wWuSpaWPbw6Em9/U1+IRCyCxUDArIQJgybKInn4oXqX3F8NDINkVRxej80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBzx5aXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD523C32789;
	Tue, 21 May 2024 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716315229;
	bh=x+IsdV8M2pqNEvj1Xztj0JRrBS3zZ1SmhVxUBR+/rFM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JBzx5aXCSX48KOajWaXZj9+BsdXlY13Rnd0Q2uoM6+JzN47KJB52ShZGwIAU4MzH2
	 Vwvl3gmX9hjo0A1VcOwEms7VZ9pJZSk8qxai+CtBDBbjz+nrBWPxyOyahUfQswqM2F
	 uVBVRrXn7EfjXrmtCD8GLdma6vxEnnTEdyfLElYryBTRThBvhZkUBTpkn+Ls3s777I
	 HgyvvCT5yTCKRaKJKv4ZSVg7ChMsrytofMw7XVjFu2RFsrU+LUqe2iisiF9IwJnPpt
	 y4z+DjF4Xvq2EXGsSV0swsN0vlilJ4NuQ4M4UQQwcnPui/9UX8oVxje0eHUhSV5Oz4
	 n5wrOdoqASV2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4D65C4936D;
	Tue, 21 May 2024 18:13:49 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240521031222.236250-1-andersson@kernel.org>
References: <20240521031222.236250-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240521031222.236250-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.10
X-PR-Tracked-Commit-Id: 4d5ba6ead1dc9fa298d727e92db40cd98564d1ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab7b884a34ffda718cb93c772f575e45e8241c62
Message-Id: <171631522973.20025.14554558609163200653.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 18:13:49 +0000
To: Bjorn Andersson <andersson@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, Tanmay Shah <tanmay.shah@amd.com>, Luca Weiss <luca@z3ntu.xyz>, Olivia Wen <olivia.wen@mediatek.com>, Beleswar Padhi <b-padhi@ti.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Apurva Nandan <a-nandan@ti.com>, Dan Carpenter <dan.carpenter@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Leonard Crestez <leonard.crestez@nxp.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "Ricardo B . Marliere" <ricardo@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 May 2024 20:12:20 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab7b884a34ffda718cb93c772f575e45e8241c62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

