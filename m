Return-Path: <linux-kernel+bounces-388748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AAC9B63E6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2345AB21388
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC161FFE;
	Wed, 30 Oct 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b="UWfkbe4W"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126517579
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294284; cv=none; b=JAFl5hHDR6rODLDQ6q50rVOe44JIfoJfj7gg0B4KYDsFufjwIU1c5r/uirg2/h/eIynwjHmthHzpVYtZkQXD82XIkLOG4P2J+0vL+wZ1GewknldntA5yjOMHTKr3qddvlmCOJ6/MTEqR/vfebRPBM4bjB7ZKFEeKcrBXavFPXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294284; c=relaxed/simple;
	bh=YK62kQm5T1e9ZrNUJ2Vht0gCb21fSYs92yEM2f8PgYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMhJ52qaMzdIGbqJZiTPW5Ya5AC5d0Nw0Dzs+M6npATSHav+iyCURFFbLAQz9m7YtcqHZ8nUv4d110GWaTcbY4gs1mUlEBoVJ1A/oJ+c+sKHfPCK3tTwzyJN5CwW9hWEdQI94qMt78RLARQdjXc0R8rSnUyRLmVsQacDeFQfS1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b=UWfkbe4W; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730294230; x=1730899030; i=metux@gmx.de;
	bh=i1q1UwcqkUE6v3t+YZk+4PNlPEsgo07VoaZWRDi8hLE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UWfkbe4WN5+a5ottoMJ+cZXIvylLefxM8Lr0q+SATv7ZxP413lFyKwD857wx3GxC
	 bIo3wJWcuzn+TBrXVqkT5XAM6XkXWAog98EF50oN1rxerUNrYW6YFBEaycgAyiYHk
	 FoI1PQYjmXDC7d/iGHdqqEC5IewjAiG2eu5NUHdJlED4y1ynzhBbmLcyWdhJIboL0
	 2GDm6j6ZVdV23Z3qcWKJ1eLXltSgL4BAkJNKNA69oEvLlO/3OuIaI7hPz1h/WCzYo
	 1Xgwlg+8uZta6Rs3bz6bNbCwCqQfjThHPkWwKfy1RkqJ4rLi67qHJLTGl43+oH6ad
	 WiQU7u+JSQ69qTHzvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.178] ([95.114.207.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fn0-1tqVw52s4e-0156B7; Wed, 30
 Oct 2024 14:17:10 +0100
Message-ID: <70148bf0-389c-4942-a34f-7ceb5449aebb@gmx.de>
Date: Wed, 30 Oct 2024 14:17:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Politware vs Free Software [WAS [PATCH] Remove Huawei]
To: Theodore Ts'o <tytso@mit.edu>, quake <quake.wang@gmail.com>
Cc: linux-kernel@vger.kernel.org, phoronix@phoronix.com, redaktion@golem.de
References: <20241024032637.34286-1-quake.wang@gmail.com>
 <20241024164939.GL3204734@mit.edu>
Content-Language: tl
From: metux <metux@gmx.de>
In-Reply-To: <20241024164939.GL3204734@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lv3+tjKjlmje1+y0wT8cg67WAbrYkVALCR4XIKsc41yPiBGws23
 IXqSq1TaJy6STAWvNua6jyAEqC6ruN7Q0NryhIZAX32/pqHKg59zIaqobl2Mo2/TG6cfxrf
 VfGcJb0XC4ih4DAr7zmwz3qFH5qHodljHf6DjJyIl30hM6l97qbQWzbuyRmsmGWqotI11ZM
 3Ff/DqSt9WEQsf/rgECdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OW0ffz0BSJc=;kcDubCnnJcf796fs72Ucirv7Dc5
 Nv/HsKB49VPuZrrLNMW0pe+39Pwt2S8OciHMxIPQwAKfo5BCXXilD+FzlYmgT4YuPqgHcGL8Q
 Rp4zY5K9D3Nrvxa3INin7ZO4YZDfMP1v7uCsAn8qZBKZqcrxfVGSnE2+BQjF/Acsx+OEddsRG
 KsdzR/3fyYWNecIJsNd8tdhbSE0Rr3Z7hmmFYZ6C1aCR4Socx2MzB9vUOP7jlPXhw+aT0iBLQ
 9wpUXP2YoITa/BZLUkclcQ4oVtNC9vOKr1+GgSdzq684ahzqn5KFXydUj1EBSOvln+ecTPH/l
 xBmrGGZ40W2Vr7Qo9zwhGpNy0adMYB8GmqsdAgVJ5gPHu+sNLFfuKpL4YexY7EELf8NbXh5Cw
 aAt0g8HqPTzf7CwajdPVyGZaWLpZCQZaI02e9cwW+5JvYbqEeMXzSpi5WjEvcBT6SNcH8M6yd
 sXn71/iDi3LHWSAFNstPj0tfwI9C+4HjMea+eejRchOAMEubtrEfGB7NG7nR+T9GEXnE0x6vb
 GcUD6+Ka2hKwFKqvJg24CPzdGqkElDTbvYaGEpvf8qiaicW0pbKz/DLl59n/e+pgdaDAyUGp/
 52a/a0c28CXqXM9TLXtQdnwYWqsXFoxTUmtWEyhT1kUem+qDrByYj2qAx3Zra+6uYmeJMRTdO
 0AQLYwwnM1ZWeBzP9PSRpoyInoJrXK9tVmRtJ4RkDk2CnBoAwkr8TOwgZOpb+rIsjZHvMh61O
 vNL/e9se1netpPqoLCyCi7UhePG2GjBWn46J97W7YMJ8IsvgXN5wzI/sIA+n9inSxsDcD/45b
 6zkfs4lWcpbPL2VjKmnF6qqpqpH/ZEorVUYpd9CKrPAa0=

On 24.10.24 18:49, Theodore Ts'o wrote:

> These exemptions may not apply in different countries, and for

The *may* - so you aren't exactly sure ?

We're still waiting to the exact legislation that's prohibiting
Russians from taking part in international scientific discourse
or even just mentioning them in the CREDITS file (that part is
probably the worst).

And if so, how can Linux still call itself "free software" ?
Or shall we better call it politware ?

> different sanctioned entities.  I will note that China is not
> currently attacking Taiwan militarily at the moment, while Russian
> misiles and drones, some of which might be using embedded Linux
> controllers, *

*might* be using it.

Do you have any actual evidence ?

And if so, does banning those Russian maintainers has any practical
impact on the SW running on that drones ?

What's coming next ? Geoblocking on kernel.org ?

> are* actively attacking another country even as we speak.

Sure. Did we ban maintainers from US/NATO when they attacked
other countries ?

> Finally, please remember that kernel developers don't make the rules.

Unless we're seeing actual evidence of the corresponding legislation
and how exactly it forbids Russians being maintainers, we all have to
assume that the LF clique is making these rules.

OTOH, if we have that evidence, then at least every US citizen who
values free software and free speechs now knows whom to vote against
in a few days.

In chess that's called a fork:

a) the Linux leadership takes the guilt and is responsible for all of
this - and thus a danger for Linux community and FOSS as such

or

b) it's pointing fingers directly to the US govt., and so accepting that
we're dealing with a rogue govt. that's an existential thread to FOSS
as such and thus needs to be removed on election day.

choose your poison :P

> P.S.  This has always been the case, even before one country invaded
> another;

Linux didn't exist *before* that. The US is built on genocide and wars
of aggression.

Just one of many interesting examples: the attack on the spy ship
USS liberty - coordinated between US WH and Isreal - that was a set up
to blame Egypt and bring the US into war against Egypt - there even were
plans for using nuclear bombs (!!!). Other examples are several wars of
aggression against Iraq, Serbia, etc with using weapons of mass
destruction. (yes, by UN definition DU munition *is* a WoMD).

Let's be realistic: Russia isn't the only bad actor in the world.
And "the West" isn't the good guys.


Turning the once greatest FOSS project of known history into politware
doesn't help making peace and stop the dying. It just errects an iron
curtain and so making things even worse, for the whole world.


=2D-mtx

