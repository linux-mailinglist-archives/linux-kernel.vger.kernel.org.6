Return-Path: <linux-kernel+bounces-351271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D59991076
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F6B3B2D748
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542361E47CA;
	Fri,  4 Oct 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMnE1V5d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED01E3DFA
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067174; cv=none; b=A5f06txYoe7k5HHbNJU7RhU6qW/ezE7uO5N6oPEH7xN4hfrT0ySQNqb/esFXA10Wfe9DGIvpFArsMCK4OUVBA4+rS5ajSjbaw0ZTBviTmBPW2zLCXqPtN05dm0UpgyN3+6yagW9YJa3+h+xPhdOMjGwdiFnNO2vYmTkTdzLEdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067174; c=relaxed/simple;
	bh=2ykzZZbh22oVJUGkvFyufnuf7+aYCIIm3sqRdBAk15Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HY3tEft+xzHIekjUcBhFTuWys2ntc67qYNzEhw83x7ofMAaoeC2jRV4sxBl6R350I8zz1uI1E9RtxG1A6/SvXWvFeUhtxPzTlziHSF99APuMATdmWhmNQgaxgwrpAgx/pW50P0M/tG0IAHgqHweJLD6oPlNRWrJCFMYXvZWVLCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMnE1V5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9956AC4CEC6;
	Fri,  4 Oct 2024 18:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728067174;
	bh=2ykzZZbh22oVJUGkvFyufnuf7+aYCIIm3sqRdBAk15Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lMnE1V5doOKaZ3aH3qWJG7WWuypsyVTppQjMgRX97ciGsamn2SvDYstyBpPaTg2+/
	 pXd1YC9FXMrrSY++CQxh4iWsjBhPpL1yRWjumeHQ10yqhcqYT68uQ8OouyGwVfRlBZ
	 E2PMiZqtnGmUBW36Cg5oP6OEPsm+5okp+f5GOJyr4gq/bLjGQgQ83c2zfeaW3uI62s
	 UsDPD1kirtQePJzf1eRfXDq/684A87v45owTcOhZtHM5wb0CPiTCmiio6Ii6OUxH6+
	 sZSXsMuEi8x55GIcsYDlYN3O9DUWwKqWAsesSVkfrEnETHawlfgVHQqk7yPxAv9fWL
	 SYxtIe294iOmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7132C39F76FF;
	Fri,  4 Oct 2024 18:39:39 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twn+on88T+O=_6LmVt2u-Lipxx3q_bp566owK9t+9UuMg@mail.gmail.com>
References: <CAPM=9twn+on88T+O=_6LmVt2u-Lipxx3q_bp566owK9t+9UuMg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twn+on88T+O=_6LmVt2u-Lipxx3q_bp566owK9t+9UuMg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-10-04
X-PR-Tracked-Commit-Id: 5b272bf7dcf969eb4f19ef994b6e60458ee6300f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe6fceceaecf4c7488832be18a37ddf9213782bc
Message-Id: <172806717802.2698437.9192339503974154951.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 18:39:38 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 14:06:23 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2024-10-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe6fceceaecf4c7488832be18a37ddf9213782bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

