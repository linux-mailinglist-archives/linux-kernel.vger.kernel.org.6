Return-Path: <linux-kernel+bounces-346599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6D898C688
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C0A1F25191
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2E1CDFDE;
	Tue,  1 Oct 2024 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FloCw/xn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AF1CDFD4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813465; cv=none; b=tLRNSSeL/zie5ROszhvFFy3flBVLVUWZ1MNI20SXbAAiyay+9I0f6/D+GD/WJuRa+K+8aTsQiiBufdXIXbMc+c8VNJyLLG31BvXaZta6MvObfIy47rNETZM3yqcmc4Kt/rrDOmYmS3DroIGBxQ2s3cuZomB/V8FAhuOjjC7crVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813465; c=relaxed/simple;
	bh=rrHLrqARY26n/u5vfnOPMmUZBDJAN0n2BtcqRU99cn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3N3HwU4yV6hR02pDQ8XV9dLe+hEkwAQYUkn5Xm3yKcXBRCeLZzpb2FWYvzi44UTqe1A27+VFDjh0zxQdwtED7apIIy5YJoVDtTfPpWMPsybnUg8Q13db94X+SeGJ+UexeFnn2+FdS/71zaeBm7prl3JjokCXQdg87w165QRRII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FloCw/xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BBBC4CEC6;
	Tue,  1 Oct 2024 20:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727813465;
	bh=rrHLrqARY26n/u5vfnOPMmUZBDJAN0n2BtcqRU99cn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FloCw/xny+BZg9ay6JZZitcYa5FmlBC8p3nMvihNYXqC2Sl9Su3rwAdr6urMT6IUV
	 gK+dnwMoyPQWonpTS7izliwsBYTxn++TpAypScowHcs/jSoreu4FH3jPqoAzLdKRHE
	 42gCE2gG9Mth4XRRAcZZTYBMgmiI3o2bWFNPQC0PATprLz6ZvmN5n81DT/bRy2zbjA
	 +e329dAZPMjYFkt0quQFskhueSbM0Ag05uAbF9obqsBn7c7UN0g0YPND67cGm8r53Q
	 w5fJInXzNy+1FdDSRdxB9K4TkpaJqYN7ajIiFDNZbPQNJzue8DxOsqt9vVS5n0tAxf
	 /iSskxQ65uuUQ==
Date: Tue, 1 Oct 2024 22:11:02 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 01/15] MAINTAINERS: Add missing file
 include/linux/delay.h
Message-ID: <ZvxXVgquzyiqzkLU@pavilion.home>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-1-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911-devel-anna-maria-b4-timers-flseep-v2-1-b0d3f33ccfe0@linutronix.de>

Le Wed, Sep 11, 2024 at 07:13:27AM +0200, Anna-Maria Behnsen a écrit :
> include/linux/delay.h is not covered by MAINTAINERS file. Add it to the
> "HIGH-RESOLUTION TIMERS, TIMER WHEEL, CLOCKEVENTS" section.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: Frederic Weisbecker <frederic@kernel.org>


> ---
> v2: New (splitted as requested by Frederic)
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38320..d9135d8ece99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10010,6 +10010,7 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
>  F:	Documentation/timers/
>  F:	include/linux/clockchips.h
> +F:	include/linux/delay.h
>  F:	include/linux/hrtimer.h
>  F:	include/linux/timer.h
>  F:	kernel/time/clockevents.c
> 
> -- 
> 2.39.2
> 

