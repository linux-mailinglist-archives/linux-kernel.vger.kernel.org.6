Return-Path: <linux-kernel+bounces-317477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A46A96DEE4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB850281099
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A357E19CD07;
	Thu,  5 Sep 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ldfM5hLg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7417C9B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551446; cv=none; b=cd/GbpLrS9lgutG7d443i+D1msPk6OP2Ckzjzl/+1k1O6eQbugMHcq80SO5gYEWhsiykocaeV0qljj8AVmnvZgZOaVClgXYHotnRAJXMV3/wXAA9B0bjSiCLELuOqhtHSJul+V/WgOxKF5pi1BGhlCFoeWE8J9GF7uzD+uBQJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551446; c=relaxed/simple;
	bh=80skF5oONXJ5Kz6IMFFpm/VNcW8CTz6bL33tED/J3XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErLFS26yVRK0c0OudCmQjA1KWjBgSu2rpzl/7AQRtd+etxuGtCuVM7FrxZpjTGb5sUpuCX7akgm1tei9UcuI1cyMJCmeB+KHtnh4fC1EsmTsfXd6b0QSnLPtZK3urel7BywGT1xuLydRvf18dy7zz6pse3wJHGyCPOGP+sP/CwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ldfM5hLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488B2C4CEC3;
	Thu,  5 Sep 2024 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725551445;
	bh=80skF5oONXJ5Kz6IMFFpm/VNcW8CTz6bL33tED/J3XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ldfM5hLgXxGlaZCRC9ImXsMokNEXFZZuzmUOos7ZiQ8gjud3fFhcGfAeiEZly36XB
	 nL4YIoEJH84P9aAtlWxVBF9H4/HEWJj6jsqQBToQz81uOWj7cOYTwEWaXmw5ohu+d0
	 WkcVvCe17USkOOagetcyUEGKrpFUDw1SC6VxF1J0=
Date: Thu, 5 Sep 2024 11:50:44 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, GNU/Weeb Mailing List <gwml@gnuweeb.org>, 
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>, Ravel Kevin Ethan <silverwolf@gnuweeb.org>, 
	Michael William Jonathan <moe@gnuweeb.org>
Subject: Re: Public Inbox Output Broken Due to Double HTML Encoding
Message-ID: <20240905-fine-ancient-gerbil-ac6a7e@lemur>
References: <ZtnRfnHrxVeEwTwx@biznet-home.integral.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtnRfnHrxVeEwTwx@biznet-home.integral.gnuweeb.org>

On Thu, Sep 05, 2024 at 10:42:54PM GMT, Ammar Faizi wrote:
> 
> Hi,
> 
> We have noticed a recent issue with the lore public inbox output where
> it appears to be affected by double HTML encoding. This problem
> surfaced after 1 September 2024, as that was the last time we observed
> the correct output.

This is an intermittent problem that is known and reported upstream:
https://public-inbox.org/meta/20240904-fearless-solid-toucanet-a70afa@meerkat/T/#t

-K

