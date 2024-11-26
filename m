Return-Path: <linux-kernel+bounces-421956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96449D9295
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CAA166BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE0A1957FF;
	Tue, 26 Nov 2024 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+OsL5e2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E23D192D69;
	Tue, 26 Nov 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606659; cv=none; b=CpRPbE9CbbKn/vBkPowC4PvvBtkoNlexjiGx37QNtsXpWeJqAclaO/JtUrIY537JdML1xgWZDa1afc0g/v/i41X842fJoGxbinwxj0x5uQpL7wfTvM2fBpqQqvabueia/x679DLj+maGrUqwmQ8ypcqoNdbxDTAzfrdqH8znx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606659; c=relaxed/simple;
	bh=r++3Qo7JVxc4zP3NbHwY47VSgGg58VDRmi+G71l8cAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMi4s0MuFIuWrcm61K/J4bIGLF9MJvZhlLOOhC+ucyYPxD4yPaZ0S7IJda004/eZcHlDHff97UCBniKcbDIAGvQrk3N7d9/Fs7FvBQRT39kFs5hObgV/mNnEaQl7rEP0wO9sTshS7dfid52BzuSvZT6TUyYGWI7LUQ+99qdejo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+OsL5e2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21035C4CECF;
	Tue, 26 Nov 2024 07:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732606658;
	bh=r++3Qo7JVxc4zP3NbHwY47VSgGg58VDRmi+G71l8cAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+OsL5e2jt0v1wI37WnVDynehv54EZ+19kfRw7zwBXYJs7jGd6/lCUH2E+KuGGMn+
	 CRs9s1DT7vM9mrsbFkqfXjzE2zcv+PRPT8PRaqhbf6udC5ErysrrMYq+rfqOmVFczx
	 C3ORS0aQWiCjlScWQ6yzEdarj2RI5x4cTMdL7eXJ/sWxK7ikVlONunFWyetZo9XkMr
	 O4hUSrMjH4Cj9wpdZSEMzUQD81ROfLBEsbY1Xc24nkuGU8cyN1I+TYs5789waEszgR
	 mzyEpyVmm5/0WDxdSKa7kKRMCA0HSiCWbjMcPUiiAbULv14b5JOFCh70F1NzLGOtxr
	 KDCInoFuHzHMw==
Date: Tue, 26 Nov 2024 08:37:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mathias Nyman <mathias.nyman@intel.com>, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: mtk-xhci: add support mt8196
Message-ID: <uy22btn4qv3gc3glizyuzdlxawgvvjgk765jjjk6mj4ftadbyv@hh62ph3ug5gg>
References: <20241126025507.29605-1-chunfeng.yun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126025507.29605-1-chunfeng.yun@mediatek.com>

On Tue, Nov 26, 2024 at 10:55:06AM +0800, Chunfeng Yun wrote:
> There are 2 USB controllers on mt8196, each controller's wakeup control is
> different, add some specific versions for them, and add compatilbe for it.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


