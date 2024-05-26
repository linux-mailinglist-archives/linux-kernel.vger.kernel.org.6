Return-Path: <linux-kernel+bounces-189621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F25A8CF300
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D003B1C2116F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B799476;
	Sun, 26 May 2024 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rzKgZG1D"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5A1A2C2B;
	Sun, 26 May 2024 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716715237; cv=none; b=dWR7HDwXxKF3SWobNwikQTCYzSa7OQeXqsCYLAsravHo70i7DI4BCOJYG4W6z7iV/W/e4ROqIX4hseOnVOWu6xTCQhImFp/CVjBxoZno6fUPCRq+gpHgFRNEifqmNG5aH6/qYeoIeA6O6twlqlWShMrFhUWipx8ZnBaAr6/jb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716715237; c=relaxed/simple;
	bh=eqdB+c9AHV8Vh8prMy2Bz/FOpvhm7Ix0hdzFjT/E4pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxHaOQyKNabw/sXiN2Fz4fxrK9uDO6UY6XD6N5HTaalPNPRQUjDeFp0jom/adfiK3+s3eBFNl1WwmUUdPfwoV3BkoTsxo57V5Znme8+FqfEXDfL9DMyHubJ7DWDYiULcVBVM0Wi4KeXHEUKLDZCGoM6CLla0H9tKIjsJhDLbT5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rzKgZG1D; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716715224; x=1717320024; i=markus.elfring@web.de;
	bh=eqdB+c9AHV8Vh8prMy2Bz/FOpvhm7Ix0hdzFjT/E4pA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rzKgZG1D0ChG4qMoe33SPqZyjz069OXTeVGhbE2MxCFW9Nk09GHMZPS5sVRCS8le
	 Cf8ic6FX4P/8jxv0f837Z2MA8m+coZq7v6p6ZbYIZon6ytA8lvem2XA1+mcR7JhYq
	 7iUkfgy6lyEFWa5WKgZ5mcE8CmPcpkAqsnVb3VYcGQAjd0buzv98GgCxU6o+ASSE4
	 ihJWnhJ0VULjVVdIyHTihzeN00ExfN3YSN8BkWqu99Mz+cSgIvd343IhR/82NkkYT
	 wt2NvNvVU/2LMrgAE9A8KyowAKRBa5ifNL4pKJ6buh0rAWo5Q134FzpFzAIDCQsxS
	 1hHH7FjFC+u3+kopBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MF2ke-1sHhUu1Ivg-00FaCL; Sun, 26
 May 2024 11:20:24 +0200
Message-ID: <ce266282-029f-4333-9ef8-6ddce64e661f@web.de>
Date: Sun, 26 May 2024 11:20:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6] usb-storage: alauda: Check whether the media is initialized
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shichao Lai <shichaorai@gmail.com>, usb-storage@lists.one-eyed-alien.net,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
 Xingwei Lee <xrivendell7@gmail.com>, Yue Sun <samsun1006219@gmail.com>
References: <20240526012745.2852061-1-shichaorai@gmail.com>
 <79ba60d2-357a-45f0-93af-78879b9f4b02@web.de>
 <2024052647-battle-sacred-83b3@gregkh>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2024052647-battle-sacred-83b3@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ObuDBLfuLFa0QOeHXUf9Fax6lqFkPp/xqy7Q1g5mIFWgujlCWQ
 3W5fZGi+ueg86bIyQzYrFoASqXJ/+mGwpka1P+aLcyuKSbFuih6HM1qlG//JuwOa9HMBUQy
 7Na22fDWceunyjGf3NyqINM737mFZ3BR9BAwvOhxhedbDV3u3IwAEZumY1Khl1vS7SBjT0r
 bZZoxNBoQIwKsSDz2DTqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AyrklB7QiJI=;9L2S08+WTu0VCvDPknYXCxiKTnC
 /0lWKYZHZ8v1g0HnqKmUHAGexYL2Q0dVu5cXP9cS7atmm68B1PzzKoQeMhHo1Fe4pjCoCv5Sx
 osEJm23xY8bj6c5/TFqWd84v3pSTOtbEytopGu6LaNVtG4EANTrxsYt/+uov7S2Hk7WBifv/u
 8yJUotgU2dnUj04wtO4Ogai9yleDo0WrNvjTwIELRnFAzCI2AHtUdMK7V/j/Hv17rCNl+EsMd
 GjJKpmdB14bpAAXuNBB1++JVnRtp4sxFxBZamHSWmh1t6uMNjtYOXUSVlYOalu/gd08zJGC3W
 K6fuA0KjEj6ShJqlaRHsvg0p3omwGC6xuVnnpV9JnkoODAM0OhFakkc7pS0TYSalZkoFx11wV
 i+snJxFj1lmHZJcW7z7GWboTKUZSPyxCZAAJ47Ngu2VpWHLW8hxmPQ5f2c8U/rBZHLejkJqm3
 O0SiENecwD4iCrSF5ERB6NZi0Ahi7buI3m3H9gsRxLMBr0giPw3heKyFaghip2OKxpVi99JtA
 B8OO8AAj5u5JfFVOu50shT5o5Cj+WF/ZIU/t6/2gVvKyGPxejBw2/8ibFHswvo/VpJMDll4ZV
 DYksbIGGzE3SAPPMjOHGP1XBEdz5C1+O5lt3cuC+klEW5sNTIJfvPokyYKKE9lXnqAN793Pjz
 E+I3waAlBwWSpFgnLeHytze00I9FK7gbN0SxVB0PnTKCY6K9aUI/yqa4PiYEzd2VbrQWNSMZ5
 rYy0QOgP2ELLyE3sn6UakCtQhiq339kqZo55HvumHKFsbWyqPL4N7VsCIXvmUazL9xBv0cMq1
 XI4vDttu91XWBYaLid19z5IDwqFFweoFuCQG553KpznIo=

>> =E2=80=A6
>>> Fixes: e80b0fade09e ("[PATCH] USB Storage: add alauda support")
>>
>> How do you think about to omit the text =E2=80=9C[PATCH] =E2=80=9D from=
 the tag summary?
>
> Then it would be incorrect.

I find this view interesting.


> Again, Markus, please STOP sending review comments that are obviously wr=
ong.

The mentioned tag needs an =E2=80=9Cone line summary=E2=80=9D.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n145

Do you find it required to repeat a questionable commit subject completely=
?


> New developers do not know who to ignore and you are telling
> them things that are wrong and not helpful at all.

Additional development views can occasionally become helpful.


> Please stop reviewing patches,

Patch review is one of the usual software development activities.


> this is not ok

I suggest to reconsider such a view once more.


> is actually harmful to our community.

Possible improvements are varying between affected software components.

Regards,
Markus

