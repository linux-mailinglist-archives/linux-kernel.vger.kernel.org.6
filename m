Return-Path: <linux-kernel+bounces-440635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1579EC212
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C06628399A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920721FCCFA;
	Wed, 11 Dec 2024 02:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKj6HfA/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71651FCCE2;
	Wed, 11 Dec 2024 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883990; cv=none; b=fL6BbovZmxAROph+g/fMJSH+V8wTkc2AObOEzT4XT4O1VNu/c+Sn8zw5TY2nt2o3hEYz633FZhHKpx8MlGnWRGTSwif+rDaU4IRjFspDsDblOyAPtOwFo5UBxDITDVgcu+IiLfd3SMEE/egDdqILoB0zmk1VZOBauDtVtlyAE2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883990; c=relaxed/simple;
	bh=VVWsL3bzXwWaTK/96d2eEnfiC9MjmcQoxiSnMvbWUPw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BkhbmEmY5piCQZEuGu/OmWv30IVvCxsXYFWKnmLst1hHfbYHSSWCnx+DUsaBC/kzgMNPjacZSfcfqQo8eNBiyc8axnXt/crdqL1NrxF1osiG6dJoiIJPlb4XPifnNwQhtGODGahQWgti3k/LKEMiYvL0cHSY18cTnwdwYKzM3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKj6HfA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59366C4CED6;
	Wed, 11 Dec 2024 02:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733883990;
	bh=VVWsL3bzXwWaTK/96d2eEnfiC9MjmcQoxiSnMvbWUPw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dKj6HfA/qmKYAGNWY/eWeKFXViXAj9H19ElBPDVzWaQaljH9uvei1428TUhwAlBCj
	 SD7Q9iYeqZhCx9PalNS2eI9e1okm1Pw3fXDhCTzrtJBCL/0Ec8DKiDz3y5Bx36SajR
	 LtNbgBM6s99mQsiUh7QA6DQERNgAXboIvERzG0YA78okPF28jxi1nsr3A60VRRIxMq
	 K5S6RuYmBNgJUcBF+2gpNqtqXB0Laoe4u1U4onrDyyqrXW5rIJxyNMEu1uzhOsidD3
	 2TQ6OS04s/GL4rXvDtRpfOENlTjbt4YTrA10xlo2wgDpEp3ECGHdvy3GRywIcb3Bgd
	 UO71b4Svxs+1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C87380A954;
	Wed, 11 Dec 2024 02:26:47 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241211002412.449222-1-sboyd@kernel.org>
References: <20241211002412.449222-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241211002412.449222-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 52fd1709e41d3a85b48bcfe2404a024ebaf30c3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f92f4749861b06fed908d336b4dee1326003291b
Message-Id: <173388400594.1089022.15073636574392835872.pr-tracker-bot@kernel.org>
Date: Wed, 11 Dec 2024 02:26:45 +0000
To: Stephen Boyd <sboyd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 10 Dec 2024 16:24:11 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f92f4749861b06fed908d336b4dee1326003291b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

