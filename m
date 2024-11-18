Return-Path: <linux-kernel+bounces-412861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF0C9D104C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F5E2828F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2741990DD;
	Mon, 18 Nov 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="O41WjCBd"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA862BAF4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931240; cv=none; b=s8RHVJs9/JNbhnIs2ctg9UL9x1RLSWNU+tRjSBpDwkJ/iEyjL+mNARUeNtjZ9n4zA9PFc7NaHOlU5axrJLvmnpuDEi0g3QNc6aue3mvD5IWGo7O3YFG7uXoJnJ+COdgQlBqGKmNG/BFRQR8HxPLPS/8pInUjFG6TprCBvvs3pBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931240; c=relaxed/simple;
	bh=2C7OsQyvvwirvGxymDvWsp8mNq85lZREg9lu4plSNUk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GySWWD5OrEcbSSgmEPKlBFR7H+Uf7/hYGz7eMNR/tXjE6swkMoyBM5gZPzNYHnZ4hP9GBr1A+TgIkuQ0U+tQMqJCJWM7bciEe6a9girGoYiLK8sHvlQMq11hsHTuIzhSQ80djWXpkj9KWmwfLsv+QAXPKGXAnKvzHchiTvegirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=O41WjCBd; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731931213; x=1732536013; i=markus.elfring@web.de;
	bh=2C7OsQyvvwirvGxymDvWsp8mNq85lZREg9lu4plSNUk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O41WjCBdCIxsxt87g4wBc4jDiEav9g0fp64WHj+vewUGwpx7+2v8F+ESGW87WFMw
	 XEJCAf/e8H08DEaqOaFy3KuniFAK7D3zhE39Cl2N33xPqbeJnfo4n/aZzTXKJg0Ip
	 YHOJYxJD6f865E3GpjQFCDc5E5/Ep+RGEb6xiP5dJpGiGIy3q58eCz5QniqoAoy6D
	 VsjBsXDsSNJ3PBlGGRaaiz3Z7xpGScnVgbSeoCzK4W2aRW6MmNsDJw2Qytm4pri1p
	 V6DqsNQN03CPd0vh9lvbi9pVAKQL98+OONIUMsTT5ziayTP4Sv2E6c9RNB+M0Sy+p
	 kyA7EpVE7p4Rc9D1dg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS17h-1tIoEw3KXr-00Hhtr; Mon, 18
 Nov 2024 13:00:13 +0100
Message-ID: <c27f53e8-5155-47f6-afb7-15b53cd5aa4d@web.de>
Date: Mon, 18 Nov 2024 13:00:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Charles Han <hanchunchao@inspur.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Stanley Chang <stanley_chang@realtek.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241025094650.253599-1-hanchunchao@inspur.com>
Subject: Re: [PATCH] extcon: realtek: fix NULL deref check in
 extcon_rtk_type_c_probe
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241025094650.253599-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IE9nRm88lsySBQX4WDMQxkOK3ZUN8LoEwwUihhA8V+WvC9v+jfl
 nQOH0E7n9VxyOIjIn1WzfF83Z5itbItfzMocRpnual7320qAAXJR0YkFLPS8gvej/UVzmO8
 3Dtg/3veyVD9TjLd0/FJbJCw4Hn3tlGyKY6UAudW9M+caoDKiFB08uGlM/e7w81fqmpGZzD
 L7FSRz99FBIaIds9ICyvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/Ar+M2kEUkw=;9hc0wBucgJTPjf8vlm9VrMIrDbl
 SehZHYKjYU5QbpVCPvcpx1vYnze55XgDVViV4J5KqldFS6gZm4Bm3LI94ssttmVLPdAvLNXzC
 pBeXCKLLE4RG6MDdYTvWtylkvf2aY0kOuYWuP8zbWUPnA30e3PSV3RZ125NFxD1PyPGDk5ft4
 0edYuEoIqiy2zTG4+c9v7Oeqswfph0xvxZzPWQzNOlBsvRPFNK2U8Srixqf7qdTXXGgZNBm8d
 jpfTtw4AGq/g3QUIQa7lGuG6flwOJPTi9gOZypjpOEN2ArZ5sUBgTgcOJqdFxhzavzEnaF7al
 RF3eecPq4NVP3/tSTrrcPZtPqCV0gpst86NNZzZYg0EjFuP5QE2wbzZnLhtXniA7S5tmuFq58
 TLso2E4/EdY76V8/+Lo8VHz+rP2Sl2Pp07B5MYJS6L/rWUztD2zRUL/JTkYSWDXoI+Yy5n6LN
 TNE7fkgNUnP1n2uWIGh340MleIgJl2y4IHoiJpQrqNhb5gDdFl7DAR+RAZ65ah+c1ZAnb363R
 pFCUWizMoVbHbMNhl2zoabli/GNGyfBgLO1ia0muvNhwxcj4ksBzwYoEg7FxVWHLi9GuLjN6m
 qlQAigjU3jqt7Nt3CrqWzV3vO4Bp5a0GI/k/RucDQXsWfMpyaNThycng2VF/HaLtARK2zuTyJ
 NnKqKvcTgfO/T0Y5TJLty1jUUFGmPGNGzHPiJHST2gd+YQ+z9KJelY4VU2wFfHxSzEdokxaaY
 c2+bTi/a8sOMgT4//VNiCqhqo1GEr0qtiGnH68Uv9Tv3XlS9xP2B3Dj7AHvIKTRKcMnMpfOoo
 gEZFRBSby5RRSF+Lfr5GLx5AhcTKzWpVJDE1f4i4dC3SysE0QgE61o9YrjyIGH7jtEBalzDPf
 Em3AYHGNjg6DkK+qG4v0B6BxVqgMwwxGpVqOCIkV4FLL+zJimqJtI2BFc

> In extcon_rtk_type_c_probe() devm_kzalloc() may return NULL but this
> returned value is not checked.

Another wording suggestion:
A devm_kzalloc() call can return a null pointer on failure.
But such a return value was not checked in this function implementation.
Thus add a corresponding check so that a null pointer dereference
will be avoided.


Would a summary phrase like =E2=80=9CPrevent null pointer dereference in e=
xtcon_rtk_type_c_probe()=E2=80=9D
be a bit nicer?

Regards,
Markus

