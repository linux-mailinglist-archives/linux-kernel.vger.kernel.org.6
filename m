Return-Path: <linux-kernel+bounces-197100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ED58D6627
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006751C22F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B892F156255;
	Fri, 31 May 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elcuDqdf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC93612EB
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170889; cv=none; b=lKIsyib6VgaCcv6RzUh8nGm4JVpIDiI99vxf9oU0bHCX2NUFOmtNroQ4UxT+KtY0gIcO3GvJDYsO7/A527F4V3h3wQvU8f3uSp52Vwao8+Q3y06mdgo/RIyDpH20XHrsI5cAzYqXqTADGXdYCtISLlwYrtglUzNi9HLg+zM94SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170889; c=relaxed/simple;
	bh=B7BX6PlfxUf3Oo3F1/fcApuOuN36L45G+Q0APZKbIkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSDXObLwuDW7IJphMtGDoGImEOk7bnNdRcm6ZfJV6SQlvNKKh4PqL5pVSGkzVCRZ/5MRV3BAKSX2dI1mNi0bE3bSVIvIyE36XODN7RzihA12qblm2HDSEZ4PO1Gc8AeiANA1SZB6GtWwB7zWDKvIDE/PIdbdxtoozzIR0Qr3hrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elcuDqdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE56C116B1;
	Fri, 31 May 2024 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717170888;
	bh=B7BX6PlfxUf3Oo3F1/fcApuOuN36L45G+Q0APZKbIkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elcuDqdf34d/9zQ7pDmwPOnAOD93laXz2cXaWa89AUHlaxzMiO534W7xgpZEYcq3m
	 UYbdWgJCi3Jc75Lg4DRiaGJEzvL6J9qXLsxLfrwUwj/NLHnVddCnca2BF4xKFAS/t3
	 vfkQU2LBzOsZdqHETGC/UZeysgrw2N18Lv5Sr0id5S61b4ltLs+ww76FdNS+GIJGWh
	 spNWO6Rm5e0wIK61fMe9sMX7yfP/e3iV5BqOYmfdYcjAjAJ1trOQ84eQ7hvYU7y77y
	 Tp6VRjz5QY0SjFH27GK9wgVltXPQXbaPaGcBFM2N57KmQxDe8lyPKoXTCPRhdD1vZL
	 KyNhVEHiV+G3g==
Date: Fri, 31 May 2024 16:54:45 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] mfd: lm3533: Hide legacy platform data in the
 driver
Message-ID: <20240531155445.GS1005600@google.com>
References: <20240508104848.846580-1-andriy.shevchenko@linux.intel.com>
 <20240508104848.846580-2-andriy.shevchenko@linux.intel.com>
 <20240531150048.GO1005600@google.com>
 <Zlnn89KPSHSCp3Bh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zlnn89KPSHSCp3Bh@smile.fi.intel.com>

On Fri, 31 May 2024, Andy Shevchenko wrote:

> On Fri, May 31, 2024 at 04:00:48PM +0100, Lee Jones wrote:
> > On Wed, 08 May 2024, Andy Shevchenko wrote:
> > 
> > > First of all, there is no user for the platform data in the kernel.
> > > Second, it needs a lot of updates to follow the modern standards
> > > of the kernel, including proper Device Tree bindings and device
> > > property handling.
> > > 
> > > For now, just hide the legacy platform data in the driver's code.
> > 
> > Why not just rip it out entirely?
> 
> You mean the driver?

The unused platform data.

-- 
Lee Jones [李琼斯]

