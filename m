Return-Path: <linux-kernel+bounces-547374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7E4A5065D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258613A3B76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99139250C07;
	Wed,  5 Mar 2025 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cvyNvSK7"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE371A260;
	Wed,  5 Mar 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195765; cv=none; b=l1brQO7FNC4Z/5zSoJr2xRQ5wDGleDTWLZAxMIAxRibkbWm7PRdAZT7xsYzU5fAgMEEF+PmYX3pGFIVbXJoOpW/1Nh71LdRsKrybuaFK5hhDyScQTxMjcgy7WUXrBqyNJIVLKqm3SB7Z7Ta5fUIO6DvmkVJw5hsmbkBpXw0Jr34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195765; c=relaxed/simple;
	bh=xtiQKLe0sh2b/5K2i8jzCLuSRfvmaqQV+l/0T1lc8Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1y/wcwVKbUXAX89oofWJPRpsfWdykRh5L1Ve1fMIeomGR2hHWysT7OsaUr5vYNhDoxosy7F6kkiOb1wh8MSODt6AhjLeS84nkuc8uCJCCTch65O0BTVaPrDiPMZeF7u69bu6Ny5EB3/GHTBvJ84C8Td8wVf+lF54bifkLmrXUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cvyNvSK7; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741195738; x=1741800538; i=markus.elfring@web.de;
	bh=xtiQKLe0sh2b/5K2i8jzCLuSRfvmaqQV+l/0T1lc8Vc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cvyNvSK7JhyaAmdAq1JK1chrv4QprDbNH6hoqgkxFk1feZ5vTk43BevHf+2nHg9K
	 P4A513oALEtWPNcM3qu0e+nvbllCfGkM7nebEo11in/gQk5yLIn+NVp5qqkHJtEd3
	 hk9ioe+QSojqxyncq4aHYOYrl3EaoDE4jfcicoQfL0pdV3YgRDf4c55XFOOBMS5aV
	 lyISBbosBh22FBqi1F6rcie9MbLYF3PvEaZ92+SsyuHRLQjKkx0CCFE4AqyFPfsJA
	 EdU8wM87Mpsr6zG/0BTbnPAJ3zjjCkoewSbCk8EZjOxz1mLDRuKQweZgtro9kpZwR
	 Lc+/PXeAze2DjqKTwA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M91Po-1tvx5b3WNS-00H6a9; Wed, 05
 Mar 2025 18:28:57 +0100
Message-ID: <e9372f7e-cefb-4f8a-9dbd-b26baceb0d3a@web.de>
Date: Wed, 5 Mar 2025 18:28:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: video: au1100fb: Move a variable assignment behind a null pointer
 check in au1100fb_setmode()
