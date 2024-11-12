Return-Path: <linux-kernel+bounces-406405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2604A9C628D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F453BC51A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310A6200BB1;
	Tue, 12 Nov 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="AozN/N0l"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8962101A7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431643; cv=none; b=MXHc8YWEhL3fDbpLGOiOJQaKcGuxapzzT//Gvz2PKyPazmGywPjfoXVQcqT3l5SnHty5OFc2jRkPqNjOguFBrMNrc8NnLUBlI7ANnCHz2PQJ7CqljpZE2xdcUq+swVS0nkbeoowI9vNX3xijHbDkz1jjlpBTRXoOLW+Azo5sZ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431643; c=relaxed/simple;
	bh=Xv46+l1WZBFnQuCUcn2J+pY8l+wWCoeIkqeIoXGwrco=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AyKywgm5j8uV6b+b+zBPDDqFExgBQRJMW2kjfCMsKRdqLqrUtbsG36LR7PKWQ5xrd6v/U8SAjZdb1sf6OrUqFGeLT+at5AKrKYwKn+VT3Jgy61J7RoRqNIOGqQRmm+YwdC0jgLun5yFEU5900GFjThMNfNk9uQDaA9z4IBd88Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=AozN/N0l; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id AiaatG2LAiA19AuSgtGgxx; Tue, 12 Nov 2024 17:13:54 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id AuSdtY8FMafHtAuSfty6Ia; Tue, 12 Nov 2024 17:13:53 +0000
X-Authority-Analysis: v=2.4 cv=ZbcbNNVA c=1 sm=1 tr=0 ts=67338cd1
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=-pn6D5nKLtMA:10
 a=oM_t_NHKBYUYTEO7nXEA:9 a=QEXdDO2ut3YA:10 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+KnGx3ACBnnMv2BmaDE1d3Gtw8+1dg1ljAPNkRzxM8c=; b=AozN/N0l9750TXxMIZV9dyrYzr
	pGPwMXEErQkZbfhuE2qJSjqeSI2GOs9LzqRhJEH5WTyajpDDai0UnZ+8/gsiQTPcKEv6hQRRLg/0s
	+7xHFVam1tSusiES8SgHsXFvRuI3b0orNqK4EI8x96i9NrCOiE0wckzlUPE/Dj0CVXyXdWMvJf6g3
	uBde9UXDm6TfRxDipncRac4MNAhLLPpl3QQ4sCps0Bd3XvDWMudY974mZj5fy8CUKOt8AaTxI0t7S
	OrMFf6kEML+ZhRAg4M/+KfEyr0iSPIO0yQCcgN9DsX5S4ejK5HFDkMrk2JqSUt7/KfMPRAf+1dAiO
	8e7zUG+Q==;
Received: from [122.165.245.213] (port=53470 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1tAuSY-000Tbs-1d;
	Tue, 12 Nov 2024 22:43:46 +0530
Message-ID: <f0d5b314-cfcc-4856-8d6e-09e437c075ec@linumiz.com>
Date: Tue, 12 Nov 2024 22:43:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Andre Przywara <andre.przywara@arm.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Samuel Holland <samuel@sholland.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Workaround TCON TOP conflict between DE0 and
 DE1
To: John Watts <contact@jookia.org>
References: <20241108-tcon_fix-v1-1-616218cc0d5f@jookia.org>
 <20241108115357.691b77b0@donnerap.manchester.arm.com>
 <Zy4SKCBwce3q0yj5@titan> <b26b9d86-4ff9-4543-85ce-176dccfbfa05@linumiz.com>
 <Zy4c9BFcrz2JVU6k@titan> <ZzNCsFiAiACFrQhE@titan>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <ZzNCsFiAiACFrQhE@titan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1tAuSY-000Tbs-1d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:53470
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 1
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH3V6fZtHzgcdUmOnM6ENdZ5DFv3nO+ncZlVGOuF5whm5M++O0QxJsczIU73zm+F90j8zCJCVvIKRr0pBvdq2qNqqbyG3wOCsWt6hK1o2sM/WUjPpimi
 eIhk84o19DChmo7YdJsX/qoSNIxyWASLC+fmzpUlO1hK4CEMMea91BBod5gqXRSJiE9yV/eOPMcsODa2sTvs9ZgLRS1XOgqAWFo=

On 11/12/24 5:27 PM, John Watts wrote:
> Hey everyone,
> 
> I'm not sure exactly where to add this but I discussed some of this with
> Parthiban on #linux-sunxi a few days ago, so I want to write it down
> before I work on the next version of the patch.
> 
> I had assumed for some reason in my mind that DE0 and DE1 here referred
> to mixers, but they actually refer to chips that have multiple DEs. It
> looks like at least with the A133 it has two DEs instead of two mixers.
> 
> This can be found by looking at the Allwinner BSP: SUN50IW10 requires
> CONFIG_INDEPENDENT_DE and has a device tree with an extra reg and clock:
> 
> <0x0 0x06800000 0x0 0x3fffff>,/*de1*/
> <&clk_dpss_top1>

Independent DE is unique to A133/A100 AFAIK.

> 
> However the tcon-top code seems to conflate mixers and DE in the
> mainline code and the Allwinner code. So ... It seems like 'DE0' and
> 'DE1' really do mean mixers in this case. It's probably best to note

#define TCON_TOP_PORT_DE0_MSK                   GENMASK(1, 0)
#define TCON_TOP_PORT_DE1_MSK                   GENMASK(5, 4)

references towards DE0 and DE1 is for DE itself, not the mixers in the
current implementation.

Handling for mixer0 <-> lcd1 and mixer1 <-> lcd0 also needs to set
DE2TCON_MUX in de clock, which is missing now.

> that down.
> 
> I thought a bit more about how to solve this properly- setting two
> mixers to the same output is something people probably won't do in
> practice, so the only way you could really arrive at this bugged state
> is by setting it as the default state. This patch may be the correct
> solution after all.

sun8i_tcon_top_set_hdmi_src for R40 already sets these values via quirks.
i.e controlling the port muxing. Also D1 quirks is same as R40. So the
original changes to make the DE1 point to TVx can also done in this quirk
without hardcoded value?

Thanks,
Parthiban

> 
> John Watts
> 
> On Sat, Nov 09, 2024 at 01:15:16AM +1100, John Watts wrote:
>> On Fri, Nov 08, 2024 at 07:36:16PM +0530, Parthiban wrote:
>>> To add, 0x20 will be DE0 <--> LCD0 and DE1 <--> TV0. Below note (copied from
>>> R40) states the priority of the DE selection, which fails to work? Not sure,
>>> may be disabling CORE1_SCLK_GATE and CORE1_HCLK_GATE in de2-clk helps.
>>>
>>> With A133 following the same as T113 with single mixer without TV, still
>>> sets 0x20 in vendor kernel.
>>>
>>> copied from R40:
>>> Note: The priority of DE0 is higher than DE1.
>>> If TCON_LCD0 selects DE0 and DE1 as source at the same time, then
>>> DE0 will be used for the source of TCON_LCD0.
>>
>> Hi there,
>>
>> Yes that was a pretty bad typo, I meant to say DE1 to TV0
>> The prioritization seems broken in the T113 at least, it's racy from
>> what I see in testing. I should note this in the patch too.
>>
>> I looked at the datasheets and kernel code briefly: I can't seem to
>> figure out what SCLK/HCLK gating does and I don't think the kernel
>> touches these registers which are gated by default.
>>
>>> Thanks,
>>> Parthiban
>>
>> John Watts


