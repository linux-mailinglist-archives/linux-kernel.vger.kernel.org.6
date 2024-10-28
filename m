Return-Path: <linux-kernel+bounces-385288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F369B3513
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0381C21BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8921DE3D8;
	Mon, 28 Oct 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="aB0OraB1"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0A1DDC13;
	Mon, 28 Oct 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129925; cv=none; b=Ow2WOK0t1Qv6tF926IwTpge9Ee5+DO+xuoUwJlYwpV7vsaMqUEcfn8exm9M2uRKXwgmNMiGeF2/FQ0U9Z/8/t6DTlA1L/kpPkpNnYTnOfWsz/ovMuU64aETfNle17MX0ghV6GiNRTGtG11i7oZqxLbLgH0Yd92pqqP57Vd31Iko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129925; c=relaxed/simple;
	bh=gaA1FXCRnUA4p8HJeCOLasHPl+EKQWo/TWi9FoBC/PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYI9/KMzvUbV545re8BcGESzP0JpX8ELM67bxlzXReW+vTsQrbXaYdAT8pPSiDDd0l09mGtgK+FIJ8oW46LYjKSSQzo2aoy/VAna2JhFlzdxrtVYl4wWs9QgGU6TmcaZ6qocQ+wDYlDF5bcoUJtpJeOWcG8KZ9SozkIZxyQJwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=aB0OraB1; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C380688D06;
	Mon, 28 Oct 2024 16:38:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730129921;
	bh=6XbJkeIa3iLwKBXFzr8b4G+oAY5+6vfUzf/eFUGme14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aB0OraB1C39n7VIdst2KqQvnjeHhYTqCLt09iV2LL5wePYEt2/SujwSqCJd2MQio0
	 bcseKVq/zkxFocl9Y7wzaOz4gU97bVEELRCU+VVnpZ+XjZBMehQcszJmqRBkleaISz
	 V7DRvI1jJkxGP4jJRj6WJKi2bXO7HlMl4tSCkheaBqkZyI0S5EzMRoXDsXWyXxAWAL
	 Yd90pn7oEPz3qKUxVLUyQVPJCVCv/9vnppDkY3n+IuLWq2hhXHRuyuO0lQ49WkgcO/
	 4lZMBgqvlWhLQJ/h0XR9Lv3kdRc9L/6UYMGrGdeGE+JzuGLJEeFDUwH+eNlbRO83ui
	 S9czEDYBpKimA==
Message-ID: <c9c5064e-e780-4bfe-b85d-7930df7a5443@denx.de>
Date: Mon, 28 Oct 2024 15:47:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
 <20241024095539.1637280-3-herve.codina@bootlin.com>
 <78a09625-6bad-4fda-8ee5-92b8dd0de381@denx.de>
 <20241028090220.1fd803ff@bootlin.com>
 <16edb769-a608-4b6a-9391-a63a69df8c8d@denx.de>
 <20241028145259.5d520445@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241028145259.5d520445@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/28/24 2:52 PM, Herve Codina wrote:
> Hi Marek,

Hi,

>>> On Sat, 26 Oct 2024 00:53:51 +0200
>>> Marek Vasut <marex@denx.de> wrote:
>>>    
>>>> On 10/24/24 11:55 AM, Herve Codina wrote:
>>>>> In some cases observed during ESD tests, the TI SN65DSI83 cannot recover
>>>>> from errors by itself. A full restart of the bridge is needed in those
>>>>> cases to have the bridge output LVDS signals again.
>>>>
>>>> I have seen the bridge being flaky sometimes, do you have any more
>>>> details of what is going on when this irrecoverable error occurs ?
>>>
>>> The panel attached to the bridge goes and stays black. That's the behavior.
>>> A full reset brings the panel back displaying frames.
>> Is there some noticeable change in 0xe0/0xe1/0xe5 registers, esp. 0xe5,
>> do they indicate the error occurred somehow ?
> 
> 0xe5 register can signal any DSI errors (depending on when the ESD affects
> the DSI bus) even PLL unlock bit was observed set but we didn't see any
> relationship between the bits set in 0xe5 register and the recoverable or
> unrecoverable behavior.
> 
> Also, in some cases, reading the register was not even possible (i2c
> transaction nacked).
Oh, wow, I haven't seen that one before. But this is really useful 
information, can you please add it into the commit message for V2 ?

Thank you

