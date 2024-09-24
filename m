Return-Path: <linux-kernel+bounces-337796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADF4984F15
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC09280E10
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C52189516;
	Tue, 24 Sep 2024 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="KpAHvQ49"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC4188CD5;
	Tue, 24 Sep 2024 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727221459; cv=none; b=JWmErSOs6c/sT8mrc/mEUNuQk49pjnp+rCarg4qpL+YHZDK68HrD21dFrta4dWEOHY8odZXU0ed4NhPNah3NosJZLtAptddTe9RE+8K+0jypbcss/U4YP0RQMNQAqAmN6NVbTVZNa/Wi1srVKYM+7Uow3BFqeyy1IcqugruZ73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727221459; c=relaxed/simple;
	bh=AotKFPH7QXcrobDMlW4cjwINVaM1enlUOmrAycDyfIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCXg8RbYyYdQb9AJNTyoQj65wVFJzXA3xcWmsYzHQz8/z3EaOxG2IoXSpYsvhYf8xR2NCWmid70jh81lNY654OO7iWWsTNuGMR/2Nq9VnG3+E2BM4YgZXoB2HOqPDsVcbeNnIuiSDjXIpR+agDmXB2pD6CqgLzuztFzFqAlrtj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=KpAHvQ49; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3007188B14;
	Wed, 25 Sep 2024 01:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727221456;
	bh=JcziicMMJvzimVi9UgPNdctmny3nPPC0wqwUTrVG/Cw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KpAHvQ49SvyQev5x4UdCcIavnk/TP8DonOJcyWmsVSvF4wwviGK4aqu/hDVhU+RMJ
	 Pfn9wR+holwkMRsKh/kYAAlJNlIcebgKrlLbx44mn2fKHSsYVcP5LpytSnQQwuDC02
	 Oaj4Gyl4Krm3Sz1xJpuhSYY+1dy+G0ORJHw0vZJr0P1/IIPy9wx0tjmeO5nvxEY35Z
	 grAno1wJGdCh860VysfvPPnI+hLXzzb8TPrKMBVVrIYAPxpk8b4EbH1Hq2s6pFkYBq
	 nBBxXYjFu3qOtTVSeqNp8cv4UAfi3a7LAVr73/xM4F4bpBHGnd2x/deKQ3Vsvw1U8g
	 LQhg28dvPT0Jg==
Message-ID: <16316a89-04f8-4a63-b453-45562e4294d7@denx.de>
Date: Wed, 25 Sep 2024 01:44:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: lcdif: Add support for specifying display
 with timings
To: Rob Herring <robh@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923135744.2813712-1-lukma@denx.de>
 <0e72b574-14ec-4369-b899-30d5c615d238@denx.de>
 <20240924225714.GA441530-robh@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240924225714.GA441530-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/25/24 12:57 AM, Rob Herring wrote:
> On Mon, Sep 23, 2024 at 07:53:57PM +0200, Marek Vasut wrote:
>> On 9/23/24 3:57 PM, Lukasz Majewski wrote:
>>> Up till now the fsl,lcdif.yaml was requiring the "port" property as a
>>> must have to specify the display interface on iMX devices.
>>>
>>> However, it shall also be possible to specify the display only with
>>> passing its timing parameters (h* and v* ones) via "display" property:
>>> (as in
>>> Documentation/devicetree/bindings/display/panel/display-timings.yaml).
>>
>> Timings should go into panel node, not into scanout engine node.
>>
>> See e.g. panel-timings in arch/arm64/boot/dts/freescale/imx8mm-phg.dts , in
>> your case the compatible might be "panel-dpi" .
> 
> I agree, but if this is already in use, we should allow it. We can mark
> it deprecated though.
I don't think it is in use yet, at least not in upstream, so let's not 
allow this.

