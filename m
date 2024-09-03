Return-Path: <linux-kernel+bounces-312653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F39E96995B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919C71C2377D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A23A1A0BE1;
	Tue,  3 Sep 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jc8bRgxV"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67B1A0BC7;
	Tue,  3 Sep 2024 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356451; cv=none; b=CHiEeAAzHEOBTwvno+s3No/Fg/Pp/+5ra/1yqvvTTGO+PmDyc/v7AdOURsfFg/N2K9LVgjxnbCZjBnhGuaCWsZSGMMSmFxq8IzvCbrm1pf5EtedktkAXho9q9joYgYwx9ks+yIzEYsu7NidWCEW8R9QpdjGiY12E02GYpTIdghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356451; c=relaxed/simple;
	bh=lLzr8Ar95hMU50yITbpvwxHOKCESpfKPFuNUnNE06bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MB+EkMR1EcnacTlZx4F/T0kxIT/wtapWOpp6YAPen+VS89ZtBEPaaLTWr1k/D+4aZ1S+MpY/KAoWWoNIvoNB8gRpMnLkdOgXWTVrohrKHzsBSOxVCcqChmPHqzw8QilT2YVOnfepbgaBTDtcgRHTZyZx3Qdj9FU1T89+tLG86WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jc8bRgxV; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725356414; x=1725961214; i=markus.elfring@web.de;
	bh=lbfwtFUUUQEa7RKRIipVXPdfzZzi/w41he9XMp87RSQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jc8bRgxVnO+hRbFNONQ+Gle2zPRAJaZ9E8VnhO7onTUGt4tLtGsfJyTFIAosRW9K
	 fsTdyGxPyCr8GvNSc9l0D03NNbyswvNWS2NZW4g/PVwXI4nM8Gx5pfXJLwZHibSoS
	 9GbKGFbqeb+VP0J4mFArOgRQ0HZQpwYJlagx94JHFxJ1aCIkP12hba3fAiekMQ1S9
	 QTWUf5OvehfchQp1UXq6wcifvKvxHNVY0nNw8mNmg0QcWpmYNHiGgaaIjpGjWHpIy
	 h5APyOfrrDiUFSdUEfFL1hHj4WLRfRyLGK91hB+pQUvKrCPbHO6xseEtFkrpqcgd6
	 fEmrqbYVhSdS0TuFkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOlwj-1sQ9hZ2WGF-00TKth; Tue, 03
 Sep 2024 11:40:14 +0200
Message-ID: <95f07e5b-72c4-442c-b58e-25c407389243@web.de>
Date: Tue, 3 Sep 2024 11:40:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] drm/imagination: Use memdup_user() helper
To: Matt Coster <Matt.Coster@imgtec.com>, dri-devel@lists.freedesktop.org
Cc: Donald Robson <donald.robson@imgtec.com>,
 Frank Binns <Frank.Binns@imgtec.com>, Sarah Walker
 <sarah.walker@imgtec.com>, Christophe Jaillet
 <christophe.jaillet@wanadoo.fr>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <ea4ec650-d858-42c2-ab59-e17824069ba9@imgtec.com>
 <8d30da7f-7a12-4052-b846-66fad0ccb392@web.de>
 <cc1a5b72-2349-4b7b-b233-1a1b90556d71@imgtec.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cc1a5b72-2349-4b7b-b233-1a1b90556d71@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kYjjDNcb9SSj1h4+Mz2o8aEKK3JGWzSQezmAzIKDl/cfDfCGTxz
 LAFz8WsXStLaZvw/ztZym00sDpprLKz1uWa4rc0OPsggwoz1gsDPSgRtgxBLidOIfB21nWy
 MY+g4UEtQ20YdrGGl6WvnIm7USeyWhDgMgb0Pq34Rwpf4URatP60t+zQAkJQvW2/a8vzw/G
 Qfh9Hd0z8RV2sWM7WDFlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1qJKy6keiWE=;k7cqz0hdvaJNcoGxY21u3lX3xbU
 P6XdqaqU9vFKc7GBsi3OVIVLT0jzihjQmJwRZgJp1xzU8slXnwCrFJAqFijQSUQgQdmGFuHTR
 8s2KCX8C8FkcY4LhUr1O0nU7Yb9apQyFTHG9EqLhBdfmoVoA5n5fjgd2QO2OiwSePysIr8nOh
 droIHvmyl89Q7BhyV7F7/HvexeIp4L+eML7TR/3VTehPr3IFR0w7yw4kfEGRNW1f+P4C+A094
 xVPZFi8j3O2dl1Y8cxxAE6HTTSFERZ6+ASs+YlPMuJTpToSEHet54KCepebKTlxDGG6FH/cIf
 X8fkeNageXI7Q/PEKyLbYOIqD6GY3TQNMsxnCHJ0g7E7RILTyW52p1sFySrEaT7cvHyO1cWq+
 HDaUSaYZr9tD+RxLg2Y1qYAjIHzQPKWL6RzyK70MkWaSPVObohpL+FITn6C0zKNq1BKfubXXZ
 pi7N278AS0iqRuo1tlv4ekT8CjTABOBepGTiGIIJFA9o2lrSAEJPW/BfgJd0SIdd6n4CSh0W1
 CWzdwYCROyykDQ7g4mmrajtHqLddCxVnZrOYH5p7GT4no/dDai/2tHGujbPi4l5ZU+28AZ/X9
 6+5Y1jSVuFNI93Wwabb4oHEby/Y6oic5iV4ilZ8NuG1JZWcYIMWrwtoCYM4IJ0n2gFhtWwQCX
 VKEJpCFP+qx06ZZqgUNyVlcNtiJF+3w62QM+vd7sOJC+SJvpQ2MrVQ/SLCPiPC1PeS50w09rS
 gKK/B6v9AB+rKPbPRHF7mAZ8VQKVlPwlfJLzBKXZiMctyTwOBvxIfNeVauH7p8ZHUql58hh6v
 tzsSV3AcIB6Z2tqDssQsKRjw==

>>>> Switching to memdup_user(), which combines kmalloc() and copy_from_us=
er(),
>>>> and it can simplfy code.

By the way:
Would it have been nicer to avoid a typo anyhow in such a change descripti=
on?


>>> Applied, thanks!
>>>
>>> [1/1] drm/imagination: Use memdup_user() helper
>>>       commit: 2872a57c7ad427d428c6d12e95e55b32bdc8e3b8
>>
>> Do you find any previous contributions still similarly interesting?
>>
>> Example:
>> [PATCH] drm/imagination: Use memdup_user() rather than duplicating its =
implementation
>> https://lore.kernel.org/r/c07221ed-8eaf-490e-9672-033b1cfe7b6e@web.de
>> https://lkml.org/lkml/2024/1/28/438
>
> Hi Markus,
>
> I apologise for missing your earlier email.

How could this happen?


> In general, we'll happily accept cleanup patches.
>
> If you feel like your patch has gone ignored in future,

It seems that some of my development ideas occasionally trigger special co=
mmunication challenges.


> please feel free to ping me directly either by email or on IRC at MTCost=
er.

Will the attention really grow accordingly?

Regards,
Markus

