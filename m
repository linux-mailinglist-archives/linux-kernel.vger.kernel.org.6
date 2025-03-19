Return-Path: <linux-kernel+bounces-567532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04628A6876E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DB5189CE06
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC62512EA;
	Wed, 19 Mar 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMkSEzLK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E326C2517AE;
	Wed, 19 Mar 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375150; cv=none; b=XQQb4dHAzbntQr6Mp4Z/NsmeH9KKOTfxK6lXxfdtHqJcffOTb+4kp3/ggo8Wwjdi0bQlFUWGF6DlGZWqi7Ac5078JUUUm6z4OGEgo2kTyxQ+oE8DMIuNaZqftY5i2ZjEvuwtWnNtvgXTt7bbS1pC5FukBlhKZsA9OIVuTFB+iCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375150; c=relaxed/simple;
	bh=kCICy4CCtytIDn9KKZBypA5lHyaF55VxprlRT8A13I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvuYiQqkiVHQ8WjX/Fq5Kiw6IrC/hAM7L5zRzxAPZ62KVhKPFmJ27b5a4UE8A4YBCtx2rfwSNxGAHqSOL0wlsk+rvB4hajnWYnpuFdRiWX5N5p/VDszk1aU6s6vanrevbH5lTL4Xmcoy4CYLJp0IdWmD4cKA2IlCYvqHBGuD5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMkSEzLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64A2C4CEEA;
	Wed, 19 Mar 2025 09:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742375149;
	bh=kCICy4CCtytIDn9KKZBypA5lHyaF55VxprlRT8A13I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMkSEzLK0AE8oSZ1o5yHkxSyMJ57JbG2luY5yXtjiB/W8pxCZwgypEK/M+nMZYaBg
	 PpVzybMdlIqWiRxUvOsNEI3QryysH6j/yiwQ5n+9MfEZVX2wx53p4w41TFjj68aL5H
	 4qgG5nKR5hmh+4Xj2ydZHc14ZEYgmyxOxBFQPGFKH+iaR1BLKtgrSQmchEEuv0g6mK
	 i3ilnLTyDB8s4Vl2xw9tTEC6jI+1JdJn0kleMs7a/oOx0JMeCQ7EhGjtorhOzZzaPl
	 tK2EEcnN3S47XljsuEZB2mnwPgAQ9Fr+w7PVdkZ0NZzZ2YhdMYx/SDJNUI2aM0GMQx
	 2shse4TaUepBw==
Date: Wed, 19 Mar 2025 10:05:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add NLT
 NL13676BC25-03F panel
Message-ID: <20250319-monumental-real-ibex-65d7ed@krzk-bin>
References: <20250318-b4-add-nlt-nl13676bc25-03f-v1-0-67e0f8cf2e6f@bootlin.com>
 <20250318-b4-add-nlt-nl13676bc25-03f-v1-1-67e0f8cf2e6f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318-b4-add-nlt-nl13676bc25-03f-v1-1-67e0f8cf2e6f@bootlin.com>

On Tue, Mar 18, 2025 at 08:58:28AM +0100, Antonin Godard wrote:
> Add NLT NL13676BC25-03F 15.6" LCD-TFT LVDS panel compatible string.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


