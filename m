Return-Path: <linux-kernel+bounces-421072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA079D865B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0750316AE2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A31AB510;
	Mon, 25 Nov 2024 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRMs/pyf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021E2B9B7;
	Mon, 25 Nov 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541085; cv=none; b=SP3rmLPTpupsMRztf/ldUyNbtiASGuuCKSh4WjkNCb/dv2ogiQeBVRRfDmVEqaA7IpzkUYrOO90sD3Lxp6ic6zExE4+Klv+oiYJbGmav2zqJLwWxxc2SS9S5B/GETHvgIQDAABgXxZJdFe+xwd3Z9+6cqbCPSjuFEiWxgnNHsp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541085; c=relaxed/simple;
	bh=Zmb6uueo3Ca6bEeXTC15TYf4oyTbrbabWc+2u0BilqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCrlwjqh03iJUatqkEoQpYF9g2Msnw0bdFGtOb+uhkPR605Fe7oGctxH/mGXgMJHBdRmRG6eiAbqyfTvrV3lg8gf+RHg5U9bbh93TnVKXRATzAwsPy2EuKbLCApMPFeS7vYvYddD4foTnBLMQRl0EzF1nzTRahKD/KpkCl4AqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRMs/pyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C709FC4CECE;
	Mon, 25 Nov 2024 13:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732541085;
	bh=Zmb6uueo3Ca6bEeXTC15TYf4oyTbrbabWc+2u0BilqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRMs/pyfXyrET4QU4JeZj9TKDK2z0K3kpSAhsaEgkb9ESvfBAGKXe3mLC3gccHqFD
	 xe9yclWfDw5hlKeFTJ1lYVhGXdFovVY7AYsNxRnpRsLgnM6OuTYJPPxIMFpZ0IKSc5
	 YOC5H4rBDHJhf5wnuqk9YfAGwyrcegZUWAp5En+3ytekj/S5BQwX8Cd5RPiQgnHqed
	 ikXbYBZSZQD8NKP6QpvdnkeTO7earIUrAfB7/jYDgg18YExuMoBTSGRUijLolQ9Aru
	 +MXFEm7NOcPFBbmVbRsC37unLip6Wc8joGqLG9XXCNfrNg5ez7WpWASsXXFP3Aubd6
	 YTs6LHTzg1nTw==
Date: Mon, 25 Nov 2024 08:24:43 -0500
From: Sasha Levin <sashal@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for v6.13
Message-ID: <Z0R6myuCR4Jpmc_y@sashalap>
References: <20241118210730.GA3331421-robh@kernel.org>
 <Z0NUdoG17EwuCigT@sashalap>
 <c25e6a80-f6dc-4ef9-a90d-0fa09cbbc217@linaro.org>
 <Z0NbeyTwxo-M4Lgi@sashalap>
 <936bf452-3d1f-4940-9a91-69efcdc6985e@collabora.com>
 <CAGXv+5FLkZbZVHNkfRWuT+OioZ0TG=u2WfaFCx-jZFi73QHnVg@mail.gmail.com>
 <19ba4910-f909-41b4-ba62-c904bc37d41d@linaro.org>
 <e77669ea-9edd-4321-8d17-4da40161b59d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e77669ea-9edd-4321-8d17-4da40161b59d@linaro.org>

On Mon, Nov 25, 2024 at 12:33:48PM +0100, Krzysztof Kozlowski wrote:
>On 25/11/2024 12:00, Krzysztof Kozlowski wrote:
>> On 25/11/2024 11:34, Chen-Yu Tsai wrote:
>>> On Mon, Nov 25, 2024 at 5:48 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 24/11/24 17:59, Sasha Levin ha scritto:
>>>>> On Sun, Nov 24, 2024 at 05:47:33PM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 24/11/2024 17:29, Sasha Levin wrote:
>>>>>>> Hi Rob,
>>>>>>>
>>>>>>> On Mon, Nov 18, 2024 at 03:07:30PM -0600, Rob Herring wrote:
>>>>>>>>      of: WARN on deprecated #address-cells/#size-cells handling
>>>>>>>
>>>>>>> With the commit above, I've started seeing boot warnings on a few
>>>>>>
>>>>>> And same boards do not report problems on the next?
>>>>>
>>>>> Looks like they do. I haven't checked it previously, but I see that we
>>>>> have similar warnings on a few boards that KernelCI is testing -next on.
>>>>>
>>>>
>>>> That's... horrendous.
>>>>
>>>> I hope that we can get a proper fix with a bootloader update on these (now very
>>>> old) devices... Adding a Google engineer to the loop so that he can follow up
>>>> internally.
>>>
>>> AFAIK that's unlikely going to happen given the resources needed from
>>> the ODMs for a firmware re-qualification. Or we would have fixed the GIC
>>> bug in ATF and had pseudo-NMI.
>>>
>>> Some of the firmware code involved is 10 years old, so even the RK3399
>>> Chromebooks, which no longer have support, could suffer from this as
>>> well.
>>>
>>>> The alternative would be to hack-in a firmware node to mt8183-kukui.dtsi, but....
>>>> ...ugh. That'd be indeed a hack for the sole purpose of fixing a bootloader that
>>>> is acting in a broken way, and I don't like that at all (...and I'm sure I'm not
>>>> alone!).
>>>
>>
>> Then we should add it to the exception list. Let me take a look at this.
>https://lore.kernel.org/linux-devicetree/20241125113151.107812-1-krzysztof.kozlowski@linaro.org/T/#u
>
>I sent a fix for this platform only. You did not paste links to other
>failing platforms (and sorry but kernelci web interface was absolutely
>unmanageable and unusable, so I am not going to even try to look for
>them) so not sure who should be added to list of exceptions.

The new dashboard isn't *that* bad :)

A list of platforms that show this issue:

- google,spherion-rev3 | google,spherion-rev2
- google,steelix-sku131072 | google,steelix
- google,tomato-rev2 | google,tomato | mediatek,mt8195
- google,juniper-sku16 | google,juniper | mediatek,mt8183
- google,kingoftown | qcom,sc7180
- google,lazor-rev5-sku5 | google,lazor-rev5-sku6

-- 
Thanks,
Sasha

