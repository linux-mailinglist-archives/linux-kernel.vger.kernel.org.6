Return-Path: <linux-kernel+bounces-216935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7B690A8C3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29E9B27DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4F19066A;
	Mon, 17 Jun 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Z7WrvZrG"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D5190463;
	Mon, 17 Jun 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614185; cv=none; b=b8qdk2MyesBB+2z/BCv/CO+cMOugJJVu4XFp00dp8wpr9uAjjbRpfSG0B/O4KswZc3uYCeCmaw3caNoixX8zxym7xV9JnBfRRdbHpALCZVvJvoM2yuU0V6oOwtgauFfvUmPYnlc4ajh3TFLiJ5HWoiG7xEpcopDR+dEyGo9t3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614185; c=relaxed/simple;
	bh=xG3H4SUiJTh6xwopJFfd72vmoAk7JKkimOYJ3eNKzM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhKmkhBnkx2CCyk4rfK3OTGq8DZPpsAiVKQmPI147TQxQjjjyCRwhOEm6+Eou8Ko2owupj8+PFO1FNe61A+A/BGHrkvmRUMR/hzRdnX42h/pxbYG7+Ss+sf9ctPX+IIAecg6UUMvr0BG4MTpephH28Lt7G9gIwrT/vvIdn+ZKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Z7WrvZrG; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ASHs9FmRI1GdRpdQ4G//vd+YFqsUwo8o4b/Ho+LAxY0=;
	t=1718614183; x=1719046183; b=Z7WrvZrGGEUEnWEWr+yejkJVzurPiK6VkPUnOXI367/CxQN
	izmAw8W2i0h9AVmGaIWKy1+JMTcamkKeBcrWDvlTwJwgj91MA2u8ahqNJAnNY1F3pFWhC1m6ikuVM
	n+19hQ1Lgkgx0W/ni38ndq4jTWOUvUO5jRJBuk5Qb7I7EpnYihNIuBTG4VC5TAxw2f8JqG9ejA+Q4
	oiHB+0zUtlbSFFCap3MLRqfEA1oHOGmfanHNHhTEBHzlkj4wC4OJlVaBYjcRbcCyVl2CfesxldoW8
	87cYBPqGS6UEtjryP7JGp7bYhNAED2KKfKQsXrBSJIBIaDadbu7A8jmCAUosTUcA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sJ83Z-0008E4-9Y; Mon, 17 Jun 2024 10:49:41 +0200
Message-ID: <50be24b4-54d6-4784-9ab9-83a90bf91a9d@leemhuis.info>
Date: Mon, 17 Jun 2024 10:49:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: pmic_glink: disable UCSI on sc8280xp
To: Johan Hovold <johan@kernel.org>, regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
References: <20240608114529.23060-1-johan+linaro@kernel.org>
 <Zm_sJb3_xfMgLsnj@hovoldconsulting.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zm_sJb3_xfMgLsnj@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718614183;2c46ea1d;
X-HE-SMSGID: 1sJ83Z-0008E4-9Y

On 17.06.24 09:56, Johan Hovold wrote:
> [ Trimming CC list ]
> On Sat, Jun 08, 2024 at 01:45:29PM +0200, Johan Hovold wrote:
>> Disconnecting an external display triggers a hypervisor reset on the
>> Lenovo ThinkPad X13s since 6.10-rc1 which enabled UCSI. Disable it again
>> until the regression has been fixed properly.
>
> I noticed

First off: many thx for telling me about the problem!

> that this one did not make into the regression tracker.

FWIW, it did:

https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240608114529.23060-1-johan+linaro@kernel.org/

> This
> may be related to the fact that this is the second time I'm disabling
> UCSI on sc8280xp and apparently I used the same patch Subject last time
> so they end up in the same thread on lore:
> 	https://lore.kernel.org/lkml/20240608114529.23060-1-johan+linaro@kernel.org/

Kinda. The thread is not the problem. I told regzbot about the subject
for the fix a few days ago and it then dutifully looked up if a commit
with that subject ended up in next or mainline already. Which normally
is the right thing to do -- but in this case it went sideways for
obvious reasons. :-/ Not sure yet how to handle that better; maybe that
falls into the ugly category called "there are bigger fish to fry,
ignore this corner case for now".

Again, thx for telling me about this!

Ciao, Thorsten

