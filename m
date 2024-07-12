Return-Path: <linux-kernel+bounces-250865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B447092FDC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E441C23719
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096571741ED;
	Fri, 12 Jul 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="iAdKmpEc"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84B173320;
	Fri, 12 Jul 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798958; cv=none; b=o/QnycHz2xkpQDEJn5Bv0XGiajejTCK2UxVYPsMQJvWxmKxD2p45gPK3AqqC9WGkwDKjydVywc7rlcHiG+3tSzsw+PuNcPnU0VPdERVP7ZwCOlmvejY9SMrTLMRDckkvVxyZYQ484bCnM5khdCPw/7t8CKrP2hPfSeW1LVDUYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798958; c=relaxed/simple;
	bh=sCwtaGelw5QnbOoK2nqEirjtxWGCgtQcAhVSm5WLvkg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FM/4p1JR5C3hMA01PQKM4XpYm7PSKeHPtqD+9nWiaseIfHxxpGvMK0a7LFPd6ZlGh+l8qxjMD6L6Z69tw1lv9btC7Xom7Yos9vHhlImpOCL75QUjm7NWfrionxEGCytTJRUy4O1bGL45zXRUJK3OGITmTYNlQfZ3RPAeXaTR/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=iAdKmpEc; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720798935; x=1721403735; i=markus.elfring@web.de;
	bh=sCwtaGelw5QnbOoK2nqEirjtxWGCgtQcAhVSm5WLvkg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iAdKmpEcsBzHHweil1K6FoKWsge0JHR5RIlsP6POhLuMUkozFWvVm99PiahtO4Bz
	 1jCsj7GNYiG+wXaH+cqYQvdlMQ4cYYdIHKNiyUNvr4QTa4vLUrKllMfY4b1GVMfZf
	 baok31vkd/rJXLQta0mGYudx08WSwBShE4s2a6aHF6oifa0HXpTWbj6KbAM10A2GB
	 UQ5W8GyVWLdHhv9JtdC2AUKCSHpCx+MvXf69zaYUAesxUTqoMk5EnrGvKFmjXhBlE
	 7l+kxiJxwsegFjddTonmgELItYjw4cLeTReSs5MdZPdVBNFgvHB4emjxWg6rK5uw4
	 HkAx5i2vsynsBAxmlQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4vNQ-1sKh7r0nwK-00zto7; Fri, 12
 Jul 2024 17:42:15 +0200
Message-ID: <19bb8ed0-e783-49aa-a4cd-6a0c3b89f0a8@web.de>
Date: Fri, 12 Jul 2024 17:42:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <b5c51026-a2de-434b-8f45-44a641ab1c82@stanley.mountain>
Subject: Re: [PATCH] eeprom: ee1004: Unlock on error path in probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b5c51026-a2de-434b-8f45-44a641ab1c82@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cKQLHTMHFOnn2opdW3wDhxufV77k1h426VF/dXXnCRFYb/yBv4g
 dA0FyUwvl7kahh1Rupwvd4iNpmV7N7MRboVDgx40Q2UwTbGk45gHHoIXzO+Tj12K2iFeyIP
 UpD6jr4MuCtEUBOfHGQO8thWmzp9b/u9nDl38D6Yn5/R6oh5dE5fx3Tkxvc2UVw5bdhrOj7
 BTyHBbZWk2zifxB6kc3wQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ChkuGOv3/mc=;55XdRv9PPjPcDrJvl9y6/jhvIh3
 cI11oAJz9ohm796zutBTqif7XhksaPufk5njSo/V7A6UpcJFtOI9xqYMdzpnki/wGwW3erH7u
 6E7Xpd1Uk/nwa0Kip28HUo8QVlatYPphmukxk/u9YSiBdJ6CiD6QTn1eCpeHjZmAXEVB6Cxhw
 zgvuCmMO4N/lJmshp41QjqdNjad3kGOo5kIT3yixKK2CFXwK3WK3Mpnpw2OCzUkEWYhAxP81/
 dQ+8jAKej+LLj1NVPjs9l5Y50H4J18oFtqMbqOrTaki6r0YZW+yeYe92yYYkFWhOsg+nlS176
 IumH3K0cUeyI8U3kCgcdV893hHgv46RL+E7HqGE14mB8HmATGzVOZ46CcEjw6YgNxjRb/PCUy
 RJtI+lCgfIcT5AVABmhLvTTBxCUqfLiB7XR+JqvmHdToH3hWz30fBid4QobvXvCx4T8AgYKa+
 rT8PjL4VB3eBTz6mWH5E5ukBEyNU4i5Y9sO/y2klBY4h56707QQju6q2d/oNHPxII5KRm3vZR
 2mU3jFuuqCV9jZE6sLMeUG6ZJi4MoOWesYO+sKxA2hXv5UzqbUADEvTjXomiA/Ru5PoqMSTNn
 anFCft75N5iJ367hsh+LjI2McApSJiqcbPoz5xHWtUlK4zbiI+CglCvK82ZvsgchN/SREx4Tc
 DRgNd26pZWHZfsvRnJ2EHWBFUbFoQA9L0lkyVDRjf6zutHUhftUSGhZqFsPBDF/Q278Y1oa0e
 4HuPz4T+I+1EckcpGe5nSV7rLSog2KhYXAv0BfXE9LiOayY7iJpCKQA6imfU4WVJRS8EACWDb
 x1c/JKVjKDoWsF7xVcDixzSg==

> Call mutex_unlock() before returning an error in ee1004_probe()

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&ee1004_bus_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/mutex.h#L1=
96


Would you like to refer to the function name =E2=80=9Cee1004_probe=E2=80=
=9D in the summary phrase?

Regards,
Markus

