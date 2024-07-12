Return-Path: <linux-kernel+bounces-250303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB792F645
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AF31F23662
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936EA13DDDD;
	Fri, 12 Jul 2024 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y+P9mpOv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A318F58;
	Fri, 12 Jul 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769491; cv=none; b=jQSLnYRKlR79YNFa7vL+c3CxhKsC7yR0na/5U67Hyc/Ij/Cx/mF95QLXGVweexr781ttiM5BnNWQkmGBQNyHPyQcuRDBfbbalLxGQYavczaf88W5Apl72ji8+Y/0tcaN/uDMXCzUrrTODmcovRIRqW5wjNpFexMi/+h9I/LAQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769491; c=relaxed/simple;
	bh=J6L70/0E91iG7uWlu2BCX4sUocMyTLY/ZH60hrueklk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq1KWLtkNW6wky5K3HS3EqlRjgNoa+vyJ9JapZbZq0aKaVTQRjvZwWYELVDdmVZ+RDODmGo6TKZAT4jy4hzP3RR0oMlRYWtvLf5Xlx/eKt2Barzh28lrGn6vPuT91+jxvu9fnijFe3Wqoa2nZcH7Xf/PkoVVNd/CT3jvxaOn7ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y+P9mpOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB80C3277B;
	Fri, 12 Jul 2024 07:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720769490;
	bh=J6L70/0E91iG7uWlu2BCX4sUocMyTLY/ZH60hrueklk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+P9mpOvYdW3/S5b7axG8utyPbXFPSg/IAkOgrQHaWl0r1nhlUiu9C9kqMG/M0dKb
	 0d6k9QEQ8rK46FZPp7aSqapIU2xjOzMXXeGfPcuN51p1V6FAQFwqAbaVCxUA3OTenE
	 5XG1T7IvdKnuOssww09/L7ipNDWwM/EigRv9Z7sk=
Date: Fri, 12 Jul 2024 09:31:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] agp: uninorth: add missing MODULE_DESCRIPTION() macro
Message-ID: <2024071209-squatting-nacho-60b0@gregkh>
References: <20240615-md-powerpc-drivers-char-agp-v1-1-b79bfd07da42@quicinc.com>
 <99d6c483-9291-4bd0-8e62-76022abb762c@quicinc.com>
 <7b7e2952-fb54-48b0-93bc-f96c04e5cdd3@quicinc.com>
 <ce7863a7-f84e-42f0-9aa5-54b43edcd260@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce7863a7-f84e-42f0-9aa5-54b43edcd260@quicinc.com>

On Thu, Jul 11, 2024 at 01:27:23PM -0600, Jeffrey Hugo wrote:
> On 7/11/2024 12:19 PM, Jeff Johnson wrote:
> > On 6/28/24 20:14, Jeff Johnson wrote:
> > > On 6/15/2024 2:01 PM, Jeff Johnson wrote:
> > > > With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
> > > > WARNING: modpost: missing MODULE_DESCRIPTION() in
> > > > drivers/char/agp/uninorth-agp.o
> > > > 
> > > > Add the missing invocation of the MODULE_DESCRIPTION() macro.
> > > > 
> > > > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > > > ---
> > > >   drivers/char/agp/uninorth-agp.c | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/char/agp/uninorth-agp.c
> > > > b/drivers/char/agp/uninorth-agp.c
> > > > index 84411b13c49f..b8d7115b8c9e 100644
> > > > --- a/drivers/char/agp/uninorth-agp.c
> > > > +++ b/drivers/char/agp/uninorth-agp.c
> > > > @@ -726,4 +726,5 @@ MODULE_PARM_DESC(aperture,
> > > >            "\t\tDefault: " DEFAULT_APERTURE_STRING "M");
> > > >   MODULE_AUTHOR("Ben Herrenschmidt & Paul Mackerras");
> > > > +MODULE_DESCRIPTION("Apple UniNorth & U3 AGP support");
> > > >   MODULE_LICENSE("GPL");
> > > > 
> > > > ---
> > > > base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> > > > change-id: 20240615-md-powerpc-drivers-char-agp-db644db58c24
> > > 
> > > Following up to see if anything else is needed from me. Hoping to
> > > see this in
> > > linux-next so I can remove it from my tracking spreadsheet :)
> > 
> > I still don't see this in linux-next.
> > Adding Greg KH since he's picked up many of these fixes.
> > Hope to have all of these warnings fixed tree-wide in 6.11.
> 
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> 
> Dave, this seems like a trivial fix that is stuck, but normally routed
> through DRM.  I hope I'm not over stepping, but I think I'll drop this in
> drm-misc-next on the 19th if there isn't any other activity.

I can take it now, otherwise you will miss the 6.11-rc1 merge window.

thanks,

greg k-h

