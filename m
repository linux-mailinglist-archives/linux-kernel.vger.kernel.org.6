Return-Path: <linux-kernel+bounces-428802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824979E13B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CCC282CDA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CB118A6D7;
	Tue,  3 Dec 2024 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpUpWXlF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401B189BB1;
	Tue,  3 Dec 2024 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733209197; cv=none; b=LN2u3ejOwQNhKIuMvMosiiAtxzOxjoguXnaW9FUeDaThdOt0EfL//n0qtRip9uBQwmVzu1+MsZZBP6dNI/p8sLsZ5IYvCqPt31jQOFVZ+o7XABZUQDLTEUMS9e2RE/n1VutH9jCqHcgBOxsK37fivzPDcjHOt4xxkeL0sjhw97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733209197; c=relaxed/simple;
	bh=fxLpxJ49/62muxJi+PRy6L5Q1LtrGMaZmRWd0CXi+5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVQ828BWWAh7yh7mSWlMZqDNQDAeIn03SHPQHkOBKaQ1gABt90aTfl58DZ312aycdxFXZW6AIDX9cRWZwpenILtmPFI2XuKRlWJ5DSCAkI0TZvzz9Qgpu+pzhlGXMSM5+QlzDdiKB/6Uinv0DFqF+hO+TsEbKaUFr8xSlay0lSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpUpWXlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E6FC4CECF;
	Tue,  3 Dec 2024 06:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733209196;
	bh=fxLpxJ49/62muxJi+PRy6L5Q1LtrGMaZmRWd0CXi+5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CpUpWXlFzjEgxgq2nKhD+oiOXshkmThD3+1a2HZ21yDtBg2zIqfMHuWCmP4Eq8/aq
	 J7VBn/+sVgF2IUg5YyEovPGzdqj+SPGZhvUA6t56iBQMrywFbT39DfvcH2lZOI/VKB
	 QDwdRZE5YdNAVqD2azLu7XYKEbnoc2QwhjDesESgwQz1/9rvjME93Y0NcKaRSB4NSZ
	 mg/RpwHeMZJ64EuzTwgGt7DqS8V22C5r6ptHX3h7K3bmANKtJkEix2zAf2RFfDD6zk
	 ccoiYhPhcSa3k6V0emWHejnjDNcTHBFh26xQ/q3nFkBWYoJOd+pDlh6DcRWcZVzf6A
	 ZgqBtIwTvfZyQ==
Date: Tue, 3 Dec 2024 07:59:51 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 DONOTMERGE] docs: clarify rules wrt tagging other
 people
Message-ID: <20241203075951.3a7021ec@foz.lan>
In-Reply-To: <bd47620e-d2bd-48f5-8e40-555d6ddf921e@leemhuis.info>
References: <c29ef5fa12e37c3a289e46d4442b069af94e5b05.1733127212.git.linux@leemhuis.info>
	<20241202092857.7d197995@foz.lan>
	<20241202110210.5e56d69e@foz.lan>
	<d8cae2d3-d855-404b-8991-f81c979486ce@leemhuis.info>
	<20241202154528.7949e7cb@foz.lan>
	<6f1bbdf3-22df-415c-b017-de1cf81af57e@leemhuis.info>
	<20241202171734.2874a9a3@foz.lan>
	<bd47620e-d2bd-48f5-8e40-555d6ddf921e@leemhuis.info>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 3 Dec 2024 07:25:43 +0100
Thorsten Leemhuis <linux@leemhuis.info> escreveu:

> On 02.12.24 17:17, Mauro Carvalho Chehab wrote:
> > Em Mon, 2 Dec 2024 16:54:49 +0100
> > Thorsten Leemhuis <linux@leemhuis.info> escreveu:  
> >> On 02.12.24 15:45, Mauro Carvalho Chehab wrote:  
> >>> Em Mon, 2 Dec 2024 14:54:56 +0100
> >>> Thorsten Leemhuis <linux@leemhuis.info> escreveu:  
> >>>> On 02.12.24 11:02, Mauro Carvalho Chehab wrote:    
> >>>>> Em Mon, 2 Dec 2024 09:28:57 +0100
> >>>>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:  
> >>>>>>> +Tagging people requires permission
> >>>>>>> +----------------------------------
> >>>>>>> +
> >>>>>>> +Be careful in the addition of tags to your patches, as all except for Cc:,
> >>>>>>> +Reported-by:, and Suggested-by: need explicit permission of the person named.  
> >>>>>
> >>>>> Hmm... There is another tag that we use without requiring explicit permissions:
> >>>>>
> >>>>> 	Requested-by:
> >>>>>
> >>>>> There are currently 376 occurrences on 6.13-rc1.
> >>>>>
> >>>>> This is used when a maintainer or reviewer publicly requests some changes to
> >>>>> be added on a patch series.      
> >>> [...]
> >>> You're basically requesting explicit permission for any "non-official"
> >>> tags as well, including reviewed-by. This is not what it is wanted here.    
> >>
> >> I could easily use a slightly modified phrase like "...as all
> >> mentioned above except...".  
> > 
> > It seems a lot better to me.  
> 
> I went with this a slightly different variant for readability:
> 
> Be careful in the addition of the aforementioned tags to your patches,
> as all except for Cc:, Reported-by:, and Suggested-by: need explicit
> permission of the person named.
> 
> Hope that's okay. If I don't hear anything, I'll assume your earlier
> Reviewed-by: is still valid.

It is. Just in case:
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> 
> Ciao, Thorsten



Thanks,
Mauro

