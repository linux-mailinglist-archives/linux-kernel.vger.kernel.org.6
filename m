Return-Path: <linux-kernel+bounces-564607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CACCA6582E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402621887A46
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7611A238A;
	Mon, 17 Mar 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBRB8MD0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966219E968;
	Mon, 17 Mar 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229240; cv=none; b=bmxx/l89oVmlv+SA8FKvseZ5lAjSFqlnA74ScTPx3YHa8CPXSQFlWK4F4Dt81CIIowYwoN9oHcVlP92/PXBwQvc9DZwV7s0HKX9MsKqdPQybbRDJzgExeBR/HSf8iTcj7S8VwKHt8PtaKACRMi38niGJyBROs/ZoLLYy/X2lqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229240; c=relaxed/simple;
	bh=YXNIpXSQ0HSHHyJffyJrutOv2Z/LlwfQ1LB5ObJU4c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLaNv60qAySEakFvnnhFXN/LUieBLxXT5D7IpvGwaLqvvPuXVgB2xFV3OOQcdlHH1NqWULzf4gPbR7zGKJIbLqNrwEV+SkYvGuJEpBGiPUlNoL5n5Tg99jGQMQSBrOgi3iPgriRpnTiECAJOtm43cXX0mLIOn3upxHbss/ThYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBRB8MD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5709C4CEE3;
	Mon, 17 Mar 2025 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229240;
	bh=YXNIpXSQ0HSHHyJffyJrutOv2Z/LlwfQ1LB5ObJU4c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BBRB8MD06NNtl92XO1LKxHaJdBIN/EYsBMJtVoTButPOl6ayJaVThYRCUmtIyxZHf
	 SBEFZ7JsWCMOdes3HZMQWF3OFigFEdjiNx16moTSfazhKdlDz2qJRhY1RoPF4isndW
	 HXeySH4plRQ4mZvyOoWr8bEZA1kdsVjOtU6+LN+0FGEmr+a0QMYRLQIJzBRCSUMaDk
	 7rCKfwDKiq3M6/fudE1gotgOb0mglwHd9ZjsURRw+90S33wRYGc8Nsb5s5VXANbbl+
	 6sYBmtCI4XzK+bhY8XedbbYQY30D8WP4UmPrx2lsXR/wGBfOqbuoR03eqjx7/9cDqJ
	 vZwxQpDYo1aNQ==
Date: Mon, 17 Mar 2025 11:33:58 -0500
From: Rob Herring <robh@kernel.org>
To: Jjian Zhou <jjian.zhou@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH RFC v3 3/3] dt-bindings: mailbox: mtk,mt8196-vcp-mbox:
 add mtk vcp-mbox document
Message-ID: <20250317163358.GA178378-robh@kernel.org>
References: <20250317110331.2776-1-jjian.zhou@mediatek.com>
 <20250317110331.2776-4-jjian.zhou@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317110331.2776-4-jjian.zhou@mediatek.com>

On Mon, Mar 17, 2025 at 07:03:25PM +0800, Jjian Zhou wrote:
> This patch adds document for mediatek vcp mbox.
> 
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> ---
>  .../bindings/mailbox/mtk,mt8196-vcp-mbox.yaml | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,mt8196-vcp-mbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk,mt8196-vcp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mtk,mt8196-vcp-mbox.yaml
> new file mode 100644
> index 000000000000..bd1b024e22f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mtk,mt8196-vcp-mbox.yaml

Still wrong...

> +  compatible:
> +    enum:
> +      - mediatek,mt8196-vcp-mbox

mediatek,mt8196-vcp-mbox != mtk,mt8196-vcp-mbox


