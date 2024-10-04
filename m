Return-Path: <linux-kernel+bounces-349950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB9398FDC2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3010284079
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CCA13775E;
	Fri,  4 Oct 2024 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MdHuP54l"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874B69D2B;
	Fri,  4 Oct 2024 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728026656; cv=none; b=QBg0FwufFc3CenE/eDcTdjughRZbPXkl6SO7hsUilM9Qe5ziBI7P3Fm0jlhcwyasKGhD3dBngFRMuZFgD2mujZUZSLK2xM1mBf+hnRXdxEDPC8UPXyX44PKGijxrg5M96pEoPpihv2KxKJ0yGOWjKCPHdKGEGhNI+ZTuuVY43J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728026656; c=relaxed/simple;
	bh=I+g3k1LDrBFuIHfv//C/9Lzybu9R4yvEHlNDT3V4Kig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoiF3Cr5CRnwiAhRUT7b/rScrG5uI76c4FvorVWZBW19iQA5hA0Mu+fm52QLWcfERl9jUOgbCng4a+USTG7C03ZQiF4UtWFNKBheYUAfvdMrnTxHAyDabTEEdk9FotkJDG3N+vaedBIFkMSAir2EuRdehN/QRORIRfXxDP84MDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MdHuP54l; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728026634; x=1728631434; i=markus.elfring@web.de;
	bh=I+g3k1LDrBFuIHfv//C/9Lzybu9R4yvEHlNDT3V4Kig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MdHuP54lv3a+OhlbtVKyguI622KLMrLcXACTk3I5ImxNCgpn7C/+ClWWa4lXLCfm
	 DS+ixFnFvgC6VkWYDJNLfdnlcIHZQY7aLSe+1Zx7M2Mvk1x0D0yJSpzOfommg2fk5
	 Xv5fuaKn1nkndHVhrYw8Y5ZJGK4Y9ao6eOWmM3hptIZSgdfu94Mtu7NcKNAW2cgCD
	 f7DMm51IbkBYh8KhohJ9ge9O1U68qa31Ud8HQp1FHTASnMm6wbc6Qgcs5MjPZtEY+
	 LGwF1e0zhc8dNpoM/vMUDXR0iZe1rRviNZrqhdacNDX1vgh0fXnmZeTf6YUWpOsHT
	 kAGgnpxzHB6e2EueYg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBRn-1sHV9w3j41-00hh4H; Fri, 04
 Oct 2024 09:23:53 +0200
