Return-Path: <linux-kernel+bounces-577354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2334AA71C04
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1D33BF5EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF7C1F426F;
	Wed, 26 Mar 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USV4xrsQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11211185
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007180; cv=none; b=lBUfi7eWlWCghYJBUT2oUs7Ne8jjLvff6kfiaKnv0t+My/TQZVvNA/8LvH8Ovb1HJ4LIQ3eHmbPhtpeQPRCCnmGX5Ij61HlJbk64K6J0EKvTiEF5jGYDB9Si4QS+xfzNRdB+XVzvBV8oDnoq4LGo15jWsOcDpB916G6dTJMRtuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007180; c=relaxed/simple;
	bh=RvjxL5DyvBDKCYG+UYSNeb2jpoQwYz2f1DmVuSY3uyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMH0ALDjTrrLOoqONZ76YoHIsQ+oyo0HmMELQP//0DTiw/k7VxV1Iu3k4JhtrXVlHEmxLKt5752FxyrRhUrxwkoMZ2TZ2ov31Y9npZuvbLYonyG+ICDBrqut5uojuU6JwxoCf7Ttm+I0WbfzCAd/qQRlHN87NWhpm5Nn/5UZ814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USV4xrsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF624C4CEE2;
	Wed, 26 Mar 2025 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743007179;
	bh=RvjxL5DyvBDKCYG+UYSNeb2jpoQwYz2f1DmVuSY3uyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=USV4xrsQk+Ul6Q7diqx19+Jg4TVC7aqBGeIc7vuB8DQR+IoXEk/Mo6Nn25KTWrRM5
	 wYfQ0+IqZcSJ04eX3LAMo/ILkcY8Trmp6/aqPBqPOU0bQ6uzf+G4fAagGAMfu3QjJI
	 A1tRYi8+VL/tn9EhF10S7eL7I1PuH/wB2K6YSWz3emaXfswXRN0sAB+Up1+oswFj5c
	 n+9l3qCDW2YJkuAlXB0xFYkyPLsDQDSwFV5M5RASRxppAIfde8bj3l5zhaxZEzZl85
	 w/UVx7s5pghDCM5DhTsid+OvibxYIU5/rkSX0583Qdd/lNt9q7o79AR9FcFQxmKfdG
	 IJIkk9j3OzPeQ==
Date: Wed, 26 Mar 2025 12:40:25 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Konstantin  Ryabitsev <mricon@kernel.org>
Subject: Re: [GIT PULL] arm64 updates 6.15-rc1
Message-ID: <20250326124025.1966bf8a@gandalf.local.home>
In-Reply-To: <CAHk-=wg_HipugbtswxFnekQy2g_ksKKXj+yht8naj2FEMtRMgA@mail.gmail.com>
References: <20250325195322.3243734-1-catalin.marinas@arm.com>
	<CAADWXX-0hMgpyeQw_7Ko14hNMciqSnKJAROEWS5vwAdMKUt_zw@mail.gmail.com>
	<Z-NHugcLdLqkEHFR@arm.com>
	<CAHk-=wg_HipugbtswxFnekQy2g_ksKKXj+yht8naj2FEMtRMgA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 17:48:12 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > This header left my machine but seems to have disappeared in the
> > lore archive. Not sure how much difference it would have made, IIUC
> > that's more for SPF than DKIM.  
> 
> I do see the
> 
>    Return-Path: <cmarinas@kernel.org>
> 
> but no, that shouldn't make any difference at all, because that's not
> what dkim matches.

Now I wonder if you see any of my emails that I have been sending?

I have my own email server which is on a dynamic IP which most ISPs will
simply drop because of that, so I route my email through kernel.org.

I just sent myself a few test emails and there's no DKIM signature, unless
I manually edit the From to use my kernel.org email (which I have never
used before).

> 
> The spf is fine, but honestly, spf on its own is kind of useless.
> 
> > If the envelope sender doesn't work, I may have to switch to using
> > cmarinas@kernel.org, at least for pull requests.  
> 
> That's fine, and is probably the easiest thing to do.

I may have to do the same if you can see this email (which I manually
updated the From address to be kernel.org), but not my previous pull
requests.

I wonder if there's a way I can work with Konstantin to allow kernel.org to
have a signature for goodmis.org ? Not sure if that's even possible.

In case you missed my previous pull requests, they are here:

  https://lore.kernel.org/all/20250325180527.5fc0a1fa@gandalf.local.home/
  https://lore.kernel.org/all/20250325193935.66020aa3@gandalf.local.home/
  https://lore.kernel.org/all/20250326115109.32b69701@gandalf.local.home/

-- Steve

