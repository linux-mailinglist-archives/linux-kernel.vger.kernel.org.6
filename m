Return-Path: <linux-kernel+bounces-353990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 672509935C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7BD3B20C63
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0C71DDC15;
	Mon,  7 Oct 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gonMD3Z8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DADE1D95AA
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324748; cv=none; b=K4UacvmN8zoT+jjI96LTvdgAdVEKFVfiGvWabzgDB0Vn69cDu1osjjQZ6xLWRYOjkQ+Lh1Z1x/hCcVI7rDmiZFEigr0TIn+bd3Ppq1JNM/9OkLyRC/xWgH4oMl9gAoikNp2sbDfHeH1YpETg/odiP6gGG7lk6QeKcP9P+sEI7lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324748; c=relaxed/simple;
	bh=MVMcREqOQie9bCu+l3+EHtHOGyR8Vt6zdS95oQnMRi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lH9zK48s1fX9ennlLL4jsEABpoczD/bezeSlZFQMDxJpz8IPwqZaEHQPDY0A6W/n7aR6mBnGTq3i/Pa4MuDQ5y6CGEHlV7COfuAHWnwb1UGXPbwg9J4ENAmXG0Sgem8H3n4PqIMqAnGuLXSi5awkqm+EaUA/EE9i13MWNsGf8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gonMD3Z8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA43C4CEC7;
	Mon,  7 Oct 2024 18:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728324747;
	bh=MVMcREqOQie9bCu+l3+EHtHOGyR8Vt6zdS95oQnMRi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gonMD3Z81MR5tRjnQ0yJmdqAu47JdQCbp7tEX2A21sXKlMP/BEUVUIIhtq8FtSqMx
	 v+rzR4G4ssygEQJ9YqcBXdmQOw6weTueOk+MWD+Sv6TQVohLCiBbGQ6wntvJad2ghQ
	 /mdKHhu1pRsMOMJk4rYFOdvZpMMUsIQezchlhaDPPYk2X+SBaD0s9ZbdHFHTtXzX2R
	 l1cLTPzVPlKpjantP9FGyeD77s1gxCHRdcDCTlHjS1MAUjJQqHbxWAyc2A6AatXFbt
	 Knh3eQXEiZJVxeOIMEkTdvsHZaxeq8xY+QGQGthQ9oqfHv0RGjhJhxiTuOwDYepBR3
	 p/XtFo3K7Xh1w==
Date: Mon, 7 Oct 2024 23:42:23 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Justin Chen <justin.chen@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
	Sam Edwards <cfsworks@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/2] phy: usb: Broadcom BCM4908 USB init fixes
Message-ID: <ZwQkh6Vg+RgpXZdm@vaman>
References: <20241004034131.1363813-1-CFSworks@gmail.com>
 <172831613316.134526.5485203085922304367.b4-ty@kernel.org>
 <d20fbf91-e7e9-4f0d-8e4a-0c5364f73bc5@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d20fbf91-e7e9-4f0d-8e4a-0c5364f73bc5@broadcom.com>

On 07-10-24, 10:06, Florian Fainelli wrote:
> On 10/7/24 08:48, Vinod Koul wrote:
> > 
> > On Thu, 03 Oct 2024 20:41:29 -0700, Sam Edwards wrote:
> > > This is v2 of my previous patch [1] targeted at resolving a crash-on-boot on
> > > the BCM4908 family due to a missized table.
> > > 
> > > Changes v1->v2:
> > > - Florian requested this change be broken into an immediate bugfix (w/ the
> > >    'fixes' tag) and a second patch containing the coding change aimed at
> > >    preventing this problem from happening again
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [2/2] phy: usb: update Broadcom driver table to use designated initializers
> >        commit: d3712b35f3c694cb932f87194caafc714109ea08
> 
> I looked at your tree and both patches are applied in the "next" branch and
> the first one is also in the "fixes" branch, thanks Vinod!

First one should go into fixes, whereas second on next (due to
dependency merged fixes into next)

-- 
~Vinod

