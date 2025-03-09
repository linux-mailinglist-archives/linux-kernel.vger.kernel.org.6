Return-Path: <linux-kernel+bounces-553402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A893A588B7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 23:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7790A16A045
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255D8160783;
	Sun,  9 Mar 2025 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J++TDpzV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C76C2FA
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557659; cv=none; b=ApfaEke7PYoytgk6E8IIM/ZqNb2H7+R5AV2mbLFgeuOHgE3A4EAPGfCZwXekxEwOjrVZJ4lEDd/7Rgu7U5/W92yNa9oG60BhIm/Fwk6zTVsZnIyxM302gpLQyLFNo+qWuKhsjrFTrsDet9CxKXOyGCy8uMPmL2QtRZL/cpDeLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557659; c=relaxed/simple;
	bh=2AwOlmOEhu3yB/ZFUZMUxaC69CB5cnd8T/Ge3O14dyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spsKXRovq0kC2Jj1ulBdrkPd6aFLNbvskZ/LhOVCrHj4Ks3OCtIXm8WV2PHrZu4Iv+OgDdMxS19JDJ5jBRq4NRt21+MYMEd0uB99XmGaAwxRwLixGNCuvZ6nIe/i9oVUc16DGzUaaTHJKXaNmPNQzoTeURlUwLHLQKxNWAKDgOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J++TDpzV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741557655;
	bh=2AwOlmOEhu3yB/ZFUZMUxaC69CB5cnd8T/Ge3O14dyY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J++TDpzVlCkjoNZ2ae2abmOJtcdsXHrqE2QTJgUz5l9o4nR/SbvysGdaNiDyN/8TY
	 EpfBVAmh+9DE9/NiPAYPaeBW4NWTf374ueN7TXjwgCWBP6WTnpB6fCs1KZVs4bDjlZ
	 WgNvAUg3r63CQ2MGSUl+Y0phl4m2VxXFq1VakrxbB+CJDN5C4aAtI2wsGXdHEcVAkq
	 CLyHA+Khi0TZMwImsEncDdpzfbF+aZwyholl36Sbh3C5i5wSknyydYtfehk7/mOJaO
	 DgBUAiOyYRz7vovByktlgODsOvnVB9Sveaal3tgRva21B0sECn6rG4VeKoDsS+xmdI
	 Gdtj7Ri4/ZLIg==
Received: from [192.168.1.90] (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DABAC17E09FB;
	Sun,  9 Mar 2025 23:00:54 +0100 (CET)
Message-ID: <0fe4388f-3374-409b-8383-ee5200961583@collabora.com>
Date: Mon, 10 Mar 2025 00:00:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] phy: rockchip: samsung-hdptx: Avoid Hz<->hHz
 unit conversion overhead
To: David Laight <david.laight.linux@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>,
 Sandor Yu <Sandor.yu@nxp.com>, Maxime Ripard <mripard@kernel.org>,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
 <20250308-phy-sam-hdptx-bpc-v5-7-35087287f9d1@collabora.com>
 <CAA8EJpoQbvFbNXQ2RB1qY2gHnwZaU-PT-DMLnZkrxkqs2wkXqQ@mail.gmail.com>
 <a1a3e86a-1906-4797-932d-8e1aadafedde@collabora.com>
 <20250309144747.744e5197@pumpkin>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <20250309144747.744e5197@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 4:47 PM, David Laight wrote:
> On Sun, 9 Mar 2025 12:13:32 +0200
> Cristian Ciocaltea <cristian.ciocaltea@collabora.com> wrote:
> 
>> On 3/9/25 11:22 AM, Dmitry Baryshkov wrote:
>>> On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
>>> <cristian.ciocaltea@collabora.com> wrote:  
>>>>
>>>> The ropll_tmds_cfg table used to identify the configuration params for
>>>> the supported rates expects the search key, i.e. bit_rate member of
>>>> struct ropll_config, to be provided in hHz rather than Hz (1 hHz = 100
>>>> Hz).  This requires multiple conversions between these units being
>>>> performed at runtime.
>>>>
>>>> Improve implementation clarity and efficiency by consistently using the
>>>> Hz unit throughout driver's internal data structures and functions.
>>>> Also rename the rather misleading struct member.
>>>>
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>> ---
>>>>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 79 +++++++++++------------
>>>>  1 file changed, 39 insertions(+), 40 deletions(-)
>>>>
>>>> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>>> index 2bf525514c1991a1299265d12e1e85f66333c604..e58a01bdb3ce82d66acdcb02c06de2816288b574 100644
>>>> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>>> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
>>>> @@ -330,7 +330,7 @@ enum dp_link_rate {
>>>>  };
>>>>
>>>>  struct ropll_config {
>>>> -       u32 bit_rate;
>>>> +       u32 rate;  
>>>
>>> unsigned long long, please, to match the tmds_char_rate type.
> 
> Isn't 'bit_rate' more descriptive?
> But maybe rate_hz to make the units more obvious.
> 
> If the max frequency might get near 4Gz then the you need something

The max freq. intended to be handled by the related config table is 600
MHz, that is for supporting HDMI 2.0 (TMDS).  Anything above that
requires HDMI 2.1 (FRL), which is currently not provided and would
anyway not rely on this data structure.

Regards,
Cristian

