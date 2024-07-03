Return-Path: <linux-kernel+bounces-239063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9A59255A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69C0285E58
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E543D13B586;
	Wed,  3 Jul 2024 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jGqlSTsH"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B285624;
	Wed,  3 Jul 2024 08:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996238; cv=none; b=YgNDpt1Tu8QkK1dR3zKuhg0mtYA2Mk74Pemm9/fqszs/5ctvOaC0vMniMPKExbb++RP6bNTRjLxnhJOTvY///iTRziKGeTzusoYqfhb2FFIHad+BdGFgTuHQ0/RL89d6ODKPD+pg8VY9vFS2FASJbjRx/4Gq5vFjDb3nIDwv6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996238; c=relaxed/simple;
	bh=lptLyrtomP510MDSTWJ1xyCDrn5Oh0FzBQfkqNjbmS8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mh1VeXKSI8pWUTTpAzuLkanA9VyLaow5ElKXJIBfMAyNDArYqujZRz+VwBaoP/BM4k1+GOfkKDzMHP4KjaFaTONWH9E4iUhdB9FHaG2dXGHjGbnpqGpx1Egzly0NMSCPhG4WM4/ZEzL9EsBZ6jpJ+AMuRqIWCx3S1lljOv6hqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jGqlSTsH; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719996223; x=1720601023; i=markus.elfring@web.de;
	bh=lptLyrtomP510MDSTWJ1xyCDrn5Oh0FzBQfkqNjbmS8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jGqlSTsHwTwtnWX//MppUHEXvabftsGca6m/4IKclXqVfuhSgDjQOger9aJmZ0M8
	 lUGbbpxyYFKXRfRNzrioP8snBn1DgGcTJLW2BCfkszr1h5EDK66qoWGSCOykiQxzA
	 +T1UHNaKT83wbaCKwvDJy23zSzFtw+4X3OFC2pWYNiorAzo+3l7WhwHQ8aYIg0sL/
	 wD1PrtVxK5sEGncZMInsLlGXX+UB/bk5EFnMUHP+IormV43B8lh020tFgxKe7Qnka
	 so1L6/bMr0va3zDIIrGZC7pLRG2XecJT695coTNvv1htBKAQ9zUv9I64tBtW+PX3D
	 1ZCaCctyM5gfMADN9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOlwp-1smN5E14UJ-00VtyI; Wed, 03
 Jul 2024 10:43:43 +0200
Message-ID: <8c69a0dc-8178-44fc-86c1-da67109ddd39@web.de>
Date: Wed, 3 Jul 2024 10:43:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: libfdt: check return value of fdt_num_mem_rsv() in fdt_pack()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 devicetree@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, David Gibson <dgibson@redhat.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
References: <20240701215441.54353-1-heinrich.schuchardt@canonical.com>
 <8b083a48-5e56-493a-b235-60afaf794fd7@web.de>
 <530a2dcf-82ad-4e59-a162-5d3080766e6c@canonical.com>
