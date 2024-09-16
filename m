Return-Path: <linux-kernel+bounces-330347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B216979CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7565281BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86061482E6;
	Mon, 16 Sep 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TKIgX6pU"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E87413E03E;
	Mon, 16 Sep 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475927; cv=none; b=dR1jxOJls9xkAjkUEGZx7Alj4at1XMa81JM0UmYcKujJZgBVblkLStZXR5npegY1xlVyLU6gTueZJIMpnpeVCClxiJiKsIq9FaoRymwmF9Krwh7rLQ6jc2WXs1NwbYC935aygALY0BK7S1HwJ9Vg/lcjE+xrgfIdm85MqG0CZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475927; c=relaxed/simple;
	bh=QbdMdfEPEYw+igQH+6jkOETxTCZSyfaJXjFUukLyQws=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nLJHQa5gUZNZ+3YI/WsON/HPSpCPDW6MaND6ipstmu7rK23ITPJMCVQ7EOCUiytu1fFVQuc0o7E34fvmHLhrPEKe673JAiNDc49N6KVI3Ozt1gIU4zlUjVgAacWJjf1aYdAaTW0hAHpYm5waM/iPtbuST9VEi/ORWwvui+KY3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TKIgX6pU; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726475890; x=1727080690; i=markus.elfring@web.de;
	bh=w+kKjiklDfz5dRPofkF9D2ZUfBBni1MS+qVkawjJpEY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TKIgX6pU5mFmAYzl1r0g9IibvUig3gMFrkBWbVF2vjgGU/xHey7OREzC6F4Sta/D
	 XCP8arjAS1tqGzc0mqafiss/AV+42i8UqARK/jY+VrkR/MbGEtFtSoMKexwKcu1ms
	 OAeAsg/d6gSYPQ92RK6P2xmzYT5fmRDGZz4+M6X48G9p8KcbneaNn6coVVhz6O2+Z
	 jgeyX6eH61dTNqUbBnBxXGkCcRkLOUcjIMV+hgsgGJ2qhAz17kWVuAR9eFxJM7oEf
	 UP8+qHOlMhkmbgitb5sTMq/kWJ2qhW04zeOv1qJ+bxDwm3mcgm4emsOMBlDUvaVAe
	 ZHa3gFMGT35JrMAB5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRYd-1sXccj2L47-00YSbQ; Mon, 16
 Sep 2024 10:38:10 +0200
Message-ID: <a7ce512c-0f82-47f6-89fb-f7269e4fdfae@web.de>
Date: Mon, 16 Sep 2024 10:38:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] ASoC: tas5805m: Adjustments for tas5805m_i2c_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DwubGJ9VVwlrPf3WsgtHhElQdPkUBQd2yoYm8jeq6rXCACSe9th
 60MXTaqsmjC7LsvwVBZrwPZ6OsbNWoEoREAfdR0HFvQ7LLW1dP49NhRw6sAMm2NzQFXtU0f
 LHQg91fZxbvOQA+SeshwDEDJSHGn9ZIEiYnBs4PG/oq1k5DUnKoCSAyoFyk2KQv8i4R2laV
 BN/QSVRvFxjGlJglN/R2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lXrZlUSTZ6g=;YST13+wL5VtBqJEjpbMGJVPAVBJ
 5v6cWMGTs0d1AobGusx1gzytqDAXPcOEeU7P0cGbx0sp7jjULd8X+HwBJ1B2BWg08u3mUf7em
 fl7EP5bsPE1b8vuFwJ1z3j8j2mp0uRdg/NvwFnQ8QZ6QyC239eSx/Ifm/JttUTPVT0TQTCQS9
 KPYBErtDAOK4QZcgJ6mSo4E/HuJg2kCUdppV4ayPDko1nLWczzTzxHv4q2AxmhlR0CZN9FJxn
 TuaQ8vvr4ADCHRIlSR57XP3P+srAJ+TGLJdswf9kIvuDXr9GELbCcWKyXTzGBaWhmsY9TIidk
 QVP4SVJ2rvN4Pcmt69q3m+150+57K/Xr4LOUC9s07F2MuRvv+ZEmgEXGrBo8oIR5JcMAWielc
 NosKvSZsVXP0NoZHWqCA0VXakSFCy7F3sGo4IdhUJ9oWK/uJv1BjokYmZ4VkABSIiJ/u3WCd3
 RxTtUeE/iMFiwHgKSMQdJWKafVsICtziRekdhSnLsEqnSo+kMAzd0+P39uvBs12/UE4BwPCzK
 WvO80qLxKsfzD0PswdIjxK9Pj5ae+FSDat+dPTxUkFfuSMfA0ah3WDiqnXtXD6w2TNwJWDUZ+
 /bwx5S18OQBe47LUG6YZsg4R2reMnxbYAQiy6UPI6NGzOyl0cSgZMESWyDWoAzk+BRr3/6He5
 MTLEK/eAA7zWjpYz8LGQ2oIqO9XS5tSoXiQjeuWI1attk7GnOIUqX+RgLg+wSjqPpUjpJoXhT
 BdMClM+jwEA39lwoEjUweZNVjMcUDOTaoNOlYxcIpZS4QY7g6w6hDtCrUaeMQECOkugd2r68D
 hdAtxX/V+gDJIoldROZJpMLw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Sep 2024 10:30:10 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use scope-based resource management
  Improve a size determination

 sound/soc/codecs/tas5805m.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

=2D-
2.46.0


