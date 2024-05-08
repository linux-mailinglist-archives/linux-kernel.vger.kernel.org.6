Return-Path: <linux-kernel+bounces-172627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F838BF48A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299671F24963
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972E8DDD9;
	Wed,  8 May 2024 02:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZT0V59GR"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D887AD53C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135271; cv=none; b=u8vkaQlPD7fhXAJqR9RO45Z/9Gozt6TOk120ugWmV6gg/c8DbLDTWyqz53F1+yAwRHEsgGRSt9q90kYWDzjfyIsNYYwgmmGkK/DXUjxKjvnneV8lECDRDqTdyVbtdxKoQDuf+gywrkWvPIDzM1GvgEVjAnCQLTpp5oVDSlVC+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135271; c=relaxed/simple;
	bh=FqHHjfDx9ENi3Pts6alsW6C4sQF4MogYbWkxo0Ih7J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPz7Q3twS6LKGIlIVaWv8CUSTF2aRZVmiP10vgtADpnyOPrfhfJiBtNyoxrZTBFiT4LNo1uqtmafBtSqJ1oXmzj4gf+lI8C2270eXiIqLKQRQewZXKPFhhBdNb/Y1hZwTYYhJzVqUStJR5ToTCBJAwTCdsUnj9zAsy7A9jaEf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZT0V59GR; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 May 2024 22:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715135267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FGZyhctyl0sVp+jffQYu4jnwoerfNp5K7r6RyHG7Dck=;
	b=ZT0V59GR7QaJbFwj0A+CDc/+5dJ1S1WoXka0vIF7pJ48MHId7ZMCGB5dVmdD/fpAQ9gDGb
	aL4Fs58nzcOshLilnH0f98xkmHDR09r/GgJgTVBIYTnDIwU+2mvdS8HvjeTPPiQbl0uFg4
	soalv7w0Ncr9z8JNXQU0/Bg4ZwFNLl8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org, 
	Su Yue <l@damenly.org>, Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] bcachefs: Move BCACHEFS_STATFS_MAGIC value to
 UAPI magic.h
Message-ID: <c2wlqrxm4y42chiiwhvqvfop7fiux3kyphjejgrdbpx2vhmvfh@o7sdo4tb6lzg>
References: <20240507153757.150891-1-pvorel@suse.cz>
 <ZjpQV0ddhG9sUo8P@bfoster>
 <20240507164430.GD138935@pevik>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507164430.GD138935@pevik>
X-Migadu-Flow: FLOW_OUT

On Tue, May 07, 2024 at 06:44:30PM +0200, Petr Vorel wrote:
> > On Tue, May 07, 2024 at 05:37:57PM +0200, Petr Vorel wrote:
> > > Move BCACHEFS_STATFS_MAGIC value to UAPI <linux/magic.h> under
> > > BCACHEFS_SUPER_MAGIC definition (use common approach for name) and reuse the
> > > definition in bcachefs_format.h BCACHEFS_STATFS_MAGIC.
> 
> > > There are other bcachefs magic definitions: BCACHE_MAGIC, BCHFS_MAGIC,
> > > which use UUID_INIT() and are used only in libbcachefs. Therefore move
> > > only BCACHEFS_STATFS_MAGIC value, which can be used outside of
> > > libbcachefs for f_type field in struct statfs in statfs() or fstatfs().
> 
> > > Suggested-by: Su Yue <l@damenly.org>
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> 
> > I was thinking you'd just rename the STATFS_MAGIC def locally as well,
> > but whatever.. LGTM, thanks for the tweaks!
> 
> Ah, I thought it'd be more readable this way from bcachefs point.
> Kent, just let me know if you prefer Brian's way and I'll send v4.

It's in my tree now :)