Content-Language: en-GB
In-Reply-To: <530a2dcf-82ad-4e59-a162-5d3080766e6c@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:trxH/ooywfNEfiZjB42Chz5zq7Z08mVhiBmMoxtxWU8Xw6QjQho
 gRd5Ugnc5dqJzXq3W8cHAgcbrD7TJLnjm6usCNWxyJGyK+6kng69oaOvQqB7N/IFFJZsEqg
 t4AHvpB2XUP0Dn7Ag6oSZBZNB8DGO1FEKmAhap+lYq4aUqT2Gb1jws/uq0S8L2cOc7K9pK9
 oo9HrS+7L48flbb5rQAkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uK+DYHt/GOU=;S0s7pwr8tzqwOQ2zE+xMW4qaNMX
 WIy//oKgW6cIr3msWPKex8mNjDGuCLWpXJbOx0yUWtsDtrus92a95uj+GlEL7lYv9+Qgsc+Rm
 ReLERiFrYWQ1ApM4IdLESJLAZEmBz5h3ZsFd8wdScemjxprnNUb2YpcRP7xerzF6II8IVzYkZ
 L5X9oVX2MRJC1TC52m4zJqY5jsVrL5kr8ZwIQdRBwVjXqxG0Ndx9+vff3g13fctsh5avAnEYU
 r6ahEoEhMnO3YbHBPrzsVi900UT3FOBI7uVGV0lO+pRDfF8z1zWlt8GRDuDjGxhYul5YXK4l8
 4Pdt5oUOarrWrrIOFdo0MjjINksP7WIiWjLzVJDFj7RbY3d7b2bHDVaq2YHPAKfRjw3KCVhWB
 6CwnDpS3Y7F5RAavZVKQjvY1DxWFbLdvPnK9AyRBW4i+CoeVd+on0LdjoC8q2ugoDPVfja2NX
 WUPBFXKaup79/lg8kdsos4ALNy4HRj/nRghGdaPaekTsoWa//yKBXgBDsJWYNX9MD2AIgDMRR
 T7nHZc4UfyR7UpAKATj0sKzQ9qnLP3RhKxgYupWUJOJThxNi9tWF5K9yyVmlmEZBpVX6vkJvG
 9Y/7poDt8DUs56bM+vfCJVdbuvxPYJajW7klrxqFJf05ZjhFBb7CcP5SGtwa5d40CnVTkuUPa
 qZg25KPjTcs/YgilqG3v7/xot5uDj8pBZizR9w+E27cCmcGALNRu7tNjmhLXN3/VBqkFiLsPz
 kLrCX9JJyaz4X60GoyAlld5vJw9bLUe7sDlUHpdUM633UxGfDeCX8FQdGYwxzJ1JWm0bAay54
 uUI0lPLpaaJzeUYkP1j/VjHSwS/4YsX4UGhDB43DLrYN4=

>>> fdt_num_mem_rsv() may return -FDT_ERR_TRUNCATED.
>>> In this case fdt_pack() should propagate the error code.
>>
>> 1. Please choose imperative wordings for an improved change description=
.
>> =C2=A0=C2=A0=C2=A0https://git.kernel.org/pub/scm/linux/kernel/git/torva=
lds/linux.git/tree/Documentation/process/submitting-patches.rst?h=3Dv6.10-=
rc6#n94
>
> The current subject is an imperative?

Yes.

The requirement for =E2=80=9Cimperative mood=E2=80=9D affects mostly the c=
ommit message (or =E2=80=9Cchangelog=E2=80=9D),
doesn't it?


>> 2. Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=
=80=9CCc=E2=80=9D)?
>
> d5db5382c5e5 ("libfdt: Safer access to memory reservations") introduced =
the check that returns the error code. But before that we could simply ove=
rrun the buffer.

Would an other commit be a more appropriate reference?


> I would not know which patch to blame.

Please take another look at a corresponding information source:
https://github.com/dgibson/dtc/blame/main/libfdt/fdt_rw.c#L487-L500

Update candidate:
libfdt: Handle v16 and re-ordered trees for r/w
2007-11-01
https://github.com/dgibson/dtc/commit/a041dcdc48453f26b76bccdb5e2a1ebb3a0e=
a987#diff-1a98f2be127ff35ab7183bdae1e010189c9992b3bd6e6779fa7b7e451bf72ac4=
R382


> Whom do you want to Cc?

I suggest to take another look at corresponding information sources.

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv6.10-rc6#n34

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n458


>> 3. How do you think about to use a summary phrase like =E2=80=9CComplet=
e error handling
>> =C2=A0=C2=A0=C2=A0in fdt_pack()=E2=80=9D?
>
> Why should I choose a less specific subject?

You would like to improve the error detection and corresponding exception =
handling another bit,
wouldn't you?

* https://cwe.mitre.org/data/definitions/252.html

* https://wiki.sei.cmu.edu/confluence/display/c/EXP12-C.+Do+not+ignore+val=
ues+returned+by+functions


Regards,
Markus

