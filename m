Return-Path: <linux-kernel+bounces-428777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B0F9E134F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C862B21F76
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C5186287;
	Tue,  3 Dec 2024 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="zOBcy1TA"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415670825;
	Tue,  3 Dec 2024 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733207150; cv=none; b=BNipzyJHS9Amw8MQphxbZV9X1dYq+dt5fHNfm+hHV+m3vlYlBJn9ZpZ9e+dcSDgXqlMytrJJiLdtLWgzcMt2SiLwZ4h8RNxD56WPNN3wx9+yXj5qL0ttA1F1teTkS+UGiCvG3hx4IjRU7TygN5O4WeVEJkAM0fp57lCkwuEslB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733207150; c=relaxed/simple;
	bh=2tS5uRgfviO0alrDY5oGTgvmEtChwVf3x3Zow9XJt2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phzrH00/moS7P5Ve7Gu8ZgJdkOOhqNeVym9419aRg7nQWB4kRFX7FllelBebMdkPnYxWITN2cViAdEnAbmn+NyubMjJPSDmBawnkTrkYv+AtiZOHCSNbpY/kEiuJa3Kq47h6MyvE9y6kcqtqY7DJLLduScXrb6ic5f7hSmX+vX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=zOBcy1TA; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=6BHMcxNwSOwsG/WMNmwatoWqGupqKJxNbDoKo7/QVjg=; t=1733207148;
	x=1733639148; b=zOBcy1TAK/MVNz2u4E3DDi/nZpGtKQshwRMhSTDIV7lu/VhHFQZEdY6MA4pZ7
	3p4Mf8u242R14/jt37NWdXxViXt6NoXFv9Zkdx5uO+XJvsifEzts4Baox2/giI98IubnZ4K1g1twL
	T8SfQp+jojkQ9On2gylaAmTMOAvklH/JEYrgcyuDc87tnDvcw96g3VqnNVkIim8SF49QQdAptIYim
	3XLIGk30z6N1bvrzBw7nDulqQgsActy9rlJDfOpDUai5ZgZjZ4CRnfMsnS62UkeV0y6V+/ol3C4uz
	X+tBVnQh/Ful4K7zyaBnk2NYiKnDMNqLxvaQ1+tGmknxqa3/Yg==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1tIMLv-005qxb-2x;
	Tue, 03 Dec 2024 07:25:44 +0100
Message-ID: <bd47620e-d2bd-48f5-8e40-555d6ddf921e@leemhuis.info>
Date: Tue, 3 Dec 2024 07:25:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 DONOTMERGE] docs: clarify rules wrt tagging other
 people
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <c29ef5fa12e37c3a289e46d4442b069af94e5b05.1733127212.git.linux@leemhuis.info>
 <20241202092857.7d197995@foz.lan> <20241202110210.5e56d69e@foz.lan>
 <d8cae2d3-d855-404b-8991-f81c979486ce@leemhuis.info>
 <20241202154528.7949e7cb@foz.lan>
 <6f1bbdf3-22df-415c-b017-de1cf81af57e@leemhuis.info>
 <20241202171734.2874a9a3@foz.lan>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-MW
