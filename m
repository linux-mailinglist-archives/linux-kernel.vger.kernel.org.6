Return-Path: <linux-kernel+bounces-421784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A329D901A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E1816A007
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089087D3F4;
	Tue, 26 Nov 2024 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fORciMI3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3A018622
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585284; cv=none; b=e1PQWxarmitREG2Jtqs+JeC5wCL4QxL20S4u+F7jrVmTTIPpRnpgafT9Ej10SvTQ8ISBTqNOjWh9wm8qze4TayNtBv952NlKyXYeKH/MN8gtpq1h9fzvG1ZrjT0kjkS00A41HJTBaYo6Tar7Pb4LtjFCHbwp7LzQURRMmKe21Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585284; c=relaxed/simple;
	bh=7PuI44X71CbHmt/+DuN2sdZGGoMpJuV58E/jpknDVPg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kxyTC0j/RxUFzdycaK8wCUUBahBcirKZm/8/WQBbSWPddguMxXgyjV5dlvkwo7nhVOIZuYG9I4Kohw8pnS75oRudrBW7LQnQqwTbFtZa6G9p3vgGTKolhY27BEAuCpIkHpxnMhS8pQyY/U8yzWJdqbMw9+n5mTOORk9troThe9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fORciMI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339F5C4CECE;
	Tue, 26 Nov 2024 01:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732585284;
	bh=7PuI44X71CbHmt/+DuN2sdZGGoMpJuV58E/jpknDVPg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fORciMI3MAHY0zEQlOTZmghNh88xenXNDrtxyhzxtPuWC7CIYM5wpDqVjK6aT8EMs
	 IH95E1cuzWiKK3KCBOzpWchg0kSOyomED4QZJVXWYnB4RV8kL/0deq3cg0Wji3pQFg
	 7Z9UXHV6ACStxBjHNeMJ/fS4AQ01fYYASic4D5C8oQwAV7oxsR4uT3RYrZITcXCDDd
	 q+yVMIXyjZb1CNj1GmKs8ZrxmWx3qOCFfjfK9F9MzxA7UEdeV7eHS76bnoBd1+StSe
	 H+Hi+LzqFRicFjXFdmpEBZjc70/WVRu3UWbqdSFJdpWvclIg+/zZl5AGEvo6RO/4YA
	 we34eigzGLb1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3423A3809A00;
	Tue, 26 Nov 2024 01:41:38 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.13 v2
From: pr-tracker-bot@kernel.org
In-Reply-To: <1e81a4f1-a3f0-4131-8515-cecfdc3b001a@suse.cz>
References: <1e81a4f1-a3f0-4131-8515-cecfdc3b001a@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1e81a4f1-a3f0-4131-8515-cecfdc3b001a@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.13-v2
X-PR-Tracked-Commit-Id: 9008fe8fad8255edfdbecea32d7eb0485d939d0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e06635e26cd8144eee17e9f256e8fde8aed3ba4f
Message-Id: <173258529679.4103683.16924741987891806302.pr-tracker-bot@kernel.org>
Date: Tue, 26 Nov 2024 01:41:36 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 25 Nov 2024 10:56:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.13-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e06635e26cd8144eee17e9f256e8fde8aed3ba4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

