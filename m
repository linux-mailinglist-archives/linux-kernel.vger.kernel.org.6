Return-Path: <linux-kernel+bounces-375623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2AC9A984D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D610B1F23A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5A912F5B3;
	Tue, 22 Oct 2024 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDtswBD+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F8E5A79B;
	Tue, 22 Oct 2024 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574827; cv=none; b=a82pJE3VKvSIWhrz8MafgqZh5cgDKNnPrfWCIKXopxpgo1jj8G+TkHFmMz053z+dx5iX9hs+/RZIKybPBNXDInCFwR2u38cfKa4vlnesUqk3CGsnIEtPiPhPzYn5WETB0iL1d36usOGbqHl63/H3N/oOWChznrG5CgCwGH6Hlx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574827; c=relaxed/simple;
	bh=lFAI3gletFq7EXPE9VsStAF+xZwzPU7l/YG+ltpKHiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZVKdoNrS/Hid3WHblEKtW2XDqRUScRpHJqerHqN32NGxQGF6NLoTQjoYdXgt1YeTGTp2j9UgbqZvO500BjqLND6H/nijANIIWHHs+0iS6FCE8EHupyx9XjqDIi7XF/7Zw2QzE3glsZ9xc8fUhhevjpn3qfbP2jzs6pJB2eegd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDtswBD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D41C4CEC3;
	Tue, 22 Oct 2024 05:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729574827;
	bh=lFAI3gletFq7EXPE9VsStAF+xZwzPU7l/YG+ltpKHiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDtswBD+4v1S/+A9hL9AYQyDQMG0XMPhS/omBNnapYTtcp9x9Kwq61wbebFOuLLsM
	 7uuFmbegF6tYi2DPdj+tpJmOEHwsdweLi92dg7+3S3qtxt3DgFbOpTjEjW+eWBF0Rt
	 puemWGOvaajZCG2nimNQ3xSORdTqxYVgcVQayYLUaGcbCl3Ma+BNpwztuDUYkMvvBk
	 LmgvaQ9dvOrlGnuGd+QahZy4eSlbf5EKhBbNo2M5MdpEOb5/2X1MspKwQ5aWLyO8LJ
	 1rMLnmEp9SWl8RGklFe3gCmfTwWylG6/nqYkFPGYluLKx+/O5kopt0CRMXqfgvk4O4
	 3ZHAa3LFsP4kw==
Date: Tue, 22 Oct 2024 07:27:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, wenst@chromium.org, 
	hsinyi@chromium.org, sean.wang@mediatek.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 RESEND 1/4] dt-bindings: arm: mediatek: Add MT8186
 Chinchou Chromebook
Message-ID: <endnevb4ilgyccy6ayfr7gscskqdzr3gcgowdow3qnmrvfrxdi@t2nubnr4y5jh>
References: <20241021072626.15102-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20241021072626.15102-2-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021072626.15102-2-xiazhengqiao@huaqin.corp-partner.google.com>

On Mon, Oct 21, 2024 at 03:26:23PM +0800, Zhengqiao Xia wrote:
> Add an entry for the MT8186 based Chinchou Chromebook, also known as the
> ASUS Chromebook CZ12 Flip (CZ1204F) and CZ12(CZ1204C).
> 
> Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
> ---
>  .../devicetree/bindings/arm/mediatek.yaml     | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


