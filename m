Return-Path: <linux-kernel+bounces-334587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D8D97D950
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B35EB21077
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6533917E008;
	Fri, 20 Sep 2024 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="PwNEEdqD"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE2208A7;
	Fri, 20 Sep 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726854164; cv=none; b=rNju+jhyblWhBxnUryA3nc/CuTGwcReF6g9JGZIO5csdZ9Kgpe3rZHOc6lTBT06xiGD0T7ucecYXT6YU2BmM5Wi2emTQsTn7e29cfIZM+6z0IMzVaTJnmcwrmb4tJwUg85j7hHT9WA193jNyJYFWrIWj5nA8TMr3nbND6wiuVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726854164; c=relaxed/simple;
	bh=tCOxuTqVEW0KEln38+xrGkbcacePdciQqlThNP9AOKo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0OL2MVesRWRzj4yyj0/PleH3Sqdb71Yh9WjDbpsCCvxIXxYTIkJDBiqzLQzl+Tjnrzp0JSrj6ToHzK2ufHsF6jBWlGMqI0AoDDCLnvxXV9KX/9pE+/WNT/FoKwcDw6Cmdh5HjFxol/kk2VxepKbxiwR+jf36TqD6abvs08KYo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=PwNEEdqD; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C8BE5100006;
	Fri, 20 Sep 2024 20:42:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C8BE5100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1726854155;
	bh=X6EHn8z5k6HYDfoR7/scyo68ynR2g/nJcShsQDoZAow=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=PwNEEdqDOE05dgCtdJZs/jKCyKstNBkfp580//dMmPdlBKpHYNNliShjPSZQcn6iq
	 39yZs7DcMtTBWBZzCoKaVojrEpp+0BB03WgnPbjzhOlumYJfyWDBc5wpOO4PDmTfKx
	 eUqW6cgAQ+pltQ5TaBU99hox19C0brEYYDRJtyDqN31OX19gKcCYkrXMzOZLm3ix1K
	 Xp/J5EZxs94qIhXwuYH32Rgf2imIwLpcW2Bn8IJ+raMhWow5PcILZAH+Wl7n8QSDG6
	 vxMF0MKAnA8oLEcZfyE6uljho93DYEb/UxTJPGdmBq8CeexynIkDmfNyRhCVkp2vi6
	 Z7NWxkQDg7VNA==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 20 Sep 2024 20:42:35 +0300 (MSK)
Date: Fri, 20 Sep 2024 20:42:33 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	<prusovigor@gmail.com>, <kernel@salutedevices.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] ASoC: dt-bindings: Add bindings for NeoFidelity
 NTP8835
Message-ID: <20240920174233.hisfcfb6pgtqzyfp@pc>
References: <20240709172834.9785-1-ivprusov@salutedevices.com>
 <20240709172834.9785-6-ivprusov@salutedevices.com>
 <4cb531b8-5ea1-437f-bdb0-a49f7799af47@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4cb531b8-5ea1-437f-bdb0-a49f7799af47@kernel.org>
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187889 [Sep 20 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/20 14:03:00 #26646385
X-KSMG-AntiVirus-Status: Clean, skipped

On Wed, Jul 10, 2024 at 12:24:33PM +0200, Krzysztof Kozlowski wrote:
> On 09/07/2024 19:28, Igor Prusov wrote:
> > Add dt-bindings for NeoFidelity NTP8835C/NTP8835C Amplifiers
> > 
> > Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> > ---
> >  .../bindings/sound/neofidelity,ntp8835.yaml   | 65 +++++++++++++++++++
> 
> No need for new schema. Just put it - after testing - into previous
> bindings file.

I am going to add some clocks in next version and there are some
differences between amplifiers. 8835 uses separate master clock, 8918 is
clocked by BCLK. Is it still better to use same schema with anyOf, or
keep them in different files?

> 
> Best regards,
> Krzysztof
> 

-- 
Best Regards,
Igor Prusov

