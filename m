Return-Path: <linux-kernel+bounces-574774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D314A6E9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4DCA16C1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7281FF1A1;
	Tue, 25 Mar 2025 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaWU+VBy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0985A93D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742885067; cv=none; b=BxPOJn8IknPovY09FMJmBWcTVZ6uVQLL9srqyhI6Cg4FChXAZ9pJTqzG3u978xeWBuvITP05wUdFVr8ThTHQdhwr8X2OrF9htUfilFTbVj8Zomu7y2wd4AK/X66g3ILGIDS0KCNljYxnP4LTXhzs5zq2rqR7meCd7KIb37SR9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742885067; c=relaxed/simple;
	bh=6ROCD3uVkDG8LybE3EunVRNDwRVemcB1Qg9wRiVuOBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG2IS0gh4j/z9CalumHX5AwM1cR579TvuLpFGa/13RweX/RkQJobnE5KQr2Xjv2aRvIAGgkhDNYmSneUxwk5i6qYHzd5JQdAHGMu9UgCWETGss6EtV6DIeHZDT+MAzMyUlA4LcVARhpdiAgtb26oyXsHGxUoeB/OQJSe3TZd14s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaWU+VBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE12C4CEE8;
	Tue, 25 Mar 2025 06:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742885067;
	bh=6ROCD3uVkDG8LybE3EunVRNDwRVemcB1Qg9wRiVuOBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaWU+VByYj2gx9zQ8lMpNrOnO04UgR1XTny9KBoxRmNp57OGugJBziRipFghudshY
	 sEGPSqy9laI+xp2dqoJ26d5xY/hVKyqUnCsTcQQNa1ryJC0LnS1ARgbaDIS5c/ksiF
	 jWi+jLkv7oOec51gQvAvGJic4jHh6jkG4Hv4DaG4qG0K0+HIiRb2d9jdl8oizhR+Xv
	 nXnWGSn51dbvPs4B4qKLKcrU59qHlWX5tst0H1Va5f7wKrMllzJgQtoUC80krUc1O9
	 Lb7Yy6bY1iHjIO7oDd/t8Yh8PIFctJA6Zv+uujtFxzQS5EHY/QCFxIiju1KrCuBk+T
	 B0apUqvNYgB9w==
Date: Tue, 25 Mar 2025 07:44:17 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PULL] x86/build updates for v6.15
Message-ID: <Z-JQwWSdyVXkttUI@gmail.com>
References: <Z96jAWGvYzZOM6O4@gmail.com>
 <CAHk-=whu2fb22rEy6+oKx1-+NCHuWucZepvD0H2MD38DrJVKtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whu2fb22rEy6+oKx1-+NCHuWucZepvD0H2MD38DrJVKtg@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 22 Mar 2025 at 04:46, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >  - Drop CRC-32 checksum and the build tool that generates it
> >    (Ard Biesheuvel)
> 
> Hmm. I didn't notice this during the merge process, but not too long
> afterwards it became obvious that this caused problems.
> 
> I've committed the fix separately: commit 2df0c02dab82 ("x86 boot
> build: make git ignore stale 'tools' directory").

Thank you!

> Please don't just mindlessly remove .gitignore entries for generated 
> files.
> 
> Because even if *you* may have removed the file, the generated files 
> don't magically disappear from everybody else, and when the gitignore 
> entry is gone, you are now setting other developers up for mistakes.

Indeed. I never saw this warning, as the directory was gone, but on a 
build box I have:

  Untracked files:
  ...
	arch/x86/boot/tools/

And I can see how this can then be added back in spuriously.

Thanks,

	Ingo

