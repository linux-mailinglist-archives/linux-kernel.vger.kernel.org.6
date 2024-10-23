Return-Path: <linux-kernel+bounces-378943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C39AD785
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE401F23684
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF98A1FDF91;
	Wed, 23 Oct 2024 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Jcjj2vrw"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C213B7BE;
	Wed, 23 Oct 2024 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729722301; cv=none; b=foYGMyaYGuzCgjEnumqqz+MmxO6K6S7HMqmte4ltuCl073Tt9IlF5GgXZS9VtcDAGDyIhq2tg0HmRQCumUPqdRCMFgZ7k9cWHarjZAV/mmYzaFWTxVeal4q6UzKLTPNxlgZjkXO21w7CXwVa9SHJZA6gFsOoS7RM2gghTsAlIXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729722301; c=relaxed/simple;
	bh=OQBKlEE0ABXql7WTGw1oZWICI3HlfF4Y4Noq0IQc2hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQJXZjk0d/ScN2uFdowZreoDUCRPucRCviNOdtXz9o3o0ge34aG783F7T7QVUxlElngiUWEWpXLagY39uJcDZXt7wG1lmmCzoHoFAxjCay1A8yHsSpQnoAwVlSjrAS1nFXsNaAuMTYaXfQXX6C6s4PVhWOyNxBY4/ZG8irLQdh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Jcjj2vrw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729722282; x=1730327082; i=w_armin@gmx.de;
	bh=OQBKlEE0ABXql7WTGw1oZWICI3HlfF4Y4Noq0IQc2hU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Jcjj2vrwsyxb0LaRM3d8qHMEt1S5NQcYmvXykU97XkBmxsn+GJngmoZYsmtbLPiJ
	 lUk0uBa/6iGA0hP1O1YDbT+jzEODzXOyp+42ypBBkoJgMWg3kpy2YN95NuX0ZcpyI
	 4nQGJcA+N175kc2Yn4oA2Vm2NzVXb6XjX8JimN2k/xpneODzVGCL9gGHB4K3gZKN7
	 34kPgnZGR3BUfRlteNGoJD9Hi5u5eM5Ryhd7mG4cEsxaAJQwfGeiHGK+D+5TzFC7K
	 0CnRwYgKZRFh75BW58gJx9+kYN9FMjkHN7R89EoCB8MvMYZg1QHYfosFaUisz1mVA
	 6NngdcDJxh6HtjXC0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw3X-1tm6o50wVv-00ePX5; Thu, 24
 Oct 2024 00:24:42 +0200
Message-ID: <98dc2657-ac1c-41e7-b9c7-302bae5a3556@gmx.de>
Date: Thu, 24 Oct 2024 00:24:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: remove me from nzxt-smart2 maintainers
To: Guenter Roeck <linux@roeck-us.net>,
 Aleksandr Mezin <mezin.alexander@gmail.com>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonas Malaco <jonas@protocubo.io>,
 Aleksa Savic <savicaleksa83@gmail.com>
References: <20241023201334.250764-1-mezin.alexander@gmail.com>
 <e78714f8-ab24-4853-99ae-4ace59ae25ca@roeck-us.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <e78714f8-ab24-4853-99ae-4ace59ae25ca@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:w+bue30PCTlTBhNsBh871TXrKyeYCgfKWTQjLc45hEtxfnO7CiI
 VIZBIqLglcxnCiBba69J/cpAgwTnRprqkPh4pka76ABKQKymld+TOx5p3HOs/XpYbnK9ZPW
 BZS6GNVdOpUL27Ujcm7iC38TOT3Ifi8ZX3TRasRWqWFbOurRk4qJSBd60G0uvqgvLW9lD+D
 XpfMNIMDzc+US3GxJOFrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7n8+Cq+1BYU=;vRrPqkxU7KcX1wQPg61TT0txv9J
 Y8Hc7QUOzSJOLy4TpZN3WNfebr7LXOEIgZOcRQU9BGgm1N/eHR9kcwqoRJd83xMnM1Vl7KO8J
 eIyvS0TB+gr1yS3muxMuXnAtzBvbx42FfZ11/TRU+hcN/Pzq8MUjW7ZYjs6Sk491FVl4Z41In
 WgRLMRCK+AO+4yfhrD3AN6yGN8nf4lCAYOZmR+6VEi8aWaMjPw51v4IpMeRoXRGT4twEUyGqN
 srrmjjmOd816GzfeEirMg6JzS3b09kVknO727jUW6nrUxpLL58XgRZwYw8L/wBpTWK4+5U1n2
 SeejcgFZXi+ELQVigJanI7+57o/DPUvb3EHNfb7gNYjMHR9V2W5BuOjkjVhmkF0F75rWgRTQW
 7II5m9q6uCw7mK3DYVBTzWTMOxdVfEvCX/YC8nzw0Y7Zh5whQXMu6At3LQjji33XwMM6Tu+nO
 nKxlfEAsbm1WKFRDvC1tlQ8ViHGwN7nZHTB6UHcMqYDiB6GNR8DyUivVmvvWmS9BpvRc1Ogv2
 hAv7kkXm+pYj1OgZF/S3voVjx9R1CePqXubOVHNkEmdOWiYmUR5HhAqA+G3srcRxL2uMgV25H
 E7aodzzdehBDo1q7MnZsvBdtfRfKVjQZ55kzKHa8lSLErlZ3tPuYW+YDqePLzI4fpk34L0/GJ
 em0fUe0jsiKcefAl3Q+eeOBqpT9NTrWxfV3f/vasST57//Y0alqy6m17Iw6zw0XsyXHhRDs1E
 AgPvUxLOTNuGCcbILCW/EdpMr96VtOfJEDUtrLjK0ggh58LN3sgCstxOGeFXqwRR05MtaCOdW
 ythAFYEKX4WHIEAILJ9+t8zQ==

Am 24.10.24 um 00:03 schrieb Guenter Roeck:

> On 10/23/24 13:12, Aleksandr Mezin wrote:
>> I'm a Russian troll. So remove myself from the maintainers list.
>>
>
I am assuming that you are not a Russian troll and are instead offended by
Linus comment regarding the maintainer de-listing.

Lets just say that i too do not like it if someone calls people "Russian trolls"
without any proofs. And i too agree that a more open approach regarding such
decisions is necessary.

It would be a shame if we loose maintainers because of this. Is there something
i can do to change your decision?

Thanks,
Armin Wolf

> I will not accept political statements into the hwmon subsystem.
> Please chose a different description.
>
>> Signed-off-by: Aleksandr Mezin <mezin.alexander@gmail.com>
>
> There are no "orphaned" hwmon drivers. Those automatically fall back
> to the hwmon subsystem maintainers. Please remove the entry entirely.
>
> Thanks,
> Guenter
>
>

