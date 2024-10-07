Return-Path: <linux-kernel+bounces-352898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A87CE9925D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B3F282A64
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA25175D20;
	Mon,  7 Oct 2024 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="N4saO+fg"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B91156225;
	Mon,  7 Oct 2024 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728285392; cv=none; b=XRwZBMoZbuCyB3CpMAOxR6jQRNnpWX6pmhR2sU0zBgxyRUNce8FhvICEoZ3FsnKr6b1NclCZxejfiMPYX3WM5pQiBnTyMAJTqGeTGcPy0qAIdPe84VYalzZQasOy5+SqcDKz7Xu2BIYVucI8U/8VbMoL+x/cmFYmRQ8R4I+ZeZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728285392; c=relaxed/simple;
	bh=leaIucq86EgwIm9BIalrReZrKllMQ/IZiyAA5rTyOok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hht/vf8jd15w/0lV9t9fQsIpFbylJP85I5os4enJRxFiDppLu4f0r59YW8vTu+nOO/9zxQhQ3rukq1N28sX3k9hUJauyXsVavJEGpRdWNk6ZWANyQepEUTzSPJBwhEl4igUOhNWeQHmSewnB8AwehY19NOY0AEMzXg2kqITNBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=N4saO+fg; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728285361; x=1728890161; i=markus.elfring@web.de;
	bh=LfrIY+pHO/ZX6h42WD8AmA8x940CYl5/uS/Of9wHfV0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N4saO+fgvYoaTltoDC2V5qHcHc3aI51HVxxMC5jsmaAWCaAnndTUM7ge7dVWVahf
	 y0Rf2zvP7kGCHnn5LV14Hh/G4hM08wjo7AJ/Nu17tObvWmlyuDnULVfzck8K+ukWI
	 NdPKRmjW71FJD0ywjUZN6bJLXbnUTPvqtmdxXtcOOvCq1XeTfjNCti4erWxReHKha
	 ID8gM30UmTIMCcRCgE9bQokITKGdkM+OdB4rgGyhJZBtQR1diY24fooY4T9jqasZO
	 c+2YjDlJwKmdOx6HptPWjLHbxhcqK1bweM8W09gm/K00MwXmKfB08ZIOk1HwsRmJW
	 IGK6M9RRbef/CydXrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRYd-1tEYAU0U3H-00J2BO; Mon, 07
 Oct 2024 09:16:01 +0200
Message-ID: <f5bfdc01-05b1-4015-8fbe-d84417b69138@web.de>
Date: Mon, 7 Oct 2024 09:15:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: powermac: Call of_node_put(bk_node) only once in
 pmac_has_backlight_type()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thomas Zimmermann <tzimmermann@suse.de>, LKML
 <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <b7e69e04-e15c-41ec-b62b-37253debc654@web.de>
 <d9bdc1b6-ea7e-47aa-80aa-02ae649abf72@csgroup.eu>
 <34233c4c-1f61-4bc6-aeca-9f5faba8509e@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <34233c4c-1f61-4bc6-aeca-9f5faba8509e@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Imoe7ZEwCJyTawNAyPA70ApwEVLa20g7u9LEzf/ELxArBp1NIGW
 k7rL310fUUIVzHcvZY1mDW7djNPCpStml1KdeoMvyRzcS2wFF4M8tuDAmwgpm8Z7O/0sQ5+
 lD582KkFDiLMG2CCbNbcOFOxCyQXO+ywtUg+5xm/NBw3eHKMKaOUrReKlYNSo3KDNTEIxcZ
 wAB07N1+HNQSk9uOtpGOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5AdduQQ23uY=;gRPrvDdYEt2bChq+CWEYWCgqc1K
 0WdHt/6k5kpY7vnwZuSCEf03Zs+rc6PpWzC1ENPMR+8wsHuSMQme/RkyjY391+qkbXtTFmB3k
 8KBTg9Mzmy46+OSyTJqI4fMM/jMghe/s8lIlCf5DGSFPm44bZ217s8g6x6aiCsIxanDiI663a
 OJu32/rBn6F9oicEpMrlbzt6f6eirjP/iqt+7w2dAo1h5ERGNxIOQj0M5YZAsEkiMEFkVHlRl
 JqJRK7qC1i3GOexvh/TWeAMeRFtdqfaOSA0ZmNtYAGkgH19talR+tKdY2qrqRRKkNIfCFcPg5
 KtrFmloBYyBKb3JFTtNe/zCxto6VgLI/KGtabTpCR+yosdF7Tvrvdc7ZRgZShB7O4uhFw7WMe
 zgN+4CB7RFYxLkiavBmPLmpuw2sjVqSwB/D54Au/HLIzx1Y2VZ0K5lU7MGhDGxwmvgV2trXtK
 ixSFKEcX4vUPAsqg/caW8WbOg0uPUKLDa3JyrcgHQvUfaiQYdAnIFKJ+cNVBZIROZR5fRCg86
 abgT/jc2iiGlaxKimlbnvLmY3F8aXMh379FgjJbMfUgZHn+klI7v7kXjAg034ZjXbweNZG+im
 VIzUvtW1mKKiEvNH7knu9idBAvOwqaCixq/ntxEmZg4pcAHfBIaCSHVXvO3v2U4Ika05zpQRe
 5rEd23d5HeEYT8aqNckhZxLoxWMFc11vRCMww9kn7tKDHqjmM5ZGBpd+jgJFjV7db9lDJqWJF
 IteBg900ZeC02iAfJS8Tz12fBjXGJfqMDXfb6rX7wIiB9rGJnF6Nau1fHVwV6p9x2IXkMsJWa
 OSJgpF8A6XejYWbabdImIakw==

> First of all, the change is wrong.  We can't dereference "prop" after ca=
lling
> of_node_put().
=E2=80=A6
> The of_get_property() function doesn't do a get as in get/put, it just f=
inds
> the property and returns it.  It doesn't bump the reference count.  It's=
 a
> confusing name in that way.  The The of_node_put() pairs with
> of_find_node_by_name().
Thanks for your information.

* Do you see opportunities for improving the software documentation accord=
ingly?

* How much can source code analysis tools influence development efforts?


Regards,
Markus

