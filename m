Return-Path: <linux-kernel+bounces-559131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986B3A5EFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB54417ACE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9956F2641DE;
	Thu, 13 Mar 2025 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TKIY2uk+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029A1FC3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859025; cv=none; b=sOwrNyLTYp56W8Sfw3svhPcPCJbq3F88RQPb7CzR4UZVUsFlqBndZ5mf6TQYsU6Af2ITJ/bj+fJgTth+vm4RVcCEeV7VLLT1XBZCZjdL76+79PNoLd0tsO+OEz1mVV7A7wVvSchBzgjykAhDLwSDEgAhlG9mmFnPdz3kqdCHyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859025; c=relaxed/simple;
	bh=BTNa5wMxmt9IsrC7IA30oW6xUxCoS64UqtN1Thd9Wes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TV+UhMLpPZM/aXDXI1uOfYeAfAKtAYgup0HyDkP/hMTTQuU8aoHxIXIt0wjPDTP30MsESLR0JHAW89o1WBpqtfSIzXQjLww5tS33FVhdL3R22R72h9Bkk0K4pT8x0UZA4cLI6IPZvrpy4iJFUwLl18MNRNC+KXeYmPvbSFfrIok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TKIY2uk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB30C4CEDD;
	Thu, 13 Mar 2025 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741859024;
	bh=BTNa5wMxmt9IsrC7IA30oW6xUxCoS64UqtN1Thd9Wes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKIY2uk+rtnzuafA7ysabChX/U7rXNzbyj/OmIf/FDJrNtQlyNbLh02aPUHQIPh8z
	 DcskeAKONVDyOJdXnHI47U+KbFEjpaScOAyzHgm9pzaiWvl4M1OW/zrgbzZeGjij/F
	 EMe5l8zztqLeQ3sJ1ycsJqY6UqwNnoEWWTnema2s=
Date: Thu, 13 Mar 2025 10:43:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gupta, Nipun" <nipun.gupta@amd.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de,
	praveen.jain@amd.com, harpreet.anand@amd.com,
	nikhil.agarwal@amd.com, srivatsa@csail.mit.edu, code@tyhicks.com,
	ptsm@linux.microsoft.com
Subject: Re: [RFC PATCH 2/2] dt-bindings: add device tree binding for silex
 multipk
Message-ID: <2025031352-gyration-deceit-5563@gregkh>
References: <20250312095421.1839220-1-nipun.gupta@amd.com>
 <20250312095421.1839220-2-nipun.gupta@amd.com>
 <37707900-9162-43f2-b89b-3e1fec514daf@kernel.org>
 <270daefd-22a6-9359-edcb-c514644cfe4f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <270daefd-22a6-9359-edcb-c514644cfe4f@amd.com>

On Thu, Mar 13, 2025 at 02:55:07PM +0530, Gupta, Nipun wrote:
> On 12-03-2025 16:21, Krzysztof Kozlowski wrote:
> > On 12/03/2025 10:54, Nipun Gupta wrote:
> > > +maintainers:
> > > +  - Nipun Gupta <nipun.gupta@amd.com>
> > > +  - Praveen Jain <praveen.jain@amd.com>
> > > +
> > > +description: |
> > > +  Silex Multipk device handles the Asymmetric crypto operations. The
> > > +  driver provides interface to user-space to directly interact with the
> > > +  Silex MultiPK device.
> > 
> > Why this isn't in crypto?
> 
> It is mentioned in patch RFC 1/2 - because Crypto AF_ALG does not support
> offloading asymmetric operations from user-space (which was attempted to be
> added earlier in Linux at: https://lore.kernel.org/all/146672253157.23101.15291203749122389409.stgit@tstruk-mobl1.ra.intel.com/)

That was 8 years ago.  We now have the accel framework, why not use
that?  Or work on getting this framework properly submitted as it looks
like you now have 2 different users for it.

> > Device name part is weirdly generic. How is this device exactly called?
> > Where is it used? Where is datasheet?
> 
> The device is on AMD versal series and is named "Multi PKI" device. I
> will update to use compatible as xlnx,multipk (AMD versal series link: https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal/premium-series.html).
> Seems also renaming files to xlnx_multipk.c etc would be better. Will
> update.
> 
> The device is used for PKI offload for OpenSSL based applications.
> Unfortunately data sheet is not available in public domain.

Expecting an undocumented crypto accelerator to be used by anyone feels
like a very odd ask.  Would you want to trust that?

thanks,

greg k-h

