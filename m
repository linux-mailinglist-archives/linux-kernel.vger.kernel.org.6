Return-Path: <linux-kernel+bounces-320268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF0A970830
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E855528209C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C57C171066;
	Sun,  8 Sep 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="n+wVjpVc"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653ED14D2B1;
	Sun,  8 Sep 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725806212; cv=none; b=tysH4y3l5knkM0Ntd+1gkJFvi44ffLHHNxL2uh3mmkXUVthBAVljAa9E1oV88liki8w+K/Q8lrSVALPDm29k8K22xwnpGL/5ppGdezC39GTvzpKri92dv0M8+KneHKjDAxNs7c26cxu/S8PSNwE3ofzGS/LS3MxO0G4QsZcweTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725806212; c=relaxed/simple;
	bh=+tmuSViIzgI9LQwEqm1b7FOa1w5L94xTKX6ZQo49r94=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=e0H5LdZBkCSjNKEW5RneMMb1wkikKxlvEbJKAqIZhqrobnPrsR4/NAAUc9YStCDrTqHo1O3Km1hRmhTCb1wUvDu3JazHa5AH0jAD7rWjOvz6cIFYy9ICCkObozEog9/DnPYvRaiJRwpAwiZ3POHN0w+CZ8cD2nKwe7Cih+7QKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=n+wVjpVc; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725806170; x=1726410970; i=markus.elfring@web.de;
	bh=XWFEP7tM0wjf6p/5JrHRs4l6Fd8dhOljCSScjquiSzE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n+wVjpVcHBNz7B6SZPb1L5lTm3hkZKvp9dKeL4rENyJPQUyMwX4xM9eEZZm6zwgF
	 ydiLlhhlGh3PFCPat3al4NHM1J6exLZnLJ9r+UyQt+YU5Rohpl9U23VqMwH3WqCAG
	 pKjP5tsD8NSpwVr2exo71bVcWsNJ4Nd3jRryxbw0N93Nf7lOxonnoJmzuSaGZz6a6
	 jtym8vGTTMlv1jExiXbFwCEvFWe7I+XZLjjq+bzClXJQEARP5mrA8fLIAA5n6BAqF
	 xsw/HPEK+zzigFfG2X2/ir1Sz/6+64dyRezJiYfzbw8z5NZLwCPxLBvL3+tYu9wNS
	 tvQloEhuNHYNhX7uQQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiMAO-1s8zvA36u6-00degp; Sun, 08
 Sep 2024 16:36:10 +0200
Message-ID: <066bcaba-8f3c-4afc-82ab-2c81ca4ceb95@web.de>
Date: Sun, 8 Sep 2024 16:36:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tang Bin <tangbin@cmss.chinamobile.com>, linux-sound@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240908134604.3652-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: codecs: fix the right check and simplify code
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240908134604.3652-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a7FM6yZ9QUWzf/F+7OQlgqI+RPBwRznUxoEiTyvs9GStjPkkDS3
 pJ30zCb83RU0kFHMns9th5b/rrR4+SaGttAqqSpAJuZiMOsg1mBN50c7GhMv4ulwBw1dK4g
 zEkWNQaav15zfxV2Hbcs5cH7T5Av7zFlMVsjP97sOjuHMKS5J7HwHudNnjw1BVaPHbAmcVj
 DZ74lMaLKmHyFpzH40mew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n267RWK3I4k=;KlNEiHzhtpd99sO6EPmTY1/PasZ
 dJL3Y4CB1rWrf+B12jmN5CmbjlUlVDCBctU5tbHr7TBH8RssepNjtm+aNIlmwRpk+KM1DkkQc
 Oyg7n4YTqIysk0xII3pZdczaeZqescknVROyIhmzzNxwX40rraNXTPhBMe9u5/1Br1GYhXXN8
 QVDJ+nONa8xE0QuOxcOdkuCu95Ew3ufK2Fc64vo9XkptQcmE7jQqMz9gi2mCJXCDlLR2WT94K
 JPTvCE58YiWpgg+MAEA03sqCSqUhy5Cl+aOUK3h+oSRVJiNsAM8HAP5YcFqj9LGjZ6g+xy+0C
 BL9sVMydA4dc9SumiogAu1HpNHQEAj7EDI8q1vqTwL21kuuHq+jae1o0Fm6mzXCqjSXrBYRb5
 /3N2390+C+5GM5RIP7UwnOr2noK8ffi5oUvhuF0vvvuon2569IF2k+4V2aLPC26WdPl3Gb9n8
 G7mPCmovI5m1OXvafba2Xuq9Fl4WXJuMb+eEGu2OeCVaYm/Pgp8rqRemGsuJn8XqxDwjjxUcb
 L00S6ZPLygOetYn2g8Mqi6GU4OmgLBdf1m3FKmj7Xt9qCAaQr0hUHoMlAbQmhIJ9BMFp+sP3a
 KBdMXOkVCVwQuYjv9b6A0cFx8wZHIJ2X4L6Re5C50TfkwOYMocfLmBP6iKBqs1aHL+6YaFnT0
 KwFsXXyOqEgcUo4LoAMmyd0RRIXKsbtnDaMGyoP3peo9YVKhWlWH9o0HtdgwJ+d/qzYy9T3oo
 /7QAf1e3QGBhRaSiOmYoAIxuv4R89JB9tcmOMYHQ+aXNvuMgEAHDPhgSWi/X4zBG3dV/+sJZs
 ztLk8u5BxGUIJx64vJ8kVdZg==

> In the file drivers/base/platform.c, the return description of
> platform_get_irq is 'non-zero IRQ number on success, negative
> error number on failure.', so the check is wrong, fix it. And
> when get irq failed, the function platform_get_irq logs an error
> message.

1. You may occasionally put more than 64 characters into text lines
   of such a change description.

2. How do you think about to split any changes into separate update steps?
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.11-rc6#n81

3. I find the wording =E2=80=9Cfix the right check=E2=80=9D confusing.


Regards,
Markus

