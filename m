Return-Path: <linux-kernel+bounces-210450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1149043CB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACBD1F258C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9B76EB68;
	Tue, 11 Jun 2024 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0+HgQZDn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7914A96;
	Tue, 11 Jun 2024 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131137; cv=none; b=MeB3SbhvM9NU7l58btt8luUgclJxXHW7Ha+FZzeEQVK2rWlHkpJAChjkBGHeVx5Zex8coJIblwLyP5Zr+bprZwioejZ4st8i2WB9RxHca2Uu3r4HTFLdIWyqrl6baAwys53s7+DCqkCJCdHXBUKNDh3MwewVU2h8/tkMeEbAO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131137; c=relaxed/simple;
	bh=QzoeiAlrGSB0mhE4dTqZ/+X4xvaNKPEqzYovZICDW+0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uvFgIIb2wKPvBPPKb9flZ1H2wv1NHB/7N/tfedIrrpnouCyPCMI71JXA0xKNSTcc/Ah0YvYkRJOKfCK0z4Q5MbSKkwWfMIE9/CBm6x1mLbfEhp9qP7DaThsWP+eCsrdXJiM9cYqnD59aqAB9auw+JAl55jnKSA+Y7P7hBtcsQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0+HgQZDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD92C2BD10;
	Tue, 11 Jun 2024 18:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718131136;
	bh=QzoeiAlrGSB0mhE4dTqZ/+X4xvaNKPEqzYovZICDW+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0+HgQZDn/hNWKdnS2pbqsdidfIolhv7J6gSm+5li7h6A2Gq5VWsruKQinCl22rahP
	 5T52QqTxH2HEQKJNBb3AeE0UNY6r1G1SpAtlxQ/KdDAIwWOuoor0NqRBT4IvfJxL3h
	 joDUk8eynkn/m8H0L9Ag5sybLEK+0tDEXRusCTJo=
Date: Tue, 11 Jun 2024 11:38:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, Andy Whitcroft
 <apw@canonical.com>, Joe Perches <joe@perches.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Kees Cook
 <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>, Tom Gall
 <tom.gall@linaro.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v5] checkpatch: check for missing Fixes tags
Message-Id: <20240611113855.b63a6015b26a0dad49d9f2a7@linux-foundation.org>
In-Reply-To: <ZmhUgZBKeF_8ixA6@moroto>
References: <ZmhUgZBKeF_8ixA6@moroto>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 16:43:29 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:

> This check looks for common words that probably indicate a patch
> is a fix.  For now the regex is:
> 
> 	(?:(?:BUG: K.|UB)SAN: |Call Trace:|stable\@|syzkaller)/)
> 
> Why are stable patches encouraged to have a fixes tag?  Some people mark
> their stable patches as "# 5.10" etc.  This is useful but a Fixes tag is
> still a good idea.

I'd say that "# 5.10" is lame and it would be good if checkpatch could
detect this and warn "hey, use a proper Fixes:".  Because

> It  helps people to not cherry-pick buggy patches without also
> cherry-picking the fix.

seems pretty important.



