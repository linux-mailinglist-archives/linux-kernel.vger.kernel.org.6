Return-Path: <linux-kernel+bounces-427805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E749E072C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D57516DE44
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699D0204F86;
	Mon,  2 Dec 2024 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="BdmelBZj"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5E210FB;
	Mon,  2 Dec 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151651; cv=none; b=lcK0CK8zy5/0J8ThmZjKqEEvuHIp79LAnDxhW8Bees3dFddxjuudDEhpWt5xPgEIRBhmVjO+772lXUt+y3g4sONkCPaxm93H7/CJaflrl8J+czmUb/GRfQ5bb0bAQGuE5eM4TZVGdgWzx68RUYdMuzqDH3/lMf9a6C9pscmf0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151651; c=relaxed/simple;
	bh=mHVrlQwCK5GGIIPaEC5wD4VmNpf8hz3vNgwxVhbJUE8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JnyPfr06ogZyHzOcpFgpRtN7AZYbIvg8av1tOiPEhKBVhQ0KdRex4mMICpimvmhabEC5XZcmNevnhQUFvjWfG4InUQXOJvaKdwL3feFIyY09OLowPibAvdo4J34v8qSHUiTmn6Uhnw8Z/YuPXunEa4aPOOLnhT1tZpgASDNn3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=BdmelBZj; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733151648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ke9HAWyIyVMoy4+WbUMo76Pv7napvRkCfz+Fo70nZbI=;
	b=BdmelBZjJaF/FJzybOwiZVaUEMz5LH7q6ikTjzxddzayZYFLlwjdx9RkYSiTS2Cb7imZGr
	Xhm5jxRZO6wnSuQ01XZUiAddXhCvdcDhqpfEyNZjU8UZ77auSBoMdzELvuaFrziQrf3n1P
	zbX/rR1wcivLdzgzqkuMzZY1jxReQeE0wtnUDePLtmJI/vIWR1RFy3mgZJzhWSRXoAh3K6
	LH/aWFf6ghmcWPvCe525daReXlhV80A3zxkgmWGHYCFBVBF+KP5yPrmDyr8CpDZEfx/o+M
	gAD2NIcNPJ1DqLWSMRWDGp0JJlxCwvKq67jkM/U360O11vdC89MXWsshcH8LAw==
Date: Mon, 02 Dec 2024 16:00:47 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, apw@canonical.com, joe@perches.com,
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, workflows@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, wens@csie.org
Subject: Re: [PATCH v2 0/3] Make Helped-by tag supported
In-Reply-To: <28c0a0ecc2e2880e4cb98449767e2842@manjaro.org>
References: <cover.1730874296.git.dsimic@manjaro.org>
 <87h68k4esb.fsf@trenco.lwn.net>
 <cabfa180845df30bfb7a541a701a57e9@manjaro.org>
 <672e628111eb0_10bc629436@dwillia2-xfh.jf.intel.com.notmuch>
 <28c0a0ecc2e2880e4cb98449767e2842@manjaro.org>
Message-ID: <9ae99d14dcd8867333fceacfaaa4430a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-11-09 04:10, Dragan Simic wrote:
> On 2024-11-08 20:12, Dan Williams wrote:
>> Dragan Simic wrote:
>>> I'm fully aware that we may be reluctant to supporting additional 
>>> tags,
>>> because we may then end up with a whole bunch of strange tags that 
>>> might
>>> be a bit hard to understand and use properly, but I think that adding
>>> Helped-by to the supported tag list may actually be a good thing to 
>>> do.
>>> As described above, Helped-by fits very well between the Suggested-by
>>> tag and the Co-developed-by + Signed-off-by pair of tags, and I think
>>> that providing the right level of attribution may be beneficial.
>> 
>> Patch attribution is separate from giving thanks. I would much rather
>> someone take the time to say "Thanks" in the changelog with some
>> supporting text rather than boil down all the myriad ways to be 
>> thankful
>> into a generic tag. "git log --grep=Thanks" often yields valuable
>> details, beyond just attribution, on how people have helped each other
>> develop this global project of ours. If the introduction of Helped-by
>> would replace even one authentic "Thank you" note with a generic tag
>> then it is a net loss for the community.
> 
> I do agree that writing "Thanks John for helping with..." in a patch
> description would be nice, but unfortunately I've seen multiple times
> that people don't enjoy writing their patch descriptions at all, and
> just want to "get them out the door" as quickly as possible.
> 
> With that in mind, making Helped-by tags supported would allow such
> people to at least quickly mention someone they're thankful to, which
> actually wouldn't prevent anyone from saying the same more verbosely
> in a patch description.

Just checking, are there any further thoughts on this patch?

