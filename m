Return-Path: <linux-kernel+bounces-188942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DB18CE8D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030AF1C20CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D9F12F384;
	Fri, 24 May 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On59lcbA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493238626C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716569126; cv=none; b=j8/XDdgVdUMqUV+s73Ibz7GvqgzF1nH98CAt014wXCll9XshcuSp9lnMrBeHYiEGKWJTRAFPgo0xeiwbqBcnSxTAal7K3Yq5frWuHMw5+fWWHodDfqAD6PCH8WOLozAU40nA0boU8j4d9FZj0HzG4wou/gbhQ4UXwZVNex+JvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716569126; c=relaxed/simple;
	bh=tJesxouxrH0A8R/OymfkbdToG3zXGCkBJ45SJjQ1gS0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rGugtCm7K5ZihCSD+0pKI9stPXkZDGf1kzwvgeu5AmgO612BfxEeqg6JvC6MvuULWgzK7dBuXFYOfPrsm3m23ezz0BuDF2D4NkhgHRquU/pJSWv+wM/E2mnbkq+bMkK/X9UsMV0/3LAQOi3DJniy8C+MgsYQX9Ld7pEmfXX/dbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On59lcbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28B10C4AF07;
	Fri, 24 May 2024 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716569126;
	bh=tJesxouxrH0A8R/OymfkbdToG3zXGCkBJ45SJjQ1gS0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=On59lcbAUO0v8nrOCRj8n44n4Ga/PHtB3zALCVPGEzTOKyxYPycMagwn6sKTJybga
	 +njRdHOXHIQzAOpmYLTI2xJAh2yW27VkoWA+9ajOujz8hujDJfgspawyRJaZY+RWie
	 24J7RrkvenoPKIXmq3+fkn8myL6qC+u05o+Kj82e1mDlpcP06q2DoaluMuR5TZ+8c2
	 UlbeiFlDzJm/sbJGXgEfTOne66eY/eIyt8SznQjJKziMmwBjN7MsPxjXXhhML4W/OO
	 snI+06I3/uZR2IDpqTZZESLnSaeh/wHUDdir/Isp/VUioIVBZusJtGxxD7twofd/tv
	 04UDxJ45wtIbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E566C4332E;
	Fri, 24 May 2024 16:45:26 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202405231637.664DFA26FA@keescook>
References: <202405231637.664DFA26FA@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202405231637.664DFA26FA@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc1-fixes
X-PR-Tracked-Commit-Id: ae1a863bcdbd6ea2abc93519a82ab5d715d5dcbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0a9ba13ffdb9591d468d84f26ec2cefdd7625b4
Message-Id: <171656912611.29701.8621694102640464617.pr-tracker-bot@kernel.org>
Date: Fri, 24 May 2024 16:45:26 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Douglas Anderson <dianders@chromium.org>, Kees Cook <keescook@chromium.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Stephen Boyd <swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 May 2024 16:37:56 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.10-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0a9ba13ffdb9591d468d84f26ec2cefdd7625b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

