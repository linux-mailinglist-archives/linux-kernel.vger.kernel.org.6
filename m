Return-Path: <linux-kernel+bounces-245600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126AC92B4CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A19BB218E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A29155C94;
	Tue,  9 Jul 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ecGsXWdo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB2155756
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519786; cv=none; b=HfCU3SGggCRDRgNRaskL2WtHL9DW60GUsvpdn6tKTNbZ0cmgADHW8vOj/6BnoASvtELm/zVUWHCuVpBgw7QgnjXhftry2kQMyssIq7U4baGMlJl+Qb6uYFz/Ydkf6feM7TgL1JqUIQmTbI+9qOhiXXGonveq/U2S07l2aI+t+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519786; c=relaxed/simple;
	bh=vJL/+yzEoTupBGM+KNAhCBR3IrKs9In5pHA6AJeTSjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCASpxsc8fEdCpuJws5N/WBvqEoEk1+aoDpmf2/zKM+mKxqOTnhCeXJPYlm/2q8XHWCXdvEzYnRUUHkCB58K1xGAM7Ju5+HLbhhFtWJ0Btxqi5mfMVW7mHrZKlywhOqA2c37z3IL6GxToYPfOLQX2zqUZax0KXrBuy3/gSHi4BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ecGsXWdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D01FC3277B;
	Tue,  9 Jul 2024 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720519785;
	bh=vJL/+yzEoTupBGM+KNAhCBR3IrKs9In5pHA6AJeTSjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecGsXWdoKF4btEiervHhtxp23tWleIXRPxuGMLVbvzIUFjxLJQG80HNLsMRSSiFwz
	 fbSaa8EKOZYy09gNol/Q8oiCdyxVFC8WUuqi/rXPwvtbXv0fHm7OZLoGIXGMlvnL08
	 FUNSiyBgG2rpSIMsS9Uh7mP1XPN3xSNwq/HCF6Zs=
Date: Tue, 9 Jul 2024 12:09:43 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] : Re: CVE-2023-52628: netfilter: nftables: exthdr:
 fix 4-byte stack OOB write
Message-ID: <2024070948-helpful-departure-a468@gregkh>
References: <2024032850-CVE-2023-52628-14fb@gregkh>
 <b8b8f6113ac1e7f1fa07659c32d34b033f775a84.camel@oracle.com>
 <2024070926-removing-chewer-2426@gregkh>
 <18f16d08f3946fbee0917f759a855cb070aadf44.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18f16d08f3946fbee0917f759a855cb070aadf44.camel@oracle.com>

On Tue, Jul 09, 2024 at 05:27:15AM +0000, Siddh Raman Pant wrote:
> On Tue, Jul 09 2024 at 10:49:59 +0530, gregkh@linuxfoundation.org
> wrote:
> > On Tue, Jul 09, 2024 at 03:48:29AM +0000, Siddh Raman Pant wrote:
> > > Is this a duplicate of CVE-2023-4881? It was rejected with the reason:
> > > 
> > > > https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-4881
> > > > 
> > > > ** REJECT ** CVE-2023-4881 was wrongly assigned to a bug that was
> > > > deemed to be a non-security issue by the Linux kernel security team.
> > 
> > I don't know, where is the information about that older rejected issue?
> > If this isn't an issue, we will be glad to reject it.
> 
> https://nvd.nist.gov/vuln/detail/CVE-2023-4881 (see analysis
> description where it just describes the issue).
> 
> Or just https://bugzilla.redhat.com/show_bug.cgi?id=2238312
> 
> I'm unable to find a rejection reason though, maybe that's on a private
> mailing list.

Looks like Red Hat created it and then rejected it, you will have to
talk about this with them.  But then later ZDI asked me to assign a CVE
for it, and I did assuming that they knew what they were talking about.
I shouldn't have assumed that :(

I don't know what to do here, sorry.  If you don't think this is an
issue, great, I'll be glad to reject it but we should say at least why
we don't think so here in this thread, right?

thanks,

greg k-h

