Return-Path: <linux-kernel+bounces-327430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BCD9775E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE081F24879
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B78B623;
	Fri, 13 Sep 2024 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="apVxy5ZZ"
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD709376
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726185818; cv=none; b=U4sD10WR8+itfSvoODXx6f/9Bx3CI34XHwP+Qrat3pTQgsmxRuUJcIPm4w/i0FFCkmR79NSozZqPxSDoW4IU5/tg5kK6oXr/LuNMQ1Hrt7UPjsEeopLBYjRUPDIH0uXq3QPjbHpSlaYhCseX3o8+TFnGYRR7ixsMfuEyregm2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726185818; c=relaxed/simple;
	bh=L8UuwACrjIlci6pVnHp5gUQtK4BTpDJJIaEpVUHIbLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppdnZjmeJ+ltv6o8jrJoUXirdcmUdPN3r2kBjI8170/8f1XLPqHcdgmfRZ69x2m5yDjtOX4RrPvIyweXGk89y0nrFE9c59bMGSP7rvz2IXC8rZV8fKF1D44duC0+Wi2B8xYgVVS9lYDQ3UnySVqK+qw0wFhK90fq/NWtX8QTUGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=apVxy5ZZ; arc=none smtp.client-ip=17.58.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726185816;
	bh=FmIGfZyH/DV0K8QZSkGSqqgovRptSxi0Ip7aw2bM+f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=apVxy5ZZYQE7pwcGfDiKddtbMfm7c8dReWsU3aVNIpVbBSt97Kr8hxzPbZGFwz8l+
	 hrJRIzAZqiWrUtShJbHTStz46YrBFxWXmx43sqYE1boDMD3P4BtcO5sK8mnpehjmYD
	 nIZ+LIXdKxDQLZercaWPy2nYLGcP/S6JcRwlUQN4DGwjbSSaAztsSZzUUcok1y9Rdh
	 EHtLSuuR1zUbDr5Uc2eEAlt5COdsCdetL+GDhznUeopJIL1mahEbyk42xcHHi9xErk
	 cWumvtu8HjQ84rXWRJ3oWwQsfyaU3a7RZWV5G4a5Cx/a2aAjBacW/YCmwtgclNQ1Y4
	 mI8ADAMAHlXPA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 539EE2C043C;
	Fri, 13 Sep 2024 00:03:32 +0000 (UTC)
Message-ID: <f3887bd7-3a30-4093-99f5-a52e3a3c513d@icloud.com>
Date: Fri, 13 Sep 2024 08:03:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] driver core: bus: Correct API bus_rescan_devices()
 behavior
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240913-bus_match_unlikely-v2-0-5c0c3bfda2f6@quicinc.com>
 <20240913-bus_match_unlikely-v2-2-5c0c3bfda2f6@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20240913-bus_match_unlikely-v2-2-5c0c3bfda2f6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NGrUBEC9J_FhmSWKwVyq_Tly8-jfAvGK
X-Proofpoint-GUID: NGrUBEC9J_FhmSWKwVyq_Tly8-jfAvGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_10,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409120173

On 2024/9/13 07:45, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> API bus_rescan_devices() should ideally scan drivers for a bus's
> devices as many as possible, but it will really stop scanning for
> remaining devices even if a device encounters inconsequential errors
> such as -EPROBE_DEFER, -ENODEV and -EBUSY, fixed by ignoring such

Scenarios which encounter -EPROBE_DEFER:
 - amba_match(), as bus_type @amba_bustype's match(), may return
   this error code.
 - really_probe() may return this error code if any of a device's
   suppliers has no driver bound.
 - other functions called by really_probe() to operate device related
   hardware resources may potentially return this error code such
   as pinctrl_bind_pins().

> inconsequential errors and continue to scan drivers for next device.
> 
> By the way, in order to eliminate risk:
>  - the API's return value is not changed by recording the first
>    error code during scanning which is returned.
>  - API device_reprobe()'s existing logic is not changed as well.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/bus.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 4b5958c5ee7d..fa68acd55bf8 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -58,9 +58,6 @@ static int __must_check bus_rescan_single_device(struct device *dev)
>  	return ret;
>  }
>  
> -static int __must_check bus_rescan_devices_helper(struct device *dev,
> -						void *data);
> -
>  /**
>   * bus_to_subsys - Turn a struct bus_type into a struct subsys_private
>   *
> @@ -797,15 +794,23 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
>  						  void *data)
>  {
>  	int ret = 0;
> +	int *first_error = data;
>  
> -	if (!dev->driver) {
> -		if (dev->parent && dev->bus->need_parent_lock)
> -			device_lock(dev->parent);
> -		ret = device_attach(dev);
> -		if (dev->parent && dev->bus->need_parent_lock)
> -			device_unlock(dev->parent);
> -	}
> -	return ret < 0 ? ret : 0;
> +	ret = bus_rescan_single_device(dev);
> +
> +	if (ret >= 0)
> +		return 0;
> +
> +	if (!*first_error)
> +		*first_error = ret;
> +	/*
> +	 * Ignore these inconsequential errors and continue to
> +	 * scan drivers for next device.
> +	 */
> +	if (ret == -EPROBE_DEFER || ret == -ENODEV || ret == -EBUSY)
> +		return 0;
> +
> +	return ret;
>  }
>  
>  /**
> @@ -818,7 +823,10 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
>   */
>  int bus_rescan_devices(const struct bus_type *bus)
>  {
> -	return bus_for_each_dev(bus, NULL, NULL, bus_rescan_devices_helper);
> +	int err = 0;
> +
> +	bus_for_each_dev(bus, NULL, &err, bus_rescan_devices_helper);
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(bus_rescan_devices);
>  
> @@ -833,9 +841,13 @@ EXPORT_SYMBOL_GPL(bus_rescan_devices);
>   */
>  int device_reprobe(struct device *dev)
>  {
> +	int ret;
> +
>  	if (dev->driver)
>  		device_driver_detach(dev);
> -	return bus_rescan_devices_helper(dev, NULL);
> +
> +	ret = bus_rescan_single_device(dev);
> +	return ret < 0 ? ret : 0;
>  }
>  EXPORT_SYMBOL_GPL(device_reprobe);
>  
> 


