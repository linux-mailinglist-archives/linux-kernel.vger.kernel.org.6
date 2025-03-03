Return-Path: <linux-kernel+bounces-541760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8326A4C140
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9ABF16ACD4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A9421129F;
	Mon,  3 Mar 2025 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv5Qnutq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8C920D4EA;
	Mon,  3 Mar 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007170; cv=none; b=LukQdUa+IAZiIQOgPOZRKaSYVnkJiifVJRYZSxtJFvcLBcRWvxC5toki1DaMyu28ZDJCThu9B5iUoynxwOd/SZwfABbu+6DB2Je92MUwzNEaijWlwRCkh6m+oB4/vqrR3/QGuYlpwd4lOtV8AFP0tkEmGyIytSLyRNXBUjupIgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007170; c=relaxed/simple;
	bh=U7M2Y7GgfOD5FgmP0/yeWr/zLGKqkQ7WQ1NWRxr7fog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhWwuCUoVhfJ8Aarx4JnXTgWWhWD8zuA+wI/u58/dohgI759uyDmYH9uJAOU3H3VY7hoK5u2ickiT96alS9E1zmHfEakt4xX/VfnMr9M8oFbXFlnFVW5kLM2F/fwh+uiF2mwU1P5tEN+AV9mG9wDF60FkwrM+IxlhGxbyvbd3rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv5Qnutq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966F3C4CED6;
	Mon,  3 Mar 2025 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007169;
	bh=U7M2Y7GgfOD5FgmP0/yeWr/zLGKqkQ7WQ1NWRxr7fog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dv5QnutqMhY/XAsekkSXJrY0588QyXsYiwaE4fbDhCSBEv8wYviT7sFDWqcwMkMvG
	 5WYxCeIKo+vzFS0/MRNQ7D0vi4xByN+gsxwykOE5AwjiXKyC0ra2FSNTEJy4h0Exmu
	 koOMNTwS60k2KkGXB3XuJkif9Ehyr7jog06uaxGZoWS9Q67Td6sVlkQYxllVDhPiWU
	 4GsK0KohBvshnKe6WFRTqV4SEA75XO0T60eMzJvdiijxHp6M/Dm1kF5RUUJgJ0eMu3
	 PTKXmwFIgGZMn5S93JhvdKJyK1sjOMqrp1lSNoh/cO3zHTFw1fZ7h0eFNI4VwYn+v+
	 jULFpATjJI67A==
Date: Mon, 3 Mar 2025 07:06:07 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	David Airlie <airlied@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add hothmi vendor
 prefix
Message-ID: <174100716718.1436781.17169517427487760851.robh@kernel.org>
References: <20250226112552.52494-1-kikuchan98@gmail.com>
 <20250226112552.52494-2-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226112552.52494-2-kikuchan98@gmail.com>


On Wed, 26 Feb 2025 20:25:48 +0900, Hironori KIKUCHI wrote:
> Add prefix for Hotdisplay Technology Co.Ltd
> 
> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


