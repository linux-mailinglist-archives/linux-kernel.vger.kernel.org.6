Return-Path: <linux-kernel+bounces-337940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1C4985139
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BD21F242AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87B71494B0;
	Wed, 25 Sep 2024 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/2+U8a7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537D12D75C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233882; cv=none; b=Jk7wS7LAzQ1DjPy54aml7FhK2YFWvj1U8VtY3uzxJfY88T0aw1X75kZ0k6Ko6AcrsMa8MrluW1dh/tu4R+zxKfeVvZ5Xw+w8BcK5Dyppgh7awQxX3UDENMDrm72K/Ykdb07ojgh0nwr05IQ9Kf9JYbMSoEg+DnJjCvLNIiAnYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233882; c=relaxed/simple;
	bh=t1QQTsCPe3vkA6i5XMNQyAH5q8mBOcv5QXf9zpQ6r20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPmnp+jOyZlIXrndn1/6XH8vH19iia64Je1/Zj60lGEbb/XPID+PEgJf329XPqCcXrm69vB3C8vlmGJ9LfZw6SWUYK+q6NV+yw/dk0KEkyRG82aNjT4TuovAD9JwNFoT/nFNikH1mUvHPwpffJ9mUR8hhtxdqI8TZNMZ57D0CxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/2+U8a7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FFBC4CEC4;
	Wed, 25 Sep 2024 03:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727233881;
	bh=t1QQTsCPe3vkA6i5XMNQyAH5q8mBOcv5QXf9zpQ6r20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/2+U8a7CofclvIfDifLnMVI9WIiGYn4IzcHmyHWtMVxeo/buHwpROj72o7jsDaA+
	 sbyjw/u2LCZIouvvJ3IgnePoJl74/gzgCrojxQXZPp9y+q1MspoOWw8OpCNqw/6TfT
	 +a84bdAALa5g/56NAe5dSF/KIB96qcUmNwdvi++ckm2eIqoyPag6NuM0m4fX28gBGN
	 rukdNMpX6lZ5b4Ys1Kd8F3FASUrzleGobX4PUw2aQnHhT0C6sfLrQbU7SeRJx+xU+S
	 dX5DxSYzW+Iw0LuSpwCSCSDQpbmx1i6//wSebqKCpaZLWERqHMPvb+iWWZKLJbWH1r
	 b3Xf4EStHv2/Q==
Date: Wed, 25 Sep 2024 03:11:19 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] f2fs for 6.12-rc1
Message-ID: <ZvN_V-5TfciQ42Pp@google.com>
References: <ZvInHczHWvWeXEoF@google.com>
 <CAHk-=wi=dvXyr8b5Z1cYLa-A=-JpYVpJ854UMvftE2gaK==GMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=dvXyr8b5Z1cYLa-A=-JpYVpJ854UMvftE2gaK==GMg@mail.gmail.com>

On 09/24, Linus Torvalds wrote:
> On Mon, 23 Sept 2024 at 19:42, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > In this series, the main changes include 1) converting major IO paths to use
> > folio, and 2) adding various knobs to control GC more flexibly for Zoned
> > devices.
> 
> Hmm. I get mostly the same merge result as in linux-next, but I did
> end up with a difference in f2fs_write_begin(). You might want to
> check that out.
> 
> That said, the difference is a PAGE_SIZE vs folio_size(folio), and I
> think in the end it doesn't matter because I don't think f2fs does
> large folios yet.

Thank you, it looks fine to me.

> 
> But please check it regardless.
> 
>              Linus

