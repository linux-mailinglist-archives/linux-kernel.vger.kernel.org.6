Return-Path: <linux-kernel+bounces-382892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0FD9B1496
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE76B1C21490
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 04:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123AA15C139;
	Sat, 26 Oct 2024 04:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="bLFAPdY3"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6A2F36;
	Sat, 26 Oct 2024 04:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729916370; cv=none; b=pnwx2Kyaf5ZWwWp83Of1wmlSc1APlPzbD4HyjxXGbqglGv3cCecd/lIDy4L3I5qqC8UgX74J9Lmpz6CebTdT+y2Duc9khWoKD4SEoXcm4vMA+YASZG0w7le0pEueAmVQD5qfL7qDUWde+M40ZtbacyvhOJkTFEggNHeSryBqTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729916370; c=relaxed/simple;
	bh=hDJNh6grgJ0o5MoLnNb93yrBnQQN2xpxX5gr/rlKdKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ot+qRgGEMG2cxS0BmraCpKAHbyJXJL3++u4iSD6cMRgoYccIKnfh95BR57JlCvwrnoAF8uLk8phmD8sDKtMJ6Co2XytgKk3ztZ2KSxcnglGL84HLqm6glrHI6cXLq50C3/zKWCkJinDn8VsI/3heeW+YPsoun8ZYqwRHa/52FEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=bLFAPdY3; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 164C388DEE;
	Sat, 26 Oct 2024 06:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729916361;
	bh=wyt6G+wlaGhTjpeM57gn1zrzX+YedbqaguZF+7Fug8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bLFAPdY3NZ1X8dwnYg2skZKkvlkVp79mML8R2nsEFbW4mGltjZzlBQ7KB0Ty4QJQz
	 pjEBwN+3vZd3BD1roQ9almqxI6ZU5pdAbd1LxhKffJeHuh4Icli4VM2Ecc6RcYYLBd
	 BI78Rz/lkfDEV/mZVhq8J0fbTGUBb3g/Hm4OfrlF9tXqSgR9GFBI9G1vSI3XbTUHag
	 C65eElfJ+ThK4mSXhN2gXYAwn/HWlf5ZWmkFkxB7Wl4ONg34iHf7jTW1lrUg9fnyeB
	 zpwlRJPbtZiGnYpquIr4hO2YoYag95xqIcHmDMXsvZ0UxoS2DcSBb9Y78riNBCwHyX
	 xiKQzl/kjMNGg==
Message-ID: <78a09625-6bad-4fda-8ee5-92b8dd0de381@denx.de>
Date: Sat, 26 Oct 2024 00:53:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm: bridge: ti-sn65dsi83: Add error recovery
 mechanism
To: Herve Codina <herve.codina@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
 <20241024095539.1637280-3-herve.codina@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241024095539.1637280-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/24/24 11:55 AM, Herve Codina wrote:
> In some cases observed during ESD tests, the TI SN65DSI83 cannot recover
> from errors by itself. A full restart of the bridge is needed in those
> cases to have the bridge output LVDS signals again.

I have seen the bridge being flaky sometimes, do you have any more 
details of what is going on when this irrecoverable error occurs ?

> The TI SN65DSI83 has some error detection capabilities. Introduce an
> error recovery mechanism based on this detection.
> 
> The errors detected are signaled through an interrupt. On system where
> this interrupt is not available, the driver uses a polling monitoring
> fallback to check for errors. When an error is present, the recovery
> process is launched.
> 
> Restarting the bridge needs to redo the initialization sequence. This
> initialization sequence has to be done with the DSI data lanes driven in
> LP11 state. In order to do that, the recovery process resets the entire
> pipeline.

+CC Michael regarding the LP11 part , I think there was some development 
to switch lanes into LP11 mode on request ?

[...]

