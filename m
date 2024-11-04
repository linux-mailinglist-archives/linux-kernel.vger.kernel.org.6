Return-Path: <linux-kernel+bounces-394332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E4E9BAD81
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB951C21070
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122519AA5D;
	Mon,  4 Nov 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="oC4uW4rK"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6318C320;
	Mon,  4 Nov 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707028; cv=none; b=gRjWXOM0cpy+PQnXfXPbWpmXPgfSuw8l5Qw4N3qePXtTMyp0qU1ctKtLDCMS0KpDqFWBkdWsuApHomICvdyV2Koec3VK/XLNZlgRZ6EVAi5+sSZftmWHBwFnCdrm/3JSrIGobOikFSvwp0nJYvfYVEG8osgn+BmdC+b49I0eQOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707028; c=relaxed/simple;
	bh=X/dRJ1Gkhm6/NRFvQ+4mJB+CftfVKw4BMgBeKwyvhAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WN344hw/mQi+mWTCP/U++xuMlHcZcbLsy9cMDtAhU4+485sv1HrqBdtIi8GtaS6/VXb6Psm+5cUVtwoGUXxm72qReXDtgLj61rwb4Uj+zpcMUeCnEwsOPPb0G3ap6uLmtnraCqFmi10W84QMmjIhulC5xgq4uaNm7IODYV6glnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=oC4uW4rK; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [192.168.1.107] (87-97-112-21.pool.digikabel.hu [87.97.112.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 78E05888D5;
	Mon,  4 Nov 2024 08:57:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730707024;
	bh=2lhytOz/pMLw6cwoN72tfr5dCndGkwWb50ggJNngL6Q=;
	h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
	b=oC4uW4rKzPa98MJMV3tddMN7nd3UbXkHVvUeAEYPtrnwaGOe1ezUvowN8GKP0IDvT
	 Qhc2aumIuJiwxzOc3br2cNL8YDgkQYjmoDMh+ZqNo08iSjr3lYWDmXWwhYzk2bbv/K
	 Uu6bgFK+aUskJ/PfxusWxP39mIlu4fISR9bNAqi4nE48xK6fpAeQcOTBncC3R5t0Rt
	 I9qLWEYUKkaH8AILQ4OXa6LjSbMXIZ4Di37hVApg8MVXv1n62wCPbhcJUHg6r8yTlW
	 AXf07mzwkqZswRY6m7kAayldZbRyuxbBn8G2scrFM01VVP099iA7gFR6hlYJ/SkC4X
	 sGfXoKH2kRvnA==
Message-ID: <4e5a3f32-f959-8106-ac32-f802353dbcf6@denx.de>
Date: Mon, 4 Nov 2024 08:54:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mp: add aristainetos3 board
 support
Content-Language: en-US
To: Shawn Guo <shawnguo2@yeah.net>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20241031151238.67753-1-hs@denx.de>
 <20241031151238.67753-4-hs@denx.de> <ZydFO6b6oe9widaa@dragon>
 <5340fb82-bda0-d22f-23df-de620c8d61c3@denx.de> <Zyh0AgJZh1//17Te@dragon>
Reply-To: hs@denx.de
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <Zyh0AgJZh1//17Te@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Shawn,

On 04.11.24 08:13, Shawn Guo wrote:
> On Mon, Nov 04, 2024 at 06:33:55AM +0100, Heiko Schocher wrote:
>>>> +
>>>> +		semtech,probe-reset;
>>>> +		gpio-controller;
>>>> +		interrupt-controller;
>>>> +
>>>> +		interrupt-parent = <&gpio1>;
>>>> +		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
>>>> +	};
>>
>> Should I remove newlines here too?... but looking into the example from
>>
>> Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
>>
>> there are this newlines ... so I let this lines in... or?
> 
> Not having newlines in middle of property list is just a style that
> I prefer for IMX device trees.

I remove them too than!

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

