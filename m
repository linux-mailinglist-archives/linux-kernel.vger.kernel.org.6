Return-Path: <linux-kernel+bounces-198806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4365F8D7DB4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66C8B2366F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90178174F;
	Mon,  3 Jun 2024 08:45:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ED081207
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404308; cv=none; b=JeIKAdw9k5um3UrMm19mBEGXqCQZHQNF4UEpYIgUF9WHEBfdQ+58xFzMtyX83op+YK79GW/a22/ZmfkBtVYwlWakC6TPkAGrxlS9nt5gEm4BGeoo0F1OqVAAYfzcGlX0oYXqJXQe9lmNrKu8NTKrUEiSA7xdq2iQpYmdASpcoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404308; c=relaxed/simple;
	bh=DtNIZfROdplNeZsgvghfwPSPMTakJhkrJ4zAqFAyKZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6f5nnWWp5GCagtqRSRirwsFWW+0epf15kdzBNtECjNmaKPtpBYiklCmJkc3eISuNJ8xxP6gLOxCtxP950akO2SZij5fd68cCocGssNZOTCtJoRwXstgOQGWAF3VjbIARwbIqEroiZu3JnD72JMdPvi2rWQvffj057qDCbb+tto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C93E1042;
	Mon,  3 Jun 2024 01:45:29 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6FC93F7BD;
	Mon,  3 Jun 2024 01:45:03 -0700 (PDT)
Date: Mon, 3 Jun 2024 09:45:01 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Cc: gregkh@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, rafael@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 0/2 v4] drivers: arch_topology: introduce automatic
 cleanup feature
Message-ID: <Zl2CjZ9mCpK1ylMf@bogus>
References: <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
 <20240513081304.499915-1-vincenzo.mezzela@gmail.com>
 <ZkHlHAj1aPEToEYO@bogus>
 <bf963861-cc26-45e3-a4a1-82e2ea51a74a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf963861-cc26-45e3-a4a1-82e2ea51a74a@gmail.com>

On Tue, May 28, 2024 at 10:23:37AM +0200, Vincenzo Mezzela wrote:
> On 13/05/24 12:02, Sudeep Holla wrote:

[...]

> > > changes in v4:
> > >      - fix commit subject
> > >      - fix coding style
> > > 
> > Looks good now to me.
> > 
> > Acked-by: Sudeep Holla<sudeep.holla@arm.com>
> > 
> > It is merge window now, so there is a chance that it may get lost. You
> > may have to post it again at -rc1. Greg can then pick it up for v6.11
> > 
> > --
> > Regards,t
> > Sudeep
> 
> Hi Greg,
> 
> hope this message finds you well. I wanted to kindly follow up on the patch
> [1] I
> submitted to introduce the __free attribute in drivers/base/arch_topology.c
> 

Hi Vincenzo,

Just rebase on -rc1/rc2 and resend the code as the original patch might
have got lost deep in the mbox.

--
Regards,
Sudeep

