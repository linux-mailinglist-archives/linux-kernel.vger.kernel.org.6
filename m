Return-Path: <linux-kernel+bounces-220259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 235B990DE8F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73521F23ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC7517838C;
	Tue, 18 Jun 2024 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K1wAzfUr"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58913DDD2;
	Tue, 18 Jun 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746757; cv=none; b=eteqkqxQ8KiT4DqyVEZGo337AKwQrJD5OsGzP3f3JR6iNEwO7+mfvnC7czhgB13gbmMpKr2urv7Jv5n6tJLk5pV1pf7WT1u4x1iDM8voWqhCqneij6E6yzwWKbFhJVneVvj/YuZgaAEqEIH/ElWKzgTsEy8gcI72CJTBQZ8Uyzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746757; c=relaxed/simple;
	bh=U0Eg57Cn4OqXvwMom/OSpj1QqTJKcmBbmsEXCWhvtX8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rDWyGXpmTqbIJbQYLS0DYXtkMfdPCGA7Lv+gB0dQQjgGR45eQ9GFf8Qe1jaTpomUDXreqz/AW1yvmI71xTJc/K1qWvyEgeGtaQJHnXpFCIEieuxHqWCynBPO1dAsjFBKMfVMp0SVi7U0JYz22ygIG2+xVyt/HyPNTOYKyuGrasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K1wAzfUr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=o8G8ifLXVT/4fr2bGcys3dHGbQ+B9Z7Bqubv+Pu8ANc=; b=K1wAzfUr5mz1ZuifiHsVo1OfEV
	UF+ZeLA/mo6mnmm+TdvzdWxuMRHF6lsaFGH3V1t2wIUglCRGNS2ZPN9rq09JJaryp5m34Fkdxy3Gm
	k0DVmDVIQy2h9ZzUaenGCffyX5I4KVY7Zkc2jl61wmLjA5xQorvGI069zJlLs0JwsO6hFWZa+sWWr
	z7sHgdOzasXTx5/F+sfTjodJZTb5a4t70x5zkJwvAhbJIloDLJMoOJ8TWgBAclCxBI12nvejmnbDK
	ZB0Edq73rPcM7NzE2VPqiZJF7IdvBOfORRIj4j10gC5WsidS/CxRUA+4+FVxUdlyOrPtJXe+I7yfw
	0VT5cWHA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJgXo-0000000GhXx-3pHy;
	Tue, 18 Jun 2024 21:39:13 +0000
Message-ID: <c9007e7e-ca1e-4a2e-a80b-4ee3cd873fa8@infradead.org>
Date: Tue, 18 Jun 2024 14:39:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] firmware: imx: adds miscdev
From: Randy Dunlap <rdunlap@infradead.org>
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-5-a7d28dea5c4a@nxp.com>
 <c2ef0570-0392-4290-a008-df74f980f76d@infradead.org>
Content-Language: en-US
In-Reply-To: <c2ef0570-0392-4290-a008-df74f980f76d@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sorry, I missed one comment here:


On 6/18/24 2:28 PM, Randy Dunlap wrote:
> Hi--
> 
> On 6/17/24 12:29 AM, Pankaj Gupta wrote:
>> Adds the driver for communication interface to secure-enclave,
>> for exchanging messages with NXP secure enclave HW IP(s) like
>> EdgeLock Enclave from:
>> - User-Space Applications via character driver.
>>
>> ABI documentation for the NXP secure-enclave driver.
>>
>> User-space library using this driver:
>> - i.MX Secure Enclave library:
>>   -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
>> - i.MX Secure Middle-Ware:
>>   -- URL: https://github.com/nxp-imx/imx-smw.git
>>
>> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
>> ---
>>  Documentation/ABI/testing/se-cdev |  42 +++
>>  drivers/firmware/imx/ele_common.c | 153 ++++++++-
>>  drivers/firmware/imx/ele_common.h |   4 +
>>  drivers/firmware/imx/se_ctrl.c    | 694 ++++++++++++++++++++++++++++++++++++++
>>  drivers/firmware/imx/se_ctrl.h    |  49 +++
>>  include/uapi/linux/se_ioctl.h     |  94 ++++++
>>  6 files changed, 1034 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
>> new file mode 100644
>> index 000000000000..699525af6b86
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/se-cdev
>> @@ -0,0 +1,42 @@
>> +What:		/dev/<se>_mu[0-9]+_ch[0-9]+
>> +Date:		May 2024
>> +KernelVersion:	6.8
>> +Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
>> +Description:
>> +		NXP offers multiple hardware IP(s) for  secure-enclaves like EdgeLock-
> 
> 		                                   for secure enclaves
> 
>> +		Enclave(ELE), SECO. The character device file-descriptors
> 
> 		                                         file descriptors
> 
> and what is SECO?
> 
>> +		/dev/<se>_mu*_ch* are the interface between user-space NXP's secure-
> 
> 		                                            userspace        secure
> 
>> +		enclave shared-library and the kernel driver.
> 
> 		        shared library
> 
>> +
>> +		The ioctl(2)-based ABI is defined and documented in
>> +		[include]<linux/firmware/imx/ele_mu_ioctl.h>
>> +		 ioctl(s) are used primarily for:
>> +			- shared memory management
>> +			- allocation of I/O buffers
>> +			- get mu info
> 
> 			- getting mu info
> 
>> +			- setting a dev-ctx as receiver that is slave to fw

Documentation/process/coding-style.rst says not to introduce new uses of the
word "slave":

For symbol names and documentation, avoid introducing new usage of
'master / slave' (or 'slave' independent of 'master') and 'blacklist /
whitelist'.

Recommended replacements for 'master / slave' are:
    '{primary,main} / {secondary,replica,subordinate}'
    '{initiator,requester} / {target,responder}'
    '{controller,host} / {device,worker,proxy}'
    'leader / follower'
    'director / performer'


>> +			- get SoC info
> 
> 			- getting SoC info
> 
>> +
>> +		The following file operations are supported:
>> +
>> +		open(2)
>> +		  Currently the only useful flags are O_RDWR.
>> +
>> +		read(2)
>> +		  Every read() from the opened character device context is waiting on
>> +		  wakeup_intruptible, that gets set by the registered mailbox callback
> 
> 		  typo in that name?
> 		or is it something that this patch series introduces?
> 
>> +		  function; indicating a message received from the firmware on message-
> 
> 		  function,
> 
>> +		  unit.
>> +
>> +		write(2)
>> +		  Every write() to the opened character device context needs to acquire
>> +		  mailbox_lock, before sending message on to the message unit.
> 
> 		  mailbox_lock before
> 
>> +
>> +		close(2)
>> +		  Stops and free up the I/O contexts that was associated
> 
> 		            frees up                 that were associated
> 
>> +		  with the file descriptor.
>> +
>> +Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
>> +		https://github.com/nxp-imx/imx-smw.git
>> +		crypto/skcipher,
>> +		drivers/nvmem/imx-ocotp-ele.c
> 
> 

-- 
~Randy