Autocrypt: addr=linux@leemhuis.info; keydata=
 xsFNBFJ4AQ0BEADCz16x4kl/YGBegAsYXJMjFRi3QOr2YMmcNuu1fdsi3XnM+xMRaukWby47
 JcsZYLDKRHTQ/Lalw9L1HI3NRwK+9ayjg31wFdekgsuPbu4x5RGDIfyNpd378Upa8SUmvHik
 apCnzsxPTEE4Z2KUxBIwTvg+snEjgZ03EIQEi5cKmnlaUynNqv3xaGstx5jMCEnR2X54rH8j
 QPvo2l5/79Po58f6DhxV2RrOrOjQIQcPZ6kUqwLi6EQOi92NS9Uy6jbZcrMqPIRqJZ/tTKIR
 OLWsEjNrc3PMcve+NmORiEgLFclN8kHbPl1tLo4M5jN9xmsa0OZv3M0katqW8kC1hzR7mhz+
 Rv4MgnbkPDDO086HjQBlS6Zzo49fQB2JErs5nZ0mwkqlETu6emhxneAMcc67+ZtTeUj54K2y
 Iu8kk6ghaUAfgMqkdIzeSfhO8eURMhvwzSpsqhUs7pIj4u0TPN8OFAvxE/3adoUwMaB+/plk
 sNe9RsHHPV+7LGADZ6OzOWWftk34QLTVTcz02bGyxLNIkhY+vIJpZWX9UrfGdHSiyYThHCIy
 /dLz95b9EG+1tbCIyNynr9TjIOmtLOk7ssB3kL3XQGgmdQ+rJ3zckJUQapLKP2YfBi+8P1iP
 rKkYtbWk0u/FmCbxcBA31KqXQZoR4cd1PJ1PDCe7/DxeoYMVuwARAQABzSdUaG9yc3RlbiBM
 ZWVtaHVpcyA8bGludXhAbGVlbWh1aXMuaW5mbz7CwZQEEwEKAD4CGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AWIQSoq8a+lZZX4oPULXVytubvTFg9LQUCX31PIwUJFmtPkwAKCRBytubv
 TFg9LWsyD/4t3g4i2YVp8RoKAcOut0AZ7/uLSqlm8Jcbb+LeeuzjY9T3mQ4ZX8cybc1jRlsL
 JMYL8GD3a53/+bXCDdk2HhQKUwBJ9PUDbfWa2E/pnqeJeX6naLn1LtMJ78G9gPeG81dX5Yq+
 g/2bLXyWefpejlaefaM0GviCt00kG4R/mJJpHPKIPxPbOPY2REzWPoHXJpi7vTOA2R8HrFg/
 QJbnA25W55DzoxlRb/nGZYG4iQ+2Eplkweq3s3tN88MxzNpsxZp475RmzgcmQpUtKND7Pw+8
 zTDPmEzkHcUChMEmrhgWc2OCuAu3/ezsw7RnWV0k9Pl5AGROaDqvARUtopQ3yEDAdV6eil2z
 TvbrokZQca2808v2rYO3TtvtRMtmW/M/yyR233G/JSNos4lODkCwd16GKjERYj+sJsW4/hoZ
 RQiJQBxjnYr+p26JEvghLE1BMnTK24i88Oo8v+AngR6JBxwH7wFuEIIuLCB9Aagb+TKsf+0c
 HbQaHZj+wSY5FwgKi6psJxvMxpRpLqPsgl+awFPHARktdPtMzSa+kWMhXC4rJahBC5eEjNmP
 i23DaFWm8BE9LNjdG8Yl5hl7Zx0mwtnQas7+z6XymGuhNXCOevXVEqm1E42fptYMNiANmrpA
 OKRF+BHOreakveezlpOz8OtUhsew9b/BsAHXBCEEOuuUg87BTQRSeAENARAAzu/3satWzly6
 +Lqi5dTFS9+hKvFMtdRb/vW4o9CQsMqL2BJGoE4uXvy3cancvcyodzTXCUxbesNP779JqeHy
 s7WkF2mtLVX2lnyXSUBm/ONwasuK7KLz8qusseUssvjJPDdw8mRLAWvjcsYsZ0qgIU6kBbvY
 ckUWkbJj/0kuQCmmulRMcaQRrRYrk7ZdUOjaYmjKR+UJHljxLgeregyiXulRJxCphP5migoy
 ioa1eset8iF9fhb+YWY16X1I3TnucVCiXixzxwn3uwiVGg28n+vdfZ5lackCOj6iK4+lfzld
 z4NfIXK+8/R1wD9yOj1rr3OsjDqOaugoMxgEFOiwhQDiJlRKVaDbfmC1G5N1YfQIn90znEYc
 M7+Sp8Rc5RUgN5yfuwyicifIJQCtiWgjF8ttcIEuKg0TmGb6HQHAtGaBXKyXGQulD1CmBHIW
 zg7bGge5R66hdbq1BiMX5Qdk/o3Sr2OLCrxWhqMdreJFLzboEc0S13BCxVglnPqdv5sd7veb
 0az5LGS6zyVTdTbuPUu4C1ZbstPbuCBwSwe3ERpvpmdIzHtIK4G9iGIR3Seo0oWOzQvkFn8m
 2k6H2/Delz9IcHEefSe5u0GjIA18bZEt7R2k8CMZ84vpyWOchgwXK2DNXAOzq4zwV8W4TiYi
 FiIVXfSj185vCpuE7j0ugp0AEQEAAcLBfAQYAQoAJgIbDBYhBKirxr6Vllfig9QtdXK25u9M
 WD0tBQJffU8wBQkWa0+jAAoJEHK25u9MWD0tv+0P/A47x8r+hekpuF2KvPpGi3M6rFpdPfeO
 RpIGkjQWk5M+oF0YH3vtb0+92J7LKfJwv7GIy2PZO2svVnIeCOvXzEM/7G1n5zmNMYGZkSyf
 x9dnNCjNl10CmuTYud7zsd3cXDku0T+Ow5Dhnk6l4bbJSYzFEbz3B8zMZGrs9EhqNzTLTZ8S
 Mznmtkxcbb3f/o5SW9NhH60mQ23bB3bBbX1wUQAmMjaDQ/Nt5oHWHN0/6wLyF4lStBGCKN9a
 TLp6E3100BuTCUCrQf9F3kB7BC92VHvobqYmvLTCTcbxFS4JNuT+ZyV+xR5JiV+2g2HwhxWW
 uC88BtriqL4atyvtuybQT+56IiiU2gszQ+oxR/1Aq+VZHdUeC6lijFiQblqV6EjenJu+pR9A
 7EElGPPmYdO1WQbBrmuOrFuO6wQrbo0TbUiaxYWyoM9cA7v7eFyaxgwXBSWKbo/bcAAViqLW
 ysaCIZqWxrlhHWWmJMvowVMkB92uPVkxs5IMhSxHS4c2PfZ6D5kvrs3URvIc6zyOrgIaHNzR
 8AF4PXWPAuZu1oaG/XKwzMqN/Y/AoxWrCFZNHE27E1RrMhDgmyzIzWQTffJsVPDMQqDfLBhV
 ic3b8Yec+Kn+ExIF5IuLfHkUgIUs83kDGGbV+wM8NtlGmCXmatyavUwNCXMsuI24HPl7gV2h n7RI
