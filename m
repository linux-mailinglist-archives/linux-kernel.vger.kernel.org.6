Return-Path: <linux-kernel+bounces-440634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C71719EC210
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483B9283D44
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3571FBEB0;
	Wed, 11 Dec 2024 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erU3qFFb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492EF18EAD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883988; cv=none; b=fpuA/c/obfjdlBSqt9fBYXFq84f9LjUYllU1yyh7WJ3BYO6mLJjRRtTcZGMYptE96rmyt56Q4ZQZW49RUTAjEvW1v4Xxj3Y+m8DPLI143Du7UkU30ALGt8xNYrtQFII8Ou9YcETMJWFPGZzMlCky7RtiARiXqyJseAv4wn8Ne3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883988; c=relaxed/simple;
	bh=ZWHNfZ/JGXwymDegJKHfFvB5QRwYZVYBNbj9Dc5mi2M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kpPXrilHlfdGOMjOCJUnZmqwKo95+cWV33nU/I7Ws2qdXlnqLzOJMqYjJtgysfmdm0TMWdbAQpuwUyd/TUxTExW+pQPbFetu6MubambX4k5cT7E+Oy8MrmFAbmZnJ7HwldkpgsAnWsrqdEa9V7Io6G/1Mzp0mS8x7vNcxdht1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erU3qFFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDF7C4CED6;
	Wed, 11 Dec 2024 02:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733883988;
	bh=ZWHNfZ/JGXwymDegJKHfFvB5QRwYZVYBNbj9Dc5mi2M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=erU3qFFbGSnWyMko6ege1vtq/guHCDTAAOq2Pnd8H2ctavg3QD7pByISwQM3H9gA8
	 o+osx2YupbDRjrZ+LgcBXK9zMZC7ZWek89susiUC6ELD/ch2akLJufrEgngNSdMpmI
	 VblYxGy1NRzrADqALka2kJZsePIrRhAqJ3FsVPI0ydjxMvL8g6MZeVkpPWsxdRIj8P
	 1WnH85w5FB202XlRjnFc20P6A3bqPVm//qqGNpfNrW4vJ4RZjK1FC6nww4ej2TO14/
	 7CcHdH6CEP8o7BM3X3ZPqeR2Qgct0OWwmp+LC5FiPcIQ1qE0CMshFjFBlaybngaHxO
	 zlTdEJJLxwyug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D24380A954;
	Wed, 11 Dec 2024 02:26:45 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241210232920.d10face123275fef39ecfb6b@kernel.org>
References: <20241210232920.d10face123275fef39ecfb6b@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241210232920.d10face123275fef39ecfb6b@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.13-rc1
X-PR-Tracked-Commit-Id: 494b332064c0ce2f7392fa92632bc50191c1b517
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1594c49394ffb0a5a9c889276ea204f05c1d46e3
Message-Id: <173388400380.1089022.7763937138380023324.pr-tracker-bot@kernel.org>
Date: Wed, 11 Dec 2024 02:26:43 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 10 Dec 2024 23:29:20 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1594c49394ffb0a5a9c889276ea204f05c1d46e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

