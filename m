Return-Path: <linux-kernel+bounces-527038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D35A406AA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9C819C3991
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435D2066FE;
	Sat, 22 Feb 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="jQrp7i0f"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BACF1FF7BE;
	Sat, 22 Feb 2025 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740215245; cv=none; b=IVSIx8SLom/XjXf2QTKfJ7iqvUGxGX61gn4AQFROBMAwu0GS4350ZNXVODDzTCB1eKPIYkllJm9/HR+QPrwflgkWOyKh9iEVdlmwJM1VsDyL9fxJZPJJtHYyNwcnfGrU8kmY8RGPWChw+RrDfK0XkAAHdjZyB124AsU/6/wG6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740215245; c=relaxed/simple;
	bh=zjYc2Ie2/4kmumpOTQmy43l6IPouj3d+7Il32MfM+Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWdNT9vT3Qkb63ug3euhbR8VkXh3hMYPZBPzM/lNmLgIyz8gGdJrhkGx+SDYsGsxcYXCwL61nRQFOY4WpoFtppRQmdnc3izk2/84Givzr6OAjSQq/pCHsCz+T5ywvVlRK9zPunErM4wcxZyUY+Zq3UWYuqRcR/Y19qEaem4g/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=jQrp7i0f; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=5WsUmyuRPcbB5IqUP9yGlRIPUiXsRxJ+yOeFKDF2Uhc=;
	b=jQrp7i0fN7LcLmrMQgBE+aDL+TzGDL6+mkUjdKX1gLw5dJJ0X95rplCpiOAFYB
	KtNXh235hWYK/I9jdfqurJosG5PP4+sHT6Ay0vnCa0n5wkB0Ifqnr4UWbX92pXjm
	jHo25K/tBNu2b3j6B+LiluLeq1Yle5MPOX5zT8Qo9BWHw=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgA3fu6bk7lnFOKNCQ--.22045S3;
	Sat, 22 Feb 2025 17:06:36 +0800 (CST)
Date: Sat, 22 Feb 2025 17:06:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm: dts: mba6ul: change sound card model name
Message-ID: <Z7mTmtEIKRlQ9cpF@dragon>
References: <20250120132503.556547-1-alexander.stein@ew.tq-group.com>
 <20250120132503.556547-3-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120132503.556547-3-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Mc8vCgA3fu6bk7lnFOKNCQ--.22045S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr43uF43XrWfWw48Zr1xuFg_yoW3JFc_AF
	Z3J3WDJws8Za1rCw1F9r4YgrZa9ws7XFnrGr13WwnxX3WFyan5GFs0qrySyw1Uua90g345
	Cr9aqw4v93yjkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0eHq3UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQj7ZWe5h8snTQAAs-

On Mon, Jan 20, 2025 at 02:25:00PM +0100, Alexander Stein wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> The card name for ALSA is generated from the model name string and
> is limited to 16 characters. Use a shorter name to prevent cutting the
> name.
> 
> Since nearly all starter kit mainboards for i.MX based SoM by TQ-Systems
> use the same codec with the same routing on board it is a good idea to
> use the same mode name for the sound card. This allows sharing a default
> asound.conf in BSP over all the kits.
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied 1 ~ 3 with changing subjects "ARM: dts: ...".

Shawn


