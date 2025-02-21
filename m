Return-Path: <linux-kernel+bounces-525338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE3EA3EEBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5575D17783A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA88200BA1;
	Fri, 21 Feb 2025 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bt7tu6vE"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65A1B0406;
	Fri, 21 Feb 2025 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126833; cv=none; b=Zkwgdc7YIHkklh0Tx7VQBcpHBaXqrfw9MpL9u0WlbWbJBi8k1y6BO/1fkiNB3sP+2Nw21i3MYmPVm6DNX28fWP4i5Iw1zxywPC0mACmuEi9SzOUQwntsMb/TgUNTqQ9Y3xRQZhELy+g8YtLMunYtYay99Ou8q4bU3xO9d+Q8gfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126833; c=relaxed/simple;
	bh=eoxsAfqeU+H0czTgEZX48o68QpjPhSUOljWF7MFbd7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuMwT41njO7gMelntjl229o1dcmoAPTmN8eG/KMr5WPiiwQuP1yp36f3AD83TvKGoejuUhNiPD0xXNrRE0XjoezntEY9+vcOeH+iHAy9DvyorqSlBuBK0MzIz0hw5ylDzx16MIDflP9vI1fe+9kLe+AhvgwJumKYVUNikkfU/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bt7tu6vE; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740126805; x=1740731605; i=markus.elfring@web.de;
	bh=eoxsAfqeU+H0czTgEZX48o68QpjPhSUOljWF7MFbd7Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bt7tu6vEi/FCn2ybxG9EcdHwaf7ChSbeKjACzGKS9hDmXV7z1I3ayop4FXieHfE7
	 SdHB+pSRaCSr2exoPvKP78fiYrF7MxBqCerRJzf6GkXkZC7IflAsxhfDdIhTZswg0
	 iqtfvnBSTHMy/oeNElfKAruUmDO2760ZFbSMjsZohDOqL9iSXzIL5Z9fvqNb38Wy0
	 GddSSacVPQ+gSqwmleo5F0K+fM04vDidDNZZiJk9IP6X4T9ozhsmjatDsYO1PHZqA
	 SJJ+/K7ffN4+jgLlVrnqJiliDguhIX4buGGUCfMUsILtc7zMBYAWQ62APQ7lm4m4N
	 UtbCgxxXxh8oWcQf0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.4]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1LsH-1tJmcI34vb-00rpwt; Fri, 21
 Feb 2025 09:33:25 +0100
Message-ID: <7be6a786-18eb-464c-a47a-298208a343cc@web.de>
Date: Fri, 21 Feb 2025 09:33:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched: fix potential use-after-free with cfs bandwidth
To: Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org, Josh Don <joshdon@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Ben Segall <bsegall@google.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Mel Gorman <mgorman@suse.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>
References: <20250221012335.233404-1-joshdon@google.com>
 <05f3fc66-f11d-4cda-8ea3-91aac650ec20@web.de>
 <9f1f3ff7-b4dc-43b0-993f-1f062f85d0a5@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9f1f3ff7-b4dc-43b0-993f-1f062f85d0a5@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7gfLZKHsqSuC43pUjNmKmLekLmyJ3gTuqEduY6KvgYEWVANTrXJ
 xu6FxHwi7uIQFXaWVpE/g6CglNErA2ZZW+71aswotQyfzzSqlNiqRW6TxEki+oRG9J3vNN0
 Scx9dWgYCKP5KxqoKodwZFVOZ6sLhB8yFdyRAoF7cUmR7xX4StR2AOYmH6YtGoCjzEPPfqP
 0WEuBZniA57oy9DVHmhgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KoKS2Xc2PgQ=;IyveE+lyO/AF1JL/3Q83EpikcLY
 xvUzQjreDGFF+Aldcqif9I3kj7/Kw6KAgn82cP2m8+QDZ6ExzqMUIYv995y0Dd6LqR9YCk4r1
 saKRxIOQLPJ5N2LFX32ynWsF2tvu7U9fElTFxrwqtWyCym76oFs3UHeS9/Xi7bpP8dpz/uoFG
 Aw0PTE9SxuN0BW7oCjbHVIGuqpDeg6ylbMo2SOQkKAuJh18Q/foNifCInJfCxOawnavoroXly
 gObaHkNxRlHlVmeomU1sO74ICnEA7XRfkkpjdYueXfA1byJpfvnL4vfb3kEFmlw63aFKhVOnr
 m2GHI24LpTs3H/3+h7Ad+0anoutKEMUBoWXH7zRbb9UDJcjNE75Y/VApLmuWEH2ypxDX7s/N4
 p2IDa6aLQ++OqqqHHwd+K0PU/yg0NH16zGYLH57VSIQDbJ74tZiWVZJ4tLt9IuVaV8nZj+UlJ
 uZs/XYMN6DLnuZBvVauPeSOrMjTxKap6o2KNlh8EGgKCxtAz4b1649/omY6HHeOkrOAUdazOq
 ueAD5ihdaP3XTRvKE9gKKP3NAJmWJaauy3nU82YMjs/H+8JXCKcxO9wNVvl0APZTvQ0tH+2XR
 4h17LohwZQ6WqkWAik1pTQiXAVA+O4SYzkv/WyxHUGMGRlh1zj18+RTOUAk2M0YlaT2y1mL99
 QVDyZZ9VSp4XwSgr3WPpVhH4FOSBhQq/xcpj3ucbenPsS3BAThAAeyAB1MY+kFtN0u+h39UWX
 M8LGk7wB2lBsrLB5UFQrwj7QnVQFksnpH7+1fw+WKVIFVRv+YZFfTw6g56LlTy///eqPoNtVL
 c5Wq24DAlL0VfDQdldJT5MJ+LeLb/0aIflvt5LkBYPtU3vx3vJ+dA0V94TTMTIBwWNms9+Ixd
 gByzmY9mOiyrbTd4KRDKqvE1JwlxSkEzGlKsCvG3vaXR3+AG/V6MdSRSx+8AUXRsTpBd4SoRJ
 G/1FYdWcBKMh1T7ckgH28sdtYDZj0wshQA8jPmw7RgGL1N0WUhSV4qVekQ6ZIdqEVm+KdDAWp
 A7iImZVjqDhiHBprvSL8SNBvgVLNv+WIQZpFtcnJJQECK9/x2aUxA334WBfubyjYE55Z1xudH
 xCNUzb+YdKQyjprGpBOWjGIu6LezIM946pk2RS6HukZ7CEg/fneTTNoOtoVe0N1prEZygBM+m
 TNds9ukNJzZI126xM5RyGXI/Oi+w23ldvBYd0bIksMq7gqzOQkdju/iyQ/39C4Exh452WDhVN
 KsOF51uAF3Fe6K4bl6d2JBNUQKfaziZ77GToKe+8Zqw5fpNIK7ppxnDCTbrhkDC8Bp9sCx+tz
 PO4dbOpYaS6Q0bu9Bxxv2JjRAi0Vn12zphr9wFnhr1E18An2N9T5a4uh6khW3mVh9P07VTkxv
 v+llP3aPnVVHfh0FbiHqUocacz8uAlhvnPrw0D5PCldOn65tue9DEkj3Q0dBxvpRks9WG2//H
 oknEXBKZF1ucvk+HDvLBqjAZRL2I=

> Markus, it was good to ask for a Fixes tag but now you're just distracti=
ng
> people who are doing actual work.

Will any contributors add also a =E2=80=9Cstable tag=E2=80=9D?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv6.14-rc3#n3

Regards,
Markus


