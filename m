Return-Path: <linux-kernel+bounces-386471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 779DE9B43E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04A31F23029
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5720A2038A2;
	Tue, 29 Oct 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="itzkz8da"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EFB4C6E;
	Tue, 29 Oct 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189430; cv=none; b=eqGscN7OTN/pBLucrreb0JXTaDnIK6IiiQfJMnVW/IV5/TQlUyC1dKvAastYLwrQLmpjEoWdIfMSUxqoxns9QXKYHnbI21pLGoGYtenAN0ZYu9QU5+XsqsTU5IwGDFNQjAaso5XePPuwWYLqXvawpy11ePKamAlfzuM1QdGgVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189430; c=relaxed/simple;
	bh=JJNPm3Bdq4ySiOd4gtYN70hmFJDbCsSVTfhbw/0Yba8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V24gmHu+Fr6vvdTZW6m0lv+XBnGBsSNm/mVU1QYwIZ5rHezxxbZQeH9n/1GQV2kNpaqhozYEzsYem6VMCSQ5xMsnlKmzVOyMFcviZ3kDQE2dzD7H9enDypwIrvEuqNwsKz0ee6/CsvrnX1bJA2IXM52pxjBaJ41ay7g4rZcM4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=itzkz8da; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=E0OscYutqiRQ2JUSb7cWt2MdlkZynOZ74rTXfpYZO+8=; t=1730189428;
	x=1730621428; b=itzkz8da0uppr2EyVOKoqnWXDSrSy4YVsaaXgEX2TkCNeywc/ZU/DLp1OrYxX
	MJr2pqdHBjdEN7ZXEwu5Pcqu7BCjB/i0LGsUAhjaJGc72m8qXCtcOCvP8h+5ID8S9C7daokr+5q0F
	EKvEOJygQdBh+iblI4psZiwb7543u0dcpIAHaFkfNWl0PFOuCs2ONeMHErHQTdHEqWLNc+nmyaXVR
	U6AsHksb6ZoEx4ppE+aYkZQm7opK/EGAC6OE6hCFQxid2W+KUpE7vPE12TNRjWDOB51sF+iAD1YrC
	SZatcWNx/Fqsd5mpAO7cDnca19GjO2z4C5ZXrO676UTqGJ8KmQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t5hJ4-0003tG-2E; Tue, 29 Oct 2024 09:10:26 +0100
Message-ID: <d75c9c2f-353f-464c-89d3-8c18dbfb4770@leemhuis.info>
Date: Tue, 29 Oct 2024 09:10:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
To: Sasha Levin <sashal@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Kees Cook <kees@kernel.org>, torvalds@linux-foundation.org,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org> <ZyAUO0b3z_f_kVnj@sashalap>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <ZyAUO0b3z_f_kVnj@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1730189428;afc16d7f;
X-HE-SMSGID: 1t5hJ4-0003tG-2E

On 28.10.24 23:46, Sasha Levin wrote:
> On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:
>> On Mon, Oct 21, 2024 at 09:54:53PM -0700, Kees Cook wrote:
>>> For example, for a given PR, the bot can report:
>>>
>>> - Were the patches CCed to a mailing list?
>>> - A histogram of how long the patches were in next (to show bake times)
>>> - Are any patches associated with test failures? (0day and many other
>>> CIs are already running tests against -next; parse those reports)
>>>
>>> We could have a real pre-submit checker! :)
>>
>> That would be very useful.  Items 1 and 2 should be trivial, 3 would
>> require a bit of work but would still be very useful.
> 
> If you've been following so far, there is a bot that is capable of doing
> most of the above
> (https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-
> analysis.git/).
> 
> Here's a histogram that describes v6.12-rc4..v6.12-rc5 as far as how
> long commits spent in -next:

I took a quick look at that tree and histo.sh that lead to a few
questions here the code had no obvious answers to (or I missed them due
to the "quick" aspect):

* How does histo.sh handle changes where the commit-id changed between
the first time in -next and their merge into Linus' tree (while the
patch itself did not change)? For example due to a rebase or workflows
where the commit-id changes regularly, such as those used by the
bluetooth tree (for -fixes, as it queues them in their -next branch
first) or the -mm tree (for most of it iirc -- this made things hard in
a script of mine that looks up the arrival in -next)?

* Do those lore scripts detect if a committer adjusted the subject of a
patch that has been on lore?

* How do the scripts handle patches that changed a lot while they were
in -next? I know of one subsystem that regularly drops whole patch-sets
from their trees included in -next to replace them with newer versions
of said patch-sets -- and then the timer maybe should restart.

> This is where I think the value of linus-next comes during the -rc
> cycles: the (89 + 21) commits that haven't gone through the -next
> workflow before being pulled. 
>
> I'm not looking to delay the process and
> add latency, I'm looking to plug a hole where code would flow directly
> to Linus's tree bypassing -next.

Overall after all the discussions in this thread I still fail to see why
we need a new tree for that. Why not make pending-fixes a bit more
prominent while motivating maintainers to have proper -fixes branches
included there?

Ciao, Thorsten

