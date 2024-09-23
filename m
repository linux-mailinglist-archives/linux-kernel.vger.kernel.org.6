Return-Path: <linux-kernel+bounces-336168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E89DA97F007
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD2D1C2146E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860FA19F427;
	Mon, 23 Sep 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="aL3yMX/J"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA2C195F04;
	Mon, 23 Sep 2024 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114070; cv=none; b=XSkEtDRnOr379F8XnPBXAhHdkMrPdiy0rj6e2QUolDCN5T7v1dKs5IM9B8siMqvOwn9aKUNHYZ9PKxSX0gFXtKbVzMrsV5+qNQgsAoEVnbJDPfZxTKHlWCiSnkdyzedvAZm6O4eDhH3GRjkPY8hY3u3OL4ZFws3JXYxuqOV1XwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114070; c=relaxed/simple;
	bh=TViihplpYmTLVoAQLbgGg60WZPa7KMt44nwrCrsbthU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j+VakpIhq0iWekkrNiNsnhCxqiMhMlC42PL7FIkGidSJV7JC5yHlHKG5o7YTKAUoE/on7l6otfJGqKXLQo3vlfqIvrsoTTs1DyzhvayN10R+NUl6o+laT0+5w0cuF0H1dYailJNrEfyOgVnYbPyLroyUnGAgSU3oohqwidQ0/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=aL3yMX/J; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AAC0C88599;
	Mon, 23 Sep 2024 19:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727114064;
	bh=MAhD+Q+O0foYr+lOstFd3yYl5SeKIjk7ofBPTCMpGHo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=aL3yMX/J5J+OkKscfj+8rYMxymaiuSxBr7W5deusVTgK9u6ZX5ygbD1q6FPnGdvO5
	 Z76ZEEloYjNrZuyGsxzGpE57+8gn20BB9ImLHxEGjUl/Qpz7sHU38i170HM42QNht1
	 gYljmbSksXzuOa9qcMaefsvOEnE2jq4L5+McN7odUypVBl4Ot11oyoK5O13+AUGyRF
	 5pK8bmP8C1cJhRPknIys/zsepyp/qPZa/BQTuoeIwa+tW7LsDjExfpma08i5Jxe9Vm
	 22Dt+jtsMi4BNb97hnhngGvTTvifj9sr4A0gX72FRvgiiTHDxhhQ4N4Vm10tcBUsqW
	 sLYDGJxnFmIQQ==
Message-ID: <0e72b574-14ec-4369-b899-30d5c615d238@denx.de>
Date: Mon, 23 Sep 2024 19:53:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] dt-bindings: lcdif: Add support for specifying display
 with timings
To: Lukasz Majewski <lukma@denx.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stefan Agner <stefan@agner.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923135744.2813712-1-lukma@denx.de>
Content-Language: en-US
In-Reply-To: <20240923135744.2813712-1-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/23/24 3:57 PM, Lukasz Majewski wrote:
> Up till now the fsl,lcdif.yaml was requiring the "port" property as a
> must have to specify the display interface on iMX devices.
> 
> However, it shall also be possible to specify the display only with
> passing its timing parameters (h* and v* ones) via "display" property:
> (as in
> Documentation/devicetree/bindings/display/panel/display-timings.yaml).

Timings should go into panel node, not into scanout engine node.

See e.g. panel-timings in arch/arm64/boot/dts/freescale/imx8mm-phg.dts , 
in your case the compatible might be "panel-dpi" .

