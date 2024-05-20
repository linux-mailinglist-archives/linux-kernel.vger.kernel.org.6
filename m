Return-Path: <linux-kernel+bounces-183665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D072B8C9C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAC61F2282F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA795381D;
	Mon, 20 May 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A37SLlAn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5D951C28;
	Mon, 20 May 2024 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205242; cv=none; b=ROG2wCa+aXF0LbuC8c8KxISUoMzx+ui4S78mwXmgW0+8xVctv90owTuqk6kOjSPoQ3abW01Ty8vYUdquZgOlxOdTGBIFh+N5NL8V+V3y36FslH2JkYP+l9qXUwnP2vWssOD3HtmehRO7d4Y3e+fjmqzU7gFXExKBA9wTlj541Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205242; c=relaxed/simple;
	bh=1CxBRe10np86Umr/5juEyiv66Fz5dDdZI72dPAmGDC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1i/jknt+EwmWp17YCXsoC4+tRhAOxe4RSpTUubOFBzoX2PBdLgG79HDtji9uXCGjliyeMq9ziRSxQSbM2V3gRJV/msR+fxTxHWt9C7QxRILHZzsluaGOcnFLMV1+HR9O2RQMKxzrXbYa5z0TXqpg/fw16a2Ormxyw2n37L8dMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A37SLlAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA9BC2BD10;
	Mon, 20 May 2024 11:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716205242;
	bh=1CxBRe10np86Umr/5juEyiv66Fz5dDdZI72dPAmGDC0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A37SLlAngFF8mOaT9XXxG2buur3/HwE3y7TavFi96pzp3UdfOgQ5AlU4GTgat/45W
	 Kwe/y2x61toVlr9x21pkhTCxk3vaBDz0DDCNaghEu0WCzQwG1EpqOUmtaNJtIygFUr
	 zwp9z2uDd47J/EgPs5P9t0FVx9gF9IHyaWaCjYANBXEoxaRJQtcpxgdPoo3mE6KBhs
	 +DWQptKIcraGuMZXbKIFpUHaMKS0VuWHeXJyGaz1NSzZXq+w5xo+eJUfYOSeW59jMa
	 2bbLd0SeMx6rTBFl2phqKbQfOvy+hWHhLJJro7ar1G7fRDNe8W67sCRcO+u21pYAK1
	 w6XouHaJPoAfw==
Message-ID: <d922f7b7-0e9f-4485-b746-0cf968dca570@kernel.org>
Date: Mon, 20 May 2024 14:40:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: ti: k3-am62a: use a specific MCU
 controller compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
 <20240518-dt-bindings-ti-soc-mfd-v1-5-b3952f104c9a@linaro.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240518-dt-bindings-ti-soc-mfd-v1-5-b3952f104c9a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/05/2024 23:07, Krzysztof Kozlowski wrote:
> SoCs (and associated MCUs) should use dedicated compatibles for their
> nodes, not re-use one coming from an another SoC.  Using an incorrect
> compatible does not allow to properly match/validate children of the
> MCU device and causes dtbs_check warnings:
> 
>   k3-am62a7-sk.dtb: syscon@43000000: 'syscon@4008', 'syscon@4018' do not match any of the regexes:
>     '^chipid@[0-9a-f]+$', '^clock-controller@[0-9a-f]+$', '^mux-controller@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

