Return-Path: <linux-kernel+bounces-510135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CE4A318A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56FE1889C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9460A268FEC;
	Tue, 11 Feb 2025 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upjUIQDy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78A22641CE;
	Tue, 11 Feb 2025 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313121; cv=none; b=ENtPEpITIW0KoRgk5ELaFRt2JT+h0rfGWu3vIu/QYg8Y26yW11DObGwE1n059mLPRDWuq0mqZAkMnDjId/Y9cfpaj+dgDbw0tXtilI+60w6RlJL2U6j9BFwhLsrCzQnacB0V9pDy83Q3daAGyy/e6EDuH83jiGcWanosdtVl700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313121; c=relaxed/simple;
	bh=nNdMjvufG1KwK6bx+D+n9kZhJLtmEZprQWWJSdNVqIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj+N4zlpYbLlLivjqztNJ7/ZHayBg1U9JR+Fpexl/xukLkFIOA3I32B87Go1vyHXx3wOyLrEfPVEy0XFenHvQogc7GsNarrSXJwuMywmHXcgHkWpehjZfgNYxqC1zYkEuB8i7zT5uvCGm3TtBEmSGr9u8bUTfvsCr8jtF3zJknw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upjUIQDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58049C4CEDD;
	Tue, 11 Feb 2025 22:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739313120;
	bh=nNdMjvufG1KwK6bx+D+n9kZhJLtmEZprQWWJSdNVqIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upjUIQDyR5fFG7FqliMYTHUesOUc7TbFtEYOd8Haus6tJOtyRuCmhYeejce15ZAYm
	 lq7zxyEt0xMnsC5lQGidtt4wYM7UDPvYseFegNz/BrigboHwJenTXzTiDpjmmtLHTC
	 vqOTYTO2RSGu4AImUVEw2CMwB86TWPmgPxZc29Zedk5xMEdP7Vh6CdGCaUELaDVeIb
	 8Es83Eu9DAX+7JJaWganAA/5YVE8EdSE6EFihiBsclIiDceTHOCMxK0GOyYyFmCeJz
	 cDtJqk4+bwqW531lqsgW0OeJMfveEWSosCMxTvjTo4evuVYZHPugFov2MlvLdn619l
	 2kkkriaqNnFgA==
Date: Tue, 11 Feb 2025 14:31:59 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Chinner <david@fromorbit.com>, Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the xfs tree
Message-ID: <20250211223159.GF3028674@frogsfrogsfrogs>
References: <20250212082141.26dc0ad8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212082141.26dc0ad8@canb.auug.org.au>

On Wed, Feb 12, 2025 at 08:21:41AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   bc0651d93a7b ("xfs: fix online repair probing when CONFIG_XFS_ONLINE_REPAIR=n")
> 
> Fixes tag
> 
>   Fixes: 48a72f60861f79 ("xfs: don't complain about unfixed metadata when repairs were injected")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format='Fixes: %h ("%s")'
> 
> maybe you meant
> 
> Fixes: 48a72f60861f ("xfs: refactor repair forcing tests into a repair.c helper")
> 
> or
> 
> Fixes: 8336a64eb75c ("xfs: don't complain about unfixed metadata when repairs were injected")

Yes, 8336a64eb75c.

This patch has been on the list for a month now, and nobody complained.
Probably because people aren't good at distinguishing one sequence of
hexadecimal from another.

Could we /please/ have a bot to warn about these annotation problems
when patches are on the list for review, rather than a month later after
it finally enters for-next, without any of the authors, reviewers, or
maintainers having noticed?

Maybe the rest of you are all excellent at this, and I should just fuck
off and quit.

--D

> -- 
> Cheers,
> Stephen Rothwell



