Return-Path: <linux-kernel+bounces-204018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5668FE2FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1480F286427
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E2F15278F;
	Thu,  6 Jun 2024 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ErXUHyxM"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF619D8B5;
	Thu,  6 Jun 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666495; cv=none; b=jrbU4rzlb3CyaAheAPOm1umMZSUSN7kFOTvQ7iFQ3/ZtSoYZ4vnGXV1XvccDoUG5L+ITb6xvW6YyEZowpQ0xj6QN90LuWLEPXt0cNUedVXYc8HjWz1Z19Dx2xl4YIoBO67sK7ehK7i0fyDJsT0iKlNQcotp6GHSpbey7XaXFLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666495; c=relaxed/simple;
	bh=O6QxW/6BMIUtD8lYbUc2Pu0nN4KzJrdPqakO9O5geSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qO82bkKWVHdyrM709N6cKY0Axmaq4NjIqdz7G5zo0dRh37YAudlpqzAYDY/Iq9JkeAP9ZG0CKbl/gNyv6siD52QiFknKATBJ8ABbTEbHv5UaxYxd+zM/MbBbk61SEbDHxys71NE6/zcjbr1HaV+DBTak/oKNDUQ++4ASiMjtHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ErXUHyxM; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=kmeK62SoIdnIVPwJAA1ZxGyQbY0oIueNKztx6sdjWRM=; t=1717666493;
	x=1718098493; b=ErXUHyxMmVjARkDr/9YwQ/s6qYvBhon3JXt6cr7AB6nnXZyvt1uJgQZphXfF6
	mNTNhvLniodCtNFkA+slnwcYBOfZ+oRR7YM9+fNQEqmsXMcjzz0w/kVT/LLlcCpFvclhxcUHeHsLN
	Uet5d4zgzfDZv6lNjyc+aA1lMEjQ3zbQtbiotrt5X984PDE/Vtg98LfnpNX0B7yN59zvRAqL4lcGk
	54pRgkmnDxrlKDcYLDQGzxxLSHJn2k3OG86rZs6kJGR9XjMbEyF3Nas3+IAxhr1catQUmWnmOa+1a
	imp4cGrDQGGeF8tlWnQUo/RtGxwcj5sgpUYvYHBgsjNpSYlAIw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sF9W3-0004z8-HD; Thu, 06 Jun 2024 11:34:39 +0200
Message-ID: <cee5e4ee-3d67-4eba-a790-c0c016cee937@leemhuis.info>
Date: Thu, 6 Jun 2024 11:34:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Paolo Abeni <pabeni@redhat.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 frank-w@public-files.de, Rob Herring <robh@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Frank Wunderlich <linux@fw-web.de>
References: <20240516204847.171029-1-linux@fw-web.de>
 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
 <43aacd9d-b851-4100-8ccc-878ac6ae10f8@leemhuis.info>
 <698cf562-1ca9-4aa3-be7e-a1474b612c5b@leemhuis.info>
 <0cba095c-3d55-416a-a7ad-b359129731cf@arinc9.com>
 <714da201-654b-4183-8e5e-8ff0b64fe621@leemhuis.info>
 <0ae387c1-31b2-4e87-aa7d-f98e3c90e985@arinc9.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <0ae387c1-31b2-4e87-aa7d-f98e3c90e985@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717666493;3a8ac617;
X-HE-SMSGID: 1sF9W3-0004z8-HD

On 06.06.24 11:01, Arınç ÜNAL wrote:
> On 06/06/2024 11.26, Thorsten Leemhuis wrote:
>> On 31.05.24 08:10, Arınç ÜNAL wrote:
>>> I had already submitted a patch series that would've prevented this
>>> issue back in 14 March 2024 [1]. I've asked numerous times for the patch
>>> series to be applied [2][3][4][5].
>>>> Eventually Daniel asked for some changes [6]. But I won't have time
>>>> to do
>>> that anytime soon and I think the patch series is good enough to be
>>> applied
>>> as is.
>>
>> Then I guess we need some other way to resolve this in mainline to unfix
> 
> I don't believe we need another way to resolve it. I've already told that
> the patch series is good enough to be applied as is and I don't see any
> responses with reasons against this here.
> 
>> Frank's device. The two obvious options are afaics:
>>
>> * revert the culprit (868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY
>> address of switch from device tree")) and reapply it in a later cycle
> 
> Sorry, no. There's nothing wrong with that patch. The actual cause of this
> issue is the patch that introduced this device tree source file with the
> wrong PHY address.

Was that also merged for 6.10? Because if not, then what matters here
afaics is what patch exposed the problem. Of course ideally we wound fix
that problem -- but if nobody takes care of that any time soon it might
come down to a revert of the patch that exposed the problem. At least
that how Linus handles these things afaics.

>> * apply Frank's patch (or an improved one) in this thread (and if needed
>> revert it when some better changes emerge.
>>
>> Arınç ÜNAL, could you please comment on that and ideally handle the
>> necessary tasks, as it's your patch that causes the regression.
> 
> I don't see any necessary tasks for me to handle. AngeloGioacchino Del
> Regno whom is the only person I know that maintains these device tree
> source files can simply apply the patch series that I have already
> submitted and we can all move on. I haven't heard from them whilst the
> patch had been waiting since March. So I'm not sure who's going to apply
> this patch, and to which tree.

AngeloGioacchino Del Regno, if you have a minute, could you please
comment if merging those changes for 6.10 is an option?

Ciao, Thorsten