In-Reply-To: <20241202171734.2874a9a3@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1733207148;19eb6933;
X-HE-SMSGID: 1tIMLv-005qxb-2x

On 02.12.24 17:17, Mauro Carvalho Chehab wrote:
> Em Mon, 2 Dec 2024 16:54:49 +0100
> Thorsten Leemhuis <linux@leemhuis.info> escreveu:
>> On 02.12.24 15:45, Mauro Carvalho Chehab wrote:
>>> Em Mon, 2 Dec 2024 14:54:56 +0100
>>> Thorsten Leemhuis <linux@leemhuis.info> escreveu:
>>>> On 02.12.24 11:02, Mauro Carvalho Chehab wrote:  
>>>>> Em Mon, 2 Dec 2024 09:28:57 +0100
>>>>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
>>>>>>> +Tagging people requires permission
>>>>>>> +----------------------------------
>>>>>>> +
>>>>>>> +Be careful in the addition of tags to your patches, as all except for Cc:,
>>>>>>> +Reported-by:, and Suggested-by: need explicit permission of the person named.
>>>>>
>>>>> Hmm... There is another tag that we use without requiring explicit permissions:
>>>>>
>>>>> 	Requested-by:
>>>>>
>>>>> There are currently 376 occurrences on 6.13-rc1.
>>>>>
>>>>> This is used when a maintainer or reviewer publicly requests some changes to
>>>>> be added on a patch series.    
>>> [...]
>>> You're basically requesting explicit permission for any "non-official"
>>> tags as well, including reviewed-by. This is not what it is wanted here.  
>>
>> I could easily use a slightly modified phrase like "...as all
>> mentioned above except...".
> 
> It seems a lot better to me.

I went with this a slightly different variant for readability:

Be careful in the addition of the aforementioned tags to your patches,
as all except for Cc:, Reported-by:, and Suggested-by: need explicit
permission of the person named.

Hope that's okay. If I don't hear anything, I'll assume your earlier
Reviewed-by: is still valid.

Ciao, Thorsten

