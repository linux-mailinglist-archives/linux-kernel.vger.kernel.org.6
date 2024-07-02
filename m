Return-Path: <linux-kernel+bounces-237676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0B1923C8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8737D1F21FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8966015B12D;
	Tue,  2 Jul 2024 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Cvh0FCZn"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524DE158D98
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920302; cv=none; b=BE52Te8Q8C+5Wm7Nz/OmAyTJidju8Hsz1wKa3eMS4/3ibZth6FA2uutQa0ZcT07sQuTfOzbFhC/96mJbcr0ID21w4opiGQQbVCDI9Mwhw3csoGRYDFbD/ZKpZh+AGCiTRunr55y4wlehEVsPLUNr7ad2fy37jBJVXzg6GgnvYNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920302; c=relaxed/simple;
	bh=PMxrC5TKVJf22V5/57I5TeYs4p9gUbgtiEdMn8BmCyk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QIyp3bQRl0YcPABoiLjRn4r4CEchYKjnleU1ENvRrfAH9zOJjKEbhfL/JAYMtbz8MVygC7XDgMP8OCDL0QGhL74zsZS8Df1ep/N44C+vb/dNQaa0fMu8ygw9hAQPtVSvkPo6DpO1VPRK67qrWVeUx25HXgS4bwuUX0ovdm5qzso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Cvh0FCZn; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719920280; x=1720525080; i=markus.elfring@web.de;
	bh=PMxrC5TKVJf22V5/57I5TeYs4p9gUbgtiEdMn8BmCyk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cvh0FCZn9HEOQxmBMnuXnZucebT2Q7Xur9sqDou+0Qpg23W54o+38A2Ytvy3SL5K
	 GerlAUmAZXWwSQG0MWOnHFV4PyYs/naLhI4mSOKUUUfyzGil0S5/WQMmXrGFoMhzw
	 GiCRGpqIYiacf/NWjsgaMVyXTTd0FJ0CSxvyZ2DIM1XSzKDMEUEsH9M71ToUFuKPE
	 8LqwCEsNOmSGFzsd3Ku+edAOFoRmxoEx/mUrR+79HGRC3TMN73lV7oZaPrAtPuQw7
	 njp7nV2ffF9FkUjC5LcOkjTK6Mnc5Edt6/doJkK6V97ob0y2IB+vmtCMJdon9PrEs
	 80h/vK3eyR7gajfXVw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJWsc-1siLdg1FCi-00QutZ; Tue, 02
 Jul 2024 13:38:00 +0200
Message-ID: <364b65a6-8717-4da3-aca4-8f8c847ad6a2@web.de>
Date: Tue, 2 Jul 2024 13:37:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: zhang.chuna@h3c.com, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhang Zhengming <zhang.zhengming@h3c.com>
Cc: LKML <linux-kernel@vger.kernel.org>, berlin@h3c.com, jiaoxupo@h3c.com,
 shaohaojize@126.com, wang.yuI@h3c.com, zhang.zhansheng@h3c.com
References: <1719903369-35385-1-git-send-email-zhang.chuna@h3c.com>
Subject: Re: [PATCH] mm: fix kmap_high deadlock V2
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1719903369-35385-1-git-send-email-zhang.chuna@h3c.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jKaQcRj1eCOQIm7UXp8deZuShjOvY7aDgonKc4BYvqTKVjB13Go
 Z/QgoljEKDusxBXBpanbF/ic413wBqq6BIuSP24TWXFp4qvymd9C6yAHggTtiCdpAI+Mb4p
 EZtM9gvB3h7hSIIgYZkkfiQ1mqJ+BGE9hpTmSmpBKhyJ3rHFeuMk+YxPB462Prayg7V3uh5
 QHDvknFw1lqRfQyQxaUUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sdT7kVaeu3o=;OYu22aOgxpB3EiposwZg8VcvJVG
 w44AW66M92gVkgmYNLlVgknXyk3CNW25cpu/Nz2M3pQFEmfTXK+c6O3BdJPn4yb4sFHkfdUG3
 2Y2DKJdbO7yxOIB09UitfrJ3x+2H6lssBzkfCesroeEVJu3M9VVB5B+ce+UFXWDb3Uwvij+5x
 q7UfLv6mZD1l1g/oWEHLpSrx0giY54Wce6S14td36dF+vf3qdY0S4doQ8w5xo0DIxSBZXy3ae
 c9yJXQ4nMbzmWb1mVEl//OqA7ZE858+84CgQhA4jG5gKnZSbN4SvJ6kE4yvpPrqj+N4lJVmnJ
 w5H7ZBrIhEeif7y7NLyuC2bd6rjLk45MYCAskcxerFBzLSdit8hG7wA2BkpOW09N/oygW1a8+
 QTIolYDE7lC0D4KVJbecZY4nUkgfzPBhXCFek/TaBlrnrjqg++d7RgjUY+iR7N0/K2tdQKnsK
 nkp+gNJyVnl2akSdyapYbqJi0hVSisidSGM4YqTmvsCyfLy4N4faKe5cd5rHjS+6LJ/H/6R0A
 oQgRAqo7lkKypEnuXdg3PRzxSQe9WxhNtB0h7urehbFlY/T21ZUZxtTULps5FCKv21liUsJcA
 Q03C8Sz0em3BXgU5fyd8OOLvuo9kPAl2lSiJJHN9VX6uBSdu8ujEOAtDr24TQ+iBr94xldqu/
 AXifkNalHGrFTXeWhlXynn3UUHDecunWykNXsZP9L+/QTiPYAyJSEkgvWK90nF2O8JKu7tOS1
 DgJpaXICmVFUsKLZNvlanE+rO7RJIK7C8bLhI/r31GaXi54pD0Y8XZRFO0mJ5/g2I8yMkXQtb
 d5XPRWcZ4eCfHyh+lm/5yv6Z4OnvUl8SUje1e+VXHp68c=

=E2=80=A6
> this is some deadlock condition. I think it's necessary to give
> kmap_lock before call flush_tlb_kernel_range.
=E2=80=A6

How do you think about to improve such a change description another bit?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n94

Will the tag =E2=80=9CFixes=E2=80=9D become relevant here?


The version identifier should be specified at an other place in the messag=
e subject.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n668

Regards,
Markus

