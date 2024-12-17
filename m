Return-Path: <linux-kernel+bounces-448858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4727A9F467C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28345166F07
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D571DD872;
	Tue, 17 Dec 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVSDEz3w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C951714BE;
	Tue, 17 Dec 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425386; cv=none; b=c2eulxTupnR4oIlXnu7pVhX12QeuKzJa9fDaDZupmLRTPH7nKydczc/qT0bH8GyCfoh6QsAdbO8k2jb6mau47Wq7TU9N7KO8u3E+tNkLoVawCHCjZUEeitN8Rs+EFHWQzJrugVoEzk1ll7BFp6iulIe3Whr8oYLP9SsXXsr1tZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425386; c=relaxed/simple;
	bh=+um96SdEnd/2/UDzVy8IGeS33caXtXI5NcZqysg/CM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUGxRsip5w60bncThei1gR2YFtsK6MZNMI7hPw6CpfU+3YuWkp3/SZ12gpojp645lKAdAclEQ2w1RjMg7r3dh8jO+zJ0iVB0uW+pN56uPZbB0P1Aik9aPoYket9pnl8hyKTLYX1xnyvfgj67ejLzuLZjcDXcHtP76GG3TA9gUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVSDEz3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1888FC4CED3;
	Tue, 17 Dec 2024 08:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734425385;
	bh=+um96SdEnd/2/UDzVy8IGeS33caXtXI5NcZqysg/CM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVSDEz3wUDA6r1BqJChrZzMgQfMMHZv/nx+HYL9cQ6GVS6CTznjuyRuDDoCl6rEmi
	 nTVBlSslhsIRuXi7VB7edXd54veh+gwt2nHlOj+apsXiLHDxvQ7/vE23RE6Mbdqcax
	 iPtdtbTteMGzvJ/PNX5YvmexCFOZGGw2Qb0G2T1U=
Date: Tue, 17 Dec 2024 09:49:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jann Horn <jannh@google.com>, Jared Finder <jared@finder.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-hardening@vger.kernel.org,
	regressions@lists.linux.dev,
	kernel list <linux-kernel@vger.kernel.org>, jwilk@jwilk.net
Subject: Re: GPM & Emacs broken in Linux 6.7 -- ok to relax check?
Message-ID: <2024121726-electable-tabloid-bf55@gregkh>
References: <ee3ec63269b43b34e1c90dd8c9743bf8@finder.org>
 <CAG48ez0vg9W=oatvEqxvTSYNUx7htY23LxPrYCiuLZhZQuaGjg@mail.gmail.com>
 <Z08NV4Z-L0anDxGk@google.com>
 <20241217094723.57c7cb1c.hanno@hboeck.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217094723.57c7cb1c.hanno@hboeck.de>

On Tue, Dec 17, 2024 at 09:47:23AM +0100, Hanno B�ck wrote:
> Hello,
> 
> On Tue, 3 Dec 2024 14:53:27 +0100
> "G�nther Noack" <gnoack@google.com> wrote:
> 
> > Hanno, you are the original author of this patch and you have done a
> > more detailed analysis on the TIOCLINUX problems than me -- do you
> > agree that this weakened check would still be sufficient to protect
> > against the TIOCLINUX problems?  (Or in other words, if we permitted
> > TIOCL_SELPOINTER, TIOCL_SELCLEAR and TIOCL_SELMOUSEREPORT for
> > non-CAP_SYS_ADMIN processes, would you still see a way to misuse that
> > functionality?)
> 
> Sorry for the late feedback.
> 
> I believe that this is correct, and permitting these functionalities
> still preserves the security fix. I also checked with Jakub Wilk, who
> was the original author of the exploit.
> The patch you posted in the meantime[1] should be fine.
> 
> https://lore.kernel.org/linux-hardening/Z2BKetPygDM36X-X@google.com/T/#u

Great, can you test that and if it works for you, provide a tested-by
line?

thanks,

greg k-h

