Return-Path: <linux-kernel+bounces-527715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10263A40E74
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC75C7AA15E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C155D205E0A;
	Sun, 23 Feb 2025 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUeCqCFf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212932045B9;
	Sun, 23 Feb 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740311195; cv=none; b=Zezp0zTT+e74njCZJNFJf/trWirk4LxBgG3T/YgxLHYLpzLdl5WCahbh7JifNOqznBNX/WP7W4CAgzVhn3ARx3R2J8Ojq1vxxns/aIVPUSNzryGJ+flBljGt7sxL/DuMcXLNMMLeSGXLzLDyp1JYZ9zTU1ATFYcOnDQ3dwN1MUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740311195; c=relaxed/simple;
	bh=xn/fx26pwoqWOzHZwiclK7+vo5qQdQsI57ke18rHGlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIZ6oLR9lFVdHWDyCvHrbSO6vMcXMVXMDcvPGtTRbx7M6+2NyZiAh8FZe6Fcg45ZsxnMnouWiseHvpoSEJJM1zbHYlJp+syesEphlvAKnsslI1znPcH8dYePbmu+1ixXbezzeBNep8/7NbZmhdWQgphcXm30+Do/k6KT8ZARVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUeCqCFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA217C4CEDD;
	Sun, 23 Feb 2025 11:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740311194;
	bh=xn/fx26pwoqWOzHZwiclK7+vo5qQdQsI57ke18rHGlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUeCqCFf3KTJJ1EV8KCOcwQuntZ2Mvb7lerpk6L0dlg1RzE5ihETBQePlMpURPglS
	 tuTX1FplO6IOsrCVrTdwkNZsSXjH6jUQajbEB8AHu/fHfdBYhCZDEu/rw5cp+Waljs
	 WbuL4w86Wy7weQE83EUjAyiPDYmqB+MlB/dVQo8SDAwAo2GiMMUTXO1LTQnvb13oxg
	 4ZIcH7wKChyzopg1cdxWGRDnjvhWX/wWE1Pj5LIu+Ud2ZNuuznM3TERaf8pQTQ+vBP
	 F28Krt7f0CrLX13b6VvFqEaZlEpIX2Vte+T8H2q3prnf1ZO0u8t9cr+zhMPP7KUjVy
	 rrZSfOJvNH25Q==
Date: Sun, 23 Feb 2025 12:46:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: wangweidong.a@awinic.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, 
	rf@opensource.cirrus.com, jack.yu@realtek.com, ivprusov@salutedevices.com, 
	zhoubinbin@loongson.cn, quic_pkumpatl@quicinc.com, paulha@opensource.cirrus.com, 
	nuno.sa@analog.com, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yijiangtao@awinic.com
Subject: Re: [PATCH V1 1/2] ASoC: dt-bindings: Add schema for "awinic,aw88166"
Message-ID: <20250223-manipulative-hornet-of-swiftness-dae16f@krzk-bin>
References: <20250221102623.369435-1-wangweidong.a@awinic.com>
 <20250221102623.369435-2-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221102623.369435-2-wangweidong.a@awinic.com>

On Fri, Feb 21, 2025 at 06:26:22PM +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add the awinic,aw88166 property to support the aw88166 chip.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  Documentation/devicetree/bindings/sound/awinic,aw88395.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


