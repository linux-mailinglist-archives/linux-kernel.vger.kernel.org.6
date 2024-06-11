Return-Path: <linux-kernel+bounces-209740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6E7903A19
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349161F21701
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B2617B43F;
	Tue, 11 Jun 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="mM7YpBD1"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675C17545;
	Tue, 11 Jun 2024 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105440; cv=none; b=MRbGXyWnTXfjJQ4ifsuNX3MKcdnwYblxiZK2wb0rzgR2OX+rUUy9fvI7sYYt88AKfdrB4g7x/vzz8PzdrhsXJWCkBrYRiWVfvk4HvpyVzGksN0D46R+j+QN21rs1Vc5fZrM6WFbXuzkvSRPagDPBEVf3kSXpvXp0pW86LwA2/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105440; c=relaxed/simple;
	bh=aE9Gg2Ds1cNqbknEdagliEq9UJsv9bvc1ITWc773ZVM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qe2xJUCRc7mA+EjqfEwg/zYI92gnLa5BjFfHYNJboCc7D0BEG/AzcLOhPn0qbFfvHLuNd/MDI0CEUBkW9s1cPtLsTpcPiGUGd1yzaQHJcgMpiprTqGC2R1cOQ2VkrhXIQKO3heJ6hyqGYeHgiMVqoIl1GQgKQEOxRx8tBrFDgpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=mM7YpBD1; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=GvDhOl1G2Z707RGHPlxQe1Kar9gOS7R/lxC7nBW4SMc=; t=1718105438;
	x=1718537438; b=mM7YpBD1dKP76BADGPSC+P50w0D/5CrrIG6GRH1P4X9WDiRamQjKHv5s7hshk
	7vQVxt8Lef/CfZDXsh/txO7ewo8FfcZaAh1lQd5YsJLvdeQeCWx6pxl7K7yCq3hXEIcOzjwdfz6IC
	qcaOMvM7ipeKbxk27vCnPIpnhI8OWRM/u6+bfTLmOLQLd8gckvDOlknL5m0Sk+3fK3RXXzH5h51PG
	zjP+lZ5+Do1NlADNQ+fCkgnYMmtFCFnHno/GRYoKxf0WU8p82wqUmQrFwDibnqNFFxFnu9P53wESN
	RHuzcJMKXvsxHYlAmlTD4XQdyKRFULheS7ZGnrjYNlWvH2sDeg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sGzhu-0002Et-5s; Tue, 11 Jun 2024 13:30:30 +0200
Message-ID: <e92c3ca0-c9be-44ac-a4fc-57ca5ebedbc5@leemhuis.info>
Date: Tue, 11 Jun 2024 13:30:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, frank-w@public-files.de,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Frank Wunderlich <linux@fw-web.de>, Paolo Abeni <pabeni@redhat.com>
References: <20240516204847.171029-1-linux@fw-web.de>
 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
 <43aacd9d-b851-4100-8ccc-878ac6ae10f8@leemhuis.info>
 <698cf562-1ca9-4aa3-be7e-a1474b612c5b@leemhuis.info>
 <0cba095c-3d55-416a-a7ad-b359129731cf@arinc9.com>
 <714da201-654b-4183-8e5e-8ff0b64fe621@leemhuis.info>
 <2cac4cf68304e81abffbd9ff0387ee100323c2b7.camel@redhat.com>
 <b49c801c-6628-40a6-8294-0876d8871ba7@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <b49c801c-6628-40a6-8294-0876d8871ba7@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718105438;d59cc20a;
X-HE-SMSGID: 1sGzhu-0002Et-5s

On 07.06.24 16:15, Thorsten Leemhuis wrote:
> On 07.06.24 16:03, Paolo Abeni wrote:
>> On Thu, 2024-06-06 at 10:26 +0200, Thorsten Leemhuis wrote:
>>> On 31.05.24 08:10, Arınç ÜNAL wrote:
>>>> On 31/05/2024 08.40, Thorsten Leemhuis wrote:
>>>>> [adding Paolo, who committed the culprit]
>>>
>>> /me slowly wonders if the culprit should be reverted for now (see below)
>>> and should be reapplied later together with the matching changes from
>>> Arınç ÜNAL.
>>
>> FWIS I think a revert should be avoided, given that a fix is available
>> and nicely small.
> 
> Yeah, on one hand I agree; but on the other it seems that the
> maintainers that would have to take care of the dt changes to fix this
> until now remained silent in this thread, apart from Rob who sent the
> mail regarding the warnings.
> 
> I put those maintainers in the To: field of this mail, maybe that might
> lead to some reaction.

Still no reply from the DRS folks or any other progress I noticed. Guess
that means I will soon have no other choice than to get Linus involved,
as this looks stuck. :-( #sigh

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

