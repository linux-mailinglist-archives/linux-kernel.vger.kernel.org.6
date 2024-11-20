Return-Path: <linux-kernel+bounces-416270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5389D42B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9151FB237D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECD11C1F01;
	Wed, 20 Nov 2024 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY6p71QI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA971BD9FC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132304; cv=none; b=cEVcx+mI+ge/7vH2kH9RghILVYfREAlnzIcA5lZSfSfwBxlOd02DGOVnRI3qBzYOVOvJ3OZvhpGO8pAsNIsoCRV+TrnB9SeRWrgBz3YxfE2oa6Kh0oz/HkR2OANyOfKhZb3duOcEptBYKHWwNlZvLWWFFd5rkSgGj1UK/65ZGj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132304; c=relaxed/simple;
	bh=SB2DNbCthho3B1tAuxpcrE0NkOWyMMnrmJZiQ0v9xJQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g/6gVa+bD3eJzZIRqBj/FgHTzc+WaLEABapCTgs3JtVSgOe/wrjIoctWwT0h+tEWz7N4HAjXmd36ygePBJGANobc6rjMRvsN4FL2QSYN7DE651eWIKJ3ogsDKu+Y3PGgfOquwJAOTKc4mHSO8KMJtFHz317yeE7+DjOJjdgdxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY6p71QI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31890C4CED0;
	Wed, 20 Nov 2024 19:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732132304;
	bh=SB2DNbCthho3B1tAuxpcrE0NkOWyMMnrmJZiQ0v9xJQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cY6p71QI1Ss2PE/b+lPvwxcMLhR357y3vFzwDY0Eb42UqHf53mFWBw5uEZxT5bxG5
	 wX7s1XiUu0J3KqxbIkHzCEMh2QfdcZiaUk7+SgFGwRa7TOmVOEF5qClqpRDq7/5baP
	 9/RJXmBq4P5ltrNwit4voklK6ckKAYHSUUnmWXH3J1WsOnJg6okpEM5w9En4wf6yI+
	 0s6Q4L9UupAPrVO7bP+Rx57xRt/EsuURBB+vuQ/0SeEU7UcnSD5EMM+kbefdEVhTbh
	 +AJ9l+5izxg8Fa+sJs64LH+CUUZ825198VDl4nYIED+I9CVF32NAlneKFm+7NrCM7g
	 0OjYBPVEGHcYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34B523809A80;
	Wed, 20 Nov 2024 19:51:57 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118164118.GA31090@aspen.lan>
References: <20241118164118.GA31090@aspen.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118164118.GA31090@aspen.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.13-rc1
X-PR-Tracked-Commit-Id: 24b2455fe8fce17258fab4bb945d8e6929baeb77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f89a687aaeae54fb59e8e8aa619bd448a9c235a2
Message-Id: <173213231577.1329460.17070556610926218782.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 19:51:55 +0000
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Nir Lichtman <nir@lichtman.org>, Yuran Pereira <yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 16:41:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f89a687aaeae54fb59e8e8aa619bd448a9c235a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

