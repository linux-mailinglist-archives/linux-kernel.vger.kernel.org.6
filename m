Return-Path: <linux-kernel+bounces-197207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADD18D6787
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA79B28368F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098816F282;
	Fri, 31 May 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLPHo0v7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF116D9AC
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174718; cv=none; b=h0SCuYzbqO5nvOCueRL7mRMWnfWKFaMlJ0bi4bYtb5ew4vEnmF97VKeyC17UaexFh0nsKlNxstrylXZ2h7VJ2ku8l/WDnVWjgysvam65WSQHBdzhmDePB3qZD8LyMpVSYrcXulYXCeUoc0nKMb43k07uUg32fFBYiykELb7GKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174718; c=relaxed/simple;
	bh=JP5FgACki9lWVStVz0zZfzJonGjYnYCtNW2WTeX1HD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rolew4h8UFyV9ixnddcD8ZIQcRt6hacdiwf5CSATD7lQSiCiDD5fTPtkFBpJDFsZaiQXU6/tYtcMCd4iTFma93aea0dY2+PN7kAVbKCRZw240R7FIIP/r9w8cf2FZ+cupdLKfebHn3ikVOE15A1VglfbWaFywxbh04l4LFI914E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLPHo0v7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E82DC116B1;
	Fri, 31 May 2024 16:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717174718;
	bh=JP5FgACki9lWVStVz0zZfzJonGjYnYCtNW2WTeX1HD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLPHo0v7a6sqPnvGBsg0go+M7RdhsO5GPIulJIHTCiIS+3n+3TiwnzUpRfxfrNiUp
	 Uvq4TF3KU2Oxnl/uZJujuY63yEXl563XravaoIW+Dz9r2AnPQifP8R7L+oDMuGdRwU
	 jO/EA4STPSrXIa0teUq+Je0vyLk1/U6FkA4ejzFTiCLzVpo76d+AuB8KAsvWgeMzeu
	 Y5f2CEXMYTXd1ZJ3iPFqpAH8CDfaO3G+Pfx4ZSvyiLDNdlBDiUv8Su33CrCLFMUSnO
	 Le36+n/b8XIu0TMdpIiSV2Fid5VI2bNtXgmkbd8K7gpGFXni4F6u95kXjr38qzujvS
	 efU62MRSQ6i0A==
Date: Fri, 31 May 2024 17:58:34 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, johan@kernel.org
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] mfd: lm3533: Hide legacy platform data in the
 driver
Message-ID: <20240531165834.GA1204315@google.com>
References: <20240508104848.846580-1-andriy.shevchenko@linux.intel.com>
 <20240508104848.846580-2-andriy.shevchenko@linux.intel.com>
 <20240531150048.GO1005600@google.com>
 <Zlnn89KPSHSCp3Bh@smile.fi.intel.com>
 <20240531155445.GS1005600@google.com>
 <Zln9lRvKJYwlSM3l@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zln9lRvKJYwlSM3l@smile.fi.intel.com>

On Fri, 31 May 2024, Andy Shevchenko wrote:

> On Fri, May 31, 2024 at 04:54:45PM +0100, Lee Jones wrote:
> > On Fri, 31 May 2024, Andy Shevchenko wrote:
> > > On Fri, May 31, 2024 at 04:00:48PM +0100, Lee Jones wrote:
> > > > On Wed, 08 May 2024, Andy Shevchenko wrote:
> > > > 
> > > > > First of all, there is no user for the platform data in the kernel.
> > > > > Second, it needs a lot of updates to follow the modern standards
> > > > > of the kernel, including proper Device Tree bindings and device
> > > > > property handling.
> > > > > 
> > > > > For now, just hide the legacy platform data in the driver's code.
> > > > 
> > > > Why not just rip it out entirely?
> > > 
> > > You mean the driver?
> > 
> > The unused platform data.
> 
> Good question. In any case these drivers are non-functional anyway without OOT
> board code. If we rip out the main platform data completely, the logical following
> question arises: why do we need the per-device platform data? If we rip that out,
> we basically make non-functional driver a 100% dead code. Hence what you propose
> mostly equals to ripping out the drivers completely.
> 
> TL;DR: with the main platform data being ripped out the driver code will be in
> inconsistent state.

What do you think Johan?  Do you see any reason to keep it around?

-- 
Lee Jones [李琼斯]

