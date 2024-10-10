Return-Path: <linux-kernel+bounces-359599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70645998DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF341C23EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF256199396;
	Thu, 10 Oct 2024 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="h8cEJo/1"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490041991B8;
	Thu, 10 Oct 2024 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579040; cv=none; b=YBwGL8WG+5+6BpgnG8DwEoP9UcJL7SYk0HmEksd2rVicjTpOcJCix+iU33DIvirpteqpj9asXfyXzHwoQdxQXJS0sOsyxV26mFnK4QeWufCEfOAfCK85okn9LN16gXg0x0QlKqBTJS3dcVHh79Jwi5zFDK4rzL2Y9Xg1Glm68w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579040; c=relaxed/simple;
	bh=Etg/hUSSIISCsDWdUTe2INcxYzNi5dlpOTEAFSJHzAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbh8K6TSuhyjLRw6U1WKxiXdGswUrEuBQ+4rterHTtW0cbP5xpBU3CJccDJyiY3EpBIknqKHl915A6bFpVS7wCo8bpSCF557Vth3InpqzgWf2WEW7zw57wDY8y30LJ2h58WmrLPnQHpsOGrzU6SPeNSJS2Zk5qkUsTYDw16OoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=h8cEJo/1; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728579026; x=1729183826; i=wahrenst@gmx.net;
	bh=Etg/hUSSIISCsDWdUTe2INcxYzNi5dlpOTEAFSJHzAI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h8cEJo/14Tjkz62WejSu72xLCKg5rMJH+IcRwGPh6zTBQYknxBpnNr255TctM7ja
	 Jg2+fyIUavXDWzuGJ1egRoV0HYNxYoGnK6YotPf7JEY/wM24leyt2jDri5qIIDnlS
	 HCacQ/fjZPCjL4HdUgNfmBVR7OmiLxU1qdmN0Zbh+gO/Nuiif6hwuRqMhUjdzUAF9
	 xObIY2huoaivEo5Dl4fAy4d5A9wEM0uo0gHSkgfPMD5Dzx2/TXodRnalVzBkf5ora
	 v4c8j+X1UHvfXxv5PtY7NlMXKQ94kf8Xg3Eo0QtILPWhIpXtpCpEPMpy6OIlus8m3
	 ijkhwuCYxY6Y1uhbVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1tNnp20qN8-00YR6H; Thu, 10
 Oct 2024 18:50:26 +0200
Message-ID: <890c234b-6d68-4a43-8bea-208e5d1a115c@gmx.net>
Date: Thu, 10 Oct 2024 18:50:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] staging: vchiq_core: Macros indentation fix
To: Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20241010102250.236545-1-umang.jain@ideasonboard.com>
 <20241010102250.236545-5-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241010102250.236545-5-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w8SU1GkLKTXWfDlL3iHpizF7uxH5F6xYix/ZuuraWfp4XtbnNgt
 EHg3ypUio3TG9riYGklvQDoY4GDUVjVaK0XWsamREdM5Pov/jyvUUEQPJ9ebOTlzHDMreR6
 WihvCwhTTb+bQW9eNTr76Lqn96Hvds6mGh+9gikxayKgW72p1VWEXOJ5b2MJ5WWp1hsQlB1
 NZaTGQiShfsx6p3/VfJUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BeOGGQXhwrE=;sDrbDNtCXZGDQ0lzRcidJc+cWS/
 GCpso9W+qRljlpcHT2tKRnItzjfMVMHTI/CcXsIAo50kON7ngfT5t6f6YqP58uv2W9yIrT1sR
 KyPmXFIsnBzaV+Qpb5JgMoEnRw8wDSDLFaFvNIzEZsSDTjF3fEcSgvclEWfvFiFCxsMylc/i9
 oawDj54C1TLIQ1Dd+Tfg3ggWxe/CkjdbUImpkovHjDj+1+f0ifzv0WZVyLdSR2QeVN1SWlZF8
 SOaAfB0mL4DnIkE8oCp7KCguwVFqP5d0h8O7/rc2JUNq8PnDjegiT7jemHGMRkC8ydsVE8Xqy
 eyZl1CUn12ZeQc0JRMWBcCQ83c956FvKckZGO5uMPTq9YWku0y/ycAWNQP5887QiXN9JzAv+J
 08NHJBid3+th0mPNa16hcAWUfoPGrorasnpqBg4Xj8ybTU+dtsSqhDKm8KlEXhOpyK4XIHuhO
 yj7H156707T49vq9LdtfNOCYX3MlApAgLgUKgL3cu0HLCDDS/Cv/PiljjyTkhoegGpADdBsiC
 QmtBPMWITrft6vg6AmVVbhv8chJL7oGAjCI9IMzVXL/wtjH6+aYEhrgE+uuJOXPQxpTsm0S3H
 NpLBxVjw75usUCgRJjFAfCxs8S7H8QBbVD0XnxDUpg8troNPnH+ZGw+cYW5wroVdP36wXpfbg
 ulC1pbKue97mgSA+jypIrMZcwzYrQhSf/aTSHhgKPe5Pp7rFhq2lRnHG8vwZ5M73+uQPcaPDl
 f7I+LtbonuznJzyyeOjLgQXRPuLhsuEIKEfg2VToMZ1JXcBMxZiWopCazzkldvmKHf+a3CYYN
 5nWRqc0gnUwotOsd13fYE4sA==

Hi Umang,

Am 10.10.24 um 12:22 schrieb Umang Jain:
> Make sure that MAKE_* macros fit within 80 columns instead of spanning
> in a single line.
honestly i'm not a fan of this change, because it just silence
checkpatch but doesn't improve readability.

Regards


