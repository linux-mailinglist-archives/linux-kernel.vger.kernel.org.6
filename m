Return-Path: <linux-kernel+bounces-324964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B073B975334
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74846284F26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A9F19CC31;
	Wed, 11 Sep 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WdYAv8gV"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101E192D8E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059961; cv=none; b=qmbaYk4n97DmiYEJrX/sVF1aBWT0p0OXe2gd7oEljo6WxpywaibssiqaDrB50PU1/tAHHbIxmTntUqA9D2Mt1IB+yLWjA5626Cra63VyF8ILd1s4hKhnPH0FyVXAZyry6K5Az5F5WRs/GEdH92RTFPJ/Ue1pKQfKYFOx3dClkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059961; c=relaxed/simple;
	bh=BXPwsoK9FvFUJ7WxxgZ5KW+jsjjxux1BD7CzjllDWkI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tj8rVgMHCeOIM49XXnyYlH0MY91EtvNrTehGkoDlEUZx7DmYcUXrYMZWkIpFxfv4qEELj7Uqe7FMYoQZjxvaPNrCf7GGFzr0i/1E7rgrRCobRueagA/rEmzsDMZhyNFWnWUBTel16mMjqurWDxw7xcxUI+FYNuQEDxbYwPu8zA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WdYAv8gV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 41A494188E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726059959; bh=KTduR+DQyc7AHb+0+LvZv+SFGZOFQithtvZgd+XN46Q=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=WdYAv8gVBhKwKbpV3fN9Zao63qdUrUEfpeE6g2rI8osrma+GInsQiPwj7NayuWO5T
	 P2gPwKi+1xxznTLwwbsam23OXL95G+RzD3vYgiY5bDWBnPTBahPDnDvifE2XXwwhCp
	 ErubrUGh3bHFkwVtbjeCl9Wix5vL3NFQPe0fLOY4j6ydlRhI+m+0NBOAUB6Amfi8Zx
	 YMdmqu3OietfEMxPuUSag+YIYwUhc0VwN/iTGxZ+KSfyr+KAlMcwN/t1a1xOQcitLl
	 xuaMhXc3b9791alvwYBzqWWjViCiIzNSufstTV1uWl1jnDcKFdyUXH7xFrvUEae3pD
	 AYBNSqr6ayx3w==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 41A494188E;
	Wed, 11 Sep 2024 13:05:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: tab-elections@lists.linux.dev, tech-board-discuss@lists.linux.dev,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Linux Foundation TAB election update
In-Reply-To: <87zforv3zc.fsf@trenco.lwn.net>
References: <87zforv3zc.fsf@trenco.lwn.net>
Date: Wed, 11 Sep 2024 07:05:58 -0600
Message-ID: <877cbi5oi1.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This is a quick update on the upcoming election for five seats on the Linux
Foundation Technical Advisory Board.

- Everybody who is eligible for an automatic ballot has been sent an email
  to that effect.  If you did not receive the email (and feel you should
  have), or if you are eligible to vote and would like a ballot, please
  contact us at tab-elections@lists.linux.dev.

- The nomination period is open through September 20.  Serving on the TAB
  is a unique opportunity to help the community; if you are interested,
  please do not hesitate to put your name forward.

Eligible voters should be sure to enable their email address in the CIVS
system prior to the start of voting.  If you have done that in past years,
you do not need to do it again this year.

The original announcement follows with all the details.

Thanks,

The LF TAB elections team

-------

The 2024 election for membership on the Linux Foundation Technical
Advisory Board (TAB) will be held electronically after the 2024 Linux
Plumbers Conference, from September 20 to 27.  This announcement covers
both the call for candidates and the details of voting in this election.

The TAB exists to provide advice from the kernel community to the Linux
Foundation and holds a seat on the LF's board of directors; it also serves
to facilitate interactions both within the community and with outside
entities.  Over the last year, the TAB has overseen the organization of the
Linux Plumbers Conference, advised on the setup of the kernel CVE numbering
authority, worked behind the scenes to help resolve a number of contentious
community discussions, worked with the Linux Foundation on community
conference planning, and more.

The public minutes from TAB meetings can be found in this repository:
https://git.kernel.org/pub/scm/docs/tab/tab.git/.

Note that there will be an "ask us anything" session with the current TAB
at the Linux Plumbers Conference; it is currently scheduled for 9:00 on
Friday, September 20.

CALL FOR NOMINATIONS

The TAB has ten members serving two-year terms; half of the board is
elected each year.  The members whose terms are expiring this year are:

 - Christian Brauner
 - Kees Cook
 - Dave Hansen
 - Jakub Kicinski
 - Dan Williams

The members whose terms expire next year are:

 - Jonathan Corbet
 - Greg Kroah-Hartman
 - Sasha Levin
 - Steve Rostedt
 - Ted Ts'o

Anybody who meets the voting criteria (described below) may
self-nominate to run in this election.  To nominate yourself, please
send an email to:

	tech-board-discuss@lists.linux.dev

Please include a short (<= 200 words) statement describing why you are
running and what you would like to accomplish on the TAB; these
statements will be collected and made publicly available.

The nomination deadline is 17:00 CET (GMT + 2) on September 20.

VOTING IN THE TAB ELECTION

The criteria for voting in this year's TAB election are unchanged from last
year.  To be eligible to vote, you must have at least three commits in a
released mainline or stable kernel that:

 - Have a commit date in 2023 or later
 - List your email in a Signed-off-by, Tested-by, Reported-by, Reviewed-
   by, or Acked-by tag.

Everybody with at least 50 commits meeting this description will receive
a ballot automatically; they will receive an email confirming this
status shortly.  Eligible voters with less than 50 commits can receive a
ballot by sending a request to tab-elections@lists.linuxfoundation.org.

We will, once again, be using the Condorcet Internet Voting Service
(CIVS) https://civs1.civs.us/ . This is a voting service focused on
security and privacy. There are sample polls on the website if you would
like to see what a ballot will look like.

Please contact tab-elections@lists.linux.dev if you have any questions.