To: Helge Deller <deller@gmx.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Antonino Daplas <adaplas@pol.net>, Thomas Zimmermann
 <tzimmermann@suse.de>, Yihao Han <hanyihao@vivo.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
 <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
 <eebf8c0c-7a6a-405f-aaab-2a8a8c2bd91f@stanley.mountain>
 <hwk2nf62owdo3olxrwt5tu7nwfpjkrr3yawizfpb3xn6ydeekx@xwz7nh5ece2c>
 <47c37d1a-5740-4f48-ac0f-635d8b6f51b2@stanley.mountain>
 <9d042e6a-6d93-4ae4-8373-28b9dec21867@web.de>
 <81a620bb-205f-45f7-9036-e8e44a8e7be9@gmx.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <81a620bb-205f-45f7-9036-e8e44a8e7be9@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yWGWNO6K9aUNn3g3Qc5ZNkQf3WSZXFZx/7sAlXKN2G2OkmRvkTM
 OOorb9nBJRzzmErR9eJErw6GmksCApLqzMDcyKGuL3v4Qalgpp5Oo9wJ3hULjiXC7J/bBVT
 BDd3SQO+O0DWCKxnpPQhgtzzOvZVrnHen1F1NTITC3WjdS1jKPIEEhHglUQ5+uuk2CmrSEC
 oWIV86XuELAY2ecrMErmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UByq28hN30c=;zVhcrG6+Sh75YoWB+H09FcqgW8Z
 bgunNY71oawVGm5ys86Bfzfb67540oJ+u7DAgmYRadi+0yDuVnhsBjFqkBXS9yWJESCsOSZfU
 4xgJJrykXQYALn4/eCVlRvVAoYzpKDR0SGzMpZFWdB+hFqSpAO7yrjX3O3Y9qUHmGkMPJZCOn
 cTFIhVVjD21fVeX2V2oZ4NbofQkCoa9OX0/KtqN1O7Bj90dOdP7Rhs5955TPCw57vqxdIZINT
 EDxDN7hucnIllSj4HktdwGfvRVzgciVCR/nnoUSB7OeeYt+Qqe9MZEKv8OLs48GVCT2yVXeX2
 +DoXgPQDJlQfvSnXLcULgMhRhpAMRdbT9rw9T49pS3OdLxxzTi5FbYpan4orQAAObc/4Gam+G
 Ck/fSxbbd8JBEAdpATuUUwJr1RRXLv37TQl/9bqMJH+wLx/IauUHcfAQ3ziqYcnSki2F9ziyL
 Q1E4abj3MTZihySUQ4yPtvuNhnQBWWW44B2EiygAOmZaWQIPka5WebAJ7Sjy1T3mrYWjHeFPo
 8CskaPVmU4QL8uazhS0gNgFAcRT0Vi6yjHr5fN7AIktIoGoMgfNaorFcZOUoHWrM8LCsIQBB/
 jfi0OhDkRJMzOo382MpJHfpGv4sF0IDGdXlzlizhUcyT6MISK2mVuDtW2rORZJpYDz8a6Rckl
 +4exgw40+U+PoIQn+Z9XSUokVxe6OlUiROGCTAGJbdpTjWIbLXHDDXg5dvfAUkXlVq9Fv+nVP
 0mSbtQtRFOKIB0qiFYM4bOtxQTqYN3tuPVXu9deUZoo7K5vCP/FWPIPvPxzkLJQNxq3utAaXY
 wy9PW371DMmOIsHCUHKsDtdOGfw2H1lDvs6PB6l8fYLhBVU4dDlPGLgh59oEHyhkFBwPXuW5w
 3DonwIC2P/zQ4cG6tm7VZtlFzxdZ+ye5k9UO0VUYwjYPiNCx8WNRPPjfmSKXhKWFgi3p6N7g5
 IqJNj/mDysSDG7RMaM39tVrMPrcwWZ8z6oGHThg3E5KmK82dUi5vxGn6jZUhz3yu4Fc8XXkof
 x6ZwtZzdVSYWDdsBr/SyXlQ8i+cfKJ6LiyG1jn8hNyWoneUdnXcqWbXMWRD0/s/IIUFN4feVO
 I+Bf45nMJvdMnn/o7rH1XpipM/SL74qzSqCXvBmn8Us6B8Ldb+aijiIzoTFfCBXAwLGwzMSp9
 Zt2uJqzqSrKjv17g8ph2Ngy58lhUGkeMwNdZg+ECbRjvBmqa4iqqoy/GVwljXXF9MS3G9asd1
 55uKhfWqWAIurDzhp96ZZq6/p8+TCaWltkV6C1rkxi2OY29xF/DgPnppVH43MTVtZQy3LFpVK
 5sEG80yWxY2f9zBsaV4bzd2XXY4aGsbDjy4kz00PAAtDOJcQQCeAgHB79klC6ohFF0vUFZueU
 6sovH08njwKsHLeJNlo49Z1ac79ph2nit6SBuAOrxGbke7PLx+ynScb3jmLZWWyWKcHw1i9ni
 heWvOeA==

> No crash or anything can or will happen here.
>
> Markus, maybe you missed the "&" in front of "&fbdev->info" ?
Would you get into the mood to adjust development views
if you would take any feedback and further background information
(by David Svoboda for example) better into account?
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+=
null+pointers?focusedCommentId=3D405504139#comment-405504139

Regards,
Markus

