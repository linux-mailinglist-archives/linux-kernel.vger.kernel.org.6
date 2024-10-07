Return-Path: <linux-kernel+bounces-352806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621C7992455
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902511C222A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317681482E2;
	Mon,  7 Oct 2024 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kmxc/Vrt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA9861FD8;
	Mon,  7 Oct 2024 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281732; cv=none; b=IhEdoGQmed3ZPfeyh4HYG1DA+YMpzswm25sM5/Zv/WUs1WnI6DmyRb9FwigOimmYoE9rjaj8kN8cIvleplXtdjhcGx1oP/7lHdX/e+IpaY6gOyZ7AuUB1uaIPD+V2v/mtHSmi43kjfMAT9eYsiZCPdPVNdnlP7buNxZIexbr+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281732; c=relaxed/simple;
	bh=PAlO2/0oeLaCiTChrJrxR82FAuJV1p5u9yp6LU0cKC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuEhJZCycz7Z13FluV3kSs/2z0oe1iKo+bJni14R/Ey8+mU0lHXMe1ykTAcwadiVyRG/xYAFCThMoN2gKnG6H9Azr2BIP1zjyST44yzpEkJk6UPCBDf3Z5kpliBb3rGRgv0wMQT+tMvm1ZlVNoFquSai3ESaFXfREiHUVg3tvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kmxc/Vrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172F7C4CEC6;
	Mon,  7 Oct 2024 06:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728281731;
	bh=PAlO2/0oeLaCiTChrJrxR82FAuJV1p5u9yp6LU0cKC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kmxc/Vrtptz7VB4T+5Eg4MLf6j3QjE9Z/JOfhNWQOaCA72RmnLUnD8iZIzukLLS11
	 wEJoPUy5Sh+5g+KuLZCCkNLCIr7+N1zMJpfpwk1S0BD0bY3mDstUPzP0NnBYlC0FIa
	 FYfbtoingUoR/IY39+45k8uwwowH/6aqIdHN8Fz2mSJFe6HwSuYiKksnyfC6xKG9b1
	 kXsbM3e9gTp2bviCkY7GmgxFNdzm7QuBNmkjlq4i97aMu8sOpPamVN3N0aZXkt1SqZ
	 MpEDQbcU3uOEikP6JM70ljtSwhhc+RLHVB+e7TYwTfaTYrSV8uW0Hz1dFecOAQPybh
	 MZhhcuIh8s5Uw==
Date: Mon, 7 Oct 2024 08:15:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alain Volmat <avolmat@me.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: gpu: mali-utgard: Add
 st,stih410-mali compatible
Message-ID: <w4gdi2vhp7pq62xmdmvspqnwf2szirif5xe4cnok5vpeisqeb4@qfws4d4pufna>
References: <20241006-sti-gpu-v2-0-c6bb408d6903@me.com>
 <20241006-sti-gpu-v2-1-c6bb408d6903@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241006-sti-gpu-v2-1-c6bb408d6903@me.com>

On Sun, Oct 06, 2024 at 08:42:49PM +0000, Alain Volmat wrote:
> ST STiH410 SoC has a Mali400. Add a compatible for it.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


