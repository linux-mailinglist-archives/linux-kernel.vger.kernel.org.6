Return-Path: <linux-kernel+bounces-555562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECBCA5B999
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBBD3ADE29
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595E7221733;
	Tue, 11 Mar 2025 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="nMoEkRQ0"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863C215178;
	Tue, 11 Mar 2025 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741677327; cv=none; b=CqbWs/SCVcJs11yw+K994GH4Y0Dpuihf1ryXdaMvCBwfARUMDyPecXjClaKNOLcvetP4yDukTBB0AUcsR2jy5soaf1Fu3QfcqcOzo2lyrHH52t3C2KSNa08yg8VQ9mTseGvXp0ktkctm7YKhenvUU00P3WkTRea4B2QnQXZHRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741677327; c=relaxed/simple;
	bh=jQyVAwfc8gxIeJGtvT1kVV9ULY05ohV//e2by3TNEx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKkTU5itml4mnR/SS5vpLYM8mmbcpYaJ8IX8nEMXROsljnPLlwoiAF3Thcg+fpIrk9WjPY2XEq0UZ5cnjNfBNRgwGuiYOJbB7ydRYV+EjeI2MHDF9vHjdBjSQutUochtRH3zqEol91+jZGApLS6G4Hu8RvuiYnx2oclc6pKB6XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=nMoEkRQ0; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1741676707; bh=jQyVAwfc8gxIeJGtvT1kVV9ULY05ohV//e2by3TNEx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMoEkRQ06c5Pdc2qFzCgbeA563Ll0Z8GA+WELdcNTEUWePEtfda9o+At7r22HMasC
	 8+WUwSdnJeeaeoT3gm4rI9v3USUCsoRvE8s/DNa52QZGu/KvKvC7iK0ksihP+WXdVU
	 ff/MSi0NUlQZAbsOcN94PLf3IQUUEqtBocAXugTxM7OLjIdHSi2ZWl/TMxHUT5N5wq
	 NTiESyz6RT1bmwf8jS1jNIk7SC22v/dHT51b9U/5eB4zzJWoX6peZka5r91EmvLEt2
	 3Ya+vJGZJDolAIciQESfvTbw0/9lcnyDQmbRUAAsuKfnVNfAkI5uo4OFeTvs5ViIcS
	 c8KTxePJZQDMw==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4ZBlBp30Brz64;
	Tue, 11 Mar 2025 08:05:06 +0100 (CET)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.7 at mail
Date: Tue, 11 Mar 2025 08:05:04 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre Ossman <pierre@ossman.eu>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mmc: cb710: Fix an error handling path in cb710_probe()
Message-ID: <Z8_goDqqhPFE4n3Y@qmqm.qmqm.pl>
References: <25de6764b32724eac554d48d17d23c50bb862693.1741508504.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25de6764b32724eac554d48d17d23c50bb862693.1741508504.git.christophe.jaillet@wanadoo.fr>

On Sun, Mar 09, 2025 at 09:22:05AM +0100, Christophe JAILLET wrote:
> If an error occurs after a successful ida_alloc() call, it should be undone
> by a corresponding ida_free(), as already done in the remove function.
> 
> Add the missing call in the error handling path of cb710_probe().
> 
> Fixes: 5f5bac8272be ("mmc: Driver for CB710/720 memory card reader (MMC part)")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/misc/cb710/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>

