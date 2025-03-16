Return-Path: <linux-kernel+bounces-563056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C996A63667
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 17:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C38A3AE1F6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238F11C6FF5;
	Sun, 16 Mar 2025 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raUJgTwk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF7DF5C;
	Sun, 16 Mar 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742143126; cv=none; b=G8esQwZOtTnUfmpVXCjslF8g/1HwY3wVxIU24rgPLjKUoL4p/nNNjtYv9onzTNOGfz+G2d01c5Oe8URo6jnrecXKhakEm/WzZH734VqvrkIruoLKn9IYXE4N3LWxP9mV2zI9H0f9bIVWtAE0Je4X4yLGjZ8fFSJHW+BRWUjCCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742143126; c=relaxed/simple;
	bh=hoozwqCdLdNL6BfyUaKSxtOLVcqnyPKzRTACPkvC90g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzpsHrCM0KUSHHIDfQCZgEybmQxTtUDW1rINDsABJAXw9oUEIotrKBh+5Z4+OfJM2nkiDX3SwIrsajB9OPTF6gi4dAjDmfwMrnyNtnCn3Gmx2m6OY0KOcFPDwF9fuv6NSRdrmRyiXZJmvjkEVvJgn4xwV9bi6tTNfURqmqpv25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raUJgTwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E942C4CEDD;
	Sun, 16 Mar 2025 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742143125;
	bh=hoozwqCdLdNL6BfyUaKSxtOLVcqnyPKzRTACPkvC90g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=raUJgTwksPzY3dH/olXTLfP5unKdbgCpEMLPW9cc4LnDWE9EIc1iv/o+MX1Zs++sI
	 PAh6e+0rASdGbdnyyp6ipx+jvxHAOXZkuFFZx9kgKFvRoiHWl1NeNM5VxfIHEg7Yaf
	 gm1ZbPXW/6Jv83czCyKS7Bc8tP1y1/IAhpGhSo32s0bZPZ73gn23z9cjklGnf/mXMV
	 ta77VLhdOhOBqXHco7faVbRFU0SvzMvRzAVmZSVoDf5YAAzN1llih4lR46EMvK8Xm8
	 oOdtZpu39wQy3CEKVlOUXzWVrAS41Db1owtESWkM6IJT13jBlG7JY9Jj53Ej7Jq9OK
	 8f6JGGOvcjvfw==
Date: Sun, 16 Mar 2025 17:38:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, jic23@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, bpellegrino@arka.org, Sam Winchenbach <swinchenbach@arka.org>
Subject: Re: [PATCH v7 1/6] dt-bindings: iio: filter: Add lpf/hpf freq margins
Message-ID: <20250316-sexy-tested-cheetah-c4a2f8@krzk-bin>
References: <20250316135008.155304-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250316135008.155304-1-sam.winchenbach@framepointer.org>

On Sun, Mar 16, 2025 at 09:50:03AM -0400, Sam Winchenbach wrote:
> From: Sam Winchenbach <swinchenbach@arka.org>
> 
> Adds two properties to add a margin when automatically finding the
> corner frequencies.
> 
> Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> ---
>  .../bindings/iio/filter/adi,admv8818.yaml     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)

I don't understand. You got my tag. No changelog here, no cover letter,
nothing explains what happened here and why the tag is being removed.

Best regards,
Krzysztof


