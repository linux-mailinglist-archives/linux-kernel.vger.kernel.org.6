Return-Path: <linux-kernel+bounces-310256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D653967717
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2C71C20DCD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB5181334;
	Sun,  1 Sep 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BGkjPyw1"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF8381DF
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725201185; cv=none; b=JSCGhKWf0D/4NGGrNpSVvhnppJHFJFZlz4GHHRGkQeVXPce+gwDPLLKhNDXcEqXuBFsstr+mA995y+iqhiXwbvP6+IVpwulfpdf2O5w1bdeI37S+gnlsRqegOiP+kwD0LdMkxEn5EnuuqblaWnD3Cw0QxvM4DYb+DBqchhwakPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725201185; c=relaxed/simple;
	bh=Qnho+P7/rrraXQouXon4x/RffWJR5iD4eKYRb+pQmDo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eV/a+tlEfvuLSEmVHZAZcfVq8ihPmo4wxq03YJwLVAfI6jI7+jWNBreiWT43qZn6N7kN/Sk+9tCIVACGPPQfzbuPUCG8Qfp/I/ppNHSTd+7pBHS2OiPTQuJuQjuX434ZXpu3mC6PRsCS+YiHFiZqezWUSy+az9bcIdaq7C1nkwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BGkjPyw1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ACA4A41ABE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725201176; bh=Wb4qVt4qrjof3WhfYa/l6tQKLywCYPwwIAXqNw7TYWI=;
	h=From:To:Subject:Date:From;
	b=BGkjPyw1LkBmVP6fnUKXPMPe3UGUlrNBiW+iTtpXe5IdN6ffPWFz21XciklFa6/ES
	 JORrFwHgH2PkrL4oZJmQqP2c2DwB9Pc6LeEoVG72cEqHm4J9yxnBfXTRcAvNwoq0iw
	 JQkW5IACV64dS7+4RrsEaDuurl6DOYphcigecRzYCGEd5R4u5m2wQ5C4pEE1n1rRJd
	 BWZWlbHgNcJvAJ2STAzlGVXlRmm5ajVOQeSjVgIUNjhy/yZYtcsU2jnXsmeRgnySZd
	 ttwmfq7/XjXG18bEE8yYrJjENEIx2uV/PmvNyXKaDWnc3ls40rblxnGdqPMSVtjrGk
	 OAJugad5zeDOw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id ACA4A41ABE;
	Sun,  1 Sep 2024 14:32:56 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: tab-elections@lists.linux.dev, tech-board-discuss@lists.linux.dev,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: 2024 LF Technical Advisory Board election - call for candidates
Date: Sun, 01 Sep 2024 08:32:55 -0600
Message-ID: <87zforv3zc.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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

