Return-Path: <linux-kernel+bounces-547585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB1A50B50
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF836188DEEC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1152528E4;
	Wed,  5 Mar 2025 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Rs4Ibrpc"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815791624F1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202306; cv=none; b=o231+VQVAiij/tc9AgtNTqNiKmuzgmlEcXlBlhhEG0kwkhzdB2VLTApjB0lcqUHSCSqvAyUW+McQz3hGQPI+jXCHdlo06OXqCcoKriXku0PUBs3kgjiJAuKXfPH1oZqtcNdDRf+D0ehizpPbNu0polE4d/nRFeDQvADxcUT2wwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202306; c=relaxed/simple;
	bh=9g2rbhyMoiE2C/oREhNhMWIX1M91P2cPIHXySR0gWtA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=elbVPN29UVVlm9/D56S59A0EAoA+nUOp68YLAlHiHzdyt6bflsNmu3pZMEZtguo9wRi7W5+pIz3KolVkA712NedtQ/BVIQmBSQsepiq/TLlN5UQdt59V8///0c0eI7AO9Rw75PRSGNI3j5oGQLkMVyYc8J7wJo+Wic1UUmoXWp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Rs4Ibrpc; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741202300; x=1741807100; i=markus.elfring@web.de;
	bh=9g2rbhyMoiE2C/oREhNhMWIX1M91P2cPIHXySR0gWtA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Rs4IbrpccT00VYlI74v/Y2weSxQOHQ4BKtgCQmkaqfwO6E+w+Bmhvep9yB5JooiE
	 q0qhJuUHn1UP+PpKwMeSWIKuL6i9xjbs2r8vLpBitS8iKGwxQOztAf8eRU1BYhxW0
	 VOs/PsnyV+j2CQoTT7S5rtYxIViktTM6r2RiSzi4EFwTh9aubGmIKkOSwtrLt0w9X
	 6FNNheZcCPf6rpVWbfMtNN30Gm4MDZY6DRz2yMpFUk9a20V4Ey6QXGG+Q4xM1FgoN
	 gQSDNoM7Rn/d+2n8G/17fXR1wofLkxk7HK80VoOw2lB4PUEsQbDR4jXQ/epIi/jRg
	 Q6KQ/Tj3A8qDiQG9NQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPZj-1td4CT1FXV-00XOXS; Wed, 05
 Mar 2025 20:18:20 +0100
Message-ID: <84969aba-67ba-4990-9065-6b55ce26ff92@web.de>
Date: Wed, 5 Mar 2025 20:18:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrey Tsygunka <aitsygunka@yandex.ru>, lvc-project@linuxtesting.org
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250305145045.1293159-1-aitsygunka@yandex.ru>
Subject: Re: [PATCH] misc: sram: Fix NULL pointer dereference in sram_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250305145045.1293159-1-aitsygunka@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oDVhHfY+x++ExZt9dmrKdtd5Wc4OE6HX2lOQVtWg6AXhEBeiUv+
 t3sBNxfwbK/3/boKIxqoeGHFon5qvyuHexSQFr5hHQzBP3ccqCTkMw9SRgfHqgsKywOKRVM
 Z2l3aMcU5gWuWgAxknQJQ6fWTc5p603tACB4UnoDqFpCvEbhD90AJKbZupVdvT7EjjGRDxW
 XzPq+3JVMUU8NMQ4x8ukQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/2sM9lf64LY=;/XKh3FG1TJZlkok0eJq8DzUS6YY
 mg/pViGjNEwgzJ2GPGkkygzlzGKYJ8FhxjD81gUoX6kJTDe4DhCjIellP8wMEp6CsiRhxBHsm
 0+UqsofiBAIfir6e3Mpwh4XoEJtFLK+zLLTId4qDkqgAVRWq47MuAaMZ7/hbdvyggP1tTzpBk
 lMXrfVYpFYNGj9Cq4fzRYlO8ZDsV9NecMt+qDEIy+I3CqSrdpMj0j6GYFc0gho2lQ6q066ScN
 dG5rvjRF+57RPHJABg9e/oKMhNio1URk/ZFvez6t0RwXiKj6kniqV61KVgqbqDJYkp0cJbT+r
 pqnRIpfHtg2t726DWOtHzQXEx58nqLB2SuNmQiY8EKCH1XDUZWqT6xg2FNM+miAmtFp7qQ/bU
 zGHohOUivhlLWH4GvHzjY3W9+kUddbaYWK9Jm8580o8DMMN8ga/oz12CbkrMARi4wKwH/+7IA
 jyA1F3CG//WUQOwYntvqCPWzaP0xn4nYro2CiOV5Mi8Gb5eRPM1p4o+dY5/vCRtk8zWSztIxw
 AHf5cQA/oncF35psTqAqBZd5F3K3kBXwiEkCRGfqfRz3JJRw2nENCRjYKLboTGy3hMCpJA9bw
 E8Jn3bRFuUSgkabXVlcQuy52aarQgZSfznmJO0dg6zQpeYdQ3r/Q4IMDVcLhbYsAzojHnNhbi
 BrgDaQSd36yoApbGZOUqRlBMW+FlojbtsDQ48F55t+iWw7gF6MWHVLs9jxmZTyZO4525ffCbK
 Bp2BBfv4NNZ1qPEJaifPvyanD6Gweo19F7OCUOzVVLEFnA8enI0o5n4cVMXy7ekIDlTgt7jTI
 H+x5MVxUEmV3DUQymTCE7VMITgdAlrzOEu3HrkNqZVuUvZoBBAVDKFomJPxkStnWIrHclvnYq
 vV7D/EDRt92pHUYRjG+XKMreWIv79XdlFgLwItjqaSS9BqwfhP+mBrgwj5GP9LlxiU/0GZP+2
 DU9ia+mEmHKml/S5D29aNgLF2zSg6pJ+pLpcTzPxjaMSD8mfvVwwRCcBs7qddsDC+I9q4b/Qh
 wI883hmmSelH35MVOnYoKCbO46bXzcG1Plz7dcxVsjyNso4CS7E1HMpKxPE7t/6wy7Slx1DM9
 7aBKSMCT8PQDn26iGWn48CPjAXSPpg4/ePJRkH1h6Tv6hAaRaFCUheIinR+gE3q99W29p50Ve
 tmv/79JngIJl92H9F/7AgQ94HFiqYIhEVBloH8qBiA87WzjznZVOHGu3v8FoiKeDJ7kygnkJN
 B3NXVZ99eTLr7FUcqEun8ncTefaNQLw+mfLQgSR4zf2b3eolBLnEqbV2V3WL2QTCSsN0vg0+h
 r02yU0/3PG5OR/f7prBNNshYbjZCje2sRw70D5Jv06kMxaYPXeh2eBX9fI2W+8QQ8k2xbyRhH
 mXhRdehM4p7PG/XvqHCtgzn8yerEsjiARnSGEwYDFbYcACNnlBpR39M7ySB7O1QEXbC+1CZo9
 RgMZ9hg==

> Added check for res for NULL value.
=E2=80=A6

Please improve such a change description another bit.

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14-rc5#n94

Regards,
Markus

