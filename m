Return-Path: <linux-kernel+bounces-402444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E67A9C2793
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14983284090
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF72D1F5832;
	Fri,  8 Nov 2024 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D0l9cm3A"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E51F26C9;
	Fri,  8 Nov 2024 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104976; cv=none; b=YTUu9xqXniz6at/iwAgVJMcH65Imm1ECkkVcvA6FJW+mp8VTLb1QW7Np9E1O5/d3QyrBknl4FVYzo4PmZ30rBiElrm1MRpxRKkCrr3Yt23xdwGyYh+PE6i4BPWaaSgbmxM3TAC6945+32HQZx8OODKgcs3yiC32Lr5kdAHi/Ktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104976; c=relaxed/simple;
	bh=qJjCe1x/+zqlWuKc7d+aXQgxzYOBvB4ApAoxF5HeEwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RraB3DZzqHja91gRxkzcM7WavzFXss7IZKHEkej4rdP5a79eV2F3IIe6OmuI4YvzUQwx4lAn6ISjQIftvcXMWxqV9F/xrIryEfLPoXjtGVoJSkyPBQ5+JyM3N/xRgo9q4sWryU0lfbFnfOuR5Li/DsvS+3Q+tSk5O0uMH6n/bok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D0l9cm3A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=vyXWLdY22mbau7qfmkpZcxZ0TUXHpJ4OrztVMYMMO3w=; b=D0l9cm3Ar1Lv9+3q4mlHfKdV6X
	runW4UHkA0IjIyBpEzIN1Yvw3dy4aGac2aq11Gtkg8PvUXnRsIRtA7kwNBumbPms/CO2QoRe/G6oF
	TGNACtbN6UuuYPydxGmq6O+2xbVV3Of6qKfNGMe/JwSvDzauKd+Sd+F7cFYckZMdc+9+mzpw+FxSO
	sv76iw9U+U7IFO2VPe3pCqFidKD+wEK6FhB20SC4UDzhm30/LqvQBSSggR6Bps+Xz7+xjNvyNX8bf
	bz1kiX7OBbuBsqK+WoM8HKss/fGae7kkB3MtZ52NeuCUSUEhzmZDa139fzEw/z0pr//mKz+69Rsy0
	ZwxcQ60w==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9XTt-00000009Nig-05OW;
	Fri, 08 Nov 2024 22:29:30 +0000
Message-ID: <4ec3e311-fc25-4732-9b93-5b8f0332cb82@infradead.org>
Date: Fri, 8 Nov 2024 14:29:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: hwmon: Fix typos in sch5627 and max31827
To: Abhinav Saxena <xandfury@gmail.com>,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Corbet <corbet@lwn.net>
References: <20241108212201.144482-1-xandfury@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241108212201.144482-1-xandfury@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/8/24 1:22 PM, Abhinav Saxena wrote:
> Fix some typos in hwmon/sch5627 and hwmon/max31827 reported by
> checkpatch.pl. These changes are purely documentation cleanup with no
> functional modifications.
> 
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/hwmon/max31827.rst | 2 +-
>  Documentation/hwmon/sch5627.rst  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
> index 9c11a9518c67..6cc5088b26b7 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -136,7 +136,7 @@ PEC Support
>  
>  When reading a register value, the PEC byte is computed and sent by the chip.
>  
> -PEC on word data transaction respresents a signifcant increase in bandwitdh
> +PEC on word data transaction represents a significant increase in bandwidth
>  usage (+33% for both write and reads) in normal conditions.
>  
>  Since this operation implies there will be an extra delay to each
> diff --git a/Documentation/hwmon/sch5627.rst b/Documentation/hwmon/sch5627.rst
> index 8639dff234fc..5f521c6e90ab 100644
> --- a/Documentation/hwmon/sch5627.rst
> +++ b/Documentation/hwmon/sch5627.rst
> @@ -39,7 +39,7 @@ Controlling fan speed
>  ---------------------
>  
>  The SCH5627 allows for partially controlling the fan speed. If a temperature
> -channel excedes tempX_max, all fans are forced to maximum speed. The same is not
> +channel exceeds tempX_max, all fans are forced to maximum speed. The same is not
>  true for tempX_crit, presumably some other measures to cool down the system are
>  take in this case.
>  In which way the value of fanX_min affects the fan speed is currently unknown.

-- 
~Randy

