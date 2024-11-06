Return-Path: <linux-kernel+bounces-398321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ECA9BEF89
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8992DB24A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ACE201015;
	Wed,  6 Nov 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFG0OwY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601981DEFD7;
	Wed,  6 Nov 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901325; cv=none; b=GOa6vSsRk3VCbVSw7aSSxnEyogL+amAcC9pI4AolK3BEPMQ6YVL5Kx/EOxnIRn1II2XVFUhZrr948vLXv9Qaz3gxa15yMZTEZRSgTT1Cy76cT7WWSupObS1sKGOw3MAk+xp0SuoVMWXsKva83Gzb4jajlrv7jJavOtkdtgrpPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901325; c=relaxed/simple;
	bh=AVIvph9mJZGEATPf56rqGStyyTSb/L8LohsnTsrbixQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIq83s6vnn2BKhj9+vD9Dz6Ox9D+ojlUCPoyotOC6du0v7yjOJP4B4bHWaC8lW789BhXu1p6BfkVLOnj0QXsFzl5kiSr0p80N2aL2v0pUUUz8dbfIodMnuzuUeBrUD9JCYqWu0+nm/4YJb9g96Z21C7qV7e7oaAWERVCPyZs6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFG0OwY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557E0C4CEC6;
	Wed,  6 Nov 2024 13:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730901325;
	bh=AVIvph9mJZGEATPf56rqGStyyTSb/L8LohsnTsrbixQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFG0OwY2lizYvqYNBBAtxFpqa4fzTj5vNKZ7XmTGCYSRgCeIX/b7WFN8Y8WR/kRq8
	 yfjP0dEAlCnj5mRw/UUq+akLW28dlEzq0yfMYXnKUWmpfV/lMJdhBw4I55aQr14UOn
	 rNJFgxiSH9DJP4Eu7fFsEeKElUgzJhrQ9BPraOLaU2yVFkTG3louTZ6h1bXIBh7/CB
	 qHm/k5uHSzoFcHiC7rSh+Bhao+lbOXjm+MNQb9JikOxVhWaOtdlVFtcENfEq9iH53r
	 2CrItMX0CvPnWiUT8whijMVCLM0alPiuKTtIX9rlP9uND5GV+AJujlfgXUxc2zPs4p
	 Pgmej3woBMTDg==
Date: Wed, 6 Nov 2024 14:55:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kiseok Jo <kiseok.jo@irondevice.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/2] ASoC: dt-bindings: irondevice,sma1307: Add
 initial DT
Message-ID: <kspk7qajv7r5glbcawmecbup36cv4wi3hjrgyfyyejjectwwt5@u5nx5y5zirsa>
References: <20241106005800.7520-1-kiseok.jo@irondevice.com>
 <20241106005800.7520-2-kiseok.jo@irondevice.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106005800.7520-2-kiseok.jo@irondevice.com>

On Wed, Nov 06, 2024 at 09:57:59AM +0900, Kiseok Jo wrote:
> This adds the schema binding for the Iron Device SMA1307 Amp
> 

That's a v5. RESEND means you send exactly the same or the same plus
tags.

If you change patch, then it is v5, so the tools know how to handle it
and we do no waste time at reviewing things twice.

> Signed-off-by: Kiseok Jo <kiseok.jo@irondevice.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


