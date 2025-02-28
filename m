Return-Path: <linux-kernel+bounces-539047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8CCA4A02D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC55E1898DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF8F1F4C81;
	Fri, 28 Feb 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtFwe0hG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC71F4CAC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763233; cv=none; b=t1EKwL1tcBNuvMCPfwjsMwr7Nqmu5HYHPDDdbhfW9XPaI6dDkTLenbTPFfQWyVHaIXSz7XvdUf/9wOde8JDNWedLqNvUm8vN4ZRDIDQ/MtgNlAp55GjcRYQPconNa+sQ6iJzmuT9mCAlQES6qCAouFiiaKJEWHBcMjemRyBT5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763233; c=relaxed/simple;
	bh=lbId641pLt0nD6Sl9SeGqbylnJgYsHkSPQi/Fyz3UyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzB3bSAqFAIAn3WKPaVEfG3r+/7eqpyCXgMFTAaoSJzuKA3RIAtlGp2I5HM2Zg4YeRoJpE8aiSFeO77B64Hc1pLVL2YEjrQCNk2QgjZIcEERhMGHf/90+njtej6I9/kQj5Qy6jVFdVsa3GPNEC4Kt8vGtJMJGcxnLYzjoZIkeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtFwe0hG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8553C4CED6;
	Fri, 28 Feb 2025 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763232;
	bh=lbId641pLt0nD6Sl9SeGqbylnJgYsHkSPQi/Fyz3UyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtFwe0hGUoY/0RJlx+Aq7QYaX7Ay1qEz8ujSJnAtZP/rwKtzm2nbr/jTFAfopNYoP
	 8N1CVQ09kPBRlKGlNsgcFAKpZqm3hpKi8v9d+aheuuCORmLQoV58wnTwZ8uerqPnpe
	 WpppPbhMjCMXs0PkGeDcNy2FEfaG4bH0KUkdMlL1gBaTjm9Hzk2K+TT3+BAX12b6DZ
	 XYmTv3H6ZQPrciBPX2E5wftLHIWpTsJD9Zaua/SWd2ZZEOBIYawjhfj5BSFVvaynL2
	 jJRSCn2k5BEkpTOBQ0fUwajfjq0cQyvOEVJfIkjG8eVuXXvEkJgchTWCLMHSQKWQKr
	 4BiT+Rhj3/fOw==
Date: Fri, 28 Feb 2025 09:20:30 -0800
From: Kees Cook <kees@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [next-20250226]Build Failure
Message-ID: <202502280920.583F8CD5F@keescook>
References: <adbe8dd1-a725-4811-ae7e-76fe770cf096@linux.vnet.ibm.com>
 <20250227123804.5dd71cef@canb.auug.org.au>
 <14193c98-fb30-4ee8-a19a-fe85d1230d74@csgroup.eu>
 <SN6PR02MB4157A0C1B4F85D8A289E5CE9D4CD2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <c68287f7-ad00-46fc-a92e-06e0c9074139@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c68287f7-ad00-46fc-a92e-06e0c9074139@csgroup.eu>

On Thu, Feb 27, 2025 at 03:15:35PM +0100, Christophe Leroy wrote:
> 
> 
> Le 27/02/2025 à 15:05, Michael Kelley a écrit :
> > From: Christophe Leroy <christophe.leroy@csgroup.eu> Sent: Thursday, February 27, 2025 2:43 AM
> > > 
> > > Le 27/02/2025 à 02:38, Stephen Rothwell a écrit :
> > > > Hi Venkat,
> > > > 
> > > > CC Kees Cook for advice.  This is a result of the tests added in commit
> > > > 
> > > >     bbeb38b8487a ("string.h: Validate memtostr*()/strtomem*() arguments more carefully")
> > > > 
> > > > from the kspp tree.
> > > > 
> > > > I note that the comment about memtostr() says "Copy a possibly
> > > > non-NUL-term string".
> > > 
> > > Can you tell more about your config and your environment ?
> > > 
> > > I just tested with ppc64_defconfig and ppc64le_defconfig, with gcc 12.4,
> > > gcc 13.2 and gcc 14.2 and didn't get that build error.
> > > 
> > > Christophe
> > 
> > FWIW, I see the same build failures related to __must_be_noncstr()
> > when building natively on x86 and on arm64. In both cases, it's an
> > Ubuntu 20.04 installation with gcc 9.4.0 and binutils 2.34.
> > 
> 
> Looks like I get that problem only with GCC 8.5 and GCC 9.5.
> 
> I don't get it with gcc 10.3 nor 11.3 nor 12.4 nor 13.2 nor 14.2
> I don't get it either with gcc 5.5 or 7.5

I will investigate! Sorry for the trouble.

-- 
Kees Cook

