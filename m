Return-Path: <linux-kernel+bounces-550070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F52A55B07
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAA018945D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFAF27E1DE;
	Thu,  6 Mar 2025 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="FQ/Qn62y"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09027D77A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304553; cv=none; b=VJTSLRfCRGtvNcTVm3U0puiHgUvO84wGArN0gzOO3bSDaR5tRLWETXNpp28k52Onae4E9D2ud2zqzuZI5oJHOpkqNjSCsPIEZA+edqUmOWF4brrwBU5hBN9z23bf7b9bNS8+PCsHeRefl4E4dQ1pXJpWq20rAjoAbfQ4DcwLk2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304553; c=relaxed/simple;
	bh=tJEJfQjhxKeAqPrvSWuWasiFZZaUalkdDqunLHyvNDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F79BLO4rZnUt5QHDyPq/PxawvgJHXMuejiLgtYmNaA8lcp0heu/OcTMslDZkX3UST2Nd+VSRfyiIEa1DMTUyJ1AouatMGruAp3jRYbvWM8mm/HK7SlgvgzpJvBFnHyMHmJU4cmj9N3ZhrV38XvlyvNkgGZQLZ15nqrAehvSO2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=FQ/Qn62y; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741304550;
 bh=hK36UdkUAC80MW7rI32wQbKkvzzOhAooKnorAx3Xf5w=;
 b=FQ/Qn62yhfaawlmV87Y9HKuHV1xOnSpm0/Y3rwCxdut+mZbXUaIslnwCGtsOBIjRqLSMIET0D
 a7DsCfrcgfQAg4ipSi+4oaVe+9ZnyCO6pO4mpCWJQsrxkgXHUdbHqOciObjEpteRmPn9VPDbgwF
 ABvmZ+Z+0r0tzq3HWY27D3j3ZDbuvtNB+eMzLjOgtqyfAx1TYHSxox1kfGCwEIRBkQkCGai7DVg
 TEGGJEI/+EdkvOlaLakEjo7s2KKBLLcLJK4N2hLhh4uW6XHZsg8ktRRj/MeIWd8fxdpqkzftBHq
 dMdcBHBElBU8QIDSacLMNzL+h1IY58DU4aRLeINT6wgA==
X-Forward-Email-ID: 67ca32e3c1763851c065d3ce
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3f341b96-1add-4eeb-b185-b4bfe0bf0250@kwiboo.se>
Date: Fri, 7 Mar 2025 00:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: rockchip-dwmac: Require
 rockchip,grf and rockchip,php-grf
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Wu <david.wu@rock-chips.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250306210950.1686713-1-jonas@kwiboo.se>
 <20250306210950.1686713-2-jonas@kwiboo.se>
 <5d69f4a2-511a-4e7e-bafe-5ce6171cb1d5@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <5d69f4a2-511a-4e7e-bafe-5ce6171cb1d5@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025-03-06 23:32, Andrew Lunn wrote:
> On Thu, Mar 06, 2025 at 09:09:45PM +0000, Jonas Karlman wrote:
>> All Rockchip GMAC variants require writing to GRF to configure e.g.
>> interface mode and MAC rx/tx delay.
>>
>> Change binding to require rockchip,grf and rockchip,php-grf to reflect
>> that GRF (and PHP-GRF for RK3576/RK3588) control part of GMAC.
> 
> It is pretty unusual to change the binding such that something
> optional becomes mandatory. I would expect a bit more of a comment
> explaining why this does not cause backwards compatibility
> issues. Have all the .dtsi files always had these properties?

rockchip,grf was listed under required properties prior to the commit
b331b8ef86f0 ("dt-bindings: net: convert rockchip-dwmac to json-schema"),
maybe this was just lost during the conversion to yaml schema.

The DT's I have managed to check all seem to have the rockchip,grf prop
and the old .txt schema listed "phandle to the syscon grf used to
control speed and mode".

Without the rockchip,grf the driver just logged an error and ignored
trying to configure speed or mode.

We could possible leave it as optional, but when it is missing speed and
mode cannot be configured by the driver. Today this just result in an
error message, after this series there will instead be a probe error.

Regards,
Jonas

> 
>     Andrew
> 
> ---
> pw-bot: cr


