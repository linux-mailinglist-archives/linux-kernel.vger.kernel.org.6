Return-Path: <linux-kernel+bounces-567482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C791A686A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BFD3B6BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12548250C1B;
	Wed, 19 Mar 2025 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxgSgvvr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ECB250BE5;
	Wed, 19 Mar 2025 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372586; cv=none; b=W1H6hU0d21ql1urN9tSA2t9q1NQFOtzB9bSVpsl+Di8cyhfFL6rYjYWgGEHA9rKKlSVmeY83AKF1XOIuqhuCS+M3KkjvIZ0uKVpMpd7s0f2st4z7JmOtEtntJbGY+W2pGfNqZGvSd0LOwPKMMNp7q1qqCgZLLYCZuliN+diO8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372586; c=relaxed/simple;
	bh=it2hB6Qpnfpwmus4HAxB8waVLgv2/xDPUXA+bYmeDWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqZtNdS0VAbzs3Dl3Egh5FZonrYdtlLWqPOQprBIRSres2ATUtpu/tL3F/sRh4TRVpaRkd9tgVZjg5eUFu7Hc0OWXHlIkBp0PhwTrG/Lew0yaRdEogJITJZ+eNB0A0nbXIX9dvu68WF7gVDLGNhhU8qE22P/a5bfSYywqZLZQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxgSgvvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D8CC4CEEA;
	Wed, 19 Mar 2025 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372585;
	bh=it2hB6Qpnfpwmus4HAxB8waVLgv2/xDPUXA+bYmeDWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxgSgvvr+AxIdcW1pLBUzbPsszc6G2Jt7fN4hByJdp/Pvg/0qhNc8qOjIAihamn9O
	 K2BZN2WOY33xnEz+8zx5GE+0PLFWXsWVvmH8vrgrQHHL6xjEanXg7/26SBeOpeQ9CT
	 ohl0x28d6SfzHRjillUCsiy1BSHfdufjf7b4eQWwXepP4pZeoMZYDTZqZUlPCN1/9c
	 tdHcXJT3yVuPgdXUK5a9WU9vZ9HTdeV4TIkXfdaKnO6mwUVJ0dObx+qVEXMZDG62gb
	 U4s5FACE6LNofAfg32bhrFe2wPNYGvnARLhDoKMdieutACuTddYF46igopjHw1Rjl8
	 t8n29ob65S0Xw==
Date: Wed, 19 Mar 2025 09:23:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: jiebing chen <jiebing.chen@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, jian.xu@amlogic.com, 
	shuai.li@amlogic.com, zhe.wang@amlogic.com
Subject: Re: [PATCH v4 3/6] dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
Message-ID: <20250319-panda-of-unknown-wonder-236812@krzk-bin>
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
 <20250319-audio_drvier-v4-3-686867fad719@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319-audio_drvier-v4-3-686867fad719@amlogic.com>

On Wed, Mar 19, 2025 at 03:04:46PM +0800, jiebing chen wrote:
> Add the s4 tocodec compatible
> 
> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
> ---

So you just ignored everything you received?

Best regards,
Krzysztof


