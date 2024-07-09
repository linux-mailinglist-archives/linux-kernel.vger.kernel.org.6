Return-Path: <linux-kernel+bounces-246685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2FC92C530
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBFA9B21C34
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B906018562A;
	Tue,  9 Jul 2024 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="E6m/rBvf"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809D18004E;
	Tue,  9 Jul 2024 21:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559579; cv=none; b=d6jb8bFceT+h1W1Gg/RZU6KA/hwGcYDUibkRPAqf1ii7I8SQONvgRImXMgcB1bNkLf7XGqb0y5WpXvIDGpfMdHiKoE+KBrx77ML/dTpMcevi8oZ3ZkylocClmS/YY672XCZ71t8ALRxO9fbY796G5+7m91ytazDgl4HCSfP9hcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559579; c=relaxed/simple;
	bh=ZQLcCo+JCusuv6Y+S21jZr/MkdBipRmNT9NNGQFy3qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZFCT90t4i2Fs9cOEUNYwm3tikiB1C5eZrrFuLLKh1atglb1pZCt2WRHOEMD/6WEWcturpFr8gYVVJ/BhxoS5Wlboa7h2sSe0V3ctcTnaVYdZiQFaikcimkM9wCCip9rSs7V9iyKQy6lqAkR4yu5Qm+74x7f5Oe7RcIrv8wgOm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=E6m/rBvf; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A81EA87919;
	Tue,  9 Jul 2024 23:12:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720559575;
	bh=1noTMqY/rG3qSD8Wta99giMVhqcbXHJ0pLLor4uc6z0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E6m/rBvfqIXAVMElepNFtOiMpn9+X3EsvyHC6aK3G5jL0yMQGgoCrxXl8fDkbc4mX
	 aHf54Bv/xpF/b3/ak6COaOHwf6kNOfnVXcuvLMhp9vg+F2722O0bzc2wqAjejP9luw
	 39ssu2GPwh5aHTbCoozbXGFSsE9CIMnW8QsUWsRy0pKc9xNkD2tdMmB/KYwnpJSgB8
	 CnePzCGe2P7VL58OK0BLIgn6zAUVdKsirgJ9KxwrE4W5MHmnuzLxx/a13R4ICOF0Oi
	 pPZQByDve4Hv9DGImZwx0OK1HmcmvbAe15hkjk0ygJkB43p3OgrGuYn7sGoWzxzyUa
	 brXcXUkcESYSA==
Message-ID: <8ae33208-3273-4bca-8371-6fc1ef50061f@denx.de>
Date: Tue, 9 Jul 2024 22:25:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: bridge: ti,sn65dsi83: add
 burst-mode-disabled
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 "Noah J . Rosa" <noahj.rosa@gmail.com>, linux-kernel@vger.kernel.org
References: <20240708151857.40538-1-stefano.radaelli21@gmail.com>
 <172045725750.3389992.15451403448241421795.robh@kernel.org>
 <CAK+owohBrewYFpDKjsE5iWC5OQ3p6S_9fwj7DWa1Ux2h8CXcAw@mail.gmail.com>
 <944ecc41-9ef7-4d9e-9d96-3c5c0cdb71b5@denx.de>
 <CAK+owoiQY8OYiZofyq4jj2S3Mg6ub88DF5V52JcppxhWbUsWgg@mail.gmail.com>
 <223b287f-4da6-4ec1-be7c-6135215c5551@denx.de>
 <CAK+owogLctqu17cFEQH+258wrpfMJ4iE6iJABRu5dwxDtR21EA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAK+owogLctqu17cFEQH+258wrpfMJ4iE6iJABRu5dwxDtR21EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/9/24 7:30 PM, Stefano Radaelli wrote:
> Okay, I get it.
> 
> So if you think this mode shouldn't be implemented within this driver, we
> can close the thread.
> Just for information, this driver has been implemented from the work done
> by Compulab (as it says in the driver's initial comments), and they do not
> put the burst mode by default, not even giving the possibility to activate
> it by dts:
> https://github.com/compulab-yokneam/imx8-android/blob/master/o8/vendor/nxp-opensource/kernel_imx/0055-sn65dsi83-Add-ti-sn65dsi83-dsi-to-lvds-bridge-driver.patch

This is not the mainline Linux driver.

> The panels that I've had these problems with are some of JuTouch's
> 1920x1200, for example JT101TM015 , and I solved it by giving the option to
> remove this mode.
> I have also heard from other colleagues who have had the same problem on
> some dual-channel displays.

Does that problem happen with the aforementioned driver or the mainline 
Linux driver ?

