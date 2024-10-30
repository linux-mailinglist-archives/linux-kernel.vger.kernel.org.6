Return-Path: <linux-kernel+bounces-388792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E869B646B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC071F2312C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589421EB9EE;
	Wed, 30 Oct 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b="MGknvzpY"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A411EABA5;
	Wed, 30 Oct 2024 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295767; cv=none; b=QRoPjbR11GWFfPs9iCp+3AYJVU/fa1OUyHQoakuVCfbk+dIK87C3JCnhuG0sisTo3AXuss/FobBXTI39sqj4uewz+58sluBkYSfHWB+wRIF+STOKVK6ehc0t6yCFYgw41Zhmdtp1vVa20xNmzLqiMp4fNMDXJCV7qwdg7YzI1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295767; c=relaxed/simple;
	bh=vDMFHs/mq1eFUuFa57P2oCYWH013u3ueyncoKLl72bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sn5QTwkOhpjJR0DpbFKxCqCotyJiseaj25YlQ61sOzDKYkYNfvwLiWkp12ooK/kwGQe/zr2UZGdbX4PIRUuoCMMBNP9rQf+VA9Hgb5aVIxP6w8KssLMYyvHmvefkw+QTan7MVY0tIedmqHqOnwl0+LoIqq7HH6KDgF6l33RjY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b=MGknvzpY; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730295748; x=1730900548; i=metux@gmx.de;
	bh=vDMFHs/mq1eFUuFa57P2oCYWH013u3ueyncoKLl72bo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MGknvzpYbDvmVG6Nx/4n6qnFUL1gMVwv2hhj7YQd4rO7QTQYcNp1SoyWtmDi25oa
	 uVe6CFhyCJV96wYaqXSpXPgMyIf/6BSMaHIxE2QjgEoEbSLZoufZCjWCklPXWtl8R
	 PxGsFFZbTLz5Chy5lJxEOWjGjbW8EEiGMVU9+rsGh3D+HiE3QKLDIo+LzruXVDyDN
	 rNGZwTWawRfZBxI7XTEO8v639N8Sl3SaPf5G0I0iswyHNoLRgTpkR8H4e0NUjCZcz
	 fIIsPjUm17ktP68WXmT3D1rg4m+tIrcqQ+a9Ej7Wl6GxvuexsMcW97XZWp+kxCxXR
	 vopTVrAWLoQ56BxO2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.178] ([95.114.207.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQkE-1u1WoV39iS-00uA9h; Wed, 30
 Oct 2024 14:42:28 +0100
Message-ID: <c06896d0-bf31-4dd9-a552-341b48d75521@gmx.de>
Date: Wed, 30 Oct 2024 14:43:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: remove me from nzxt-smart2 maintainers
To: Aleksandr Mezin <mezin.alexander@gmail.com>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Jonas Malaco <jonas@protocubo.io>, Aleksa Savic <savicaleksa83@gmail.com>
References: <20241023201334.250764-1-mezin.alexander@gmail.com>
Content-Language: tl
From: metux <metux@gmx.de>
In-Reply-To: <20241023201334.250764-1-mezin.alexander@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yzvYk/DLlYgkMquhPs3TR7SXSHYQ29yYvpuzHC3dqCunfsYU/9I
 Iqm8QtD3CDENR6MA2twWyXLuMTJllBj1Dkt2j+OcdPpEFJt3qF/xMfWotTAOloVHCzP8fc7
 LP9gzdG0B21vLdjSzwFmNnsXdU5PXRdHg51gW45N/Lzh6pN7KoEqggxygCKCE8+ElvalIdV
 FOgskX1OAhyPdjKW/klAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WLwoR3BM0cg=;cBDISIv995U0Sug/RagVRtAEOLr
 3bVb+vuIRrM9wATBg8wkPKRJmQ9i2y3gU5EZVAoAE9EvQH5wtkjVyXtMGzZ2ChrJhTmkaGEoe
 uWQEAl+fibZu9syi9bpl/7X6UbpqfUTp5AQx9aZs7L9azg7+T+RA6yEphCrRtFc6xmjUgOaRj
 m+OQHmUjWYZkJrwlcPAm0WraB/MRzmjxOhNHdhCNGUV6Vkj5lMrbpC2lBdewMDmwTfPNBl/+h
 lb9j3d52xLXnp4tAQytK8LHZh5Ju+3Qyf6Tn13KYwslnQ2BTwArohL4VsuAPamv39a0g8MheX
 Xm2wD7Y5hqDk3YMVeTscJgVAxbyu7Bp9W/IwWsUfwqpkEjIh4ByNaEhacFd5C3bDNi9Rx7aqi
 hHGIrJ4Jg8NmypqXRTzFfouyFu9PCAlF7OYTt2HG3o4RSJgC0fkUKGEiGFwQalBCjumlcK+Fw
 gihWpfJLcY09IyVkvzGZQe8UNyTFc5jcTlPdjKvrC8kNNsx+VClOC7g1PKb+PC5t0ZC+zxDo9
 9bxGrtSkCnKctl7W4ZxJAi/+usY2+e8NCzkvhnMIYE/1C5YmWW+3OkZofSRvw3VuxicCIum/G
 w5kUmA/h5AmC5GOHIjUJCLSWOXTVs+DkYQF5lPMXoiPAm85Bq3TDpWZUoy4yRSV/PBIT9YTgW
 sYNciZFTACppKv5OvUKo8gL6Uhbhio4cAmDOTBFhPMp/332k2wzb6JwOI3HIfL13ezxwI5nFB
 guhji5vHYwIzEFYOh4tZEymMUAv9sllc4ZDoIrPKuzf4bcmrFaQGBMQi9BCzJcU2OMIffHwhm
 DTrSmhdLEjhbwjRnv3lPWG68FqFEY42rDNNTq9zDfe46I=

On 23.10.24 22:12, Aleksandr Mezin wrote:
> I'm a Russian troll. So remove myself from the maintainers list.
Good take. But I guess you should also remove the *whole* block, as this
seems to be how things are handled now :p


By the way, interesting to see my whole business domain is hard-blocked
on kernel.org mail system (I'm a maintainer, too, btw).

I'm not even Russian (I've got family relations to Ukraine instead),
just somebody speaking out against this cancel culture.

Meanwhile, Linux turned from the most famous FOSS project into the most
famous POSS. (politware). And speaking out against censorship gets you
censored.


--mtx

