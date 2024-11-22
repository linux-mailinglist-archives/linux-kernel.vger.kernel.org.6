Return-Path: <linux-kernel+bounces-418701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D899D647C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8BEB227E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51091DFD97;
	Fri, 22 Nov 2024 19:13:16 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E01DFD95
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302796; cv=none; b=D2raLSNx2eyv2nUEN0YfKsVLL3+e77x6wTItK2QXcmPHOZ6AnvxV68g1/9toH9/RcHjQR2E7QPmQARfAxbg75im8tN0mwlknP13VupAYJy1zmHcAJ2ffbuGRxTibIjIhOQon39G4OjVMQ/1HPDokv/OtZ8ji7xq6gdY7Q36zPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302796; c=relaxed/simple;
	bh=q6gz/bNnEPokdRWa7X1rhwL1CD+NrW+h58nfXlAVnGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa7drV4cMVceWUW+uzJ4/RAVicSuMMQfNcMmWjOQ6r9B5KdkD1lFkuZ6QEuCRg4Qjq7ptXKC3dUKOtXAiqoIlWpq948IxsoTEGEP4vZQUF0+nu37He8nLaL4u1Y2BO1WYR9Dqp2GA0oTK8UMcj3/KqmwX23C3jwiHk7GxWr/5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4AMIVs9W024111;
	Fri, 22 Nov 2024 12:31:54 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4AMIVqd3024109;
	Fri, 22 Nov 2024 12:31:52 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 22 Nov 2024 12:31:52 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: mpe@ellerman.id.au, arnd@arndb.de, geert@linux-m68k.org,
        gerhard_pircher@gmx.net, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
Message-ID: <20241122183152.GN29862@gate.crashing.org>
References: <87bjydoz18.fsf@mpe.ellerman.id.au> <20241121084136.3648581-1-glaubitz@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121084136.3648581-1-glaubitz@physik.fu-berlin.de>
User-Agent: Mutt/1.4.2.3i

On Thu, Nov 21, 2024 at 09:41:36AM +0100, John Paul Adrian Glaubitz wrote:
> >> Pegasos2 users still exist, but admittedly they mainly use MorphOS and
> >> AmigaOS4 on these machines.
> >
> > The Linux CHRP support is still present in v6.12, which will be an LTS
> > for the next 2 years at least, so if there's folks who occasionally boot
> > Linux they will still be able to do that for a while.
> 
> Is there any urgency that warrants the removal? I could understand when ia64
> support was removed because it put a burden on maintainers.
> 
> But CHRP support?

It puts a burden on maintainers the same way.  No one can really test
it, to start with.  It is essentially dead code.

Or do you know someone who regularly builds and tests this?


Segher

