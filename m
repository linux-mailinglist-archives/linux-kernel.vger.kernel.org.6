Return-Path: <linux-kernel+bounces-354561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB4B993FBE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5AE286E2B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE551E008E;
	Tue,  8 Oct 2024 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eBpqGMHr"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03816BE23;
	Tue,  8 Oct 2024 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728369207; cv=none; b=FogJoQcaAFRA2X0CnD+12JgJ+WAq1+UaiFb2XFgEhmxeyggKoKUk43ivIVTK7iFX9AvDnBVR82Ph+Dhk7XA43B8h99/VDwiCBXEAv1+wG3PQhgjSefkp0h8YIe6tRp0j5JXqTxCEx2BYx1HQfgdPHJqxnipDnrPMjz1a2C151fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728369207; c=relaxed/simple;
	bh=AGiKsKqYURIRcYEHc07f7OpWqEU1xXaxaB2Q38FeP3s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=PJ4D8STI9xFZxBVHAngDh0BxM8qB19fb8p5wzpF6qnQsSJdbqBQr853LRmmHiBRW4IHePOsAcwnniGQnf7UB7JRzUM9GXZkkbMlvn9qsq3883N3Ubr2UvvjIrWukzOLOKbpsuDi1ND3V3T6d9JSXkFDuw5pmgDv9zUo4JeMC1Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eBpqGMHr; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728369156; x=1728973956; i=markus.elfring@web.de;
	bh=+8/DjBb6G191vWvg9e0+8zi9zIgQXVjAWUYynL1R+64=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eBpqGMHrkNpi8BZjZfZZKXBcZj38aPySql5EWi6pYx6HGdvcEMKMmc0t4GYIgBbz
	 3sN+ckHGFQ93mwWnWM/3mD//jj/9ySUSrDlkAWn0Hq2WRDqLwOAoGoAwLnGMIsZgM
	 6y39m/+KMdu4Vc5P8U8MjTz+FaZbvdyrp9kyQ+Xaa6e0RjXSgRWX56Cbgqw04CU2A
	 EkJ0l2dJsc5qCyWJDjqfGujV5p4YrVxt+PHvO6Ww7gqsOYiuONYe/XyyYFcGZp65O
	 4IPkKRtsiEb1wt5+U+fQt1Y2a2chtMT0fLUH48W9Hw+nyOdj+SxgblRkTjcMNsjl8
	 xO3f7O6hCUtMnSwRqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuFD5-1tq2XJ2Nxt-00rqan; Tue, 08
 Oct 2024 08:32:36 +0200
Message-ID: <6849d647-0240-4d3b-8f35-e4e65397e389@web.de>
Date: Tue, 8 Oct 2024 08:32:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, linux-sound@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Weidong Wang <wangweidong.a@awinic.com>
References: <20241008025923.10606-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: codecs: aw88399: Correct error handling in
 aw_dev_get_dsp_status function
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241008025923.10606-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xQ8GjhIGSUnP/T/491P0cple+s24opNwPQbB6DQep1dL5sCkHLl
 c8OHbo/vf4raBw0loh8Qs0foGPIw52ywV31tHfe+fViTkILqsJQdLdF+soer5P6YozKm4tv
 /kgfisJHQeuIogk3kk4u025e9VDK2o1sjmzw5YpDtzPhiM864EGJ4ou1JSxuGA01vNyhhNO
 /Z0rxtY9BkR7Yywc0v+8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2aMQYqS48bA=;smIuq31sN7FgPV93J/wA4GnBTMn
 9mcToVMq4L5K/kQNbjFKkLHDXb/GpAmxkjvS3/xPDP+mr22Fp6bah8O1eMVIxJC0XvszzFjON
 gUeZSybRmNI7mIwcTfzbwANg/809gHRfnao4OfxxfqjTu6uLBiCYXWCOHTJ34NjtlaZLveMUs
 A1Eh+X8/n+u8xewPqw/lu0qjw9rWc/IBIg7sexwhBG67obiCzGl2zFdfWZwKpO0DVLx+usoE1
 5SBzhAWIHPQI4QmyPfnfvRVZH2YNhNbtsVwYJsgHwvrTph/Pj8Pma/byTJ75oddJLqMjxjlBr
 6Sgt5XUApaZ3ESVclPbcplKgOj7zzCQ7ObLDcvp6l7Jx80Lh8mHKQWtDMHGJH5QjCQxe8O10N
 7L6ExkQdgqA/Jz0coY/pnmrlq2QNuq27qQcWpi5JaM9BG7Ysu/oII8PnASsvNNm9QIazdYp5f
 stag9YYsU9mPsIcLVYrryGYXibWcGNCTPFc0kWwKGW0q5w7F2j2OdeSZKYaUUsKcARNUVQQxA
 OS4m3Eqymp1ZRNCq9Vx02KOAsDXINJQnyoX8so0MYncIWLYqFXFNCqpAC+YK+oAzlUErpjBX/
 NIZ+ZQdgTLuK2wHsmXlRqzdUNimWQ0gHz6m+5glyz/aqBEL78/+FJqrbSjJnhPFA+sxll4lGm
 IK2TGiyVyfWGPxEvHuHhANt4+XgdmVUCDPI22b0RAig+Gzt6EZpp7Tx8yvkmfTkWFGZZD1VtR
 QfNAz3H0VYMvWwd9Cs+bHTikz0YTtF34VuKY+gbDBKAv3uKU7RaGwthgl6XrAX1EpHzRwdNNn
 7u6xBDdh0UNGjzsAkVhu3T0w==

* Please check the subsystem specification once more.

* How do you think about to replace the word =E2=80=9Cfunction=E2=80=9D (i=
n the summary phrase)
  by parentheses?


> Added proper error handling for register value check that

  Add?


> return -EPERM when register value does not meet expected condition

* It is usually preferred to end a sentence with a dot, isn't it?

* Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?


Regards,
Markus

