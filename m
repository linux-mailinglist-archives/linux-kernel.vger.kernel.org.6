Return-Path: <linux-kernel+bounces-172763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AEF8BF663
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B664B20C8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4062030B;
	Wed,  8 May 2024 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Cndb51xc"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A49171B6;
	Wed,  8 May 2024 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150333; cv=none; b=eNGOhQC9ZKjZqJ9flAfXumzfc/nmgtHt9fbsgRzQ+JfC3ONIQyeZJOaXQU5b3zQAwEHohsSVQAoPWzkNWLzasaPEDWp18azl8e7A5jwbmgM3fdSm9bMqUgJndeObqF3mE6Cto+QG6hOjSFyevYU2wWJX9KvRXx7rIbKrHDowVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150333; c=relaxed/simple;
	bh=A+PJVgDVE8sTEvBSrfqKil2ejz4LkNUS/yxQcNdS1gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnKeWaequ/IlXh68qqnTL3NF4ic6o8pI3VtwF7vsu6SVVIVx6nYnE2TxaBvXCzVKvqYc1jBO+nBEcUN+4DE/7DQgDrx83l9grX1IY2V2prEgBjtgJdigRGyKz7SgfsyKlXqHPndsX1rs9TpsKbvCCZmnXkXDqT1MqBrtzhkhrko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Cndb51xc; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715150301; x=1715755101; i=markus.elfring@web.de;
	bh=9nmIhydlWpp+VskLYPtmBE63mu4+9KImaXkDmeMoLtY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Cndb51xcVx2MFXruzuS2M3HvLbHNpQOx/diZ7ZjNUXumKHRvhYIoVvHrX4WsDnuw
	 7YXkZuhN3wDmQYrGv/48OptjHfW1+fadhlSFkMwil0hOVMH5ilmwYZ6CL6DLJql+o
	 f3oXU4esgCUxy4jYCKew+QcTrfLoCaBWligiOhTWAqhtaODXKm1f4PcZmsLl3Dvg8
	 ggZoBK4NQfulrKSdu0OctgW3iE2lO2t3UpjQp6GfP8d7KoG/rmgHJCMnJfNXgXloD
	 Gwo+UnKq+aGOe2rieFhWHzTJFVpj9usYocdy5sUT5e0ewXFnvuoC3RV+LU8IMn8Qn
	 Q8XwTnMh8ZFaM6BVsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtPre-1stw6l2zKI-016aBE; Wed, 08
 May 2024 08:38:21 +0200
Message-ID: <1617bc1b-5966-45d8-ae3d-25c6e11a032c@web.de>
Date: Wed, 8 May 2024 08:38:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] time/timgr: Fix wrong reference when level 0 group
 allocation failed
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Levi Yun <ppbuk5246@gmail.com>,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20240505085709.82688-1-ppbuk5246@gmail.com>
 <20240506041059.86877-1-ppbuk5246@gmail.com>
 <ZjisiuqiR9p76YcJ@localhost.localdomain> <87seys4yn1.fsf@somnus>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87seys4yn1.fsf@somnus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gdEVndsCrAEtnuIVmhtjmSp0KuU+wodZDrdmAlvkjLCoLE1SfmI
 VjLwjvx4FMJT2dmBZ0Mg6DUBVnEoGn8IwMxnPfPEnriyNxdPIZJhEIj/BXUKlgaKxxMOE70
 5lAYb9Kgax00hI2foDSZEsfmR1ZeVYpG4NdK305g+FBAjexLxqPnU/YD3y3cbwfhELt8AL5
 x5DKAyOl/kX+hzLNPGlxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PIJEPIvcphw=;T4OJJsqv1WrvnN7UKjTLeIJBMmh
 lWzJTWyx4nF3aByranlTxHu5JOAsFRJNVwYJWyroGgWBFhNarxMEJ60Z3dERKyOLIYqZkOqvB
 5wZ6C1bFIACna39/aN1VRLar6uC+G/JESIPA9MujqM6B1laDZnoDrhDJZmGKoWbx+sXfbuA3w
 HFZ/syjtcv71K12Uj6xdTSEvQIyXbhl7iI52OfdVQPLFdyhPcXZZRFNi9kj+RAGTQ6sS1zvBj
 RP56MlTepQhKrFDDwvkvFddikRde5xOO9gdqJBjOnyT5UxKLhk06yCFZ/h/qk48UKaHUZQ30O
 TWnctfKc1xKtytpK9Oc/jPXQVQNw1/xXE4cM2CMxKSOlTFRghtpyKZEcdj/GzHi29dR+A61xp
 0zRxyKfAQ26AqwFhxOSnH586qu1VA36BwOPz2B49RULj++PNAGJBR0M9NA9vlcKMPuP+tSdyz
 kClf4ogmddXdgqeQdoKVx2+yvsSM1w78w7GLr+kvXMLDQugslr9FAv6boCv9QmtmeRBePXAj5
 7bcy0nRkaO0h5ODJKR0MACYMcxWn9Y8dEnGvnm7UtrMisRgncnQ66WhdtaVuP6zypExRKtnf1
 AD2SpdEgwgmZTrw744xkwVPL6P1zcZZ9LQIZrMpE52UcruTP6BMHxVJOrZ3HPk2S8qpuw6OSH
 KDCPya08tugmjB5U10r4ABpr/TvEH+3lDWY9A4DXRL7RmQfXgwjXCtYE5h6pPQfam7FtlWZUR
 EIYUwe0pAp+dqqoesx9XMfhzzpl4kJH7IYXgRrifXXy6DLEWlKJcXz4DF3S15R8elzin6RkpG
 /9H9XZwx9s2p1dTlcSkyVl4lP/pqlukvD2WdVL2wx2ipE=

=E2=80=A6
>>> To prevent this, Check loop condition first before initializing timer =
hierarchy.
=E2=80=A6
>>> ---
>>> v3:
>>>     - Fix typo.
>>>
>>> v2:
>>> 	- Modify commit message.
>>>
>>>  kernel/time/timer_migration.c | 4 ++--
=E2=80=A6
> Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Do you find any remaining wording concerns less relevant fur such a change=
log?

Regards,
Markus

