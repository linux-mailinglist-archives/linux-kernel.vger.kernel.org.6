Return-Path: <linux-kernel+bounces-299923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CDB95DC49
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 08:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4A11F23B7E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 06:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3169B15380B;
	Sat, 24 Aug 2024 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="FvkssMyK"
Received: from msa.smtpout.orange.fr (msa-209.smtpout.orange.fr [193.252.23.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA471514EF
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724481317; cv=none; b=gw2SEb3Vs577zRcr205GpACsSIwbfX0swjGyVYjSRtYGjfQ6ik/8Lb4YskBwDk6lA13IXT/ZYFGCGDxEAD6oSD6oIr09J86jCqjqB3bOk5bM9J2iJ2NeUkrdkNH7Fac/qMu4Lde7a4hz9qG9pUcs5P6Rr6sZUfKw4Cc0m/Wy5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724481317; c=relaxed/simple;
	bh=TMgOLqfm30b86e4ts78f85wexaylim5TyQN7MaiIe6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdGhC5UQd7TU+UNyimzAlM8S+0o6JCV95yZcuvG88l2ym0X62vaPVA6VzcbdOPqEgYPSAEYw/u06FAZzRv8Aoysn69o+hmz9CdBF1pLCh5FeMZgYKmqzClW/62QhFUNda6+/vGR6QgvyqDP4lR1lavLEMBxT9m+sAapC9v/bakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=FvkssMyK; arc=none smtp.client-ip=193.252.23.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id hkMasExHFZ40ahkMasoNh6; Sat, 24 Aug 2024 08:35:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724481306;
	bh=IQiQE8ZAQ9sR54pSRg1laMkFOYw/GV3RVSf0chmw70Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=FvkssMyKKbtvTjFBaVy3HTS8GkfFynWH7jhyv0nUCxq4+Cy8a9bkg+bnysYnxnuC+
	 0czd8gSL3fy1ukfiyFgvVTixm7V2dEbapg0Egi2/WeP3o+yYZozDZlIeCDuwZ94RS3
	 qBFYCG58IarylkSwnP5Z6eReAtzDW6NQ1GUKvbsj7ehe0jfyberviSh+WqhUV2EPdF
	 MZYzGlOBTQw1+sq8nFKJfCqtrfZGVoKBvbKc6LVMH253McVgnjKEPvUkjxCTCsOvTb
	 zV9fu4DpW8hNBF3brwKK5QjLCV/y9dEu6E4sEkivkSara13O9dprMRpwbJmBm/brB1
	 aEXRTXlIhlrBQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 24 Aug 2024 08:35:06 +0200
X-ME-IP: 90.11.132.44
Message-ID: <77e4dd0b-2c82-4f00-92a3-069526a5f795@wanadoo.fr>
Date: Sat, 24 Aug 2024 08:35:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: Replace strcpy with strscpy in
 rtl819x_translate_scan
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Abhishek Tamboli <abhishektamboli9@gmail.com>,
 gregkh@linuxfoundation.org, tdavies@darkphysics.net,
 philipp.g.hortmann@gmail.com, garyrookard@fastmail.org,
 linux-staging@lists.linux.dev, skhan@linuxfoundation.org,
 rbmarliere@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org
References: <20240820184216.45390-1-abhishektamboli9@gmail.com>
 <2348e646-e1da-4deb-ab55-c438a42e25b3@wanadoo.fr>
 <510b12b8-91d5-43ce-a191-9ee0a6c91460@stanley.mountain>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <510b12b8-91d5-43ce-a191-9ee0a6c91460@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/08/2024 à 20:23, Dan Carpenter a écrit :
> On Tue, Aug 20, 2024 at 09:38:22PM +0200, Christophe JAILLET wrote:
>>     - if a "mode" matches, do we need to iterate the whole rtllib_modes
>> array? (have a look at wireless_mode)
>>
> 
> Can only one mode be set at a time?
> 
> regards,
> dan carpenter
> 
> 
> 

Hmm, apparently several can be set (see [1])

Base on a few lines below, it looks that WIRELESS_MODE_N_24G is 
exclusive from the other ones.

So the 6 char array seems to be sized either for "N-24G", either for a 
concatenation of a few other modes that won't exceed the size of the buffer.

CJ


[1]: 
https://elixir.bootlin.com/linux/v6.11-rc4/source/drivers/staging/rtl8192e/rtllib_rx.c#L2200

