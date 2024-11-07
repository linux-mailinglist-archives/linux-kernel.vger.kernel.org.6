Return-Path: <linux-kernel+bounces-400082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D743F9C08BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152271C21F58
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FBF212D13;
	Thu,  7 Nov 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QetVRRgG"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA62212164;
	Thu,  7 Nov 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989068; cv=none; b=idmuE0nPuTmpopWG9il4Ada4+QaiA/B6cy7Uy1BWtxmTRrMw6kroMwSPUCXye5RZIuarEOdkNXjwcbJHfXW5fatF/rvUeL2VU+k0OsRhJUTnqPv3wNO4+30niW1Ttnf/+Uoxc/SO7Wh3RMYrxmN3orAfkSh0cXvLU7GTprBfQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989068; c=relaxed/simple;
	bh=Fm1zpy+fNmmSrwiAXW+famhfnfU9ILSbYobTRaQC/ys=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fCFgOGE7Or2zlY0QWHj+8x41vhG/skBkTrxMDb6BNDKBtismPYB7GqgUz7/gHaBOB+L7QC6GMCnEdIfmRXcfDwJ7N3MJ/oRteds2pSy5CFbEGflNgH7isGm+vlVEoDvnTi5tu1fqhAc03PlGSpF9vCAOrFvLWeCioMeIu7hmXhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QetVRRgG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730988545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfCiWb167VnGXmqmnUWRqEBySAPrNU+qdZTF1ehmBTg=;
	b=QetVRRgGq8wyM3ZZpQE1NvypY1a8AGGzAav+vWhxsadpLFvHi5bLwjxpp7UuBNJDYUwT2Y
	yIV16FY+JQ2RoCzPPKbJPiE2H0pREpT/ZEYUwlzH+GGZ74OX5nSI7BrWlr8X3Rxup/opgY
	lqNFpz2hnG90ZjG95wMaMUKt5xvaQmcHnSUGN5Tr4elt34959hOqnU6WaRQ2r/LbOuUm+N
	4XovsGG25b8+QjwSdArzQJAQdSB7uxMSnVIrqLopwItK4gr4BCM1P7sO36gD/ULUEWF20W
	cIaiei/TxDLcHodIx50xsG7F4CzS6SepeVKwMNUD8Dk1GOVGgvnxK613d2Ebjg==
Date: Thu, 07 Nov 2024 15:09:02 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com, workflows@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, wens@csie.org
Subject: Re: [PATCH v2 0/3] Make Helped-by tag supported
In-Reply-To: <87h68k4esb.fsf@trenco.lwn.net>
References: <cover.1730874296.git.dsimic@manjaro.org>
 <87h68k4esb.fsf@trenco.lwn.net>
Message-ID: <cabfa180845df30bfb7a541a701a57e9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jonathan,

On 2024-11-06 15:28, Jonathan Corbet wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> This is a short series that adds Helped-by tag to the list of accepted
>> tags in scripts/checkpatch.pl, and describes the intended use of this 
>> new
>> tag in Documentation/process/submitting-patches.rst.
>> 
>> The proposed Helped-by tag fits well to indicate someone had helped 
>> with
>> the development of a patch, to the level that doesn't warrant 
>> providing
>> a Co-developed-by tag, but is much more than it would've been 
>> indicated
>> by providing a Suggested-by tag.
> 
> The documentation is meant to cover our existing conventions, rather
> than to drive new ones - usually, at least.  There are exactly 11
> commits in the history with Helped-by, suggesting we're not really at 
> an
> established convention at this point.  Given that there has been some
> resistance to inventing new tags, are we sure that we want this one?

Thanks for your response.

Of course, the documentation would be updated only if the first patch
in this series becomes accepted, i.e. if Helped-by becomes supported
in checkpatch.pl.  I'm sorry if I wasn't clear enough.

It's usually said that necessity is mother of invention, which is the
case here.  In a few words, I've got another patch pending merging [1]
that a couple of people helped me with.  What they did is more than
what Suggested-by tags would indicate, but doesn't really warrant
Co-developed-by + Signed-off-by pairs or tags.  Having Helped-by tags
provided for both of them would fit pretty much perfectly.

It was very similar, if not the same, when it comes to the development
that led to a few commits already containing Helped-by tags. [2]  Sure,
that isn't a whole lot of such commits, but this may be a good point
to decide what to do with Helped-by tags in the future.

I'm fully aware that we may be reluctant to supporting additional tags,
because we may then end up with a whole bunch of strange tags that might
be a bit hard to understand and use properly, but I think that adding
Helped-by to the supported tag list may actually be a good thing to do.
As described above, Helped-by fits very well between the Suggested-by
tag and the Co-developed-by + Signed-off-by pair of tags, and I think
that providing the right level of attribution may be beneficial.

[1] 
https://lore.kernel.org/linux-sunxi/129f0c754d071cca1db5d207d9d4a7bd9831dff7.1726773282.git.dsimic@manjaro.org/T/#u
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=Helped-by

