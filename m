Return-Path: <linux-kernel+bounces-306218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9B8963B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBA2285B99
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D591581F3;
	Thu, 29 Aug 2024 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJx0XCpo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6411547E4;
	Thu, 29 Aug 2024 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912670; cv=none; b=nxbhNn/4y3nQxy676xKalmjUiwwW10i2BHAKCst4axoPGxuQPai2xBJCvZLHh3+VsSC0sPtzQIRFcMfUobwlkI/GcKbw1JyFQ33uSn028sQJvYvfq1pox9+KtoULD6TEbORNn4buT+nT/6EHtL55f8w0kJPF2mS2rBr7aVcq6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912670; c=relaxed/simple;
	bh=ulAcHw74Q+tiKNpuxivzK4jpkzIcYckUBh6qezE7LUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDT0dev0XONdFy2VVhfQd24hxi22Pw+LTY+e3ScToszxQvMqYY9CGiiVR56qJQBDKpqyk9MwEE1x89Q/Fbd26A/RJid8l4+hbHQi/RgD33Q5fQ8qmK0M0ihdc0S/Fb3PePdWFG27YF8WZ4BRtYHoDVnltzoKjcPZ2vKgkPUQK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJx0XCpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667ABC4CEC1;
	Thu, 29 Aug 2024 06:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724912670;
	bh=ulAcHw74Q+tiKNpuxivzK4jpkzIcYckUBh6qezE7LUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJx0XCpofs9ieyBEV/PfMjMgFiSOBsH8YQBG4XDcCXWX8U625TazmJFw51z00Jxcu
	 BfTQZVh7yCtTYWo5pPTeWsc46L7i+Otg8CSBr0F9OCAAS7AThnsPl5VHMR2ioHplQ6
	 Qd6g946RwV+7fbFg9JAibhuU0zP4tx771s0LFoYPH7x4nzazEs90gi8l76wVBS8pU+
	 L2UW0gWQMs9QY3KNlt+TYPjWFJr+vxiI0CCgusq/ZxcGz7vRptZALzbFN/33pNzumO
	 Vj/blE6KnyvnOoU2YpC5Z190W27NklrRsJYGee6gP4W3CcJWvZvDsPF+M/QDDZObJD
	 w2OOEyntncPhw==
Date: Thu, 29 Aug 2024 08:24:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: misc: fsl,qoriq-mc: remove ref for
 msi-parent
Message-ID: <kasyt62uhb7cijyrmbs7zelwgjtted6p4ynsy2s47e2ycniicb@szosg55aejjh>
References: <20240828163417.1130252-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828163417.1130252-1-Frank.Li@nxp.com>

On Wed, Aug 28, 2024 at 12:34:13PM -0400, Frank Li wrote:
> msi-parent is standard property. Needn't ref to phandle. Add maxItems: 1
> for it.
> 
> Fix below warning:
>   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: fsl-mc@80c000000: msi-parent:0: [16, 0] is too long
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - add maxItems: 1 for msi-parent

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


