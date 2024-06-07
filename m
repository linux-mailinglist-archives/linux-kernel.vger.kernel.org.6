Return-Path: <linux-kernel+bounces-206245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0697F900642
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CCC28405E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0084D1990B2;
	Fri,  7 Jun 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="LtLRxxw9"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC88C196C85;
	Fri,  7 Jun 2024 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769768; cv=none; b=H3jmudrzsr97j+TRO4CDI5NO3BUtkNYDhzBjRYFxSGTgMXjjqR2xD7qjckqhk0SorKoSaK1BpvW9zbXC6dznql2/WlxnTGj7RGKLQUGaUWRalL3IWqWZ+E4FPKIPInLs2RBerTVPuLGJkdYfndVl8XCLbS+EESvUTDvg/KqJy88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769768; c=relaxed/simple;
	bh=JBVRyBCOFG01AX+NTwNG9z2hwT8IJW/qVvyafu70yeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMd1fDb6XDd4jy8seAvRnO4MrATI7VdqPpaXZEotLC5E6cxFu0wqPrB3YVFs5GYCMD1U/VZ1OUpyheqsA4J1g9+3yBVcxtegrS6wIddiUV88khqJ7R5wU4wom7xaGrvmX4EwY1bjhC4DgOTRrBFfN/1+3iJ6FL4m0IsFCwgQRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=LtLRxxw9; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=QpfsdmbQFYvZxKAI8q31ouTwkcH7zth/8NJaR1BN+nU=; t=1717769765;
	x=1718201765; b=LtLRxxw9omrI+yJwCrKtud5d7hALofHpv3DAsTgx2klJcdB+KwQ7pwMquY7rK
	QgXWqCg2p55lWRkd3ugXw+WPi1hvUiYaboElwi4mGadlL5PiMqDg9Lmo473YdKwV8kZveWH2C5Gt3
	lnFjqMwljRd2wY/IJaFJ4CXmCXxhwDpebGUrMq3T+io/9oLmpjjXVSKHm7K5pJZN2Mzux5YJ0SJiP
	mYtnpoCKDJySeRrNLSTFvl2HdvHfoNNCqpRcKiBu/2MbRiB0pjXsmrkreux192UBD5T3OfJgIj0N7
	Yyg2lRR2Avc8LubwYYPOyLVKWSg8cz3hy/X+EY9UrpVP4+uWJA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sFaNq-00040R-Vo; Fri, 07 Jun 2024 16:15:59 +0200
Message-ID: <b49c801c-6628-40a6-8294-0876d8871ba7@leemhuis.info>
Date: Fri, 7 Jun 2024 16:15:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
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
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <2cac4cf68304e81abffbd9ff0387ee100323c2b7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717769765;d9bdf263;
X-HE-SMSGID: 1sFaNq-00040R-Vo

On 07.06.24 16:03, Paolo Abeni wrote:
> On Thu, 2024-06-06 at 10:26 +0200, Thorsten Leemhuis wrote:
>> On 31.05.24 08:10, Arınç ÜNAL wrote:
>>> On 31/05/2024 08.40, Thorsten Leemhuis wrote:
>>>> [adding Paolo, who committed the culprit]
>>
>> /me slowly wonders if the culprit should be reverted for now (see below)
>> and should be reapplied later together with the matching changes from
>> Arınç ÜNAL.
> 
> FWIS I think a revert should be avoided, given that a fix is available
> and nicely small.

Yeah, on one hand I agree; but on the other it seems that the
maintainers that would have to take care of the dt changes to fix this
until now remained silent in this thread, apart from Rob who sent the
mail regarding the warnings.

I put those maintainers in the To: field of this mail, maybe that might
lead to some reaction.

Ciao, Thorsten


