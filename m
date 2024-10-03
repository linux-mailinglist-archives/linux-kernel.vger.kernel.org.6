Return-Path: <linux-kernel+bounces-348434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274E898E79D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 02:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35DF1F25B6C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7F3610D;
	Thu,  3 Oct 2024 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="iqhv58Ry"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5864A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914507; cv=none; b=I4lApfmqpI9hdLZYma0IOHIM/6+Md8JdLo+exI72aVn9ExXJFBSvpyTz5MrIjvRWgdmks7Yp0mDPfrIpdvJomphFO54zYpzwnKOplr90ghR72z4ehz/doNhrHITRUAeuBcHW8qmjREzs5Z4ctKr5xbOAB6fR0MfZk5/6P14h+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914507; c=relaxed/simple;
	bh=4WfAKXbZdBD6N3ano/uR1aTZt+m+v1e+gypCAEp7O6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hzV/Z7hajbkzGfWuwEiqPOBWxGyNXhnBkRyZ5w4eKGsNutfjoXRTkP93BVBR7sjPi4V28GhqORp7Og1F9AfGjV//2DsNlQFYCnJZZc54u10E/o9gg7iyOLDN5jUdoPNCV4JeiAhUZGP0wN3ZDmmd3RlgaWbYRRfD8LDHmI80/EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=iqhv58Ry; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XJsd51BQgzDqMh;
	Thu,  3 Oct 2024 00:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1727914505; bh=4WfAKXbZdBD6N3ano/uR1aTZt+m+v1e+gypCAEp7O6M=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=iqhv58RyqkRhk5v51KLv+d01pwK3B0PO8bc4QMHl4Arnhn5Aw0L+K7amfnt/slS9R
	 6xbQwj4DhHHBSq3uE3UAgv+d6osif3DZqPKUmYnPHESeRlA/I5LaRNfDLUpWkvYYXa
	 lFmicYYmkzJNCzeRsJPjTO/UvANq/iiqpMdagAOY=
X-Riseup-User-ID: 9C9CA45A99711EE903FC3E8437CE0A9B1C59647B04DB93407632F281A7DDC7EF
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4XJsd31S2yzFsRg;
	Thu,  3 Oct 2024 00:15:02 +0000 (UTC)
Message-ID: <1bd0064c-d0ec-415b-9b86-47df5c13e620@riseup.net>
Date: Wed, 2 Oct 2024 21:12:46 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Add information on checkpatch warning about `help` in
 modules
To: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
References: <20240928234649.193664-1-gbittencourt@lkcamp.dev>
Content-Language: en-US
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>,
 Andy Whitcroft <apw@canonical.com>, ~lkcamp/patches@lists.sr.ht,
 linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20240928234649.193664-1-gbittencourt@lkcamp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Gabriela!

You forgot the prefix "checkpatch: " at your commit message.

Em 28/09/2024 20:46, Gabriela Bittencourt escreveu:
> Add lines number information to warning of `module help` on Kconfig.
> On the creation of a new module, if `help` section is smaller than 4
> lines, checkpatch.pl gives a warning asking for a fully description. So
> add the information of the minimal required lines to be considered a
> fully description.
> 

I think the way is described could be more clear... maybe you could 
start by stating the problem, and then describing your solution. It 
should be clear why this change is needed and helpful. I would write 
something like this:

---
When writing a short help paragraph for a new KConfig option, developers 
are prompted the following warning:

    please write a help paragraph that fully describes the config symbol

However, developers might get confused about this message, giving that 
they do have written a help paragraph, but checkpatch is not happy about 
it, which can be perceived as a false positive. That happens because 
checkpatch considers a fully descriptive paragraph one if at least 
`$min_conf_desc_length` lines (as of now, 4 lines).

To make the warning more clear, output in the message the expected 
length of the paragraph, so developers know better what checkpatch wants 
from them.
---

Thanks!
	André

