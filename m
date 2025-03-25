Return-Path: <linux-kernel+bounces-574616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E038A6E7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE05C1752A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9102938382;
	Tue, 25 Mar 2025 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMy2AUxu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94F2F5B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863497; cv=none; b=ipfb82J4tApAL/DKqP7dyORCLduLzqwn/bE+522u4GC6sOsUml5J1WdpJ3IXallJ+0+cFR2Sox255d4CrkmyWPBtLK4JwV5Y6e79xbzsdW60OdnKqF+aSlKuDZvMhIQ0yEkeDGfNBHBOjpXALVVjmTngWW9ydhy4VC232qPvfAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863497; c=relaxed/simple;
	bh=8RpWY3WyNHt5GVGeNDZlOZcp6U0sdULeUumlpL5jXkU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=imIpQHufCzcNXstL7SqP2itHi7Gjh01xKuNAXhpYTsehB5eGD78/bRi139VWRtqZzX2Tj3TiVz+tvh5/5FCvbQ5ZRs+LOqRVnR7ZLs9PBSCrcYICTIE2T+zKfvu2qjbYh85xF71fjh0KOutHGHqEjUet6hl1IMzqBwgtluTTpYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMy2AUxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2F9C4CEE9;
	Tue, 25 Mar 2025 00:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742863496;
	bh=8RpWY3WyNHt5GVGeNDZlOZcp6U0sdULeUumlpL5jXkU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aMy2AUxuUDkVcvr4EdITqQRpjs2X6uFTXAw3uPoC77VJ2euFiASQgp7LtTYml8TWD
	 7ZGjgo68zv6RB59oeWnzj5f4fMX4dQ4l/De0HKsX1e+oquxSRu47IMogmv7Lhq9J4R
	 XC737Z4KSYL7QsqQoS70GrS2gBUM/Ct7O0ghsOPR+OJP8iy6OfImF0ejtQcQcOEH77
	 JK24Ps37DR5yLbUFPPqryNFLewskFi/DUY6uUly+fhTwP/DvilMiuf/CcZ6CA5Ehi1
	 tW+MgAm3crarRYIByfHkyTvWnnb7pQn1eeWaT1wd0q/mAnSOTZ1By4ff9Vk+BTROeH
	 qYuDFEG3GW+QQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349AD380664F;
	Tue, 25 Mar 2025 00:45:34 +0000 (UTC)
Subject: Re: [GIT PULL] move-lib-kunit for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202503170842.FFEE75351@keescook>
References: <202503170842.FFEE75351@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202503170842.FFEE75351@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/move-lib-kunit-v6.15-rc1
X-PR-Tracked-Commit-Id: d62f8c95470c395ab6fd8f344ff431a5f4ce0da5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06961fbbbd7a832a5943413447d2813a714a3c82
Message-Id: <174286353269.36585.16445052642349508818.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 00:45:32 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Bruno Sobreira =?iso-8859-1?Q?Fran=E7a?= <brunofrancadevsec@gmail.com>,
	Danilo Pereira <dpereira@lkcamp.dev>,
	David Gow <davidgow@google.com>,
	Diego Vieira <diego.daniel.professional@gmail.com>,
	ernsteiswuerfel@kernel.smtp.subspace.kernel.org,
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Jakub Kicinski <kuba@kernel.org>, Kees Cook <kees@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Pedro Orlando <porlando@lkcamp.dev>, Petr Mladek <pmladek@suse.com>,
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <"l inux"@weissschuh.net>,
	Vlastimil Babka <vbabka@suse.cz>, Yu-Chun Lin <eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Mar 2025 08:47:13 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/move-lib-kunit-v6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06961fbbbd7a832a5943413447d2813a714a3c82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

