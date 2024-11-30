Return-Path: <linux-kernel+bounces-426212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A243F9DF057
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 13:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18730B21A3C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7F9197531;
	Sat, 30 Nov 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="V2xPQZWP"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30A13C3F2;
	Sat, 30 Nov 2024 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732970095; cv=none; b=U2DxavzWAWIExrfFl895BF/zwWjfjL1qCvGykGfQHpY2L8R8ha9hW2LGZtr8xD3ewAdSew43lZuKorHsdcHjM6d3TgnyQuNXea2kLmskKE/f28QVz+5ZooiWzHTJRvTDN2N+5tj3qIZWPyCHa3a8bkGYhK0NsOO+KwCVgZzVoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732970095; c=relaxed/simple;
	bh=XZIJk2adA4rlPgleUP7ccoyQv05KntzbvvNTIhOf97c=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=iYwMw+X1V8ttr1iyxVDwH2gVDWeHRDeS2xMlYsbHX02Ii9cP5BdGhv5jp/LVzCMnJhn58vJx36kTufnlXT9iPS5l4jhzYryNPbsvzoA+8AeysMUc3XU4I56xqwispZaEprRj1cavLKzhOabo0BT5T7h6NPC3DxeszOcrsfNfk34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=V2xPQZWP; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732970067; x=1733574867; i=markus.elfring@web.de;
	bh=EKTFWHVdKPv4zouKlHIVlvi8TUgd1IyhKWUXdDSdmnY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V2xPQZWPLXe9pEFCtvBynTKYWcTalBPohQYBL6ON+lgniy3okqcdHc0J/hzVuIAA
	 2oeYoWAl5nPoULV/vu0P9YBOa9GnduWTxnfozb1NYnXmzaQ10I1JmPYCBFPdgfjzj
	 gR0rpvwNpgA68gnJgMy7rOi42KxTazX7TwcCJknQkeGeYKCsJycxML/+ONJ6iKqni
	 wP4Bzg0Xh1hl7MJryCR7XZZJimOmuYq7+KVOr7oNJlBI1uYiqy0OkLHwWsBubB6tO
	 s9iYK4OkVSWBI9s1oRUn+senIO0CXhg/4Hcs63DUUm+2xMjwONRZn17hN7fQoIUxX
	 4uKBV0X3qge8lGCHlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79N8-1tlKEZ0D3E-017cg7; Sat, 30
 Nov 2024 13:34:27 +0100
Message-ID: <6fd72d7d-8a6d-46b0-a7aa-08111093738a@web.de>
Date: Sat, 30 Nov 2024 13:34:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 linux-riscv@lists.infradead.org, Michal Wilczynski <m.wilczynski@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Drew Fustini <drew@pdp7.com>, Fu Wei <wefu@redhat.com>,
 Guo Ren <guoren@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>
References: <bda05d7b-5a6e-4f57-a124-ba56f51da031@stanley.mountain>
Subject: Re: [PATCH] mailbox: th1520: Fix a NULL vs IS_ERR() bug
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bda05d7b-5a6e-4f57-a124-ba56f51da031@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uxeDcr6BH8BxBkN6tuLsL50ywJWugil/p7X9C1bf7AWIfWPi0zi
 rsYjH2uwJEDsogJzQcV+vk9mn57E2LNDPOMkVHbcx7Y9LNHnb6WoY+1RM67VXs4o+bS3KN0
 tqbxL8QzDJbDfQO+NsnFMDiksz00Fgue3xjDETmMqdsI5Lpn9JxbTJbGD0/pcVkovoVvumY
 AusXQqaPnE6C6ZgXG3p1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V0SMgdf1a7k=;WA/kuaWxdjyIv3fUoke2JJqcdTM
 0T18UrQgQ2yfyPRY7tJwuKhWtjE3whwJVbdlAvOsxeYym3jtii8/pdkw39fpw9tU3EYuk5k10
 CKcEyo1jKTdbduccRKXb/CIf+wDsm3+260wehGpXgpBG3um5tK33HrcGNETcI7VPIHqa7Y+I7
 zvorhSoh92Zxe0AjWbQD6OSMBNKaTuXMITyoODIxfaArzqTuGFF0TUslqp9zF5vTRjLNviR40
 oU7kuhYvD6nvlkSotIU6sNrkdAB+EzZIN+VxZKiwtrDlCXgR70iax3HpF5icjyJ4vLm3YX5h5
 kmLayr7nVTqgXDnGq6e5UV6/A1j3n7GYNmJefgRkKv5t3u47WNNRArEPF9YODS1YdLGCkeYyx
 3ZVAQaoWg0J0bsJev03t4oulO7AqTUe4nJ0L5DplvRlXXEQLuZUIusdeTipF3nvCy26sxlWja
 4f+Dz13kSU+kKfLM3E2qHtuy4QJlV3c1rJSEXIMtr6jqPA4livJVcIu8QtD0nLLteb3yAgr18
 8ZDEt05pfgjlxOjs10RekH6or0U2W35oMPgs4eXgHa896kiE5z+czjpOcKcsqjc6AHIf7y9Ve
 muag1vpxlhZN8To8QxVdCvJWX/QiYOLubmiF4nHfp3vD0SO7GeXfIrtCZE6tp1ItOEbrqSPkQ
 +HUt6M8jU2YoTXcS8v7YtRM72Hl/cQBr0uainDDjEb0WYzHhQPLB91sjTjHCbwdzoxSfYMKfR
 Z2X1WeSFJIlzuY8QDDM1MhlWJ39Bev6lh4Z8EeU/cb2HSMyPaCVmGlleRmG8AuN1kktQNQjGl
 1zAobMVWngetpqmqFfn3DfwPnAhReBui7Hyuj3jjHWD8E87lMe1zmedwWoTXJhyVvnguQa/BD
 edpwwzTJaZKmQt9AjaT0IzmvJ1m4BQUXbZUJ0UimDc7qS6se9pwBXma5l/W22Dj1icKLivjTl
 xcQlntQnkfIueMQKJ3i3KXTxpt3M8rv/5BRrl9RNa8ROQijas75dGaY6i4Gu+LPzdjRixeQSq
 c3bxXawLN/sG7Qc6AyIOKxbT0iNmkJDtLKSVj43ywiJ9+bJgIvpsoSda8xUt6JIoY3bzT29OQ
 QSAJwH3Kc=

> The devm_ioremap() function doesn't return error pointers, it returns
> NULL.  Update the error checking to match.

  on execution failure?


Regards,
Markus

