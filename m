Return-Path: <linux-kernel+bounces-342224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBB4988C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0220D1F22B62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA16018BB97;
	Fri, 27 Sep 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ytzH7vyr"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B118A92D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474160; cv=none; b=dhj/NHc/6EUQ/2InaqI1tYNEP1jIBB3RBGNQlpiVOurSEAX0RFmMMakqymvwGqUJX5NkxGKeX5/zMxvGVP0YcGTe+AAy0TdPv9f+36M65KEweheAqOvQ2QNc7QNczF4SulbPf3aBSscQr4LFmmuqrwaFaMyXLd+Zy1uEguhjhno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474160; c=relaxed/simple;
	bh=ScBPzu7AlRpuZcnQVp6CaaDdval5J8mnLC6j+332lYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dk3FlplAKk1dbT8ekC2aW86leO95mWQV+k2CrrorsLgLhP81zN371LNyZYtNYgvb9fLHwbP02hoLMU1aWqUAlFgPlR/6Urcvlo9hOGWP3M0/Zar1U8+/Aq7qu7nBjVt4BTjbTi6lXjwKdnQz7CTWl+fxHoRrTx9YLuoBYiu/XuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ytzH7vyr; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id DEEA8890C6;
	Fri, 27 Sep 2024 23:55:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727474151;
	bh=E+3UYSlD414mGFPU6R05dL9aTBYOIxrQPp6O6qPC17g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ytzH7vyr84w1+nSUYd4Rh7dy1qFpX/fwqpBtChkLMkaYzbnbYm8vJHeg4uUlVCVjp
	 djKGKrSVNdwn9ISrtkC48qo77fkL4DDcpQfrDVzs9PWrYWlXsEf8nJ3JXMHoSQbXbq
	 e9VJMniPl9nNOZLxzN81y4sk/9KJTsYPUHFCaJ1iVp1yIpS3rE4SNa+WpKgTLv+Ieb
	 IAo8d+t+OzioKRFEguvXTtViTNKK0L1dtmVvJ5k0qEFCss0U3E+3sKvhPLbHzwGnge
	 eVQPuRe+1fMb9K5ESj/cZw3KzPa7dMRgFBPzsl5L58dZwHwbOuzh36H+OxuS8UJ0Xz
	 rluqpr5jzpL4Q==
Message-ID: <a9211119-f590-45cd-a7d0-8ae2d86a82cc@denx.de>
Date: Fri, 27 Sep 2024 22:05:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] soc: imx8m: Remove global soc_uid
To: Frank Li <Frank.li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@dh-electronics.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Saravana Kannan <saravanak@google.com>, Sascha Hauer
 <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240926213729.2882045-1-marex@denx.de>
 <20240926213729.2882045-2-marex@denx.de>
 <ZvbkL97Ba3CNPjEk@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZvbkL97Ba3CNPjEk@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/27/24 6:58 PM, Frank Li wrote:
> On Thu, Sep 26, 2024 at 11:36:52PM +0200, Marek Vasut wrote:
>> The static global soc_uid is only ever used as kasprintf() parameter in
>> imx8m_soc_probe(). Pass pointer to local u64 variable to .soc_revision()
>> callback instead and let the .soc_revision() callback fill in the content.
>> Remove the unnecessary static global variable.
> 
> Can you simple said:
> 
> Remove the unnecessary static global variable 'soc_uid', which only used
> in imx8m_soc_probe().

I believe it is better to be a bit more verbose in the commit description.

>> @@ -215,10 +213,11 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
>>   static int imx8m_soc_probe(struct platform_device *pdev)
>>   {
>>   	struct soc_device_attribute *soc_dev_attr;
>> -	struct soc_device *soc_dev;
>> +	const struct imx8_soc_data *data;
>>   	const struct of_device_id *id;
>> +	struct soc_device *soc_dev;
>>   	u32 soc_rev = 0;
>> -	const struct imx8_soc_data *data;
>> +	u64 soc_uid = 0;
> 
> unnecessary this these orders in this patch.
I can spin the sorting into separate patch if that's really required.

