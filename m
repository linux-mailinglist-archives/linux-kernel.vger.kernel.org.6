Return-Path: <linux-kernel+bounces-366966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38E99FD03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B717D1F25CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FE45695;
	Wed, 16 Oct 2024 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="fJqbDu2c"
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A511711
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037850; cv=none; b=g1/rnBYfXhmhli+BzTOEwGoixddlNvKI3E+F0uDleS8xCid5TN9l+ybTatFL6GdeWqTAtxU+9eu1nY5Yvzrfq4zx0YysDmgl4KahNt038TfqAgKf5i68jgC5duuSKgqXo3/ggLDlNznNqQOLDcRCs+JY+D2HMT9Z1M7gZ/7gewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037850; c=relaxed/simple;
	bh=LDqjVq1XQh0F0sOn2t6JMafqRzkK3CzTC8at+XyzOuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVel/8dV0puGcrTVsbKxXBrLjvHls1f1/ncfd4SgJ6Ezq05q/Xpeo+un2JyvAgONuR4+bnv9ejy9fgJ7X0E6PhGifFtIR/cpYI6TapIWc58bETsKnEn2mVQY/rGSxZo54JLuO0rVD6Un7gjBM3x8Hw7XCB+kck33XkyAfe0zFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=fJqbDu2c; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729037848;
	bh=sjf0l1f2oxkkDUoPoT+WcZDLjAqSG4noEYQ+5/9oSYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=fJqbDu2cNWuCpBvY4EGGpaqZrtRqqLkbzl+Uc7mS81k9eR2alJPdCGbR+1araG07t
	 N93/7BQxGh5Nz6SWtV+Js2ZGZQAY6JWUHM9ZlvfDlAN6hf5+865UuQqwlNJmlf9EuQ
	 DSiCLD3Yr1kYO/SfaLwpr5aNztT0mgtBSIiMknBCVWFh3ddzd/B0wFvlD5zsWEHv/Y
	 yuVxJeQxye76juZ33kKzo27viTMw8sr7LaZdO/sUGq4jqiXi6D6TwkPqFfJGEDUBYt
	 RJpmeIAEWYtYMlvJ4uAyeegqYzOeGe4AAeRmNTCULRqqZ6I24SfCfrqQnIZr9v6EUT
	 4zCbezxVEgREw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 6F39534BAB31;
	Wed, 16 Oct 2024 00:17:25 +0000 (UTC)
Message-ID: <2f6d0ffa-89fa-436d-b6f2-f213d9dda8ba@icloud.com>
Date: Wed, 16 Oct 2024 08:16:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] driver core: bus: Correct API bus_rescan_devices()
 behavior
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240913-bus_match_unlikely-v2-0-5c0c3bfda2f6@quicinc.com>
 <20240913-bus_match_unlikely-v2-2-5c0c3bfda2f6@quicinc.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20240913-bus_match_unlikely-v2-2-5c0c3bfda2f6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rP_MHqZyHg5LCxytK8-6OEurV6YChs2w
X-Proofpoint-GUID: rP_MHqZyHg5LCxytK8-6OEurV6YChs2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_20,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410160000

On 2024/9/13 07:45, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> API bus_rescan_devices() should ideally scan drivers for a bus's
> devices as many as possible, but it will really stop scanning for
> remaining devices even if a device encounters inconsequential errors
> such as -EPROBE_DEFER, -ENODEV and -EBUSY, fixed by ignoring such
> inconsequential errors and continue to scan drivers for next device.
> 
> By the way, in order to eliminate risk:

The only change for this commit is to make the API scan drivers for more
devices for these inconsequential errors, so it should be low risk.

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

Also remove this check dev->driver because it is redundant since
__device_attach() also has such check but under device_lock()'s protection.

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

which types of error should stop me from scanning drivers for next device ?

is it suitable to ignore all errors here ?

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

in order to keep return value as-is, the first error code is
recorded then returned.

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


