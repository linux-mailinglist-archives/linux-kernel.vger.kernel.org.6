Return-Path: <linux-kernel+bounces-301038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72895EBC7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B5E28114B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C55D13DBA2;
	Mon, 26 Aug 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jpXMBJMf"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FAB13D2A9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660458; cv=none; b=ZRJ7NQ+8WiWh8HDWDO5Z88Z9l8zZf46lBddmKVpYTo2HXIdNCyelqZ6subf2EoAd/W5sdC2aim1RwLQ2if7ClxPpkgnhWaWadhis4oDjTQ7m9vOnzdP1a6BFoSXaERS+TTaauP/hxmKQnJcUDiXZfFweYC7/IOQk53gaGOGsQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660458; c=relaxed/simple;
	bh=K1YnpBkT+cVoB8PBEXPGLg6Moqbes66MYtr3X2fBdU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8Tg/uUcv8nXWB2IZxvo0IjEcUtlkURAZtuDqbH2QKi2EKWSFeGYyFVdYXV2hpg/vG32NU53V7QRA0gMgOGoZUxVHhhRS+gX3C2XTKWkc9qiE+++75KZOs8Whafdr16kyvXG9naMW8JZ/Xcrpfit1X+LRz/lMC4aL1CXgdep/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jpXMBJMf; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5fc71f8-5b14-4cb6-b0ae-cc4ef333526b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724660454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOp17d0+ZaLcKHAp00iycdUMgC7QEulIPpmusZTNMuM=;
	b=jpXMBJMf1L1y+LNyINwQlLjK9R7nioqlXARPLUqU+LIu5dtuKQelGrOfUdkdYzSzc2o7/L
	svLTv7nTaib6hdAODPCjyw+tICLuNlFbj5Ky1p5adoPAPEtkD7LB6hxyRXHLUCB8l2zYFM
	3jsENQfsssXSPLmoS2uScr/RIxB8ldQ=
Date: Mon, 26 Aug 2024 16:20:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] amba: make amba_bustype constant
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux@armlinux.org.uk, krzk@kernel.org, andi.shyti@kernel.org,
 robh@kernel.org, gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
 rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org,
 Kunwu Chan <chentao@kylinos.cn>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
 <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Thanks for the reply.
On 2024/8/23 21:48, Andy Shevchenko wrote:
> On Fri, Aug 23, 2024 at 02:42:03PM +0800, Kunwu Chan wrote:
>> From: Kunwu Chan <chentao@kylinos.cn>
>>
>> Since commit d492cc2573a0 ("driver core: device.h: make struct
>> bus_type a const *"), the driver core can properly handle constant
>> struct bus_type, move the amba_bustype variable to be a constant
>> structure as well, placing it into read-only memory which can not be
>> modified at runtime.
> ...
>
>> -extern struct bus_type amba_bustype;
>> +extern const struct bus_type amba_bustype;
> Can we actually hide this from the outside, i.e. make it static in the C file,
> and introduce the dev_is_amba() helper instead?
Sure, i've find the patch  series 
(https://lore.kernel.org/all/20240528102708.1451343-2-andy.shevchenko@gmail.com/)
> P.S. You may look at the PNP bus case (some of the latest patches there).
>
I'll change it as PNP bus in v2.

-- 
Thanks,
   Kunwu.Chan


