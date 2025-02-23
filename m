Return-Path: <linux-kernel+bounces-527721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A287CA40E94
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC80178957
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25594207DE2;
	Sun, 23 Feb 2025 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4JfxVLF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747412066D4;
	Sun, 23 Feb 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740311440; cv=none; b=eoJA7otMJ/dWua73IeCSO8FAVhin4tm20zNUB4yowosG516rdvteQ5XLKzqjFeYebZryndDHX0ASMs+ojtafkIY7aThp8icEFDQ+28TrIcmo5MddaMFPlkk+mBzYXOEP8ZWj+kCdEwi9OkX/BRD7kwbUF/eg3P2Ctr/PLufxq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740311440; c=relaxed/simple;
	bh=hQuSDA97lCMpIvGvsB8HeScp/fD9G2ojAxcjSBtTtvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaImvoRR3GLFc4+yt1LKauMgraC6lVuzc7JNZPHHSH7s9XiPa/e63MsQzlZgRMzmYnhAs4IjtYUcPEZa+BkqEedsMHMrZC48k1zRVFAJQRTqUIG5Q9oAY91taWZ8289H8lbrJLb+4QuybEmbrFTHJAGvBLf7MPYeikRTMH6MNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4JfxVLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45362C4CEDD;
	Sun, 23 Feb 2025 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740311439;
	bh=hQuSDA97lCMpIvGvsB8HeScp/fD9G2ojAxcjSBtTtvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4JfxVLFiQ5Pu4uqfbL4ygsTH66+gFhJth7YPlh9QN0QceaaE2aPQpUicIj4MMCwa
	 sKkauQBx+HFu+amvbQycxlZmjlfa6gtOfysMB0g2V/KUqF4lzJ0ukL/gzfqkcYPPbN
	 L0rsjNgkXy/VLptBrRy7MSMRAr8ixcZtXymJZ5/SklwZX6BrGusFwVAnYDg7JVE/41
	 TlVVbITRFRS0sSKhIkLoiI8ifqNebhUACfnpDG0KXHNXG9el+xGN02q6mdaiwV3vKC
	 JZHlW/Ja4AXac+IR6Tq7YVv0RLm/FZJtcVykoN9jfH+aN34v9D5/w0hzJQjHXxsh8q
	 PzYto0djL2jMg==
Date: Sun, 23 Feb 2025 12:50:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: bus: add documentation for the IMX
 AIPSTZ bridge
Message-ID: <20250223-ambrosial-macaw-of-imagination-dce169@krzk-bin>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221191909.31874-2-laurentiumihalcea111@gmail.com>

On Fri, Feb 21, 2025 at 02:19:05PM -0500, Laurentiu Mihalcea wrote:
> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx8mp-aipstz
> +      - const: simple-bus
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1

That's not a simple bus anymore. simple-bus does not have reg. Neither
power domain really, because this means children depends on this device,
so again: not simple.

Best regards,
Krzysztof


