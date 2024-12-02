Return-Path: <linux-kernel+bounces-427978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317929E083B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB384284BE2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A91A17C215;
	Mon,  2 Dec 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orWka/Fs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95087126C13;
	Mon,  2 Dec 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156259; cv=none; b=OB8cLT4xHL1I7YFxtNKqR8vP8lyPM05FVx74tI0ylw2BF08mjJE7YoiyPkhKyCpyX+pphCtpycR8Px6fIKgiTKfweWH+P/WRwouy848+LgRuK6l6SNMjFgvtR1tifBa/COdaHmy4JKsR2qFnTufG9MxdAih63YloDmHgObO314g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156259; c=relaxed/simple;
	bh=FdAl/pnmfZjlLTBXtyBGlzxjl+zb6kNwgaI64za+Yy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCYVAn1tRcR2Q8zMEdPCruVTCMQS2+It6YgRikBh9J381wTbpJo0z4AWd6b7Ujx2HwvPJvyDdBm5BIOLa7GHZKukaCySLQqFhZdy2dDs/7W0dROar8S9t1Uhvag8C6LZwURUeE4tzvU6lP1hjp913LR3WGh19KCAPsnxA5/STLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orWka/Fs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571A8C4CED1;
	Mon,  2 Dec 2024 16:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733156259;
	bh=FdAl/pnmfZjlLTBXtyBGlzxjl+zb6kNwgaI64za+Yy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=orWka/FshVy1ETVnsHYOcsYvI47dzAzZfvzCVSpKLJId8S9UECUiMx/pbQiSopcVx
	 Xpa5p/+71s/PxhdGdF4KVuO1+nR7K4xvqMYfNIAlR9Hd+RKM4rKVNhseKiqq1klPsG
	 prq+gpR+IiXmGO2c1Ernb+PzokGx2meBGohin/PU6Jz8Vn4lDrGGj0gRq1EraAGxsc
	 WECvenbjRbZE8P2qOwL+RJ9/Oib7wAdjcr20tvR8nxfZvDAZpbijeGRQD65dXoieeH
	 7rJfFaEMp3rkguwLO6TDdfm5RzHMpAYd4MXNBzsiBI0Kalg1hJz+jrd8XGXhn+ryVV
	 H4lE2t13sCOEg==
Date: Mon, 2 Dec 2024 17:17:34 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 DONOTMERGE] docs: clarify rules wrt tagging other
 people
Message-ID: <20241202171734.2874a9a3@foz.lan>
In-Reply-To: <6f1bbdf3-22df-415c-b017-de1cf81af57e@leemhuis.info>
References: <c29ef5fa12e37c3a289e46d4442b069af94e5b05.1733127212.git.linux@leemhuis.info>
	<20241202092857.7d197995@foz.lan>
	<20241202110210.5e56d69e@foz.lan>
	<d8cae2d3-d855-404b-8991-f81c979486ce@leemhuis.info>
	<20241202154528.7949e7cb@foz.lan>
	<6f1bbdf3-22df-415c-b017-de1cf81af57e@leemhuis.info>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 2 Dec 2024 16:54:49 +0100
Thorsten Leemhuis <linux@leemhuis.info> escreveu:

> On 02.12.24 15:45, Mauro Carvalho Chehab wrote:
> > Em Mon, 2 Dec 2024 14:54:56 +0100
> > Thorsten Leemhuis <linux@leemhuis.info> escreveu:
> >   
> >> On 02.12.24 11:02, Mauro Carvalho Chehab wrote:  
> >>> Em Mon, 2 Dec 2024 09:28:57 +0100
> >>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> >>>     
> >>>>> +Tagging people requires permission
> >>>>> +----------------------------------
> >>>>> +
> >>>>> +Be careful in the addition of tags to your patches, as all except for Cc:,
> >>>>> +Reported-by:, and Suggested-by: need explicit permission of the person named.
> >>>>> +For the three aforementioned ones implicit permission is sufficient if the
> >>>>> +person contributed to the Linux kernel using that name and email address
> >>>>> +according to the lore archives or the commit history -- and in case of
> >>>>> +Reported-by: and Suggested-by: did the reporting or suggestion in public.
> >>>>> +Note, bugzilla.kernel.org is a public place in this sense, but email addresses
> >>>>> +used there are private; so do not expose them in tags, unless the person used
> >>>>> +them in earlier contributions.    
> >>>
> >>> Hmm... There is another tag that we use without requiring explicit permissions:
> >>>
> >>> 	Requested-by:
> >>>
> >>> There are currently 376 occurrences on 6.13-rc1.
> >>>
> >>> This is used when a maintainer or reviewer publicly requests some changes to
> >>> be added on a patch series.    
> > [...]
> > You're basically requesting explicit permission for any "non-official"
> > tags as well, including reviewed-by. This is not what it is wanted here.  
> 
> Ahh, okay, I see the problem now. But well, I'd say "as all except" in a
> text like this implicitly only refers to those the text mentions in the
> first place. So I'd say it's good as it is. But if people think this is
> a problem,

I still think it is problematic, but with the change below:

> I could easily use a slightly modified phrase like "...as all
> mentioned above except...".

It seems a lot better to me.

Regards,
Mauro

