Return-Path: <linux-kernel+bounces-546227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29694A4F7FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696AD3A9D86
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246DF1EDA34;
	Wed,  5 Mar 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pmL8bH7d"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BF13D8A3;
	Wed,  5 Mar 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160324; cv=none; b=X79c2Nbf41sIE3KV9N/jdXtasK4SyONiHVyXiA2u96r98CHJs/KJRkxka2gSBzBIiAhRKdS9MVq5P9s5oW9/poLdHZz8Injepw80B0FxmzMzdWOswYO1d0gd1p76Co+Q/gKFWSsur2znQZudXWXUH0dbmlhB+gmgshJHiV/p5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160324; c=relaxed/simple;
	bh=D5uGxiyDcm3Shg8mLoX3Q0SCviCq0xuD8oG42U/2OLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VX8ypO8Gh04zuYI5fCRVLJI/mSs0wb01sEfg/oK/6a27r1MmprFnl7GfKZYVo6EHmRqghdfFQNt2zWJbWymjBgk48wxEJqYCLz7yOGa0Egj6y3qD2qiPjuBiI1hxv0mswl/I430GKworUri4eecCY6mSUQ3FPLBMgkGsC9X6upk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pmL8bH7d; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741160319; x=1741765119; i=markus.elfring@web.de;
	bh=D5uGxiyDcm3Shg8mLoX3Q0SCviCq0xuD8oG42U/2OLM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pmL8bH7dtNwwP1NP6sfHcoAB9agjFS2De39RG3ASlY/U4QVNBqnQXdvnoQ+TpCov
	 sKpOHk2EHys1Cavdd5D1+9ma53P2ennYUA3+uqtul6VBSRk8h/1BTrrUN9B8iiQvi
	 6A/TeuMEm3GwDkaZY5f9QRdDwlMRu55EsM4S4swZ+eWFL0HsY45poswFOjvUz1SuV
	 L2oHX8takBJWK3T8NEJAOR8J1oQaUZlbiRbvqpiaiUXXtbh5Zd9izVvI5w/OdJPtI
	 32h1IkdVGGU+1GRtCe/Y7SsZ6FgrfEToNUnAXknAB1I+4JgPfxaU6nA91KjsYK15q
	 Y7qKN5Luxppbvmv+VQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKM5t-1tYJyS21Hz-00SRAI; Wed, 05
 Mar 2025 08:38:39 +0100
Message-ID: <ccdac63a-4a04-4243-9350-05acc23f413b@web.de>
Date: Wed, 5 Mar 2025 08:38:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] mei: Improve exception handling in mei_cl_irq_read_msg()
To: Alexander Usyskin <alexander.usyskin@intel.com>,
 kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
 <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
 <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
 <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9gAUY4g2oS0urtV3vRhhYlTmrsU7dOJ0SyTnwZT/zt+Q6w7MFNR
 j4Fwv0rgeJEjLx2mI5XVdbWuQCwMXtO5n/IhsKL2pMwUxTTTlOglrKQxXJToIWR9tO5IY+K
 1O7yhxiDff5ZkC+WlgzI8QpkAU7ygqRo+oL7F3RB4v+KjCkeYvlpTeMMC5YIj6Le+ZJM8YY
 OCWTTShMTmG1kJIVRwW+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9hvXnXV3tvM=;B84svodVSnaqDoVJgwE8XzBlAOI
 OI7hjM0XpHECNyo56fG4Hr5QV6msmNM81mW3fi7Ixxas7EIJTaRPTGp4zA/K0d/CcND5AqdIP
 gMkePNu2ZCPWNAz1sVSIkh28sf4yfzhLskGwBfkiPQu8W/WOS58/i2pVYI3aG86kac7UjdqWl
 JuvZNLuoLsz+bWBKESF9UfK5FKjcxFxQKb306YgdKMXSQXPypIh08B6OrhQkUxceqQ207Il0A
 bhPBW2dvD+Yfi1G94fWNK5rzb2EdHU9XfaBDYeiw6CSzBpfU+BWlflxvl0ropyxgIcNZ1QloD
 1vtuT4/GOVAandOmhQH9OGBcae40wsFRMWrr3UtYCPrHYENgOgKW+b/EyGLr4+ZSnTuU+JQ0v
 5BNKKmJUqNBW8lfTlnSocNeonwDdpEiymjZSVjjDm1+TYzCmLCMipRwyCd4JgZcpZ8mKqjF/P
 IoUgZ5C5aKR+SR6ydLqRCntaivTZdWwc8v6Jl1+WWkAqAPnAZtuO/bEz7GT9Fja8gkYYi4/8Q
 2Z7bPGe7qYQSpCtOZOz6kOAuZzigtvGMIYyePYsnAUW/caSo/3YnnF8EBXKQL8I/fhpKyo1nD
 tv2GOcaEjITXNIO49JzjG6VWKNJPObIbNhXTeb1c4xQ2M4bMhPoWa3PTLub15ne6tJ6Cz8Itl
 U09Z7ZImvlbprBaj2mLfnXEXFXusOrplgy065ExSfFY90rsfKPaQO2GZ26WDZZjp48dTPcXfA
 dVu3tCO6opiKou0Xog0Un6x+mcAH89eQ6lXsOsM9JvQ9/1Y4yNqwBHc+G+a+LaXe/xnTooSnF
 gljV+WbBaJ40kaNhMGmGuxnQRnyuJXVsTxiubeB33TAxyUI5QHoU5ex0TtFxyDWhtTliFZKnA
 ZHvdJI/se82qS1LUaHl1MH5Nrl9AtuqtezSsOIyJhtRglVUuE54nn91dtlpPRjPijeE8drAP0
 +2a8hDiuexPk8Cjp3tZOxnB6rKGDukkWlDDZi82Zto5RYBBrrSH0GcazMnjIElzl0Je4Ga3WH
 44/on5HAuOXzQ24LkA5Lhl4uVhD+fcVqGWF6b9mPOYo48/Q/cYWTz6eRZymIlBpJDzlCZjc7Z
 ygOuIj3/eJmp5R2RG1JdQwB7XW6y+CKVIUHmZnCaqgH0zE7JALnH2ZuQ93ueC10tHVawv+yxJ
 LDJvrYQHFNcgZraj9d5yclWt0WHDDpuz5jX9uw2rkBDbcBQfQtkMABj4zPgqa90rE79JXLoqt
 LmWoVXtCX/ZoQYlBWhV7JTLmkss53A+APC+44AEyyNzxYglg30Vl9icbitut60jU5EmWmNmnI
 ZeGlkQqFZ4+Jf2bjmsBMjS8Sjs2dSrdWvTEbbHLkkgT/RC90XcT6W2R4YXf3G2FXpBubJS9JL
 b/BMmOT1uWoVZK30HCtr33bB5MnwUQCijII2PLu0OaviYBpCsSbw61/Kmf0ts3/WabngG6Lr5
 v7zQhEQ==

>> The label =E2=80=9Cdiscard=E2=80=9D was used to jump to another pointer=
 check despite of
>> the detail in the implementation of the function =E2=80=9Cmei_cl_irq_re=
ad_msg=E2=80=9D
>> that it was determined already that a corresponding variable contained
>> a null pointer.
>>
>> * Thus use an additional label instead.
>>
>> * Delete a redundant check.
=E2=80=A6
>> +move_tail:
>
> In general, why not, but the label naming is bad.
> It hides the original intent to discard this message.
> Let's rename existing label to discard_nocb: and leave a new one as disc=
ard:.
> Also, the patch will be smaller in this way.

Do you expect a third patch version according to your naming preferences?

Regards,
Markus

