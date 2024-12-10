Return-Path: <linux-kernel+bounces-439913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B913E9EB5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5861618827CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC741D7E4C;
	Tue, 10 Dec 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ASaDkeC2"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF022FE03
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847387; cv=none; b=k4Uizbw6eu90+OXUWhyp/FwMyeXwLMYvWiy52upUvhEOrNGWv17fcTemeslHUQk7azSKJYy1GgaEXS6NJD1FjWGFXFOKxI4l2SEvguUsJ5aNxEFj7q/jJwAx4QDgDR45RW/sBNZoVuxieUQFG/3ex+9cv7SSFTGSJK+2h+gs5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847387; c=relaxed/simple;
	bh=H52cy46JdpnZyjHw+2Rfcb03VLcFF3EuVujI2nROnF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bg7VqsxzrF775RQ/2IiVlHz2CNnfOQnBmCgT5wnax6j9UAw8Y1TayyiA/VUQioAjnOf/je2jGxEBwSZkf2kS82DHMPuXHatSNZCrGxD82w85ksmE3GGE1FrsZezVgPfTw/LeOKOJMK0EN212dkVpGgbFq5PXErfSjZvgsQa8RGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ASaDkeC2; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1733847382;
 bh=PyFDOAJVNrvBIfRJIJW+BVdBfeFkP4zy0JFDJEjFdMQ=;
 b=ASaDkeC2hsC3XOnHzz78vZ4xAJApfgilvDzbT1WtHJnS56ZVVOMvm2BOrtFj0RMFcZ8J4olrn
 UEdm7R7HZ+D5goTjNLcykiSECV4li0/sleRDjbW/clMseDC0/FC8HxoCI48X6ZBywcVE0hrp/+m
 IzK6J4NMuwpb1Ywb7F4eLHfq7nR+iayALo7nI+Y0E9JSGiK91V+rhU0IqMlpoIexo/sNDpdBHBL
 H5ThYbwK+PZBh8wGQxl/gH4ACCYOt6/9bHRGBMk+CeoYW62EJ/QtJmQ/nkuBoLzkCdTnnKjRrVo
 1aO4ZptWdyjRkSE0LrlEwHv3n1VK/wGpCvQS4M6ByL7A==
Message-ID: <f16b3688-91e1-4760-ac2b-ce53db98ed68@kwiboo.se>
Date: Tue, 10 Dec 2024 17:05:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm64: dts: rockchip: add hevc power domain clock to
 rk3328
To: Peter Geis <pgwipeout@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Alex Bee <knaerzche@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 Diederik de Haas <didi.debian@cknow.org>, Johan Jonker <jbx6244@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Liang Chen <cl@rock-chips.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, shironeko <shironeko@tesaguri.club>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
 <20241210013010.81257-5-pgwipeout@gmail.com>
 <e32fa593abfa6d08202b4f929e0b4bdb@manjaro.org>
 <CAMdYzYp+MQVYr1tOMEOn62vXZGVEYrtd1p9vn6YQzXdrJgSdyA@mail.gmail.com>
 <CAMdYzYquvGBzfWqvUOku7m1sM9qxmBHAL95cANDViUCT1oEEhQ@mail.gmail.com>
 <8c604ada27457698ad6d33d22a39b45a@manjaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <8c604ada27457698ad6d33d22a39b45a@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675866c8ce9f514b1380cc1f

Hi Peter,

