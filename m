Return-Path: <linux-kernel+bounces-577471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A971A71D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF38F16C229
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D9C1F3BAE;
	Wed, 26 Mar 2025 17:42:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9CD23E33B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010922; cv=none; b=rQk4bWZ5yFzfyyJRnaYtBwUo2QebDb2fhNrhvl5DnJJaOwEnBijDJvTChOToWRXVbtTKHZk5CVI3Mjf5+dWuOjybxpswxutHL0orGWKxGXtWLmOvUyEvLAq1ioY+c9O+Sgm20HHOmPG8w9hBfXJzKrS18g1cNlaVipv4ZLE9o1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010922; c=relaxed/simple;
	bh=qwnXpELhDtfHGnp5wUmQSlCWRvVcTBt4FaL11rFw+Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0qPqcp9OrtcyORchWUV/PjDfMgbADyzlSh6IqTB5YtaT7bdLwrcEXerWGmNbE+jHae5jFJXcFowcPlEu0heYKOqE2R67qkXFBwgmW73Ezg65mpSqGFIuygPsMxdWtEBH3eMc9WO9avcl94tyjujJJ7qtJlgoQdBE+xr7SYlE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764B1C4CEE2;
	Wed, 26 Mar 2025 17:42:01 +0000 (UTC)
Date: Wed, 26 Mar 2025 13:42:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Konstantin Ryabitsev <mricon@kernel.org>
Subject: Re: [GIT PULL] arm64 updates 6.15-rc1
Message-ID: <20250326134247.675f8d1c@gandalf.local.home>
In-Reply-To: <CAHk-=wiXEvC2r=Sa_tpYjd=g+AxZDxxjSdq1WADTvZYZ9oUi_g@mail.gmail.com>
References: <20250325195322.3243734-1-catalin.marinas@arm.com>
	<CAADWXX-0hMgpyeQw_7Ko14hNMciqSnKJAROEWS5vwAdMKUt_zw@mail.gmail.com>
	<Z-NHugcLdLqkEHFR@arm.com>
	<CAHk-=wg_HipugbtswxFnekQy2g_ksKKXj+yht8naj2FEMtRMgA@mail.gmail.com>
	<20250326124025.1966bf8a@gandalf.local.home>
	<CAHk-=whwmmU+hv1SyMoyr8yAGP2JiAAP+g5BZaMajzAukzrM9w@mail.gmail.com>
	<20250326131200.1c86c657@gandalf.local.home>
	<CAHk-=wiXEvC2r=Sa_tpYjd=g+AxZDxxjSdq1WADTvZYZ9oUi_g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 10:25:22 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 26 Mar 2025 at 10:11, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > So it definitely goes through kernel.org.
> >
> > But it has no DKIM headers.  
> 
> Funky.
> 
> There's definitely something strange going on, because your *previous*
> email to me did have the DKIM signature:

That's because I had manually changed my "From:" from "rostedt@goodmis.org"
to "rostedt@kernel.org", which in my test emails, added the DKIM signatures.

-- Steve

