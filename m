Return-Path: <linux-kernel+bounces-348178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFADF98E3BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3431C20EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F79216A0D;
	Wed,  2 Oct 2024 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHXUv3W4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41681720
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898728; cv=none; b=Nr9JXZz3mm0FPNqtItmp+BhKiqgYrrHEykrSMb5hcMQ/YkiXDIPCKgtFiQijrv7cBvEct1TROKOKqaE/13Z9RMm92wDW4sJLAqjwF2+/1QLL3YX0CIGc5cmu57ys8GX7DOB4usb2jnzzr4r/i9GaAayyBXVzSxoOTIIQkRuVgUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898728; c=relaxed/simple;
	bh=vL66viiqBCK4YYvAQwzuAwVW9Ds4pNj5l3OpGju2sUk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oK80yuC5tWfz2CC7GgQnB/yipp0mfqZdFrKsgF1cka96XO5HZkBiP0wqigPAserPd7t+Fnrsc8r+/ktHk4wv/HdMojJvl62oWp6cxMb7Z9Q9UDDiB5UMmuldGKvnCdN5b8R3fdMjJBw81NU/HJGU4gyYBTrTE49Tty3VE5Yp5PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHXUv3W4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CCCC4CEC2;
	Wed,  2 Oct 2024 19:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727898728;
	bh=vL66viiqBCK4YYvAQwzuAwVW9Ds4pNj5l3OpGju2sUk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VHXUv3W4mrzJsx/mE872YBdRSbWg+kZPowLIxcZgMzIhS1pItQYeNz5v/oAf691JR
	 3BvxG8vqXvGK44KVjTPn3it9hHORacNlLp21C38WY6OggIe8bBKXz0VYub9w5vnAt3
	 BYLAri33zd9UKyS5Oi6iLIm48HhzbXIaNlw+gBraa/BlCEkEQvRKjqRtXDbzWjmxN/
	 L44QPQuMjmW5JZpaWimeV0CgbTVega4t+PITJkTA4j0R/gMujdKl4VrEgVZhB5jx0x
	 jIuvxO+5hAzJABYMso35aR5R271aCIh7IIRuh4kdFd+0MmkxIDkF+28FwYdZVczSO5
	 /A5vjqtYpudNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71416380DBD1;
	Wed,  2 Oct 2024 19:52:12 +0000 (UTC)
Subject: Re: [GIT PULL] HID fix for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <z75zg2bvyec6pwsrewzrlydn65f5pjknpnbgvi2pnsmpdr65pf@ja4tba66xuyu>
References: <z75zg2bvyec6pwsrewzrlydn65f5pjknpnbgvi2pnsmpdr65pf@ja4tba66xuyu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <z75zg2bvyec6pwsrewzrlydn65f5pjknpnbgvi2pnsmpdr65pf@ja4tba66xuyu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024090201
X-PR-Tracked-Commit-Id: acd5f76fd5292c91628e04da83e8b78c986cfa2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f23aa4c0761a70bfd046dd5755281667f0769a94
Message-Id: <172789873089.1292614.14185311742992482944.pr-tracker-bot@kernel.org>
Date: Wed, 02 Oct 2024 19:52:10 +0000
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 2 Oct 2024 17:40:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024090201

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f23aa4c0761a70bfd046dd5755281667f0769a94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