On 2024-12-10 14:53, Dragan Simic wrote:
> Hello Peter,
> 
> On 2024-12-10 14:23, Peter Geis wrote:
>> On Tue, Dec 10, 2024 at 8:13 AM Peter Geis <pgwipeout@gmail.com> wrote:
>>> On Tue, Dec 10, 2024 at 5:04 AM Dragan Simic <dsimic@manjaro.org> 
>>> wrote:
>>>> On 2024-12-10 02:30, Peter Geis wrote:
>>>>> There is a race condition at startup between disabling power domains
>>>>> not
>>>>> used and disabling clocks not used on the rk3328. When the clocks are
>>>>> disabled first, the hevc power domain fails to shut off leading to a
>>>>> splat of failures. Add the hevc core clock to the rk3328 power domain
>>>>> node to prevent this condition.
>>>>>
>>>>> rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 3-....
>>>>> }
>>>>> 1087 jiffies s: 89 root: 0x8/.
>>>>> rcu: blocking rcu_node structures (internal RCU debug):
>>>>> Sending NMI from CPU 0 to CPUs 3:
>>>>> NMI backtrace for cpu 3
>>>>> CPU: 3 UID: 0 PID: 86 Comm: kworker/3:3 Not tainted 6.12.0-rc5+ #53
>>>>> Hardware name: Firefly ROC-RK3328-CC (DT)
>>>>> Workqueue: pm genpd_power_off_work_fn
>>>>> pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>> pc : regmap_unlock_spinlock+0x18/0x30
>>>>> lr : regmap_read+0x60/0x88
>>>>> sp : ffff800081123c00
>>>>> x29: ffff800081123c00 x28: ffff2fa4c62cad80 x27: 0000000000000000
>>>>> x26: ffffd74e6e660eb8 x25: ffff2fa4c62cae00 x24: 0000000000000040
>>>>> x23: ffffd74e6d2f3ab8 x22: 0000000000000001 x21: ffff800081123c74
>>>>> x20: 0000000000000000 x19: ffff2fa4c0412000 x18: 0000000000000000
>>>>> x17: 77202c31203d2065 x16: 6c6469203a72656c x15: 6c6f72746e6f632d
>>>>> x14: 7265776f703a6e6f x13: 2063766568206e69 x12: 616d6f64202c3431
>>>>> x11: 347830206f742030 x10: 3430303034783020 x9 : ffffd74e6c7369e0
>>>>> x8 : 3030316666206e69 x7 : 205d383738353733 x6 : 332e31202020205b
>>>>> x5 : ffffd74e6c73fc88 x4 : ffffd74e6c73fcd4 x3 : ffffd74e6c740b40
>>>>> x2 : ffff800080015484 x1 : 0000000000000000 x0 : ffff2fa4c0412000
>>>>> Call trace:
>>>>> regmap_unlock_spinlock+0x18/0x30
>>>>> rockchip_pmu_set_idle_request+0xac/0x2c0
>>>>> rockchip_pd_power+0x144/0x5f8
>>>>> rockchip_pd_power_off+0x1c/0x30
>>>>> _genpd_power_off+0x9c/0x180
>>>>> genpd_power_off.part.0.isra.0+0x130/0x2a8
>>>>> genpd_power_off_work_fn+0x6c/0x98
>>>>> process_one_work+0x170/0x3f0
>>>>> worker_thread+0x290/0x4a8
>>>>> kthread+0xec/0xf8
>>>>> ret_from_fork+0x10/0x20
>>>>> rockchip-pm-domain ff100000.syscon:power-controller: failed to get ack
>>>>> on
>>>>> domain 'hevc', val=0x88220
>>>>>
>>>>> Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for
>>>>> RK3328 SoCs")
>>>>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>>>>
>>>> While I was unable to formally verify this clock assignment,
>>>> i.e. by using the RK3328 TRM or the downstream kernel source
>>>> from Rockchip, it makes perfect sense to me.  Thanks for the
>>>> patch, and please feel free to include:
>>>>
>>>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>>>
>>> It is unfortunate the TRM doesn't include the clock maps, because they
>>> are extremely helpful when one can acquire them. It also doesn't help
>>> that the TRM register definition only referred to this as "pll". I was
>>> sent specifically the usb3 phy clock map for my work on the driver,
>>> which had the location of each switch and divider along with the
>>> register and bit that controlled it. That combined with the TRM
>>> register map allowed me to find this error.
>>
>> Apologies, that's the wrong response for this one.
> 
> No worries.
> 
>> This patch was the result of educated guess combined with testing. I
>> grabbed all of the clocks that looked like they could affect things,
>> then tested them one at a time until I isolated them to this clock. It
>> lives alone with cpll as the parent and has no children according to
>> the clock summary. (Though the writeup i mistakenly included above
>> proves the clock map isn't always accurate).
> 
> I see, thanks for all your work on this patch!  It surely took quite
> a lot of time to perform all the testing.
> 
>>>>> ---
>>>>>
>>>>>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>>>>> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>>>>> index 0597de415fe0..7d992c3c01ce 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>>>>> @@ -333,6 +333,7 @@ power: power-controller {
>>>>>
>>>>>                       power-domain@RK3328_PD_HEVC {
>>>>>                               reg = <RK3328_PD_HEVC>;
>>>>> +                             clocks = <&cru SCLK_VENC_CORE>;

Do we also need to include one or all of the following clocks?

According to Fig. 3-6 RK3228H Clock Architecture Diagram 5 following
clocks point to the H265 block:

S51_6 (4PLL) / G6_3 / S51_0 (DivFree 1~32) / D4 ---- aclk_h265
                                                 \-- pclk_h265
S51_14 (4PLL) / G6_4 / S51_8 (DivFree 1~32) / D4 - clk_venc_core
S52_14 (4PLL) / G6_7 / S52_8 (DivFree 1~32) / D4 - clk_venc_dsp

Regards,
Jonas

>>>>>                               #power-domain-cells = <0>;
>>>>>                       };
>>>>>                       power-domain@RK3328_PD_VIDEO {