Message-ID: <6d4240ab-b432-4753-bb6e-de0697f8db69@web.de>
Date: Fri, 4 Oct 2024 09:23:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/2] powerpc/pseries: Do not pass an error pointer to
 of_node_put() in pSeries_reconfig_add_node()
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de> <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de> <87v8iz75ck.fsf@linux.ibm.com>
 <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de> <87pm9377qt.fsf@linux.ibm.com>
 <afb528f2-5960-d107-c3ba-42a3356ffc65@web.de>
 <d4bcde15-b4f1-0e98-9072-3153d1bd21bc@web.de>
 <8949eefb-30d3-3c51-4f03-4a3c6f1b15dc@web.de>
 <434320e1-2a30-4362-9212-ca17cdde8b31@web.de>
 <9dfb5d24-f05c-4a67-b86c-7f157f633fb9@csgroup.eu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9dfb5d24-f05c-4a67-b86c-7f157f633fb9@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cOf4DD9kuzKnBYdmw6NcXUSvbOP9sAzC9p5qTgB+bGyU7sJcs63
 QiMSjOujc9hiccxuIXqHaRZLnUJsdU6ykSuv5ytZ74uWVnAwPLBYyOJj343c2VT8S9Y0Boy
 XMoKO/CvstmKZrD+uYN54Gmjsaz8CDNnDLudkSsQM48q6FB0olfOotKL0kJ4ATs/IEkIw2o
 VX191Yqz9Pq2ESV7BohcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xq5kUmhz/C0=;EHOq5dN2pU7VW7prVUe4HmKd3Cq
 WLbiil794B2VtL6Mj2+aYkkps5TLz5oe9JuvauRVC7zo6qYK1hV9ewjbsWOG5b/71DpyvyEQZ
 mxBuM3EVRmETUQA0s5kbw0ZQDAiuc9UsFZDdeuhgBrXvvsqHEGd+bp4kfYFo9NUFbDSomgmxY
 iRrzj0NtmeK/RDAt5RTzbjluRTs9p07JbKDlZnNIDSxF3iOoWQBtf9pE5CA8plRhd/7hArg8T
 z1j/i7tAxmG7bphOpkGUNNBKdpN2L+7J20HqKyWViEA2gBmFE4CgfiLck9oXGiHKpTnzBNVd4
 T84cR/1xcTKFSre4h2XsGc7Ydlrff2HGkHP0BYF5FlkzBbpa66o1lz8RYL9gxeESqrydxu/zn
 l+UJOLSsh5p4CwV6SE4oaGKvDu1bBmqEiavyk9SFhyTmSdbQOLkOOMHCvLPLeA+Mz49SHVIHH
 WLSJwZiq/5yUTkWGRGGVF7XTqRY8E6jy5/w2kp9OEgml6qocLQrSfzQFddhvw0FRNZOFU2rA3
 kbUwf1B7V/+eUOWUz7Hi6gDtJ5NDSYWPCIuX8K+See+yELI6IgIXfsuZhI6i/W4VWkUejq9VO
 ZA3uB0yZcoY6lrKl7IbAk5XU/mCFgxoLp7HchSXaYP01Tpjsz0zoAYCLSrQr4IjNWLfVlnUfa
 SUk7aMQP80QMm9PsMe4WekAVGp7K/KhEbiprpwK1kUAdMJyq8igQZYtf+y1KVpHXCdKvCtjCw
 nvR7ys0XpEkE+BcJzhi3pe9+Hw24QUK3l+JMU90GNbPgOt/OjnUbDRrZcfrL3VJXktIIyTKIH
 5XUwx5vxocfmzbbHfssHf65g==

>> I was notified also about the following adjustment.
>>
>> =E2=80=A6
>> =C2=A0 * linuxppc-dev: [resent,v2,1/2] powerpc/pseries: Do not pass an =
error pointer to of_node_put() in pSeries_reconfig_add_node()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - https://eur01.safelinks.protection.out=
look.com/?url=3Dhttp%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Flinuxppc-dev=
%2Fpatch%2Ff5ac19db-c7d5-9a94-aa37-9bb448fe665f%40web.de%2F&data=3D05%7C02=
%7Cchristophe.leroy%40csgroup.eu%7Cab19d1c85de343f5474908dce3cd8c02%7C8b87=
af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638635719164841772%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C0%7C%7C%7C&sdata=3D8b7APXbglDf13PvZ4nVh5Z92bEft2RBqU3LfKsUETOI%3D&reser=
ved=3D0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - for: Linux PPC development
>> =C2=A0=C2=A0=C2=A0=C2=A0 was: New
>> =C2=A0=C2=A0=C2=A0=C2=A0 now: Changes Requested
>> =E2=80=A6
>>
>> It seems that I can not see so far why this status update happened
>> for any reasons.
>> Will further clarifications become helpful here?
>
> Sorry I forgot to send the email. It is the same kind of problem as the =
other series: Message IDs and/or In-Reply-To headers are messed up

Three mailing list archive interfaces can present a mostly consistent view=
 for
the involved message threads, can't they?


> and b4 ends up applying an unrelated patch instead of applying the serie=
s as you can see below:
>
> $ b4 shazam f5ac19db-c7d5-9a94-aa37-9bb448fe665f@web.de
=E2=80=A6

This development tool is also still evolving.
Are you looking for corresponding software extensions?
https://b4.docs.kernel.org/en/latest/#getting-help

How do you think about to start with the desired cover letter from the pro=
vided patch series
for another integration attempt?

Regards,
Markus

