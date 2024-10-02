Return-Path: <linux-kernel+bounces-347324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E90A98D116
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26CD1C21937
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74851E6339;
	Wed,  2 Oct 2024 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BnHe16rL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RdHU7Mt2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909D2F56
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864491; cv=none; b=XJym2h609idMD27JMF/jhiZs4Kk97X/kuLhJlhAl5QIgfyiJ79/KOZtQiwFZMCJOMUDq3Et9Fb4m0IZTdCT0QRAbUzueEBLZYDpr1NPakLrkXYp9/vgL0/P3Dv0TNG9mcFiZRxRN7j9/NXxhte26yRYiB60cNfZZhtEHRznAfpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864491; c=relaxed/simple;
	bh=HZdWCFueSNscGiJRSMDgbKrODWkGed8c2Rej6W9Cd+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFqBUySYCTTTD3nVka0AxGhl7JMUQ9MYHJXpHbGUV6xA4qBcp/3O5Cm4hMbSb8slHxIpnaf0cqBzJ9K8VRH4++N8LSfsirUfMDTQQGffqSXh9uqU320d/IGu4MuJw3dniRrn1WCfjBwqL9nVEbeSivpVztGI0Mmh6q7oP4TeIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BnHe16rL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RdHU7Mt2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Oct 2024 12:21:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727864487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhD25htocjLaJhhw/FN1jPZB8HhN+tD6ZhBBhAifomQ=;
	b=BnHe16rL1tG8Y46BcKHdCWnMzIDHeM4kxsXos+WJq3VsWoGjgWmBpv1zv+Imj16+o4HSZV
	lIVE0kHplh4ZmM730AoTQ69DNB+1hX08//ELR92GjCRsUv9RunJzZblgC17mRvs+iX6bDq
	UgJxhtfx/u9kBFIpQBHNCjSBgK3DhZuS1zg3/0v5fqu5l12mq7lqvC2fRVZGAerXUm9gn4
	sr/aQag6hzSu3uMuA3vZnDGgVGO2cVTzdplp1TAQp58PlItYrnG+BrkbGac7MHqci1EiEY
	y8ZsWyQzkrngajsZnWkXWlVaDasRJHU0PTBi6jmr0f9NlHqFPhBFfXipjGCBmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727864487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhD25htocjLaJhhw/FN1jPZB8HhN+tD6ZhBBhAifomQ=;
	b=RdHU7Mt2IXp/zUN+hFhk2mjuCxd7zuMbvi/6WGPSE4HWRPXQQxPUNrmey5qPZAWOt+fbYt
	2PLF+0N0PRAxSSCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, Jason@zx2c4.com
Subject: Re: [PATCH 1/2] powerpc/vdso: Add a page for non-time data
Message-ID: <20241002121330-50b996cf-e296-4f0c-908d-300948728d1f@linutronix.de>
References: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
 <20241002104334-b655500b-901b-42db-a2c8-582e10826889@linutronix.de>
 <368e38d3-5883-4192-b9cf-f66d0f558528@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <368e38d3-5883-4192-b9cf-f66d0f558528@csgroup.eu>

Hi Christophe,

On Wed, Oct 02, 2024 at 12:10:08PM GMT, Christophe Leroy wrote:
> Le 02/10/2024 à 10:54, Thomas Weißschuh a écrit :
> > On Wed, Oct 02, 2024 at 10:39:28AM GMT, Christophe Leroy wrote:
> > > The page containing VDSO time data is swapped with the one containing
> > > TIME namespace data when a process uses a non-root time namespace.
> > > For other data like powerpc specific data and RNG data, it means
> > > tracking whether time namespace is the root one or not to know which
> > > page to use.
> > > 
> > > Simplify the logic behind by moving time data out of first data page
> > > so that the first data page which contains everything else always
> > > remains the first page. Time data is in the second or third page
> > > depending on selected time namespace.
> > > 
> > > While we are playing with get_datapage macro, directly take into
> > > account the data offset inside the macro instead of adding that offset
> > > afterwards.
> > 
> > FYI
> > 
> > I am currently working on a series to unify the storage of the
> > VDSO data for most architectures, including powerpc.
> > This will also include a dedicated rng data page.
> > 
> > That generic infrastructure would replace the need for Patch 1.
> > Obviously, if your series gets applied, I can adapt mine for that.
> > 
> > If you are about to also modify other architectures in a similar way,
> > we may want to coordinate.
> > 
> 
> I'm not going to do anything on other architectures.

Ack.

> Indeed my patch is an outcome of the discussion at
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/ffd7fc255e194d1e2b0aa3d9d129e826c53219d4.1725611321.git.christophe.leroy@csgroup.eu/
>
> I'm all fine if you are doing something generic for all architectures. For
> powerpc will it handle the entire non-time data, not only rng ? The purpose
> being to revert https://github.com/torvalds/linux/commit/c73049389e58c01e2e3bbfae900c8daeee177191

Yes, it can handle arbitrary arch-specific non-time-related data in
addition to the rng data.
(In addition it also handles arch-specific time-related data)
The code introduced by the linked patch is gone in my series.


Thomas

