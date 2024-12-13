Return-Path: <linux-kernel+bounces-445320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A8D9F149B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8F316A24D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175B71EB9FF;
	Fri, 13 Dec 2024 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa4KxUIT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91B1E885A;
	Fri, 13 Dec 2024 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112845; cv=none; b=EGe5i5lk4WRpyR/PQBie2gNrG3LATIoPa0macBM9e+aD2Yz+O5HAc56SDjd97ZEoSoD0XmrTXB9DcG+NlaBtQJrrA8gRwSLeePQCD1VHMQoYVVF5NwaZzMDW7E/yLxkmHjMTn8ilEwepVVy7VVeSeziXJqBOpCdHb4TmlwQsM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112845; c=relaxed/simple;
	bh=WgB2jziZv49k7KWhEC//JPDky76w9/53XoNiCw/2/Pc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=THVigiy/nRGczCw62sWHPojSkA1KGlBvd7TA1FCQtoYBgnqu9xmi9OMgHtS61q1Yn9DmNXzCVzawsYHOV+XCH1W7flGEHPonjhA5FaXKr//NDQilNdgVcK/hJdOmuIP8fuqe3SH+4R2zAlPLD1dWFKYwcddxebVgOpLdbFXWOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa4KxUIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0267CC4CED0;
	Fri, 13 Dec 2024 18:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734112845;
	bh=WgB2jziZv49k7KWhEC//JPDky76w9/53XoNiCw/2/Pc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Aa4KxUITO0df9FYGd5X54Eq7Hv+cRt8q77sMxlOF6mqQHlsZqKcGdR/gV2Zjtmi5K
	 sha1azfET7pjN7oOXnrH3Gkh9Wkfq1KWQJpuSeddQt9sMBLQe0aqX1iaUanuviN/Ow
	 p2+oELP7SyZ+H1fd6+vu+QGxJ2JfiJKKCKujNiMzUSRkfZKNgWBeqLaOGp4pPTXfuI
	 ehCe2ntMYFTNeq5T3xcV+UWgju2xVKLwHq9QKxDYIizf2h/I+QsHX+6dLSe34GDmal
	 m43C6460xGfaOgwP93m7yTNyFO0LYqAkUM1/bEy1M96IH4OGfJXucLJ4gvNlOOir6K
	 +f8J9uVPB3hBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0F2380A959;
	Fri, 13 Dec 2024 18:01:02 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fix for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <87pllvy57r.fsf@trenco.lwn.net>
References: <87pllvy57r.fsf@trenco.lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pllvy57r.fsf@trenco.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.13-fix
X-PR-Tracked-Commit-Id: d9339496729f1471b8dc326face17c4cf108b027
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3170b7d9319f79235a4747164ba1aaba981e758
Message-Id: <173411286146.3116882.9541776255412455989.pr-tracker-bot@kernel.org>
Date: Fri, 13 Dec 2024 18:01:01 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Dec 2024 08:26:16 -0700:

> git://git.lwn.net/linux.git tags/docs-6.13-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3170b7d9319f79235a4747164ba1aaba981e758

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

